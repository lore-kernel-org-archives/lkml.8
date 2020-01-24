Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC14C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2532071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rcu1X3Dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbgAXSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:07:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391255AbgAXSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:07:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1521941pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IuP/yrM7TogQo0+OWnA/G49Ex8i7tTjc/gFe6ERivRQ=;
        b=Rcu1X3Dy925fd99fddM0KMzZam97zkVjdr9upq5++IvBdA2IfcyFEIh8b6fLzzo0Ld
         K+mqtwzsypb6XTldw9H7/eo9qKG7Hrv3aa5/f36PVhpn9q8X4kXDMAXnB1HMI+Q0YzrB
         8J9USsvQMxw2K6KBot1wPh7QfCjvXybbZw1Xbf1cegWCswe0JbwgcVVOZoE+2qSofnov
         WgQBiOxZtOZWWTIUlPJqiquaF4FjZSHLPCa/4nh5LzyDhEVeP4bSrdThlTsLNeHVJJEE
         KxKDQEveNdNTdaeFt1oLZ/K8PUQOGZJ93TTtoNgRCYLcwJVpNYw0a2THLGo20/yT5KAH
         6g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IuP/yrM7TogQo0+OWnA/G49Ex8i7tTjc/gFe6ERivRQ=;
        b=iaW83JRaBnscgF6WzqWBQCw4OINbUa+9hePGY+/q2ctpRfGh30SUBNrxSpbAbXp4yL
         uWkwVlX0RfGfNfhrHSSvnI5zAnKF7sB4+waeoPBI2UqRp3ao54WkpLbJ2B/qwLSP7rBp
         ekMKiHvvI+W+ZhcNEYOtcNBxMP0ZYms/jWQtAbK011Z6T6aIz3+ZAoyLVRtcGpme0hFx
         NrXsh39lgYTD87FwvaAxWFG3ttEolrmrnAfwydvpeZOKsWtgPdMl9nJz1EXexhFsEUWA
         nxA0EElCQ8tmPd43K0jdO7YosM1OFvKEAr35q3JXmNmOuUITzjjx3oP3PHtuB90KRNQE
         sLDw==
X-Gm-Message-State: APjAAAXlnlZuFtr2o8tMTMLIN+4h0Wu+Rfeul14qrO/QUDJl8LluP1v/
        ZIxybjamQ/Nu1YCsd7OqkQquVQ==
X-Google-Smtp-Source: APXvYqyQ5Jw319haXXTfcQlWyCuDDIq6I1T8s2i5tzgNXAWiINJ5GGI0hNmFmaBSU6Mh1KCXecvrug==
X-Received: by 2002:a63:20c:: with SMTP id 12mr5293196pgc.237.1579889268059;
        Fri, 24 Jan 2020 10:07:48 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x65sm7308897pfb.171.2020.01.24.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:07:47 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:07:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, vinod.koul@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Add device tree and clock drivers for SM8250 SoC
Message-ID: <20200124180713.GP1908628@ripper>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jan 15:39 PST 2020, Venkata Narendra Kumar Gutta wrote:

> This series adds device tree support and clock drivers support
> for SM8250 SoC.
> As part of the device tree, the sm8250 dts file has basic nodes
> like CPU, PSCI, intc, timer and clock controller.
> 
> Required clock controller driver and RPMH cloks are added to
> support peripherals like USB.
> 
> All this configuration is added to support SM8250 to boot up to the
> serial console.
> 
> This patchset depends on one of the RPMH clock driver fix
> https://patchwork.kernel.org/patch/11318949/
> 

Validated that this boots to console, so even though most of the clock
drivers hasn't been exercised.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
