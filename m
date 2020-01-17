Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FAC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07062072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KeIszkAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAQIyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:54:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAQIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XO29zYwx4hHLz7JsjcnHBs2ZcfiIaLvQEPYDWFilZ/E=; b=KeIszkAkhcH1JxeD9bKiF9mhr
        UD+kxnRJr210Af67SY0X89g28UCA82/xVx/nHgSZwYm+zGP/lJKgbBg7o1ru3Q83lH5AAfNfBhude
        pV5JVb0l6MjmsCs3cg5EEsVdwJJQE7041jSg+B5BOkTmw/cPzy/pSkfZr7n0DbfHnAbs29+3cytnG
        PJ5J90yWbUtXwJbfoR2ITc7dBMVMoYzqBZ1LNYw/uGlxoohPP4z4unud1/a/HDiqocG4MffgqkENl
        1y3DSooclMrZhH0EEdgTBe1deUEbXYzYT8CojCujkLaAnLmDPXaOUqG5az/hzVEzLQMBo6zqLrrqS
        4kdE54Jiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNOQ-0004hX-Kl; Fri, 17 Jan 2020 08:54:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0803A304A59;
        Fri, 17 Jan 2020 09:52:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F03220AFB27D; Fri, 17 Jan 2020 09:54:12 +0100 (CET)
Date:   Fri, 17 Jan 2020 09:54:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH V2] perf/x86/intel: Avoid unnecessary PEBS_ENABLE
 MSR access in PMI
Message-ID: <20200117085412.GU2827@hirez.programming.kicks-ass.net>
References: <20200116182112.20782-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116182112.20782-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:21:12AM -0800, kan.liang@linux.intel.com wrote:

> A PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
> PMI throttle may be triggered for the PMI. For this rare case,
> intel_pmu_pebs_disable() will not touch PEBS_ENABLE MSR. The patch
> explicitly disable the PEBS for this case.

intel_pmu_handle_irq()
  pmu_enabled = cpuc->enabled;
  cpuc->enabled = 0;
  __intel_pmu_disable_all();

  ...
    x86_pmu_stop()
      intel_pmu_disable_event()
        intel_pmu_pebs_disable()
	  if (cpuc->enabled) // FALSE!!!

  cpuc->enabled = pmu_enabled;
  if (pmu_enabled)
    __intel_pmu_enable_all();

> @@ -2620,6 +2627,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		handled++;
>  		x86_pmu.drain_pebs(regs);
>  		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
> +
> +		/*
> +		 * PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
> +		 * PMI throttle may be triggered for the PMI.
> +		 * For this rare case, intel_pmu_pebs_disable() will not touch
> +		 * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
> +		 */
> +		if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
> +			wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
>  	}

How does that make sense? AFAICT this is all still completely broken.

Please be more careful.

