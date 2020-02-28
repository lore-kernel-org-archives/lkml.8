Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F5C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B109624672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZWWWXPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB1GpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:45:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgB1GpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:45:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id 15so1208390pfo.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XbwCgyzVBr1Eex7C4dZmk+lP7N9qyM1bwXDkPQVNSxc=;
        b=JZWWWXPQlwpFMM+AmL6fMEUoHrxuhqLoDilpUgmvmVAKEqhhSePTAMQ0slt9Lf5vZo
         iF+l3WGS3z/TWp1qwOj9Y5Erx2EscBNgXkxVBbHaAMkr43nhTaK3z1dIEP3JvH4uQ0cd
         Jw/I5bKUULhGu7gue52JYD7uwP+zoMV1UE2OFwxi1II9q0QEfOWd4xrgBdDzmoy3BKHu
         JPeQRnH1EI+M6Xvs+CSnnSqHAMAAr644hSU4Vg0TF8dxceiw0rA3MrUGiracAi71k2MI
         RmDW3uM6RVjhir88gnl+P0vD5jj83Wa4cCg3MOrGfMBL6l+1QaB7saiu8yMmw30wZkFZ
         mzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XbwCgyzVBr1Eex7C4dZmk+lP7N9qyM1bwXDkPQVNSxc=;
        b=bOHiMX951Ma5iXzq/B4QUf+eSSjVoKVwXs5HYUb87hVzRYORGaYWgGtZM7glqKFLcN
         /oxFgiN4Za/IpAn0MLpNkDrMS/ggJQlDo3xadwdx7wZ+oKA7R1mYR0PGiEFcrVTgcO9P
         csZ0B1xFY1an/MDJ764WP8C1bOVMErTCiCW1z99qJ8kag86BKTZB5r/Uw1V1OyT2IsZ9
         HLA0VaspNdup4lKE+Fh2IIojTLivxRuN/nJ7d4S4tuterScR65HPMwmYeTOn/R+mn7Sf
         Fx+Unl+urtGglGV3N1HPwFnZGw7yhDXEVePEiQfTal8ErDuVB3QXoWZiqxQTjdkjdLxI
         9lnQ==
X-Gm-Message-State: APjAAAVFR7fP7AVhv1xOSZx/+PDoDvewOIjBgj9Jhjj4cAXF5E4S8SvY
        Czg87riTsGnM3r8OuWeJnDGz8g==
X-Google-Smtp-Source: APXvYqzF8ji+gn0dQ8v39z9gCg4DrDb6BT+aNjn8AKK6duXJ7WHZBsqH1TJg6ktNWWvBpX27Ce2TWw==
X-Received: by 2002:aa7:8e9e:: with SMTP id a30mr3031533pfr.158.1582872321548;
        Thu, 27 Feb 2020 22:45:21 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g10sm9711018pfo.166.2020.02.27.22.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:45:20 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:45:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Cleanup dtbs_check warnings for tsens
Message-ID: <20200228064518.GD857139@builder>
References: <cover.1582871139.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582871139.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 Feb 22:32 PST 2020, Amit Kucheria wrote:

> Make dtbs_check pass for tsens bits. I'm working on another series to
> cleanup other DT warnings for QC platforms.
> 

Thanks for the fast respin, patch 2 and 3 applied.

> Changes since v3:
> - Fixed up subject prefix
> - Added acks.
> 
> Amit Kucheria (3):
>   dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
>   arm64: dts: qcom: msm8916:: Add qcom,tsens-v0_1 to msm8916.dtsi
>     compatible
>   arm64: dts: qcom: msm8996:: Add qcom,tsens-v2 to msm8996.dtsi
>     compatible
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi                     | 4 ++--
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> -- 
> 2.20.1
> 
