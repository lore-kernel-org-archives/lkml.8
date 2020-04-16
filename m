Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53677C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBAC206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ryq1RWfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506612AbgDPLqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505036AbgDPKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:32:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CABC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:32:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o81so4016787wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9L5k3Ln1Qt7W9TpURaqzpjRy4n7lxiu2UCwSIpKQOFY=;
        b=Ryq1RWfipGTXPSDerCgXOnwVBcBk+SES+dQi/983JsKTieI0hUpxVt0XEnAt5BZtc+
         3j0OPScJqjuBIE/e8RGOCz2qxvAOsR5mXaTJGLhb/2duJk/L3WjLQ/RFj565RNvubZUj
         hrSaYRFzGzIrj5sKgXIknAqEaWAnJEKXWJhEzJV60auxxyKw0K6wI8LTl2AvhZqxAIzs
         uUb+EokUxmU9Z5axhY1kITo29sfTFoPdQv2b6GKfiFiAtbS7xobLEghD53lOPZN2TpEu
         nZmpRVx6DspQ/ffW9RGXXgnbX7+3JVYh3AZBYzIMNW5yjBNXwQzkQJY9vONcYn4HDTT4
         WFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9L5k3Ln1Qt7W9TpURaqzpjRy4n7lxiu2UCwSIpKQOFY=;
        b=g36K4pIluTAOzTaQFBTjVJESch1S+oA173n/c9R3B79tc79aTOzZ4vqf3lt4re+egf
         mYwBtnrCR8BH2x0abHL8NiyApV9v26JYAiZlGb96XbXX7HJH2NjURaYWZ/zh2FXWKyIt
         NrIgP6QQNBWpNw8IVP51xRaUQ1S1GB2f+ZnlMGcuM4fBiOssiKscK9BIEap+Ib2prTn/
         YspyPFVz264ZZBrL+VY4HVMHo7PEpJCmYtesbAajBFFE27+f+PdIAYY2R6P6Gy0FVziu
         VECaO4nJ6iaP7ftlB5CW2Z//P+rearnFq93+wutOB27scOVfoGAluV0H/lSN4H3mm5NR
         vIdw==
X-Gm-Message-State: AGi0PuaxRzafYJwr4IN32YzLB1n93fjumWrofLQvc59AlyDF9GlqNKxX
        s6Ti8Jad8D/gcSeGhZqQdzvCaA==
X-Google-Smtp-Source: APiQypJclY5jrpfvL8yZKMalQnkMXP+jCZNrFkQ3BCEqz3+ltwYSFd7LZVCdQLzaOSzpaZBpIvP+Cw==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr4442183wmi.83.1587033142678;
        Thu, 16 Apr 2020 03:32:22 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id j135sm3021115wmj.46.2020.04.16.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:32:22 -0700 (PDT)
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com> <20200414200017.226136-2-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
In-reply-to: <20200414200017.226136-2-martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 12:32:21 +0200
Message-ID: <1jblnrbu16.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 14 Apr 2020 at 22:00, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Use hdmi_pll_lvds_out as parent of the vid_pll_in_sel clock. It's not
> easy to see that the vendor kernel does the same, but it actually does.
> meson_clk_pll_ops in mainline still cannot fully recalculate all rates
> from the HDMI PLL registers because some register bits (at the time of
> writing it's unknown which bits are used for this) double the HDMI PLL
> output rate (compared to simply considering M, N and FRAC).

Have you considered adding a fixed_factor pre-multiplier, like in the
gxbb driver ?

Seems to be the same thing

>
> Update the vid_pll_in_sel parent so our clock calculation works for
> simple clock settings like the CVBS output (where no rate doubling is
> going on). The PLL ops need to be fixed later on for more complex clock
> settings (all HDMI rates).
>
> Fixes: 6cb57c678bb70 ("clk: meson: meson8b: add the read-only video clock trees")
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 7c55c695cbae..90d284ffc780 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1077,7 +1077,7 @@ static struct clk_regmap meson8b_vid_pll_in_sel = {
>  		 * Meson8m2: vid2_pll
>  		 */
>  		.parent_hws = (const struct clk_hw *[]) {
> -			&meson8b_hdmi_pll_dco.hw
> +			&meson8b_hdmi_pll_lvds_out.hw
>  		},
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,

