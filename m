Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E2C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BE8206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rLucE9/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgC3WLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:11:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39013 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgC3WLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:11:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so23591752wrt.6;
        Mon, 30 Mar 2020 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VkoQedczWLBus6tX3n5y4wQRH1ftctG/cF/BNNp5TE=;
        b=rLucE9/RYbxcQsiwyj8s+DMFOnyqScGjogDDQTt/ysPfoWFsvldH4Eb5BFVYuF1K3Y
         Nb0YBeTl4mWGVBP84wku6pbJvTZvSP/br/lx95SLIIWji2b83He3DMHuRnNgM3tmVQgj
         gQBj9BhZyYl9DONJppZ/Cqa71rjlTqM612S3YnpPtokD32kmU7J79ZvVjoHyuuRFZtj0
         c9YVfGzaNMJ0GjNRwAuIsl5RKkfxf4Jc9I42GUpAMvpoDT1RxHhHWb32MdREz/TO2i6s
         i7OJVW5mfJWPrWY3l8xLtUjpDMFMx0q0GV1rzN5I+gztT1PCQ0hPwl1zAG2LfXwX0rG2
         ymZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VkoQedczWLBus6tX3n5y4wQRH1ftctG/cF/BNNp5TE=;
        b=OwAHSfOEFQWNOwwHeY23WTan3MjcJcAIlar1kQW5TmGjsHEFVtemVl2hgUtJwz2S5M
         JZlCtHLlkVsaNOjnQCnQhPYJWrTe/7wY+ixESDUlWGQF3pUtXhMCTRCLOsUopNMHQ7Wz
         oIIzXRca6Y4hB/nnarR0VPqGlvmzxrDw2QM6GmkLGjZ3k1xIkkRwdA6aMhD33HcnJMSA
         GyVVz76LLbKpe05S9DrKfuGTm4dJgGFEgqSUMNfrR8xQVjWk+b9mUey/DIZ5K4RlTPOu
         zE2SBx1vfAGWCYrpADUmGJevGLh4GEqbxxtaoavcnqnn+SgO0fydktbbxgBEKjr2wB2n
         B9Ig==
X-Gm-Message-State: ANhLgQ02OU2YPmzcrsKELBphFSDXOmOBkZbrY27NEYwmr1DBcRzf+DOJ
        ikWbAkqwL+2e35stHfmxKX40+KiF
X-Google-Smtp-Source: ADFU+vt3Xdhd1l9/VCPq5miOEsLgn0jBbyBbBYz0y9zmPaIrN6jUxlNqvubLbBoVAA2/eXbmEAb3mw==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr16739067wrq.259.1585606288271;
        Mon, 30 Mar 2020 15:11:28 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b187sm1260509wmc.14.2020.03.30.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:11:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 0/5] GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1
Date:   Tue, 31 Mar 2020 00:10:59 +0200
Message-Id: <20200330221104.3163788-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have GPU DVFS support in lima [0] (queued for Linux 5.7)
and panfrost we can make it work on Amlogic SoCs.

The first two patches update the clock drivers to allow runtime
frequency changes of the mali clock tree. This is similar to what I
have implemented for Meson8b/Meson8m2 already.

The remaining three patches add the GPU OPP tables to the .dtsi files.
I decided to remove code duplication for the Mali-450 GPU on GXBB and
GXL so it will be easier to maintain this. This refactoring is part of
patch #3. Patches #4 (GXM) and #5 (G12A, G12B, SM1) are straight
forward; it replaces the hardcoded clock settings with the the GPU OPP
table.

I used the userspace devfreq governor to cycle through all available
GPU frequency settings on GXL, GXM and G12A (which covers all relevant
GPU driver and clock driver combinations). I have taken the GPU OPP
tables from Amlogic's 4.9 vendor kernel and the voltage settings
(opp-microvolt property) from the public dataseheets for all SoCs.


[0] https://cgit.freedesktop.org/drm-misc/commit/?id=1996970773a323533e1cc1b6b97f00a95d675f32


Martin Blumenstingl (5):
  clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
  clk: meson: g12a: Prepare the GPU clock tree to change at runtime
  arm64: dts: amlogic: meson-gx: add the Mali-450 OPP table and use DVFS
  arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
  arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 49 ++++++++++-----
 .../boot/dts/amlogic/meson-gx-mali450.dtsi    | 61 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 51 ++++------------
 .../boot/dts/amlogic/meson-gxl-mali.dtsi      | 46 +++-----------
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 45 +++++++++-----
 drivers/clk/meson/g12a.c                      | 30 ++++++---
 drivers/clk/meson/gxbb.c                      | 40 ++++++------
 7 files changed, 189 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-mali450.dtsi

-- 
2.26.0

