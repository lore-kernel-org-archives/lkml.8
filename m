Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8032B2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NgBDnrwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgFSSbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgFSSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:31:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=09WzDL/oWiVIJIl+efUQGeH1Ki+wJFUV+z7CY98tRKE=; b=NgBDnrwPbWzmpuVI9GvXmWBbr9
        I/WLjk7R/U9HI7Z26TedeG0rTMmxPDUFVI3VCOV9MPM4vsCukNaDpeeJNX7ZyXctUNYgh/QEWDRHO
        6rSrln2xQlJA6FtC9l7KwEAW087k88XeTYJ8bAn6T2Ll7wNmW09GAQEYnBfnZHC6XOsa2jMSg5/pl
        zh4ofFilaLUXMR1DSaRxc49MdpATk5+RPSM1SYjSDo32fFlTP9Asxa4w6jA9VknBfe1drU2QD2Zia
        +tvuAw3ZNuRLtga5zhuAVrM3BdZ7arazRBFAyYCyQ/7Lcdf7gIXQf1aUzogULYQqtagTBvOlrA2j5
        5eIvQ14A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmLn7-0001y5-QY; Fri, 19 Jun 2020 18:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C23DC3003E5;
        Fri, 19 Jun 2020 20:31:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B205D2C28E83E; Fri, 19 Jun 2020 20:31:02 +0200 (CEST)
Date:   Fri, 19 Jun 2020 20:31:02 +0200
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
Subject: Re: [PATCH 09/21] perf/x86: Expose CPUID enumeration bits for arch
 LBR
Message-ID: <20200619183102.GE576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-10-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-10-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:03:57AM -0700, kan.liang@linux.intel.com wrote:

> +	union {
> +		struct {
> +			/* Supported LBR depth values */
> +			unsigned int	arch_lbr_depth_mask:8;
> +
> +			unsigned int	reserved:22;
> +
> +			/* Deep C-state Reset */
> +			unsigned int	arch_lbr_deep_c_reset:1;
> +
> +			/* IP values contain LIP */
> +			unsigned int	arch_lbr_lip:1;
> +		};
> +		unsigned int		arch_lbr_eax;
> +	};
> +	union {
> +		struct {
> +			/* CPL Filtering Supported */
> +			unsigned int    arch_lbr_cpl:1;
> +
> +			/* Branch Filtering Supported */
> +			unsigned int    arch_lbr_filter:1;
> +
> +			/* Call-stack Mode Supported */
> +			unsigned int    arch_lbr_call_stack:1;
> +		};
> +		unsigned int            arch_lbr_ebx;
> +	};
> +	union {
> +		struct {
> +			/* Mispredict Bit Supported */
> +			unsigned int    arch_lbr_mispred:1;
> +
> +			/* Timed LBRs Supported */
> +			unsigned int    arch_lbr_timed_lbr:1;
> +
> +			/* Branch Type Field Supported */
> +			unsigned int    arch_lbr_br_type:1;
> +		};
> +		unsigned int            arch_lbr_ecx;
> +	};

Please, union cpuid28_e[abc]x in asm/perf_event.h right along with the
existing cpuid10_e*x unions.
