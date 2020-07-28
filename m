Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52292C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDE820714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhCJuYdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgG1MlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1MlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:41:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:41:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so10888584pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aReFv2nNZFl6PbmS4OI8Ldg/Mk0JrJ8F6hC/pZA0KpY=;
        b=AhCJuYdRU7t6Qb139CRylt71iQN7gAp/Fr4QAueqUauM7+uHVyrs7JdUdumGdUhzLt
         AGxnh2GNGJ8SngZuQKo0WMcI+LG6NyKwW0uSjm+giOi2nLAWxanYK6VI+5XcpOGAxB+U
         KWO+Q09WOIpUFljsaUy03B8VZdNBmyKHBmKnlDeTi0YIX94y/KWRyqXL3U3dbm3Vayo3
         msQkiDqtKaXQaymYABeERKc0nXmLrC5IXVSIgvfmgeuD314DcVvnmF6eoJ34v8z4m/OQ
         qMYls3XCVy9JK7saNQ4sqbWWhr+KRicX08m6kcGTUMUznZJ/LQ41BbagdTSvfPtqg9T2
         09bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aReFv2nNZFl6PbmS4OI8Ldg/Mk0JrJ8F6hC/pZA0KpY=;
        b=bG/wD+AwIsq5HTxM0I5fg43O75HCJsucebv7Mx/pJ8NLidVI8smXkulJisO1na4el5
         4AOF58mg/zQlqoZ7pjiUX16p5jlB0Qo5vFY8TdtF09905pBOzswwmxA/bYbGFkeOCmxi
         BRsTjNks0LdhzW1mzLkuVA+BsrpjeWw1D2SRtzWfbLBpeYSN5EZzvrIIxBmON9NwYiXg
         HFp8pPc/V/Tfsd36l+czD+IEk26VFh0DuEApeFxkUyzf3ruPyfL6FydkABkxLw3EzGtI
         hakT6CKfXnyO2/7ZA7kPBMaw9gYAj1vr3th6hlypNRqyM77RrkRBj3jd79UcGk5GjVdq
         ivCQ==
X-Gm-Message-State: AOAM5335ftBF9AkywLwlH5Kgz5xTgFt1QHyiX95VC88CXOnPSvT7CC3I
        Tci2HnvJqOweuRD9F6BSi3TR4w==
X-Google-Smtp-Source: ABdhPJyle/kz4IiW3C4bEJ/IjREM7cyi3tOw/6+R5YW665bO+46I4ihdSCKxCYIuibDz5/OQwQ0EqA==
X-Received: by 2002:a63:742:: with SMTP id 63mr2027362pgh.295.1595940069765;
        Tue, 28 Jul 2020 05:41:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y68sm5931829pfy.185.2020.07.28.05.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 05:41:09 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:41:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 0/4] Add support for ARMv8.3-SPE
Message-ID: <20200728124101.GD4343@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200728120623.GB40195@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728120623.GB40195@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jul 28, 2020 at 09:06:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 24, 2020 at 05:16:03PM +0800, Wei Li escreveu:
> > The ARMv8.3-SPE adds an Alignment Flag in the Events packet and filtering
> > on this event using PMSEVFR_EL1, together with support for the profiling
> > of Scalable Vector Extension operations.
> 
> Leo, Matthieu, have you had the time to review this? I can take the
> tools/ part, the kernel bits should go via the ARM tree or via PeterZ,

Yes, I will study and try to give some comments for this patch set in
today / tomorrow.

Thanks for reminding,
Leo
