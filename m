Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD1C20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXnDhDr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgERWxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:53:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52305 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgERWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589842413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ge02D+vMtH+KKLBjcerJB21jPgtxIQMEv9lA24a7Lpg=;
        b=GXnDhDr0/LfdbSUpOjmTBfICTY+Nqb2GA6xTX+umgXiatyudp4QjgIpbcjqf5KGLEPSR1I
        zHyjJ8yAwCewNC6qTJONiw6kAB1ks+xgZ3jG+uFOGQ3WFAA54TZb7JTptIvoHxrzMPLPdf
        RMIWAaCsNZ9B+BrQzZ04+9ee1R5XhV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-DotPqO2TMOuWWHAGZDGNFw-1; Mon, 18 May 2020 18:53:29 -0400
X-MC-Unique: DotPqO2TMOuWWHAGZDGNFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F21460;
        Mon, 18 May 2020 22:53:28 +0000 (UTC)
Received: from treble (ovpn-113-47.rdu2.redhat.com [10.10.113.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA3AD1C92D;
        Mon, 18 May 2020 22:53:27 +0000 (UTC)
Date:   Mon, 18 May 2020 17:53:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200518225325.is5ojipcc5uq5y5n@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0G9uOatw93R90nP3tURgx=WW7yDB7qDtC8cwx0DHZqCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0G9uOatw93R90nP3tURgx=WW7yDB7qDtC8cwx0DHZqCw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:57:50PM +0200, Arnd Bergmann wrote:
> On Fri, May 8, 2020 at 1:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, May 06, 2020 at 04:07:25PM +0200, Arnd Bergmann wrote:
> > > Hi,
> > >
> > > During randconfig testing with clang-10 I came across a number
> > > of additional objtool warnings, I'll send another mail about those
> > > when I have collected more information and some object files.
> > >
> > > This one sticks out however, as objtool returns an error code that
> > > stops the build:
> >
> > > fs/dlm/lock.o: warning: objtool: __receive_convert_reply()+0x1e5: can't find jump dest instruction at .text+0xcaa7
> >
> > Thanks for sending the patch for this one.  Objtool always gets confused
> > by new compiler versions, I really think we need to revert
> >
> >   644592d32837 ("objtool: Fail the kernel build on fatal errors")
> >
> > because objtool is never going to be reliable enough such that we can be
> > confident that failing the build is the right thing to do.
> 
> I'm now struggling with a clang -fintegrated-as related failure:
> 
> arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn at offset 0x16
> make[4]: *** [/git/arm-soc/scripts/Makefile.build:355:
> arch/x86/kernel/ftrace_64.o] Error 255
> 
> Using this as a local workaround, but I'd like to find out if this is a bug
> in clang or in objtool:

It seems like an objtool bug, though at first glance I don't know where
exactly.  It could be a problem with the rb-tree stuff Peter added
recently.

That instruction should be part of the __fentry__ function:

     4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    3 __fentry__

So find_symbol_containing() should associate it with __fentry__.

-- 
Josh

