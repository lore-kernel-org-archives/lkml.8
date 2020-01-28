Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D02CC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6018124688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oe0Deoml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgA1UkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:40:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39675 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgA1UkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:40:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so7627284pgd.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2i3ifj+o7a56Ej6B9maiwsFtxZ+qZn9EVpxFQulwzyI=;
        b=Oe0Deoml28uBRBuJGwSYnMX4gjeW08RPDQPW1p9i/uhQqlnGChZF22DGhZYBwL7qNu
         nGzDMvsDqIjQm5sW4u42/ryWYW2uLjdypkNR59DAfrWdRa4YSZH9CmBbGqg2dXyEVXX/
         wEn4suIUo2Hb9TqHuzqhMbTqpQacXNSJsvVKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2i3ifj+o7a56Ej6B9maiwsFtxZ+qZn9EVpxFQulwzyI=;
        b=mGqNUP5neg9oEG6ORT690NSRl6lRB87PkYiQSo2CMpXgYpZVhCP2BYuPSexKl5WN4T
         Obgnejq28EnufK0OFvqNLKtWSVBAMVZpgXQymP1nW+aRlazYfTwP5Nrl3NP2vGTYNowj
         HpUEYBI9QbVbn2xerJde6RkLNUNnYtVTCDNC/v9EE1iLElo0snw6ONvUrgwFNWUnTult
         HEh0DdBtFaFD96tO1CMpuy6ty5GavYS7Saow0SPiaNHM6sxlACjjZcFQKPgasG/vH2zA
         YavCFOP6GMqVggkws8r78ab+r/JQlIZrkpja4oshhAZuFCO2ubky7ZS8Q3pbLl8HAf75
         //7A==
X-Gm-Message-State: APjAAAU2csjShE5tWg0fPOejAdXfE+KEvmgTuZMh/tFF0CtFNtCE8Fm6
        yDy4NohQW8TcvQ6cCOleQhcrQQ==
X-Google-Smtp-Source: APXvYqwMQdKxHn6Q4Ri/enHwlEiGz4BaCFfgC4w0rKZoFtqzu009EY6UmncTFq6yvHoRzxcL6hMY2A==
X-Received: by 2002:aa7:84c6:: with SMTP id x6mr5442136pfn.181.1580244007783;
        Tue, 28 Jan 2020 12:40:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z19sm20419043pfn.49.2020.01.28.12.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:40:07 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:40:05 -0800
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
Subject: Re: [RFC v3 01/10] arm64: dts: qcom: sdm845: Add SoC compatible to
 MTP
Message-ID: <20200128204005.GE46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Tue, Jan 28, 2020 at 01:33:41AM +0530, Sibi Sankar wrote:
> Add missing SoC compatible to SDM845 MTP board file.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 09ad37b0dd71d..54087847794aa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
> -	compatible = "qcom,sdm845-mtp";
> +	compatible = "qcom,sdm845-mtp", "qcom,sdm845";

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Since this is v3 already I think you can omit the RFC tag in the next
revision of the series.
