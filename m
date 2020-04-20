Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735AC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD6206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOT0X9ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDTQhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbgDTQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:37:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C652C025491
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:37:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so12974676wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rj3jrSbU2b68oTmKDFbN7ThfXz7DCPKlENH6dIentbg=;
        b=qOT0X9riAMzmEP5Ha7488hZVekV30Pk1csqcVzplu+ZIg38c2b8tJvtqrQxgpOYkB9
         gX3MxO54dkj2kFQFhE5lK6hQo7mTnazAsr/J9Mos46z019jWW0wXkiX4mXVo7Slw+LmM
         v5tq74Of3prsSVSua+OY6XUstDoUqWTCf0/NpP7ovNedfz5TSTxz9xs1B4lJkC9hP74b
         YBH+u7CaAba8aqdOIlMvsOdBz5fvPCDxaisMIDG148fRwFWGWsEtfhVUIWBUGapQLE7h
         bOZo0wZ/o5qKajlkAxKhsO8NZxFKfxwBbEQ6JKkH71oNt5TtD6msKqc81wIjQ6P9pA/e
         A2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rj3jrSbU2b68oTmKDFbN7ThfXz7DCPKlENH6dIentbg=;
        b=Vkol3/RolP+ElhsSvJr5rwykLBNGkf9JciMf4b3cvgOWG7v4ZD5e7iEiKRNLHo2XZT
         4uZq0v/ZlKrQGE+J4icD8IH/AxIn/alfDhvl62Rp6G6GCbdjmzvBzMx2e+METM0pp3W3
         XqTAUcSdr+fny/0UTYIsVKHUD04qKE3WYfNS1RVbnWrbtKI6HWslczRcPbSzHFfZh4Ua
         fTrbdVyrEYRtLLLOuv5KsbuTHg1NvLL6sWSN2QU6agD8dtoygPLW4n2ToKtg+2G54iEF
         0yTF8B8j3g8JImWXJOrZ+fSAoV3A/DsqBS56ua+201psNpQlr2Hdrr6SkXYB7lMHFESj
         gm/w==
X-Gm-Message-State: AGi0PuZ/T7qs+Lunc+UM2X6H1opa9MVFR5yJrjiXB6pLpje2BMXN4W71
        iJe7CXQUFlSL2blGlvCIZleqZw==
X-Google-Smtp-Source: APiQypKAH6kAxnN7z1zkH/+viWwXnCewnUDNHJ9TNYyq8qYdBhojhij+2K2UR3NYJ6w9XnjttNtugg==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr21467911wrn.56.1587400666708;
        Mon, 20 Apr 2020 09:37:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s8sm42510wru.38.2020.04.20.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:37:46 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:37:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH V5 4/4] backlight: qcom-wled: Add support for WLED5
 peripheral that is present on PM8150L PMICs
Message-ID: <20200420163744.3qbeqwv7myzmam3d@holly.lan>
References: <1586274430-28402-1-git-send-email-kgunda@codeaurora.org>
 <1586274430-28402-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586274430-28402-5-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:17:10PM +0530, Kiran Gunda wrote:
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> PM8150L WLED supports the following:
>     - Two modulators and each sink can use any of the modulator
>     - Multiple CABC selection options from which one can be selected/enabled
>     - Multiple brightness width selection (12 bits to 15 bits)
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 443 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 442 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a6ddaa9..3a57011 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> ...
> +static const u8 wled5_brightness_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_BRIGHTNESS_LSB,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_BRIGHTNESS_LSB,
> +};
> +
> +static const u8 wled5_src_sel_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_SRC_SEL,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_SRC_SEL,
> +};
> +
> +static const u8 wled5_brt_wid_sel_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_BRIGHTNESS_WIDTH_SEL,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_BRIGHTNESS_WIDTH_SEL,
> +};
> +

Each of these lookup tables are used exactly once... and half the time
when this code chooses between MOD_A and MOD_B a ternary is used and
half the time these lookup tables.

I suggest these be removed.


