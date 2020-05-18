Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F136DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7C7207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1CKlPpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgERXEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:04:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50196 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728445AbgERXEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589843073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RbdoSp6BluJSbg1qOlBGmWOjT56/eb9Ot/HcRT0ANI4=;
        b=Y1CKlPpOqiFGgW4IHcbW0lgdgpIoUzzcKS8Rh656KNJGQRsy/QTowlGDML+0QhvlgZk0QN
        zgge8BMRYEG3ya7OIYIRdB3yQQZuLbVryQik310JXA53HxS0BvhHs7YqcRMSLxR8fCeRhh
        UuQTpyiQ7pCZcnbbvZuTD1Rhmg3ytNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-21bFL1gXMZmlOCXQHlekiA-1; Mon, 18 May 2020 19:04:31 -0400
X-MC-Unique: 21bFL1gXMZmlOCXQHlekiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7BCA7BAE;
        Mon, 18 May 2020 23:04:29 +0000 (UTC)
Received: from treble (ovpn-113-47.rdu2.redhat.com [10.10.113.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C6FC79584;
        Mon, 18 May 2020 23:04:29 +0000 (UTC)
Date:   Mon, 18 May 2020 18:04:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200518230424.rftemp76uch4piy7@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <CAK8P3a0G9uOatw93R90nP3tURgx=WW7yDB7qDtC8cwx0DHZqCw@mail.gmail.com>
 <20200518225325.is5ojipcc5uq5y5n@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518225325.is5ojipcc5uq5y5n@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:53:28PM -0500, Josh Poimboeuf wrote:
> > I'm now struggling with a clang -fintegrated-as related failure:
> > 
> > arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn at offset 0x16
> > make[4]: *** [/git/arm-soc/scripts/Makefile.build:355:
> > arch/x86/kernel/ftrace_64.o] Error 255
> > 
> > Using this as a local workaround, but I'd like to find out if this is a bug
> > in clang or in objtool:
> 
> It seems like an objtool bug, though at first glance I don't know where
> exactly.  It could be a problem with the rb-tree stuff Peter added
> recently.
> 
> That instruction should be part of the __fentry__ function:
> 
>      4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    3 __fentry__
> 
> So find_symbol_containing() should associate it with __fentry__.

Peter, is find_symbol_containing() broken by aliased functions and/or
overlapping symbols?

Symbol table '.symtab' contains 7 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    5 __ksym_marker___fentry__
     2: 000000000000000e     0 NOTYPE  LOCAL  DEFAULT    3 fgraph_trace
     3: 000000000000000f     0 NOTYPE  LOCAL  DEFAULT    3 trace
     4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    3 __fentry__
     5: 000000000000000e     0 NOTYPE  GLOBAL DEFAULT    3 ftrace_stub
     6: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND ftrace_trace_function

Notice the NOTYPEs are inside the FUNC.

-- 
Josh

