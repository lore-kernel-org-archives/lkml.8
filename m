Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B983C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3362063A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5N0geky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgEAR0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728933AbgEAR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:26:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A733FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4s9Kc9podEipbVFwf7RgdQ5NU0qdM7rKVGMYPDm9ajc=; b=D5N0gekygXT6+UctiNnGtkNDsp
        QwzkvVAZSO/re5pJZgmFWCOLINt/3indQe534GOZBCt6N6RbtzC/76f3I9/C+PcyiOfbsJBYWh/vC
        2aTabmU6VYmcTVKID15b6GdfwVRuaPJasIdqhMB8S2ZpyG85SZcNi8Rs6LS5DlR+3dAGpJvIH0zc+
        1/8yDG82nfnjIti7ECmTV/dRIRSkEnPhZol4CPio5d81OfAnUFvJAGwN9fMgPd8vwzqNgs59kyJly
        36bMi2gm7fDG2p5EDUR8+bZpN9WSdLO/E/t6BFzepvmIu+0oSJsA9onwhZ78ZnaibgFu+jxmUiamo
        oAZNOKBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUZQY-0003Lj-FX; Fri, 01 May 2020 17:26:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 005CC300130;
        Fri,  1 May 2020 19:26:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E027A29D9C091; Fri,  1 May 2020 19:26:16 +0200 (CEST)
Date:   Fri, 1 May 2020 19:26:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501172616.GG3762@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 07:21:31PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 30, 2020 at 4:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> it gets into undefined behavior and stops emitting code after the call to

> Do we consider this expected behavior on gcc's side, or is it something
> that should not happen and needs a gcc bug report?

When it hits UB it is of course free to do whatever it damn well
pleases, but just stopping code gen seems a little extreme, at least
issue a WARN that something is up or so.

Not sure how the GCC folks feel about this though.
