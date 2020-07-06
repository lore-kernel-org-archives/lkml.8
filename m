Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1C20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO55GR5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgGFP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgGFP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:56:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22DC08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:56:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so18596645pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pVmdFcPnDIN4VmYOV1khBeXkMu+a6j7sOe2sgMGHfsU=;
        b=TO55GR5G2jDWam4n1xIVmo92hKZldcYsVJfkPHpZ0r3rpphNQip1UwI85GwNw4yLMI
         tqKVbaIJx8/wxKOjPQUzD7ckrhaz4ZwuYLpWjF9QpBE+SpgHU0l9lSgbSQJOYnxB40r0
         9EQ0zQonk/g9xidXOeU/ZhbkWCEnt9EysCyko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVmdFcPnDIN4VmYOV1khBeXkMu+a6j7sOe2sgMGHfsU=;
        b=hFODxXMOH0RmF9nIBK4W4zz8Txsc9jVjXPsIavVYtWa/oBGXx2TkZc85Bq6ubdndI3
         6ZLLL1/Mi4d/Bq8YOims7MHiKMynRfKk/wMThlED9wM0tquIjsewpQhyNsWGiAXkuKep
         7sn6FghhRvsjLLw1H+E8o3Yoo+h5k/j06x4i5xdYBauqCFBSA4eHzf1mIR3kVYXMsnU/
         JNyleY4yJOweYKFsrRsWd5pJ1q2bJrQKImZ3JiZVh73do0UYxGxeqI1M5k43Rvbpvbf2
         5rJu7hJTPJEIPDSKzpdTPlBXEsPhtv2Y9+do+DuYcjfaBm0zPC5Lc9KUbXfP+NAV5Nq6
         zaxw==
X-Gm-Message-State: AOAM531OdpMLHecsF2bp4faIr5/LMZRZuinCxLT9raw/zTICV3mLnLtl
        oWkx1ogZz+HhzRN371qdt3qh0w==
X-Google-Smtp-Source: ABdhPJyvHVpu4bXYVN+N+KScd3VX4nB79IkZJ5AQZJY2cTj7GHiR7QWpLWJVIgHkuOqC+Bxec777+w==
X-Received: by 2002:a62:2546:: with SMTP id l67mr5919215pfl.154.1594050970085;
        Mon, 06 Jul 2020 08:56:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id c23sm18976405pfo.32.2020.07.06.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 08:56:09 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:56:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: sdm845: Add qspi opps and power-domains
Message-ID: <20200706155607.GE3191083@google.com>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
 <1593769293-6354-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593769293-6354-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:11:32PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the qspi device on sdm845
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
