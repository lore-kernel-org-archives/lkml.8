Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAADCC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D55206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaqchf5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDGXip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:38:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37886 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDGXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:38:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id r4so2475868pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOG8uXDl25YkIY1KwvU7WP+vA59IBuf+1/ymXSgkT1I=;
        b=qaqchf5jB5Eqy41fV6WU2Pz9vxP8irw80dxERZBvo8vJlEUyLvQcVHqo4d7BqKi5mk
         OzWDY3XOoxKXqyjI/WiJMwIx732T7Zasabr7mN8xRgxLdQugRkuLklMqQo+Ko7LHb3Jk
         s6ekr19+LwPrmvkJCNgUquIJZGlUv7tY+a1Ynp/veuOitVrFvnVN0CibRse67tRCbWoB
         Da7DlOB6sd3vxeH/eOHhilb8y74yZqq9KWgdDEQqkEVeKW/CelXsOB1V4m/Bl+mWGGG6
         QCv8SivvGUS3W6VPJQSAru20CvvFR1SUImMZ681gh306B9PWC+k/syh4IpzC6qvd+HEq
         lmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOG8uXDl25YkIY1KwvU7WP+vA59IBuf+1/ymXSgkT1I=;
        b=lrJvVYyw+rkQkXFEH/bKaseWnyyFSNocojDglIbT26e7AlZA1hIb7AAA6WvmSw3scJ
         0+pHS3ID0mdiMoFdQbJWaxmr263jvsFhP4x5B/smh0fdFNtJ6Mfga/pbLITiOnap6jAc
         JoQ4TdcWwhMcjy2bIAFcJjT7xtloWvEHfywlfI7CPP3oacU5m1OIJRJ/lRN7w6/P1wxD
         CUXJdwhxsbFZC4kb7RZ+YSZTDw/WolsgAAivfcXhOi7HSZHnJqFPDVOl7eRj4rp/2F4j
         Z7yufdEI2r8gi1WW/Aoq0XT5OOK+StV+SLTYhRgalJMYhXciQzh+h1anFhCiBP6Je/S3
         AK7Q==
X-Gm-Message-State: AGi0Puau00keg9O73KtAJSdNavj+DyceM4aZ85Aao9XAGAU+iZbUkCJq
        nJ93KYyd1DQ/DdrkOGdtgROVZA==
X-Google-Smtp-Source: APiQypLJ4W6r4lUs3kl4+KovCBimfVWxesaytHb1fY7SpaerFs+CbFQPc75tWHX2dn9mukWlYUgjuw==
X-Received: by 2002:a63:2e44:: with SMTP id u65mr4419244pgu.142.1586302722857;
        Tue, 07 Apr 2020 16:38:42 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id hg20sm2573036pjb.3.2020.04.07.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:38:42 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:38:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org, Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8150: Add USB and PHY device
 nodes
Message-ID: <20200407233848.GN20625@builder.lan>
References: <1586298267-4722-1-git-send-email-wcheng@codeaurora.org>
 <1586298267-4722-3-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586298267-4722-3-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Apr 15:24 PDT 2020, Wesley Cheng wrote:

> From: Jack Pham <jackp@codeaurora.org>
> 
> Add device nodes for the USB3 controller, QMP SS PHY and
> SNPS HS PHY.
> 

Thanks for the respin Wesley, and thanks for testing Vinod. Just spotted
one little details below.

> Signed-off-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Vinod Koul <vinod.koul@linaro.org>
> ---

Please make a habit of documenting what changed since the previous
version here, below the ---.

>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 21 ++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 92 +++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
[..]
> +		usb_1_hsphy: phy@88e2000 {
> +			compatible = "qcom,usb-snps-hs-7nm-phy",
> +							"qcom,sm8150-usb-hs-phy";
[..]
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";

The first cell here should be qcom,sm8150-dwc3. The Linux driver will
"fall through" and match on the less specific "qcom,dwc3", but if we in
the future realize that we have sm8150 specific behavior/quirks we can
make the driver match on the more specific one to implement this.

And similarly the order of the compatibles in &usb_1_hsphy should be
reversed as well.

Regards,
Bjorn
