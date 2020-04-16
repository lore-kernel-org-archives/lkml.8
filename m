Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ECDC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28C32192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y283zphW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504945AbgDPK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504868AbgDPK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:27:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70497C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:27:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h9so4175617wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ytcr4DNGsM/t7kd6jXgpKOZ/wK7hRn1NK12HxIXMRKE=;
        b=y283zphWTaRIHsqXboEQebyUcsf1x9LJ0OAGOqpxQTdsNtsjus/FsAB4jcOrbwQRmU
         ovPNF7Uil97R6r1wi7otHb+HEG0ZivE/3Mal3+mMpWMpsqPOwJBWmUWk0JsYvYbtgPOz
         xB2hC0AxW7bx/I9t4+kspS3NGqOmYzdltktQ1ic+DzL2O/t8O8tatfU4vxj77lCP1rf6
         STIzdzowht1EWGVfD39Z2Aogi27qNWUcCQ2LIEVA6eJ0YMMEx8XGsgiilp69jV55p5Mz
         MnUmmXnQXYlZXExyVCIqsI8j2WrJ9PcuiniGJdjht0BiqboZC/SX3qGiwcre7vT/LzJe
         rLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ytcr4DNGsM/t7kd6jXgpKOZ/wK7hRn1NK12HxIXMRKE=;
        b=db2yrmGB4m1t5P5Sa8+5ej8O6HrW9GjOscv3v4u1GzMzSHtKawwcQIoyvs007LjAB/
         jqchXnpdvNK0UDHCKYdSQR/cdO08uU2aPXA4nE/93ZE0sdoKUG/oA5MFdikqxMx7+c2d
         YgL8AQhylpCTbye5aWpbFAMau5zwraJiM7otrv7aQr5xO0rySzUtH3W5KObJ84Y4BtDN
         5rchp823g4DPeBH0StPU/WjsDAdcYFKIpUKapsbRhidGaPpnNVrGiembdM8iQxrw0gUt
         unzSXDAdbF3iTmR+8NBQKtLucbHYVjY8UlpmTDSaFnhFOUPMSRppzhuecapegrkIcv2i
         BqlA==
X-Gm-Message-State: AGi0PuaitHT9Ic/9hp5oiLJ+zwwYpBL6LSPrCXGZ+MvpojQmsfMx2mJh
        fWGpQmn30xbwOz5qiIEl4gBWJw==
X-Google-Smtp-Source: APiQypLHefjPm8Xgjdu6ICpgrvUDFrLOqOiQNSaKWVEHJV0E00xqUmBJ6qCW31i21zKvv/bei5YhbA==
X-Received: by 2002:adf:e54c:: with SMTP id z12mr23478210wrm.276.1587032818803;
        Thu, 16 Apr 2020 03:26:58 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h137sm3760755wme.0.2020.04.16.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:26:58 -0700 (PDT)
References: <20200414195031.224021-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: meson: prepare GX and G12 for GPU DVFS
In-reply-to: <20200414195031.224021-1-martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 12:26:56 +0200
Message-ID: <1jd087bua7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 14 Apr 2020 at 21:50, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This contains only the clock driver updates from my other series titled
> "GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1" from [0]
>
>
> Changes since v1 at [0]:
> - update the patch descriptions to indicate that we explicitly don't
>   want CLK_SET_RATE_PARENT on the muxes
> - split into clock driver (this series) and .dts changes (future
>   series, waiting for testing feedback on v1 from [0])
>
>
> [0] https://patchwork.kernel.org/cover/11466399/
>
>
> Martin Blumenstingl (2):
>   clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
>   clk: meson: g12a: Prepare the GPU clock tree to change at runtime
>
>  drivers/clk/meson/g12a.c | 30 ++++++++++++++++++++++--------
>  drivers/clk/meson/gxbb.c | 40 ++++++++++++++++++++++------------------
>  2 files changed, 44 insertions(+), 26 deletions(-)

Applied, Thx
