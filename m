Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B26C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E212A20B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PqocFj0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgGSRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:37:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w9so1670374ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mR0eGFh9MH9sNZOZh0ch4XwokpANORC/EtJxy7S/4c=;
        b=PqocFj0Jsii8lhfLE+i9nkHhQxwb+4fvkmQpIk+6oQvM4O3P1R6HdSLNpjJ2S0vqmy
         ImMCCRT9lJxe6ZvaVRavb8zChQ48lbv52AN/5xEA7ZeDWl4psh9eNt+ILjvRy4SYfN/P
         VB9+wrEW9dck4RyXBIToou5kroxexoONJE25Esnmj9A+jYpgeZ8kkmp26VUup9m3S1mg
         AodQzZrEgo9hTSYVCYvcPpQdLOZJSiejtxpHpofvHVlSutLrX2TOeJii3XVXweAQboF+
         Xw9K4SgsQH3jVPTqQkCZ2KKW7S9T9z9HHS3GZjbwiG6p14VToyv8ALRjIBIg2cFWHk+O
         +cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mR0eGFh9MH9sNZOZh0ch4XwokpANORC/EtJxy7S/4c=;
        b=DViSwu1EkuNDsRT8Ckpaisa3wWhgHDAf411jHWK0p3tBmQCN2sNbOM/E8NGgKPpXtD
         rw2jp1iA6tZuU2+P2aDS411ufQihTiOP8uHhq/Mvxfl4jDgrV7o8CsfNsdeRvFQlhs+S
         PfM0kD/eHzpdZAzMgQdxnvwHOVOkeKaJ5s/cU8XwYpIcMOuy/ksVmzvyen7JqafNwjZz
         5bCoj9U9P/c0i5PFAEl75+92gC4y+8vKfS4/QuI9oN+PjKUxNkP0OwQovnOchtA36LOJ
         9ucwhe7JUIoSt2SeXeMRsIppuuv8okLGVIpvn24fNHH0bxAVGlBiKd0C2hRWy87slpx6
         v/Jg==
X-Gm-Message-State: AOAM531LashyEW8ClzofcwqZomlJE7dNwQToyYT023q+2xy1K0OtLFGC
        S55wRPtVNj0pH8kw16getpo=
X-Google-Smtp-Source: ABdhPJzdG3bG+QiQ6JAaqQvzVrYAYHyHbzTb+FaypiX/eZFje/aNBPy5qd9VGW+15tq5at4aC546Eg==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr17450701ejb.210.1595180252411;
        Sun, 19 Jul 2020 10:37:32 -0700 (PDT)
Received: from localhost.localdomain (p200300f13716be00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3716:be00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id bc23sm13563208edb.90.2020.07.19.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 10:37:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1
Date:   Sun, 19 Jul 2020 19:32:10 +0200
Message-Id: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have GPU DVFS support in lima [0] (in Linux 5.7) and
panfrost we can make it work on Amlogic SoCs.

I decided to remove code duplication for the Mali-450 GPU on GXBB and
GXL so it will be easier to maintain this. This refactoring is part of
patch #1. Patches #2 (GXM) and #3 (G12A, G12B, SM1) are straight
forward; it replaces the hardcoded clock settings with the the GPU OPP
table.

I used the userspace devfreq governor to cycle through all available
GPU frequency settings on GXL, GXM and G12A (which covers all relevant
GPU driver and clock driver combinations). I have taken the GPU OPP
tables from Amlogic's 4.9 vendor kernel and the voltage settings
(opp-microvolt property) from the public dataseheets for all SoCs.


Changes since v1 at [1]:
- removed the clock patches from this series as they are already
  applied (in Linux 5.8)
- rebased on top of Neil's recent patch "arm64: dts: meson-gxl-s805x:
  reduce initial Mali450 core frequency"
- adapted patch #1 after Neil's GXL S805X patch to keep the 744MHz OPP
  disabled on that package
- added a comment about GP0_PLL (as to why it's needed) to all patch
  descriptions
- removed RFC prefix


[0] https://cgit.freedesktop.org/drm-misc/commit/?id=1996970773a323533e1cc1b6b97f00a95d675f32
[1] https://patchwork.kernel.org/cover/11466399/


Martin Blumenstingl (3):
  arm64: dts: amlogic: meson-gx: add the Mali-450 OPP table and use DVFS
  arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
  arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 49 ++++++++++-----
 .../boot/dts/amlogic/meson-gx-mali450.dtsi    | 61 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 51 ++++------------
 .../boot/dts/amlogic/meson-gxl-mali.dtsi      | 46 +++-----------
 .../boot/dts/amlogic/meson-gxl-s805x.dtsi     | 17 +++---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 45 +++++++++-----
 6 files changed, 153 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-mali450.dtsi

-- 
2.27.0

