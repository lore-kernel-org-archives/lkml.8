Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31867C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013C620771
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl2akqo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgFVStm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:49:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:49:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n24so20502132lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6u6/dv+jBcWLjTJt7LasJyF0zDI1Q4uNreYy9wn0bVc=;
        b=cl2akqo8GXtwM1zHfRkfLSphpe47oZ8yj12HrFnJamJmqOSANi0rHB7DiYOEqL3yGW
         3MuD1JNydm4Evx/b+rsa4EFQ1sTdmmWbZwT4r48a+XFFN17cktC/NR6nBJpFkxb/XCKZ
         rGjIK6feM9Pa+tgN8V1ODYrsPLJcdiM4ZhUEzKFodJZaeZm7B+wwZtH6PxqbvhvVc2Mc
         txK0n7nXUH354YFXbYGziXZqZ9TQNm+xzaZNM90M3flT4o/yflDInzEkZaDvUgW+hK2r
         x9uqQMxydGPny922GAMM4efz1w7h3uSkDbfxKq/otQ6U2rlYeAnOp8UDGCiyvG9Shn8t
         Q1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6u6/dv+jBcWLjTJt7LasJyF0zDI1Q4uNreYy9wn0bVc=;
        b=ZzbuGNsh+hetNHQxy+ckYs1iWyBYEQOihIUXLdSVVtwPshtlGmSiUdiRrlx4xjMgRX
         xZ8Qs3kdP05KApJ6x2swrL3VUlQNZEilCz1HUHezSypV85AvHZ4U0YNMGUNAALkdbt8s
         B1USY29pWAFp5vc8fWnFFJg7YUTKviU6eqIAIyH3CN7B9jmbprRPlWl1llYmUUe5gHrI
         tOTxGQms3P5d8YBpIPcZgzvNAVvSFNyhYBVhuCiRlMoZgD9bELYq8ishMxw4Vruo+CMD
         D6eF1lB+2ctcWQWJHL21zD1EJa4EzUlkmly7//PZbBm1Jlap5OmakdOsE8MU5NLWdSGS
         bHmQ==
X-Gm-Message-State: AOAM531XiCnRkrmhLXS3ACgnPeuFmvy6mhZ7fxOlpShUFBQ9IMKwqy5D
        gG1duvE5CcfGve2dufUU568=
X-Google-Smtp-Source: ABdhPJyjdw0gCWhZYWsYqOYfenTFiKE5DOXJFAfjRTDyLc3XAjOsByeqUlnj6Jray2e4Qv67FLlYgw==
X-Received: by 2002:a2e:7611:: with SMTP id r17mr9496407ljc.233.1592851779734;
        Mon, 22 Jun 2020 11:49:39 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id m15sm3621826lfk.65.2020.06.22.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:49:37 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 7BCD81A007B; Mon, 22 Jun 2020 21:49:37 +0300 (MSK)
Date:   Mon, 22 Jun 2020 21:49:37 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dave.hansen@intel.com, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, hpa@zytor.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 21/21] perf/x86/intel/lbr: Support XSAVES for arch LBR
 read
Message-ID: <20200622184937.GV134822@grain>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-22-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-22-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:04:09AM -0700, kan.liang@linux.intel.com wrote:
...
> +static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
> +{
> +	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
> +	struct arch_lbr_entry *lbr;
> +	int i;
> +
> +	if (!xsave)
> +		goto rollback;

Why not make it simplier?

	if (!xsave) {
		intel_pmu_arch_lbr_read(cpuc);
		return;
	}

The goto and "return" statement before the "rollback" label
looks pretty ugly. I'm sorry I didn't follow the series
in details so if you plan to add more handlers at "rollback"
then sure.
