Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E36C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13922078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qzb6D4Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:27:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F66C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ihzv2G7gl4wbywFbFfD4kmdeTyXKLjmi41Fi4pfZKE=; b=qzb6D4Usq+oxdkaVPdq/sdGYIj
        8zeI7a9lB6gB+lPtJISBLf7QqogLLW8ULuXtzwz1H/KwsZ65Y3IRX8RB4CRtXSMIBdiWro7gaPLMP
        R0J78KOPR2Fhr+YNmlEOBP7aNfSnzPlk5CVdbTwLLx0BOD5XXswXXRY/arcDGAaxaWF7894991rdQ
        UJh6NHt1MOs+njcLykTTKmxxQ9n2vIC9bb2zJ2ipaWG2ubKw+9IQ4jlGxskYrWT4GnfzJRTNwQ2rL
        lo0tJnF/lykXXp33YMowTxb6bxbvYaM4MLYVWjlabaAfau8KEfWC1fOXESB62Z+vlnWfMEQheHwD+
        RO/QzI+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQRm7-00015J-8r; Mon, 20 Apr 2020 08:27:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E14E3024EA;
        Mon, 20 Apr 2020 10:27:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6796A2B8D15BD; Mon, 20 Apr 2020 10:27:28 +0200 (CEST)
Date:   Mon, 20 Apr 2020 10:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420082728.GA20696@hirez.programming.kicks-ass.net>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420074845.GA72554@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:48:45AM +0200, Ingo Molnar wrote:
> Fortunately, much of what objtool does against vmlinux.o can be 
> parallelized in a rather straightforward fashion I believe, if we build 
> with -ffunction-sections.

So that FGKASLR is going to get us -ffunction-sections, but
parallelizing objtool isn't going to be trivial, it's data structures
aren't really build for that, esp. decode_instructions() which actively
generates data.

Still, it's probably doable.

