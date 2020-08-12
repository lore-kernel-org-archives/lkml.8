Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5407A2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YeE8QRql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHLUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHLUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:00:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DCC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KrxCJwFdZ4E7XIwBDMBb4m+4zd0Ve77BHKwErS67suU=; b=YeE8QRqlJhzEqIYndaE2AU++E4
        COMk0ELdWfMnxUsdgn0u/iPpX2aksP1HZb376gW7opp/mgt6vwNRw9ZJB4MVTDR8jIefz3Pby3vZj
        Dg8K1xb5tbQ+VFscuz1bpgR6Ve5AOaCRYqpr5dyeMswPCn6rxhlKtQdqeh8KRAky5sRYzc9c8Luam
        9JNU6xMxTXFcjHyCoDdVtKlbHGsPzN9AIf2QKEUcWR/809P5eeyQbq5qaU8h80ARxIQW2y8Ngt/VO
        4WfaQCRB9LX9MLiXJg2CYlpj3Civ/KtR+JhN5u5bV0x9o4kEgds0cwZoh4dUFiH1jbn2YS27qvWZk
        cabxMGSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5wv7-00021Y-6W; Wed, 12 Aug 2020 20:00:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E3A8980C68; Wed, 12 Aug 2020 22:00:19 +0200 (CEST)
Date:   Wed, 12 Aug 2020 22:00:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812200019.GY3982@worktop.programming.kicks-ass.net>
References: <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
 <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> I know there is little we can do at this point, apart from ignoring
> the permissions - perhaps we should just defer the w^x check until
> after calling module_frob_arch_sections()?

My earlier suggestion was to ignore it for 0-sized sections.
