Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D8C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57524681
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HyrdAeTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBLU5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:57:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33254 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBLU5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:57:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so1853119pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHo3G194HPvl0+OTxbPr1GwQTRPrDmSRoLumh9Fh6mM=;
        b=HyrdAeTcvgHRYbZo09Kb86QXTMATZSY7Vuv7SI6TBS/vPJAQAsIBnvFZa3CqLwlJZQ
         Z85vtRCWtFi+hpjM6UQZ00PWApDMKryOIxEazlJ7UGYNTkdnMOrOLwlH3HRiQgxtsN2O
         2auqk7fJBFTIMRrJ6ozqhAF2nCmdMJJXXrfBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHo3G194HPvl0+OTxbPr1GwQTRPrDmSRoLumh9Fh6mM=;
        b=Pqtmu+VAOLuhPCP6ACeuS9B6auTkQetD3acOFDVGXJQ3HkbH3DgW6NJr1xU/1HEeR+
         BIlX3Avk7SwbuU2NTFDKq0Flv75q2LmW+8fuk1higzwdhLKiezhK4I+mVK9JphpnnvFp
         7X9olcCcwsjaEg4Uex0kq32Di2fTyoX4SGFcf89+00apvMhuAs381E9B8dskuGnVQBx4
         DkN/ofHLXOZ0MDvCXntDvMw6wxL7bvluL8/fRpDSElVPbIuCGZz7TjLSqBHgfckMICAT
         aalZPtl/ejNS7+9MjZqeg1RpHLJStObmjuxcvH7h7Ct9jlP/+3sKL2XEySIDNJqtk4bw
         wc9A==
X-Gm-Message-State: APjAAAWvpbX/cGBW5yscmjNS6XGLZo2VdLjZHTQc0deHvYfNwueql/B0
        n3jZRy6QSY4tNPQqJRuWn6XDqg==
X-Google-Smtp-Source: APXvYqxtQ0mau5xXh39HhHqp1pbCX/c1RwJEe6CZloh7WRAzdL9bkzXuPrMaZXDdzb2V3HCJEXDKhA==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr10153014pfo.145.1581541020946;
        Wed, 12 Feb 2020 12:57:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o11sm159647pjs.6.2020.02.12.12.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:57:00 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:56:59 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc7180: Correct qmp phy reset
 entries
Message-ID: <20200212205659.GE50449@google.com>
References: <1581506488-26881-1-git-send-email-sanm@codeaurora.org>
 <1581506488-26881-5-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581506488-26881-5-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:51:28PM +0530, Sandeep Maheswaram wrote:
> The phy reset entries were incorrect.so swapped them.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 8011c5f..63bd7f1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1081,8 +1081,8 @@
>  				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
>  			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
>  
> -			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> -				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
>  			usb_1_ssphy: phy@88e9200 {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
