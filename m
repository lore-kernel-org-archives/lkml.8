Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460492168B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCkExZY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgFVCPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFVCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:15:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FEC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 19:15:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so6916141plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=37v9Z2NUuqEmIDRz9ZfwrUOtyxz3ECbT8f4zSnYfHZc=;
        b=KCkExZY40XAQKmTnsGnTWfYUJmKzA95HBhZPmuw4lTsn4xCJnetK+8GlvM7qExsTOC
         sJDkwc5T2E3UE65Rsuug+L2NIui/rPi/53fkrggYqHqNlRY0hcxeHraOQlXwZTsy6/bR
         bkuYWgOaY8rseIJFqUMnkRIMJ6s7qeBdjBVpy3o85QNt6uJbxibtRPi3m2MkRzWrHSTX
         UZLNOgU2+YgL5nePf9spvJZwxbe8a27Uxsys08U547TxFci9p2HHbZinkjGICt6NYo8P
         1PpNKCDWrVMrM6Ngqr4HPLa5YCWL0H3nc4oQBDfMq1uSlxSnd+MROhX0O2+cwJ+SWnfp
         jsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=37v9Z2NUuqEmIDRz9ZfwrUOtyxz3ECbT8f4zSnYfHZc=;
        b=L2dt7ydDcLav7HcKy4SlTZBgamUQEkgRYgPyXImlVLeTpfhgd0uF2HvuCMydtH/Oyc
         aQ4wa0yT0f6eDImHwfit++p3A0pWAiHcm5bhyynmIRcWS82/XV4Uy5eLmJMh/f8QCOAW
         4ua3HrD9ZG2BznxSx5Atrf/IVAFOfxjWHlVXKEXcNIpY/10xuP8CEhhlKTT2l1uShEmv
         0awBqeaM+NPpP/pha8JJivrvg0UZODZ1r4vQQShRHNSWRON6G1+o0oDe2VdiwfPZjv18
         rgzFGqx9Vn2mMUOCJsI89JRvDxh++r8MsbLih9nUfH08O/NxOz0mtN8C5kvOGyXW6JlZ
         m3iQ==
X-Gm-Message-State: AOAM532bq/nESD/KpqdUVJqUcYNmktI7ubyViXm+KGXK7cLl2Xk4PaQu
        HSAHJgS8g4K0FyWqgChQmY3ppw==
X-Google-Smtp-Source: ABdhPJwPS+7RGBWUpT0GPEFKZ75DSVusV7wLo1l1FDO1Kr7CAcaD4Qq1njDS7a2sV/pjaNpTCmEjIg==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr18694335plj.25.1592792131751;
        Sun, 21 Jun 2020 19:15:31 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id gp4sm11449615pjb.26.2020.06.21.19.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 19:15:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 07:45:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: opp: core: Add missing export to core.c
Message-ID: <20200622021528.gmpnvjhvq66oqhit@vireshk-i7>
References: <566735.1592672602@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <566735.1592672602@turing-police>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-20, 13:03, Valdis Klētnieks wrote:
> After this commit, a 'make allmodconfig' fails due to a missing export.
> commit 5f2430fb40c74db85764c8a472ecd6849025dd3f
> Author: Sibi Sankar <sibis@codeaurora.org>
> Date:   Sat Jun 6 03:03:31 2020 +0530
> 
>     cpufreq: qcom: Update the bandwidth levels on frequency change
> 
> ERROR: modpost: "dev_pm_opp_adjust_voltage" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> Provide the export.
> 
> Fixes: 5f2430fb40c7 ("cpufreq: qcom: Update the bandwidth levels on frequency change")
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 6937bf45f497..c9336aac74e9 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2302,6 +2302,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
>  	dev_pm_opp_put_opp_table(opp_table);
>  	return r;
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
> 
>  /**
>   * dev_pm_opp_enable() - Enable a specific OPP
> 

Applied with reworded logs.

-- 
viresh
