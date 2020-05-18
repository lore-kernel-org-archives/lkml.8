Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A35C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CB920826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yezs7gGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbgERSE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732846AbgERSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:04:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8CC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:04:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so4547393plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nGHpGwwWCzCJVc7bPHElzmAcZWD6x2usMfgTF/Hyv34=;
        b=yezs7gGmWNEMQgES7TZ+xcCNcGDm2+5zFxorxpSP+ZD8d645MzsEgn/+ELaoNKXIFF
         jwt25o2C1yM1vnTI6Hq0qT4rrZeh8aZYdo99QBYcXaJAED8NNz97cHQPfyanqByvOh8p
         q2P6P9PgOakAS2y/R7ywxQeQLTluzvw4DRj7LTbweDTceoXUwix5YjtjzbpIgwZhWacL
         u0kJHWnongsmlnxe9x81xW8PMi4x3cfmmaFf76hlMYAh3p7i/SevDZdLWIdwtV+XIvZo
         HsJG3QBKDPJKTLwyqp0nSxh4qC5QRhrQ6MTB5zCV25Y/P42K/Yk+kupocFQObxdpjLwh
         mzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nGHpGwwWCzCJVc7bPHElzmAcZWD6x2usMfgTF/Hyv34=;
        b=eSCaSRLe1xPvIlNOKTqzKjGWQxBILHT2xHCfms+xN2sKayEh0zbu+1EhfDl1eiyAew
         uNl8EeKrS+ecmJcfSZbQpWrezVQK4q7lIKp+P/KEfU/7RFeBscWscYpZpzXIS0lQMawW
         oRottQzWzxVYQ+wuKAOhIik+ndFKlPgBA8JCyhLdontwdx+PKSFMhQgvxcSHiPsPkkxB
         8XY28OUObe3CvLfVbmkxhovr9lnPImoM+ylE1UtbUeTJXYg0/Sbc2MsC+1xt3vtBQ6rf
         2y18LBC2usfyZ4D0O2c+NaWFvwL0h+nQtGBBwr09kRPtf5iIrgMfRHVliSZIAdrJFuAW
         lVoA==
X-Gm-Message-State: AOAM532cXfw2Reun4/vhOKZSfbVk9au2e5VwEigKAK3fpB8cNXzN8B8r
        ZLESSHMy+uA9/iz5FzzguBW2jw==
X-Google-Smtp-Source: ABdhPJy0os+7IoFCFKg7k+EZgJxjNXzkxcklwepEVVeiJOSzaLYyRQZOx0XwQFhan0Ma7PyXS/9uNQ==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr605595pjr.168.1589825088878;
        Mon, 18 May 2020 11:04:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c24sm172998pjs.51.2020.05.18.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:04:48 -0700 (PDT)
Date:   Mon, 18 May 2020 11:03:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] arm64: dts: ipq6018: Add a53 pll and apcs clock
Message-ID: <20200518180325.GB2165@builder.lan>
References: <1588573224-3038-1-git-send-email-sivaprak@codeaurora.org>
 <1588573224-3038-9-git-send-email-sivaprak@codeaurora.org>
 <20200512202439.GK2165@builder.lan>
 <80039c21-41cf-2ace-939a-ef48fd773aa4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80039c21-41cf-2ace-939a-ef48fd773aa4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 May 20:55 PDT 2020, Sivaprakash Murugesan wrote:

> Hi Bjorn,
> 
> On 5/13/2020 1:54 AM, Bjorn Andersson wrote:
> > On Sun 03 May 23:20 PDT 2020, Sivaprakash Murugesan wrote:
> > 
> > > add support for apps pll and apcs clock.
> > > 
> > > Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 16 +++++++++++++---
> > >   1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > > index 1aa8d85..af2ceeb 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > > @@ -294,12 +294,22 @@
> > >   		};
> > >   		apcs_glb: mailbox@b111000 {
> > > -			compatible = "qcom,ipq8074-apcs-apps-global";
> > > -			reg = <0x0b111000 0xc>;
> > > -
> > > +			compatible = "qcom,ipq6018-apcs-apps-global";
> > > +			reg = <0x0b111000 0x1000>;
> > My documentation states that IPQ8074 indeed has this block at
> > 0x0b111000, but IPQ6018 it's at 0x6b111000. Can you confirm this is
> > correct? Same with the pll below.
> The address 0x6b111000 is how the RPM sees this block. For A53 it is still
> 0xb111000

Okay, thanks for confirming.

Regards,
Bjorn
