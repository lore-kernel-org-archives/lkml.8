Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD39C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AD621473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6L8Y736"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEHQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:20:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726767AbgEHQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588954853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H62jLWxF6mJP38xdlMPJYxyincWvSwp41kLYheQf1ro=;
        b=V6L8Y736Rb7GMBelC2j6te2s2aGnRg5tKRZf2CcOoWFEJM1jrKZ0iwHhATM6QIhMPtE2UV
        9qdzfMVKmcGvgxsGuV/jqfm8b4e/cy31hDoJzeoVj3SoYVhPaPFoQ7/Dui7arSYskCMeLY
        nC8UVJ3lLZMg/s4CsftlUmKLeR8no2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-PGyXSKFTNyuckXST9GaQVA-1; Fri, 08 May 2020 12:20:52 -0400
X-MC-Unique: PGyXSKFTNyuckXST9GaQVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263DF872FE2;
        Fri,  8 May 2020 16:20:51 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18A0A341FC;
        Fri,  8 May 2020 16:20:49 +0000 (UTC)
Date:   Fri, 8 May 2020 11:20:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
Message-ID: <20200508162047.cwdhuonz4jjnnsc5@treble>
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
 <20200508094518.GW5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508094518.GW5298@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:45:18AM +0200, Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 06:29:41PM -0500, Josh Poimboeuf wrote:
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
> So on the one hand I agree. We're forever playing catch up with the
> compilers, and as I said earlier, objtool generating an error has the
> very unfortunate effect of the actual .o file getting deleted by the
> build system, which is all sorts of annoying when you then want to
> figure out what objtool got upset about.
> 
> So, yes, we probably should revert that.
> 
> OTOH, if we don't break the build, people are going to continue to
> ignore objtool warnings/errors when they writes new code.

True, but they can already do that anyway since right now it only fails
on fatal warnings.

-- 
Josh