>  static int wled3_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, i;
> @@ -225,6 +291,25 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  	return 0;
>  }
>  
> +static int wled5_set_brightness(struct wled *wled, u16 brightness)
> +{
> +	int rc, offset;
> +	u16 low_limit = wled->max_brightness * 1 / 1000;

Multiplying by 1 is redundant.


> +	u8 v[2];
> +
> +	/* WLED5's lower limit is 0.1% */
> +	if (brightness < low_limit)
> +		brightness = low_limit;
> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & 0x7f;
> +
> +	offset = wled5_brightness_reg[wled->cfg.mod_sel];
> +	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
> +			       v, 2);
> +	return rc;
> +}
> +
>  static void wled_ovp_work(struct work_struct *work)
>  {
>  	struct wled *wled = container_of(work,
> @@ -317,11 +420,67 @@ static int wled4_ovp_fault_status(struct wled *wled, bool *fault_set)
>  	return rc;
>  }
>  
> +static int wled5_ovp_fault_status(struct wled *wled, bool *fault_set)
> +{
> +	int rc;
> +	u32 int_rt_sts, fault_sts;
> +
> +	*fault_set = false;
> +	rc = regmap_read(wled->regmap,
> +			wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS,
> +			&int_rt_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Failed to read INT_RT_STS rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = regmap_read(wled->regmap,
> +			wled->ctrl_addr + WLED3_CTRL_REG_FAULT_STATUS,
> +			&fault_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Failed to read FAULT_STATUS rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (int_rt_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
> +		*fault_set = true;
> +
> +	if (fault_sts & (WLED3_CTRL_REG_OVP_FAULT_BIT |
> +			       WLED5_CTRL_REG_OVP_PRE_ALARM_BIT))

Correct me if I'm wrong but isn't the only difference between the WLED4
and WLED5 code that the wled5 code also checks the
WLED5_CTRL_REG_OVP_PRE_ALARM_BIT ?

If so why do we need to pull out (and duplicate) this code code using
the function pointers?

> +		*fault_set = true;
> +
> +	if (*fault_set)
> +		dev_dbg(wled->dev, "WLED OVP fault detected, int_rt_sts=0x%x fault_sts=0x%x\n",
> +			int_rt_sts, fault_sts);
> +
> +	return rc;
> +}
> +
> @@ -615,6 +797,7 @@ static void wled_auto_string_detection(struct wled *wled)
>  
>  #define WLED_AUTO_DETECT_OVP_COUNT		5
>  #define WLED_AUTO_DETECT_CNT_DLY_US		USEC_PER_SEC
> +

Nit picking but this additional line is in the wrong patch ;-)


>  static bool wled4_auto_detection_required(struct wled *wled)
>  {
>  	s64 elapsed_time_us;
> @@ -648,6 +831,46 @@ static bool wled4_auto_detection_required(struct wled *wled)
>  	return false;
>  }
>  
> +static bool wled5_auto_detection_required(struct wled *wled)
> +{
> +	s64 elapsed_time_us;
> +
> +	if (!wled->cfg.auto_detection_enabled)
> +		return false;
> +
> +	/*
> +	 * Check if the OVP fault was an occasional one
> +	 * or if it's firing continuously, the latter qualifies
> +	 * for an auto-detection check.
> +	 */
> +	if (!wled->auto_detection_ovp_count) {
> +		wled->start_ovp_fault_time = ktime_get();
> +		wled->auto_detection_ovp_count++;
> +	} else {
> +		/*
> +		 * WLED5 has OVP fault density interrupt configuration i.e. to
> +		 * count the number of OVP alarms for a certain duration before
> +		 * triggering OVP fault interrupt. By default, number of OVP
> +		 * fault events counted before an interrupt is fired is 32 and
> +		 * the time interval is 12 ms. If we see more than one OVP fault
> +		 * interrupt, then that should qualify for a real OVP fault
> +		 * condition to run auto calibration algorithm.
> +		 */

Given the above why do we have a software mechanism to wait until the
second time the interrupt fires? I'm a bit rusty on this driver but
wasn't there already some mechanism to slightly delay turning on the
fault detection?


Daniel.
