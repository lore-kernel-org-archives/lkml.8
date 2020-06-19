Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A834204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5VvDskD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395273AbgFSSlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389284AbgFSSlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:41:07 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08666C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QtDEQGCaPDLFJZLzFz4vFTkMLLqDzPlomTvJhmg/yeA=; b=i5VvDskDpupxJDvbClZN2Kf/U2
        zE7SekBoNTpB6H2nMDAnVNO3iFvfPpNdmnaiSUVv9w3GcYG/SON7HOyqmRt6OAihky3J5nlELQx39
        AebESG33iascKWlkQZ2LYVXs90D9AsL6JkoFkeKWIjwjsM9EaD2jTFIM2f6MbTpfF4CGK6cbP5hoK
        BJD4Yek5+fDA9NKR+IRaXjWPGCZ5DtywYKza11lXgdMLkKfabceePq9zkXExMsxZt/BmShBGJXuOz
        YcyyL+TOwWv85KrJfbk846sT5rhhx6qFkmsgkR7mno5dsC3prZYeu40wEBWn/NpqHikY2VWe+cpY8
        OgfX/+og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmLwB-0004mX-Q7; Fri, 19 Jun 2020 18:40:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BACF301A32;
        Fri, 19 Jun 2020 20:40:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67D212C28E840; Fri, 19 Jun 2020 20:40:25 +0200 (CEST)
Date:   Fri, 19 Jun 2020 20:40:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 11/21] perf/x86/intel/lbr: Support LBR_CTL
Message-ID: <20200619184025.GF576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-12-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-12-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:03:59AM -0700, kan.liang@linux.intel.com wrote:
> -	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
> +	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map || x86_pmu.lbr_ctl_map) {

> +	union {
> +		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
> +		u64		lbr_ctl_mask;		   /* LBR_CTL valid bits */
> +	};

This makes absolutely no sense. There is hoping the compiler realizes
how stupid that is and fixes it for you, but shees.

Please, just keep the old name.
