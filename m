Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97573C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7631D206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IfncSmSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGUIuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:50:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:50:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so2044305wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=OOIK19iEIQb8iLI8NiFFRQO03KIxqOtMui3x9Ea/uFU=;
        b=IfncSmSRKyoe03aLW/O3/cHMCD+6dX2gbOWcsWC4NWYkfk5936OP1NnRhuTxmFkGQ5
         ftAcILzlhO8C/cnPjq8B2NH5unXuz3jppCJD+8yqJc0pYP+2BzzGBPTv+f3DNtJmC+Bi
         Lt9zw8Hu4M+fUi/jpHAVE/qc/aFv5fiOSD8tfzB5jBoQzgY9vjS6oqxarekX3k/5BLOs
         +GqRwvB9d6mtVgGqrmxDMNwbaPaMgjSo1C8boYlQ1Gx6zL3/3Jt0oEwgGp9YNpn8zDm2
         0AynyTQasTOY1AAHNGsZjfQ/Y4hgPHVEyYW8hVVupTldFVokrKPM9aAkXBUGBYBL9Y/Y
         oaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=OOIK19iEIQb8iLI8NiFFRQO03KIxqOtMui3x9Ea/uFU=;
        b=bD/+swJyGMHVWVaZ5tGbg4o3GVk+ooCFWb+KOy0OWypLj75QaeRMqoA+eHBMfdWAI6
         gdMN4DsFHMDq6k7ASRxoYVYyhMwhQlH2wBf5JnQqbQ/B3duUvW4AeFh1W05t+6pTyVaP
         5fZ+TDTMMAFVkIf0dmN99EBCd+feaj/1PzYV6ozpOWmRZM+cb0Ty+gVIQOrO4SWcLlOU
         877x5F2zBdsRx/kFWua9Xr7VtjrG2g943h5GRCnvdUKKq6MB0p1sFmE4Uj3EOgDdOAnH
         vUfLuCv5S4QfluxlBhwTeWVuZ9hbfbXBrn51Y7OOmb96kKMNsegzprvNMgpCPQH5Y+6/
         YPpw==
X-Gm-Message-State: AOAM531WLzcTac+okQ29VF5xGReee3U0Q/bsqP3J0UBBBppGNxkzCFv7
        U4uSSOpUPKPTKCvhxU4CnFSp9g==
X-Google-Smtp-Source: ABdhPJwLk5enCMhq80NTtQvAvtSfv/4KmTEVW6gahsKEe44MxFF7XlPA8Fg5iPiiTmh4PJlAE/0rDg==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr2969980wmf.140.1595321400727;
        Tue, 21 Jul 2020 01:50:00 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 1sm2466296wmf.21.2020.07.21.01.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:49:59 -0700 (PDT)
References: <20200718050056.1713-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the WeTek Core 2
In-reply-to: <20200718050056.1713-1-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:49:59 +0200
Message-ID: <1jr1t58d6w.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 07:00, Christian Hewitt <christianshewitt@gmail.com> wrote:

> The WeTek Core 2 is a commercial Android device based on the Amlogic Q200
> reference design using the S912-H chipset. Specs:

This series is missing a cover-letter. Please add a cover letter when
sending more that one patch

>
> 3GB DDR3 RAM
> 32GB eMMC storage
> 10/100 Ethernet using Realtek RTL8152 (internal USB)
> 802.11 a/b/g/n/ac + BT 4.1 sdio wireless module (AP6356S)
> 2x single colour LEDs to indicate power
> 1x power button
> 1x reset button on the underside of the box
> HDMI 2.0 (4k@60p) video
> Composite video + 2-channel audio output on 3.5mm jack
> S/PDIF audio output
> 2x USB 2.0 ports
> 1x USB OTG port (internal)
> 1x micro SD card slot
> UART pins (internal)
> IR Sensor
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 378229fa8310..5eba9f48823e 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -121,6 +121,7 @@ properties:
>                - libretech,aml-s912-pc
>                - nexbox,a1
>                - tronsmart,vega-s96
> +              - wetek,core2
>            - const: amlogic,s912
>            - const: amlogic,meson-gxm

