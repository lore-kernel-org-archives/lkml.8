Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679492067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKBZK0fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBXdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFBXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:33:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1166C08C5C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:33:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so3272327wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gRIfKnJl6SPT0TJEscdrNR/IF4u0o0KTS5V3RmcEUyM=;
        b=JKBZK0fKK1R/SWy7yxMUC8suZIyxultiSmdoxR3UvAqPTsEh9pJ12gIrHrzxSaP/wJ
         1KwHQ4uoqdDgRKP0rUf2ngjWH7KZegwN3bN3V0kq9BXoNNPADqqSu7p+CrNekbPkRtfT
         XY2cvpv2j70n9V+knYIMoo6y+UfAxd1/go08NJBEzjSHP9N5MB0RJKmI28BhLy7XlwqM
         lCJxePHePQ8cjXxRuURh2oe5D/XWTn2F/3MKpL6fOZbesn/sVSh3daVKWyOccvCXi45v
         Iu9yNec0gWwQRQBwywqYhtf4mEyXK3s/RT4q/DGWc/HUW/7/sM2ur/sD8LjJgaMuomWc
         LLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRIfKnJl6SPT0TJEscdrNR/IF4u0o0KTS5V3RmcEUyM=;
        b=UMAOjYkN1IyEbWJ8RNOtLLqFq6geelF6bi4iP5m96XzXWtjbCG1rzYzcRyoX25+w93
         7OCTAn/h2AmPHTSQX6mIcQINBBrzo7EsDi9BTXrnJkn2OyzfYZWYcENAeNQPc5PYkHPE
         vyFrD0auB5A/fDu5+OX5APrqTE5hbxn/C5x5N7nNLC3++rqlnwMAcZ73M0Ogqb6cMJGz
         GMyuw+u1nqhBeCUlEuHlgRawee56pt6l+AENW7GrXceVRhBewt1BcMsoUOIe/nB0f/uV
         GATw9fCIu5totaCSvNInRK6JOXOyqhPj7Q1FL4ZWXFqVRUD7RZxCt6usoYEWtuhxFuVC
         7F7A==
X-Gm-Message-State: AOAM532Y4RghmwPDnV24tyPUIHLKcBaRyw69fMqe5N1+YfEGpY3rsETO
        T6t/g9G8XFFQ8vcsgddz9Zpe02PDv5Y=
X-Google-Smtp-Source: ABdhPJwcp1KiPxegia0Y7JYvV9kaPCj1e5qD1uO6/BUPm79pbtxCR2NUJxnMNO9b3KYzZzZvZw3CLg==
X-Received: by 2002:a1c:5987:: with SMTP id n129mr5999760wmb.60.1591140780694;
        Tue, 02 Jun 2020 16:33:00 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l18sm418067wmj.22.2020.06.02.16.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 16:33:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] drivers: clk: qcom: Add msm8992 GCC driver
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200531174612.260113-1-konradybcio@gmail.com>
 <20200531174612.260113-2-konradybcio@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <7e618280-ecb8-cf1a-5243-737e56278662@linaro.org>
Date:   Wed, 3 Jun 2020 00:33:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200531174612.260113-2-konradybcio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2020 18:46, Konrad Dybcio wrote:

> +static struct clk_fixed_factor xo = {
> +	.mult = 1,
> +	.div = 1,
> +	.hw.init = &(struct clk_init_data)
> +	{
> +		.name = "xo",
> +		.parent_names = (const char *[]) { "xo_board" },
> +		.num_parents = 1,
> +		.ops = &clk_fixed_factor_ops,
> +	},
> +};

I think you can drop that, and use the DTS definition.

xo_board: xo_board {
     compatible = "fixed-clock";
     #clock-cells = <0>;
     clock-frequency = <19200000>;
};

sleep_clk: sleep_clk {
     compatible = "fixed-clock";
     #clock-cells = <0>;
     clock-frequency = <32768>;
};

clock_gcc: clock-controller@fc400000 {
     compatible = "qcom,gcc-msm8994";
     #clock-cells = <1>;
     #reset-cells = <1>;
     #power-domain-cells = <1>;
     reg = <0xfc400000 0x2000>;

+    clock-names = "xo",
+                  "sleep_clk";
+    clocks = <&xo_board>,
+             <&sleep_clk>;

};


> +static int gcc_msm8992_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk *clk;
> +
> +	clk = devm_clk_register(dev, &xo.hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

You should drop this too.


> +MODULE_ALIAS("platform:gcc-msm8992");

and that.

---
bod

