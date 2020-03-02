Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB782173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mSdaRQNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCBRSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:18:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39781 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgCBRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:18:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so718695wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=SXg4ANPPHujnOtlOtYMneAF3xY1y0Qzs6lLnP3dZ2Eo=;
        b=mSdaRQNlY7mufhxefFHO9E0HmiRuJqcR5IkePx8zpUI992xFIFgiMiz4Gi5sNj3NEI
         hd9N2W+4Dsx6v7z2hXGn5kxId0G3btlLTgkiwpAyx9BHnkcH7DNgJkFwd9JeQ/SLXftl
         +9HmX3flc+V509SOfMf1CeDGcImsWgpc1FtEXVRF59szYLbOFJ8Ac3vjMAclYY3eVBO0
         VkaksqS/ZaI/Hkm6f1oXy+NUAJUmm7teNAIJtZaVhrPE/dpzQP5pX6HxaqApu+UnpgrR
         m30yCONditdo/eeyfb0vTsI+hldY5qSWaLg8a86atbEOC1iqlmuPytX8k26Sb8Z2TLdZ
         ZtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SXg4ANPPHujnOtlOtYMneAF3xY1y0Qzs6lLnP3dZ2Eo=;
        b=pn8+Ag+qKhOqOunYHh4nUp9PYAVrrfjTIHGOv6oXFrREpI6Fm+jfggHuka6H9SVMXZ
         LNKU4yIwUs6nrlbI/2P6q6HdK/AmE+5gi7G29hSVboSpY/aj7mKX6QfDJ0r+oFPENLJJ
         2o/br07i/J4Rh5epBUED5UkCkI28ByptkuUIfSUynfQAYmmK19IV/kyJSrK2rivqTx8u
         cl7aUf602hI6ybCgj6/wa/NiSPthXx3ocpUkOsIhdDLQ3QYV908LiCOYIDIQnkNia2vm
         Il9r8AOmf3k8HiHJ152z5QH6Jsx1/orkD2zB/6+Qia0nffrML8YlcR25eDnKIJX8bZRX
         TKtg==
X-Gm-Message-State: ANhLgQ1vEtn2TAbejGskBxS11b4WE0YM0IJIqsc9pxqGO7RCmK+LxWeV
        rr7NCzrEI2vD4IF0FNMdGaXx0Q==
X-Google-Smtp-Source: ADFU+vsX7sylmYulhpint5DODaeUoRGQLESGv6af+LdEy2T3qLGW2WZccdCEKj2zO/+pPKdQyCoHhQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr652127wrs.166.1583169499293;
        Mon, 02 Mar 2020 09:18:19 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2sm45867wma.39.2020.03.02.09.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 09:18:18 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCHv2 1/2] arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator to FLASH_VDD
In-Reply-To: <20200302125310.742-2-linux.amoon@gmail.com>
References: <20200302125310.742-1-linux.amoon@gmail.com> <20200302125310.742-2-linux.amoon@gmail.com>
Date:   Mon, 02 Mar 2020 18:18:17 +0100
Message-ID: <7hfteqr7za.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Moon <linux.amoon@gmail.com> writes:

> As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
> regulator.

Could you please add a link to the specific schematics you used to find
this usseu?

> Also add TFLASH_VDD_EN signal name to gpio pin.

Your patch does not do this part.

Similarily to the other patch, can you explain in more detail (including
kernel boot logs) how the SD card is not working?

I just tested with latest mainline, and the MMC driver is detecting both
the eMMC and the SD card.

Kevin
