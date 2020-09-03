Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBB1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3DC2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Ck0KrP8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgICUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:43:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC15C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:43:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so2992034qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eYv0gbDpx47eQ5/qXtuRplSM/G2L1Krze2Is6VCmRm8=;
        b=Ck0KrP8L6SDHEcNpSrjN5mMhsbJsQNRkf1uukumEmBzfNRWvInrpOSZrGbW9x97lid
         yCQ/ujU3eqFXU+nJQa8a+3uWuUaMG1barputIlu3E3TTQ9M8CIzmHM6Z8mNsWP8gKPof
         QzMRxF5W6UEcs9iBDZG88sAB1VTmNDFwhkil/p3jKkRlhLn2eobUSSFCXaKoJgi6BJ5t
         /yTw8yyifVYwfkOrOiYSH867sthl4d00ceomhIBmFTr85rbRs74f9HB0yTt/1CC0s+yy
         eORe33chTcY/0hjP2YPrP0tvHNitIZk9Wy5k9CzFt/fLV309Ex0Afe/jIvJVcxentLY3
         9awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYv0gbDpx47eQ5/qXtuRplSM/G2L1Krze2Is6VCmRm8=;
        b=TjOG5PC2ZwpRCaIOXL9M92rfj7bW+wObtfgdsJpKTp7mV9RajqaEWlFVrSB9agRRy0
         6Ota3fwxS/X9aMPCSYNAmRBsN8LWjoAf8rLULuJhi++T9zRljneyLjdt+ANB4Mab7kvE
         2wZbCMTQgJOZSdSiLOFrRDyC8/ZW29J4pH+Ht1AtnkVVvxuqts29i5IwcL3ZYjh1XDa+
         uHlQGWsJn0bbvsUPsH+xNYaY6yqubW3cMLGzsoc1NfXI0TQV5AUJh+AxNGZkha8l+1rZ
         khxUOJ+J/0eeYnHwx0aOXEEk4X1XT0PVb4sWTwULYnCcRa08+HI+ZZHLpJnHbl1Ri/BJ
         Tzvw==
X-Gm-Message-State: AOAM533QPQ1D3TVFKLTJ2gyBflQ2lRuSoHgJwXsHjdkEv3PgnB8NGRYR
        XwAGGcstBVEoXDwqVBkasUhDLw==
X-Google-Smtp-Source: ABdhPJzeG1PuO6XlkbEPv7d/MdMOKoSKHaL+/NNzyAAAfZnfY3HXdFpRJ6xnMZcaQWn7420qYEOwWw==
X-Received: by 2002:ac8:c47:: with SMTP id l7mr5593873qti.112.1599165834877;
        Thu, 03 Sep 2020 13:43:54 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id j1sm1637007qtk.91.2020.09.03.13.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 13:43:54 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] phy: qcom-qmp: Add support for DP in USB3+DP
 combo phy
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
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
 <20200902230215.3452712-8-swboyd@chromium.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <b6f80242-482d-b778-690b-8aefa4e8f23e@marek.ca>
Date:   Thu, 3 Sep 2020 16:43:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200902230215.3452712-8-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 7:02 PM, Stephen Boyd wrote:
> Add support for the USB3 + DisplayPort (DP) "combo" phy to the qmp phy
> driver. We already have support for the USB3 part of the combo phy, so
> most additions are for the DP phy.
> 
> Split up the qcom_qmp_phy{enable,disable}() functions into the phy init,
> power on, power off, and exit functions that the common phy framework
> expects so that the DP phy can add even more phy ops like
> phy_calibrate() and phy_configure(). This allows us to initialize the DP
> PHY and configure the AUX channel before powering on the PHY at the link
> rate that was negotiated during link training.
> 
> The general design is as follows:
> 
>    1) DP controller calls phy_init() to initialize the PHY and configure
>    the dp_com register region.
> 
>    2) DP controller calls phy_configure() to tune the link rate and
>    voltage swing and pre-emphasis settings.
> 
>    3) DP controller calls phy_power_on() to enable the PLL and power on
>    the phy.
> 
>    4) DP controller calls phy_configure() again to tune the voltage swing
>    and pre-emphasis settings determind during link training.
> 
>    5) DP controller calls phy_calibrate() some number of times to change
>    the aux settings if the aux channel times out during link training.
> 
>    6) DP controller calls phy_power_off() if the link rate is to be
>    changed and goes back to step 2 to try again at a different link rate.
> 
>    5) DP controller calls phy_power_off() and then phy_exit() to power
>    down the PHY when it is done.
> 
> The DP PHY contains a PLL that is different from the one used for the
> USB3 PHY. Instead of a pipe clk there is a link clk and a pixel clk
> output from the DP PLL after going through various dividers. Introduce
> clk ops for these two clks that just tell the child clks what the
> frequency of the pixel and link are. When the phy link rate is
> configured we call clk_set_rate() to update the child clks in the
> display clk controller on what rate is in use. The clk frequencies
> always differ based on the link rate (i.e. 1.6Gb/s 2.7Gb/s, 5.4Gb/s, or
> 8.1Gb/s corresponding to various transmission modes like HBR1, HBR2 or
> HBR3) so we simply store the link rate and use that to calculate the clk
> frequencies.
> 
> The PLL enable sequence is a little different from other QMP phy PLLs so
> we power on the PLL in qcom_qmp_phy_configure_dp_phy() that gets called
> from phy_power_on(). This should probably be split out better so that
> each phy has a way to run the final PLL/PHY enable sequence.
> 
> This code is based on a submission of this phy and PLL in the drm
> subsystem.

I updated my upstream-based sm8150/sm8250 displayport stack [1] to use 
these patches.

This commit [2] might interest you, so that you can consider what needs 
to change between v3 and v4 PHYs. Note some of the V4 registers have the 
same address as V3, so the diff could be smaller.

Do you have any plan for dealing with the SS PHY and DP PHY conflicting 
with each other? For example, PHY_MODE_CTRL needs to be "DP_MODE" for 
4-lane DP, "DP_MODE | USB3_MODE" for 2-lane DP + USB3, and (AFAIK) 
"USB3_MODE" for superspeedplus usb (and it seems this gates some clocks, 
so you can't read/write dp tx2 registers in 2-lane DP mode for example). 
 From your cover letter it sounds like this isn't relevant to your 
hardware, but it looks like both PHYs are writing to the dp_com region 
which is still problematic. (in the branch I linked, I disabled the SS 
PHY to test the DP PHY)

Also some issues I noticed:
- used QSERDES_COM_RESETSM_CNTRL instead of 
QSERDES_V3_COM_RESETSM_CNTRL2, which has different value
- in sc7180_dpphy_cfg, .regs is NULL, which results in NULL references

[1] https://github.com/flto/linux/commits/sm8x50-hdk-display
[2] 
https://github.com/flto/linux/commit/ccf56912bd5e652b4daebec1300961a9d51342b1
