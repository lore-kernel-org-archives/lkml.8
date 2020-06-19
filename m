Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A6B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LotKzde0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgFSTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgFSTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:12:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BCC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0SOhWW0ptYBXJaqZ7r6SRlKPoSW36fKX4F/Z1w9lS04=; b=LotKzde06lRQCfnSJV0/HomH9/
        WZ3nXTWkj4DQcy707D1Gok3XqkZ07oyE6FYccQnzwEb7tk05RTXktw6FTwm/wawn1dMnx/ORuE0Y+
        sxdki6wMyt0KTmng2K4GG+cyeHDl+54OtrYusmx2yGiN5egpSIu5SAT9+TfVTAM8+ZZ/8HscVzLSM
        a2nHAztcZofFg2RS6I4/kMx9F27XxQ3CZxbRUK+pTvLg+F3i5AAqJxF/Crg+RFSysfyQSvfrjp4La
        gBY9D+op921lOxejahX9eOcljN8ek49jQRfRtaSkdLLssm4ON5Vq0ro30yyvth1J7s5X0caB4lKoE
        Yfq+/8RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMQa-0005K0-8y; Fri, 19 Jun 2020 19:11:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8764E302753;
        Fri, 19 Jun 2020 21:11:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 725AF2C28E842; Fri, 19 Jun 2020 21:11:50 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:11:50 +0200
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
Subject: Re: [PATCH 08/21] x86/msr-index: Add bunch of MSRs for Arch LBR
Message-ID: <20200619191150.GH576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-9-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:03:56AM -0700, kan.liang@linux.intel.com wrote:

> +#define ARCH_LBR_INFO_MISPRED		BIT_ULL(63)
> +#define ARCH_LBR_INFO_IN_TSX		BIT_ULL(62)
> +#define ARCH_LBR_INFO_TSX_ABORT		BIT_ULL(61)

That's identical to what we already have.

> +#define ARCH_LBR_INFO_CYC_CNT_VALID	BIT_ULL(60)

If you call that LBR_INFO_CYC_VALID or something, then we good there.

> +#define ARCH_LBR_INFO_BR_TYPE_OFFSET	56
> +#define ARCH_LBR_INFO_BR_TYPE		(0xfull << ARCH_LBR_INFO_BR_TYPE_OFFSET)

Same

> +#define ARCH_LBR_INFO_CYC_CNT		0xffff

And we already have that in LBR_INFO_CYCLES.

