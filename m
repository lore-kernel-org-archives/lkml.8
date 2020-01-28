Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88457C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BBD21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNCVgdtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgA1Uo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:44:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50432 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1Uo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:44:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so1587086pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbJeh8/LI2mlLTbZ1tH2VO6yi1sNDNk35sjg9NyyWm8=;
        b=FNCVgdtuEjKA0XO9LyT7fFDkTLztdtZBXLK+Wji/XBIULcUc0VHBKSq9rnp57o4/uv
         Wrvz6O3JeBx7ohJxH5vzXQHWvMR/zOkDj31S7lKg05DguscHm3hzpUBEspKsfME/HFvJ
         hbOhPs4Mz+OsShEmI3DgPvYZwga6/tAccTuq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbJeh8/LI2mlLTbZ1tH2VO6yi1sNDNk35sjg9NyyWm8=;
        b=kcmFkqNmUJthyW7yveA6j0FKtuD4lF+0Jxik2uN+iUq7t9BAl9CEYxfTMOOGbknuPc
         NKaSoon2bVBwrnQYnMUGx+iOvQVJsTz9SThJTP6JnJSIsSrLgIFuEwQkcTgg6R7KAmwH
         w3vB75vIDfx2D4CpntFtmUWpIGx9ODE7eoS3hw8Fv7ldVFm//1mHFU2liri4s/5q8n4c
         HTo+4WCiykWTY8cWrf8SMWE8wRiw96s7bCG7GOj4UzYxw4DycuHS7H4AVd2i6TVXg+Mk
         NkzJl1L1i6deHZUMSx6qhk2UIyOAX3XjKgum4uRohYBshzjvmG3nxZIDcvelqJcJpK7L
         WhFw==
X-Gm-Message-State: APjAAAXTpq5uHbN2rsPvsprkAMyj2HRYuGWYVUyMQ9W0k/Ld15rlaZ0Q
        z6USiNX1pOFIn9V3renwos2ZRg==
X-Google-Smtp-Source: APXvYqxRJmQfwf2gXkhjLY8zub6q2yqFGirhOsUJnZOp1NUzUg5k4YhfFHNWtUB/gZ/+9rYRTomoww==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr6823668pjr.129.1580244265708;
        Tue, 28 Jan 2020 12:44:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c14sm20864917pfn.8.2020.01.28.12.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:44:25 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:44:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
Message-ID: <20200128204423.GF46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 01:33:42AM +0530, Sibi Sankar wrote:
> Add SDM845 to cpufreq-dt-platdev blacklist.

nit: you could mention that cpufreq is handled by the
'qcom-cpufreq-hw' driver.

> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f2ae9cd455c17..5492cf3c9dc18 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -130,6 +130,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,sdm845", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
