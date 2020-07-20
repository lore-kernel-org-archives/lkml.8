Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E21DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC803206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rCeOpitt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgGTWYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgGTWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5853C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:24:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so19354927wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=h/iiGE/hMDHwo1jMRtAjhSPPyBiqm3USAufgg0bvzlA=;
        b=rCeOpittQdYPYWCf6wlX+oHYRzPRTkTJhX1U6fWNKWkX4ANROneKyoy68EKrZIn4jX
         blMBSkuOmxef6fQhYQ99Kwrb9HSLILNxN7kI7N2nG90ibGgKs+ktVc2JhLCXhIsIIAyf
         ZuQE8JLHWZDvwfyuT279I6XGAqA5WbsXz62oxHHh0w3ntl9yCsmh5e/0Px4tNC6NLXx+
         4cvCgN/SDSR3x2o9NkttFcwYRmb9+P13kMSs7kjRIrfSuimk5+63ag7kvvfvizvAMmFF
         2VcVuEqgaGUt3wmrc6PxD0KaeABfdaamdDw+/oeu30je2546HZKLysQFjyaLrD7rhI+j
         ORvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h/iiGE/hMDHwo1jMRtAjhSPPyBiqm3USAufgg0bvzlA=;
        b=tJ/Cf2ySNnpyuYo+K3ljK1GFYvyiwN1w2Y5kfczAMzfHsY2wQ9y6ya0Gwovub2UiCg
         o40AsCUNN5R8cH8VTuI8cqx9oxmftoUvrW/Kp5DFqiSwA28QULvMH0Zdz/AMMzKG+wTA
         kzNXZ+tycc4fI/C9hgDjW5pYAcahjMvRs4fYbSshQVPDkzLIALsU/PLKdpOXZeaTf6BH
         7cZE6e+vUz7qcmCKwvt1Agmz196Wd2YD54F5YX1Kqnko0q8D5dm905gS9D9RzFQAPiNM
         FIh1Sv9IpCUeaNLDvjIOmkbWt4YJ5L9iTEFIEhGfGW5OVkTkn1sMQWPJLfehNXywjMLV
         Af0g==
X-Gm-Message-State: AOAM532419XeisNJXjz+pkCo8VtElUhCRHVws0JwUX0re3o5NJGqUYVM
        qVuExAxc5QQu28goXHNa0He8uA==
X-Google-Smtp-Source: ABdhPJxOqcn9joaabrwtIlsBoWejqjHNRkfkhbpEwfhZXef4rnzEUWmKjXGUKtqWnxuyo80g7c7+Nw==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr2034828wru.222.1595283845126;
        Mon, 20 Jul 2020 15:24:05 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c194sm1129294wme.8.2020.07.20.15.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:24:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: misc fixups for w400 dtsi
In-Reply-To: <20200718052950.3707-1-christianshewitt@gmail.com>
References: <20200718052950.3707-1-christianshewitt@gmail.com>
Date:   Mon, 20 Jul 2020 15:24:01 -0700
Message-ID: <7hd04pakqm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Current devices using the W400 dtsi show mmc tuning errors:
>
> [12483.917391] mmc0: tuning execution failed: -5
> [30535.551221] mmc0: tuning execution failed: -5
> [35359.953671] mmc0: tuning execution failed: -5
> [35561.875332] mmc0: tuning execution failed: -5
> [61733.348709] mmc0: tuning execution failed: -5
>
> Removing "sd-uhs-sdr50" from the SDIO node prevents this. We also add
> keep-power-in-suspend to the SDIO node and fix an indentation.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

This could use a Fixes tag so it can be backported to stable

Kevin
