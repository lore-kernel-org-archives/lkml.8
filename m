Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC152C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877252087E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UyQbo7MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502569AbgDNNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502552AbgDNNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:05:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:05:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a25so14256876wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hXwIQYgoQP2Wup93C1/59d2xx2g3UUkrum6b3g6XEYk=;
        b=UyQbo7MJKG1NihktiWx4FwRnJw5Y/jhDfqPKDzBCTAnc3WqjnfQ/r8MXmIK4H2tTcc
         p/suue+ZEK+pVaNOs6LS+XEDherVb2ELvDV3m+CCOdnmZ7LUmlSkF83KfwIE0byLOtbw
         iHvrkfYP+0z/V/MbtwnwT1czz90p5UT2RrjBNhc6GjdHa7Af859SsPQAzcnFmpM/zkCG
         ongBPvM7Zj3IMiwBjBcpWjBJewL221NaOWh7Y1Y4IFBXdjQAQ1SRqHVMiSf4LwkETeiv
         lsHf4UojuwH3EeQvz64OlDVcDd2O8e8O0UvizYkWaPpibK0sDuMefLzpyhTJC5+5qfRr
         p1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hXwIQYgoQP2Wup93C1/59d2xx2g3UUkrum6b3g6XEYk=;
        b=KVTm/wNw7MB4rgavdJm4g+JNHqlqA1S+E0xwpj391CiRrynya/UU+aaelbI2xyTN/1
         Tcmkql/DY/jxev/v0AAX8ratYnY2Z2YpHKrdCIaVAJUNQaLSrWQ/CCBBnsA2jCKzPU9+
         ZudUy0c0yig3daWkeVSNy4YBbd2IOmaodWGVJtcyyiJet0OtbF/aRaLc267JOgx5COu9
         JcTi/8NROd2MRMitQOf+p3RqUb+BCblQghuc7PBh3EU6Bw+/YhFeP01HjSCwOXgZbtdl
         R8LT3DRQtsoLYdE1IXI/O/2/E4ajSw1gbXHKwo7qGGlvMdewwi4K0RMhWqx0mFiqCx+L
         jH8A==
X-Gm-Message-State: AGi0PuZRHz/DAWWjz/FcN2+HXr3oCjG02VKC+VASdWXeeHBTFgNzSOFV
        8Kce9vOVZ81NI9DwKckguA0/sA==
X-Google-Smtp-Source: APiQypLVat6kUor59eAwhpTgIo0JZwEUdzMv6AqD1oJjYDhA/1hYzmlEALMZYP/w2KFVxCghsnhsSw==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr22627237wrb.233.1586869526464;
        Tue, 14 Apr 2020 06:05:26 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k3sm9397220wru.90.2020.04.14.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:05:23 -0700 (PDT)
References: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v1 0/5] GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1
In-reply-to: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 14 Apr 2020 15:05:22 +0200
Message-ID: <1jftd6tdyl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 31 Mar 2020 at 00:10, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

>
> [0] https://cgit.freedesktop.org/drm-misc/commit/?id=1996970773a323533e1cc1b6b97f00a95d675f32
>
>
> Martin Blumenstingl (5):
>   clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
>   clk: meson: g12a: Prepare the GPU clock tree to change at runtime
>   arm64: dts: amlogic: meson-gx: add the Mali-450 OPP table and use DVFS
>   arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
>   arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS
>
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 49 ++++++++++-----
>  .../boot/dts/amlogic/meson-gx-mali450.dtsi    | 61 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 51 ++++------------
>  .../boot/dts/amlogic/meson-gxl-mali.dtsi      | 46 +++-----------
>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 45 +++++++++-----
>  drivers/clk/meson/g12a.c                      | 30 ++++++---
>  drivers/clk/meson/gxbb.c                      | 40 ++++++------
>  7 files changed, 189 insertions(+), 133 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-mali450.dtsi

Clock part looks good to me and aligns with meson8.
Please resend the clock part without the RFC tag
