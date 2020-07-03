Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D364720B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0rihSI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGCRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGCRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD0C061794;
        Fri,  3 Jul 2020 10:05:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so34975207ejc.8;
        Fri, 03 Jul 2020 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuBPpVunJ0tNS4CUGWOLlzJqZ3YUKldK5LCG9zmjIAQ=;
        b=r0rihSI5KUuKo7yEjRhmqvPlQUxh81S9BeaLhBJj7He0m+PBmADWA/YQ85s7llLbJV
         Xj50nanM+KV5xK6IX7ANPTuWgKeNZ2t5PLanH/Nktk9uOQ2in9uK2a/r52lBwaDElaK6
         Joyq9DktciJ7KiK4mxckUolOHEhPiTNyinqaWTMYZudn/40UHK3WErPHuz5AAnpJQ4vf
         RIP5A+uJJS3uYrj4Rv0T4uxQQ/bTm647OnXNA23LZEDgym/EoZY890F40tjK9HCDLGPw
         Rt/pRGZzqKflmYcIPKuhzCgs+qS8GKHMA1wyaFjF+6YdeU9BkdwIKRC7oIALtcRPwdz/
         GERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuBPpVunJ0tNS4CUGWOLlzJqZ3YUKldK5LCG9zmjIAQ=;
        b=OCkb3Wa39jMOAp9VR7pwJ03A7iu6y4MbEoSBTBICx7K698XPBOapSWyr7nqK5qvEU+
         yGdqv3qqasw7pWEoA3toBISMFVS78+l/nimNxTip/OsnFpjvxMKtxSPbMxFWXK1INO32
         mhovDug2Uot3/1o4iIajDRPBovS1YxH7yZNl08SjH5f4dusHyDyroBdiBGKydiyf3T6E
         JYOPbrl1536igY+c6kGT6ee5FpMudmN2k4727m9+QDZb/dG+efQ0n9YWzScywThAyl0D
         mAfkfinn2Tj69mfQTRQBkV4dPxSnX4PpVsCG1ET3D8YkHceldklibAjzqWA+d7VtfW2p
         AXUQ==
X-Gm-Message-State: AOAM531tsOUed+69XB9QcVtsiPgdfSHvncVuTqGL9I6q5TPmBC0JdsNC
        Zdoh27b0544vnGyH/ArVW9E=
X-Google-Smtp-Source: ABdhPJwp5W/Yeq1alxZu1RLmUQIVu27SvndMVqvf+PFt6UV4W51xfcVujxtkrCIVEaUU+wrjOdfoAQ==
X-Received: by 2002:a17:906:314c:: with SMTP id e12mr30506048eje.500.1593795915167;
        Fri, 03 Jul 2020 10:05:15 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:14 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 0/6] Add RMU and DMAC/GPIO clock support for Actions Semi S500 SoCs
Date:   Fri,  3 Jul 2020 20:05:06 +0300
Message-Id: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a stripped-down revision of the initial series
"[PATCH 00/11] Add CMU/RMU/DMA support for Actions Semi S500 SoCs":
https://lore.kernel.org/lkml/cover.1592407030.git.cristian.ciocaltea@gmail.com/

At Stephen's request, I detached all DTS related work to keep the focus
exclusively on the Actions S500 SoC clock driver changes:

 - Add support for some missing clocks: APB, DMAC, GPIO
 - Add support for Reset Management Unit

The removed patches are subject to resubmission via a separate series:

 - arm: dts: owl-s500: Add Clock Management Unit
 - arm: dts: owl-s500: Set UART clock refs from CMU
 - arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
 - arm: dts: owl-s500: Add DMA controller
 - arm: dts: owl-s500: Add Reset Controller support

Regards,
Cristi

Changes in v3:
 - Incorporated feedback from Stephen and Mani
 - Rebased on v5.8-rc3

Changes in v2:
 - Incorporated Stephen's review comments
 - Removed DTS related patches
 - Rebased remaining patches on v5.8-rc2
 - Updated cover letter, both subject and content, to reflect the new
   scope

Cristian Ciocaltea (6):
  clk: actions: Fix h_clk for Actions S500 SoC
  dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
  clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
  dt-bindings: reset: Add binding constants for Actions S500 RMU
  clk: actions: Add Actions S500 SoC Reset Management Unit support
  MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs

 MAINTAINERS                                   |  1 +
 drivers/clk/actions/owl-s500.c                | 89 ++++++++++++++++++-
 include/dt-bindings/clock/actions,s500-cmu.h  |  7 +-
 .../dt-bindings/reset/actions,s500-reset.h    | 67 ++++++++++++++
 4 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/actions,s500-reset.h

-- 
2.27.0

