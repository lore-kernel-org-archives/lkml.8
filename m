Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B253207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oejGwdjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgFOQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgFOQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:58:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so5596739pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBuCFcr1c7ooxiwUbO0ya6INndghv2LyBVNZliL2uGw=;
        b=oejGwdjrw7F/9k7o+lXiX92BL1qKcWDV88mAc1fiU852jJImA+gWVoieEhjlqQ3ryH
         ssfZeisyS3tkrTn4uMfkW8Wyc5f2B4A+g4HPPkxWmIcZeyOXJDBaZSev4HgFISReeM56
         484Eh9oXtcE/h6d8Y/6jXuH0LUrhuQnFV18N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBuCFcr1c7ooxiwUbO0ya6INndghv2LyBVNZliL2uGw=;
        b=hy0BZJk2OPeUlokJcX35iqi8D6Vm4WGvG2hpf073gOr3PHeyWu+Ir/zOPD0LDXsbxv
         WnIEuZmfmBLWleQB/B7bqA87ALqVpCq/7WinVZORWsuxUjRgFY+OhHYpqfwyvXUTHiW8
         4xIN1dCFjcxn/pJg/Ki2c9mURlQFrdUmtrt6zyQspfFYr1i+ejAxG/FK7qV/KJIBf3F4
         P/9H18KLaU1ZCpW0TpOBlzrtka4DY0iNZJ3l0TUk8KeQT9hROlCfBRbFVaamz1V+v+H2
         719kbV8MC86vWAQHSfCnMdzC9mDpm+tTyesOsxWLNxdUSwF2yY1g8KIckJvfTjwa9kP5
         CK5A==
X-Gm-Message-State: AOAM531C7NJ1wxQmVFusIZOykXha2ZZXDoQrGVoUjf/XEj4BQU+CXJMJ
        Om11tjhx/49f6OfC3gg7z3K9uA==
X-Google-Smtp-Source: ABdhPJxU9Bh85Kri2tWUmfVcR9ufNh16uRs+L3DH1Fs84oxdpMeR1Kn73BIg2cnnMMEi+sNaSAHEpw==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr21673925pgg.24.1592240336288;
        Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s11sm13980521pfh.204.2020.06.15.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:58:55 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:58:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 3/5] OPP: Add and export helper to set bandwidth
Message-ID: <20200615165853.GT4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605213332.609-4-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 03:03:30AM +0530, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_set_bw' to set the bandwidth
> levels associated with an OPP.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
