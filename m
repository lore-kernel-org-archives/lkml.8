Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43742C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226CD2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0YustwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgFVP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgFVP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:58:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F77C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so8320088pgo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hqx7rC9HmtHirbGKyHJfb50cjiD/ySJOns5T8xAdcmA=;
        b=Y0YustwI6sqGt3ubIoVtT7pkFHCMGqdSaeU8DfgABVXFCm7esF8Kz3VoXytTPp9Vh1
         yWKiYxye1K+LL++kEuA1k6FFFHOZgvNWUY4ymAAS033Lerg6Nfr3JB2HxdJH5OSbuWEW
         75sXQ0axi7IA3a3hTQKit3yVgVgdot+PQAJcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hqx7rC9HmtHirbGKyHJfb50cjiD/ySJOns5T8xAdcmA=;
        b=nG1XeERpq9VBYOldHdUSqiugu6NZLORGb+YFjhDlrRpDh7njyK0TwrKkYzyTzvuYSb
         u4nZ8vKSKBkYp+jAdAhYJo5Bi55RHYFCUuUKWIqH5kupEf+9GEAGUQPuQy+EW095UA04
         nzPtq7GhEjHCezczR/INurhYas6gEtoRi2liXibZ+MAhzuZr3pO+6x1vMLmeI7JxcEa2
         fUrEX/MhKDbTQBUOi7uECUHUd2eo+fkGwQ+SNsiwjqKV2HZoAyv7CkD2hWnZ2quEk31v
         foVWNA0t1EWKGGlduWYPbrypAlYzWA41zfmDfm7W0GNBsfy5lAwqw5TfXwetp2+2ONcS
         5qrA==
X-Gm-Message-State: AOAM530Qi7f1TeFstkNtrG51NNgWbl1CeH52815LjwE1TM0N04bcR9Fm
        hDaKmVV2gT87qqfi+6+tI0SYcQ==
X-Google-Smtp-Source: ABdhPJzYKjvdTbFBrvziiaoyvuftohXyJS7FfaTDWSSJUGHWw1taamvOj/VHPJsiV9By6792NzQeAg==
X-Received: by 2002:a63:be01:: with SMTP id l1mr13730067pgf.32.1592841489272;
        Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d9sm11584719pgg.74.2020.06.22.08.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:58:08 -0700 (PDT)
Date:   Mon, 22 Jun 2020 08:58:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200622155806.GH4525@google.com>
References: <20200622081649.27280-1-sibis@codeaurora.org>
 <20200622081649.27280-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622081649.27280-5-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:46:48PM +0530, Sibi Sankar wrote:
> Add support to parse optional OPP table attached to the cpu node when
> the OPP bandwidth values are populated. This allows for scaling of
> DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
