Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054EC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C264420786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="P8Iz+tAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgICXa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgICXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:30:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3529C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 16:30:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n133so4747509qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tER5efoKTXhoRI49DGq6kR5MKl16jgpcrniDIS3TWH4=;
        b=P8Iz+tAMI2G73pmBCBPMKVteWRhgCOG8kZ5NkoW2pKohWNkpkYbaHlAfkCEVU1i2gN
         EpI9213e0JXvYg81is2Tf8AXYcM5zB3+GMa1m+VTd8CuWnjRbRYk4Q1LOkFOU6eJVT3F
         /gNZAcSmaqEmyH3DGWNvEQ7BNp0BWGhL6UFdvjy5Da5osKR6IDu1kVuECdiG88Mk8uqZ
         5ta4+ky/SkoRH0zQKDx6eLfToQTXUvKv7Gn/VAxX4qV8d1MEelj9BKISJfLvW3wlcz2Q
         gkknVBseAEIHH6qhcjO/fzbJpauwUvoeJrpSX50rQ108IuSpBKsJsZo5bVeHf9De5Kp/
         n+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tER5efoKTXhoRI49DGq6kR5MKl16jgpcrniDIS3TWH4=;
        b=gp0idytBn0h6OnN3R0gChtbIaA0p0VS6iWdbGwuCIDyC6HlqUF6Pt4gUj85vps8jLX
         KKWM7BaJ13qaYJCgZ9aCCKBFRo+Ap6/wIjirNKLPNlZHRui6fqm7oTeVvoQEBKvprx7X
         PiNmdc9LLhYh/X1T62lwVqEkYShNbo/Fj3r/qXfLRCk+kfTUmO/mLTf6FUsTjgM0fGMS
         141nWMlar06HTnp3pzFHc48ZapmkBo6LEd7PP1HrWplQpTuyPJY54ixt+JSgTMH4hkmR
         4LUcYrMPON64oanDUvz53xByv0I4O9phpk1Mg3AGJ7JHBIn8SqGhkk02YWwH/LtW1Qd9
         L+NA==
X-Gm-Message-State: AOAM532F4Q7u6gVpW4HVqK2Qy7zzKic7264HD22CH5Z2HINbvkygRpDe
        MKebTQGWBVyl6zMxbaCmIzbzWQ==
X-Google-Smtp-Source: ABdhPJzGeyHICZQjuWnQYHvAm4kf2dcs+Bx6pEomtDyhHgZ0jZPH7Hh0NrALaByHL5XLSyHLvrHSsw==
X-Received: by 2002:a37:c404:: with SMTP id d4mr5392815qki.273.1599175827627;
        Thu, 03 Sep 2020 16:30:27 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m26sm3209338qtc.83.2020.09.03.16.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 16:30:27 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] phy: qcom-qmp: Add support for sc7180 DP phy
To:     Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
 <20200902230215.3452712-9-swboyd@chromium.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <c53059ac-dd88-f8fb-5473-ebc6f70f00d4@marek.ca>
Date:   Thu, 3 Sep 2020 19:29:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200902230215.3452712-9-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 7:02 PM, Stephen Boyd wrote:

...

> +static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
> +	.type			= PHY_TYPE_DP,
> +	.nlanes			= 1,
> +
> +	.serdes_tbl		= qmp_v3_dp_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_dp_serdes_tbl),
> +	.tx_tbl			= qmp_v3_dp_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_dp_tx_tbl),
> +
> +	.serdes_tbl_rbr		= qmp_v3_dp_serdes_tbl_rbr,
> +	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_rbr),
> +	.serdes_tbl_hbr		= qmp_v3_dp_serdes_tbl_hbr,
> +	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr),
> +	.serdes_tbl_hbr2	= qmp_v3_dp_serdes_tbl_hbr2,
> +	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr2),
> +	.serdes_tbl_hbr3	= qmp_v3_dp_serdes_tbl_hbr3,
> +	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v3_dp_serdes_tbl_hbr3),
> +
> +	.clk_list		= qmp_v3_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
> +	.reset_list		= sc7180_usb3phy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),

You need a ".regs = qmp_v3_usb3phy_regs_layout," here, otherwise phy 
init functions like qcom_qmp_phy_serdes_init() can crash on a NULL 
reference.

> +
> +	.has_phy_dp_com_ctrl	= true,
> +	.is_dual_lane_phy	= true,
> +};
> +

...
