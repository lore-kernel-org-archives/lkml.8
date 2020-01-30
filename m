Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04AEC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6443206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtcHvisD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgA3IQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:16:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgA3IQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TCsQ3GzavAe26bRtqfddchOtZ1YoWhMpGMKjZxM60vI=; b=KtcHvisDsABiHx64Iuvyz6yaB
        X07tpTx9cNQomPHTclUK8DQVorusdFctcSZoMQgOUd77/FH5pTTe2VacSPBXFXU4NVnbmaaZI1JaO
        914ynMtjZMtxIcliWLkqqu1cgy/+rt14w69YJnSkfcLDCu8gQfpfJePnfJocKNngud26WUUobBTW5
        /f5KPthpaEi9byvQIifLgw3Qhp28h24Cx3EtF0m7we9PcOB7EfHcunkvE8MaluUR3GAYk0Z67sWW3
        gFm+pW5G7wCZtoQU8EdS+n9G87ooGZi7w9d+9ErttwPCMGGSg4Vu8ki7jNHgxmC9TutETsihaM696
        EFGmwzEhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4zx-0001t8-S7; Thu, 30 Jan 2020 08:16:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 710D03011DD;
        Thu, 30 Jan 2020 09:14:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B9522B7334D2; Thu, 30 Jan 2020 09:16:23 +0100 (CET)
Date:   Thu, 30 Jan 2020 09:16:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200130081623.GW14879@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
 <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
 <20200129193109.GS14914@hirez.programming.kicks-ass.net>
 <b72358cc-ddd2-52d6-7eed-c88bab46e6f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72358cc-ddd2-52d6-7eed-c88bab46e6f1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Michael,

On Thu, Jan 30, 2020 at 08:31:13PM +1300, Michael Schmitz wrote:

> Not much difference:
> 
>              total       used       free     shared    buffers     cached
> Mem:         10712      10120        592          0       1860       2276
> -/+ buffers/cache:       5984       4728
> Swap:      2097144       1552    2095592
> 
> 
> vs. vanilla 5.5rc5:
>              total       used       free     shared    buffers     cached
> Mem:         10716      10104        612          0       1588       2544
> -/+ buffers/cache:       5972       4744
> Swap:      2097144       1296    2095848
> 
> By sheer coincidence, the boot with your patch series happened to run a full
> filesystem check on the root filesystem, so I'd say it got a good workout
> re: paging and swapping (even though it's just a paltry 4 GB).

Sweet!, can I translate this into a Tested-by: from you?

> Haven't tried any VM stress testing yet (not sure what to do for that; it's
> been years since I tried that sort of stuff).

I think, this not being SMP, doing what you just did tickled just about
everything there is.

There is one more potential issue with MMU-gather / TLB invalidate on
m68k (and a whole bunch of other archs) and I have patches for that
(although I now need to redo the m68k one.

Meanwhile the build robot gifted me with a build issue, and Will had
some nitpicks, so I'll go respin and repost these patches.
