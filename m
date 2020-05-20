Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD74C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42FF20884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z2sSWKck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgETWRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:17:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgETWRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:17:21 -0400
Received: from zn.tnic (p200300ec2f0bab002db258470e3f635c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:2db2:5847:e3f:635c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 570181EC0298;
        Thu, 21 May 2020 00:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590013040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kYf72KKZVszNZ/yk8NzlKuZkkzdrnAXgCUIALVMakAw=;
        b=Z2sSWKcknTQG1EqVCBXyc8EpOZnLcaZeT2+AGeSZufUIpIxj0rqrfeQC8oXLyiJZyaM3j/
        xP0QZgUjbadHozIdc8+DzsoOQmC2n0o6fuk8i++7TcrGRVzaJmjVVloUl4anVTQ1NOkv99
        33TvZxaf5AP3Pw28qXL53zdhS3T/zls=
Date:   Thu, 21 May 2020 00:17:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200520221712.GA21166@zn.tnic>
References: <20200511204150.27858-18-will@kernel.org>
 <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 02:36:53PM -0000, tip-bot2 for Will Deacon wrote:
> The following commit has been merged into the locking/kcsan branch of tip:
> 
> Commit-ID:     cdd28ad2d8110099e43527e96d059c5639809680
> Gitweb:        https://git.kernel.org/tip/cdd28ad2d8110099e43527e96d059c5639809680
> Author:        Will Deacon <will@kernel.org>
> AuthorDate:    Mon, 11 May 2020 21:41:49 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Tue, 12 May 2020 11:04:17 +02:00
> 
> READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> 
> Rather then open-code the disabling/enabling of KCSAN across the guts of
> {READ,WRITE}_ONCE(), defer to the data_race() macro instead.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Link: https://lkml.kernel.org/r/20200511204150.27858-18-will@kernel.org

so this commit causes a kernel build slowdown depending on the .config
of between 50% and over 100%. I just bisected locking/kcsan and got

NOT_OK:	cdd28ad2d811 READ_ONCE: Use data_race() to avoid KCSAN instrumentation
OK:	88f1be32068d kcsan: Rework data_race() so that it can be used by READ_ONCE()

with a simple:

$ git clean -dqfx && mk defconfig
$ time make -j<NUM_CORES+1>

I'm not even booting the kernels - simply checking out the above commits
and building the target kernels. I.e., something in that commit is
making gcc go nuts in the compilation phases.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
