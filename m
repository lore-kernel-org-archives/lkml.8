Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05160C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E21214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiQLWorU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCDH2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33244 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCDH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id m5so579946pgg.0;
        Tue, 03 Mar 2020 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQ+CUp+1AMSQaNMNgIbviSQx1y9loRr5fUvJb8ibZj8=;
        b=uiQLWorUiGOdPnaOOQlgkFoHplLC6t7myellJvAWKMqtP4ZS4J7gpqQdmuWCoQ9UE6
         pzq6Tq+YcDvDiPls+QKJKDDSxPMfZb7H7g0cKTxR43zHm63Mv219RTwruHUjKXb7xdtA
         jmqAKdUsJ7NMtjm8qiUHoe/t8KR/SoZXkDx4bbm8+WqYaEsjIzIHLBxKuonkf9pV8RMU
         osOGeQtOc8BQAHzDxbJJE75YCEVXjqVIJWkjj4RNe+W33RzKie/qXizqEy+ZytvCjmwC
         a2nrYDVxFZkmiG2qncdRM7TFvShT18y5ObxmJDc53mpOAZWkDUGGkofupP8n746iuxii
         CBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQ+CUp+1AMSQaNMNgIbviSQx1y9loRr5fUvJb8ibZj8=;
        b=bKq3rmm518j9SoYNNEz7U6PFXXrXQ6/vhX+0QKAE5Yn7xJWIPXVtgIL3xYix66BbXA
         2vEyKF61mSeK4NUqTTF4HNp9h+segjWQAzdS5TRJ7kYs5ygjiwMevh4AlhRHyKWBdW+Z
         oVc1ZXUH31zS9hr8an22GMTb1EiTDgC0h/g8IR+03aqqR0x+XmHAjhVIoVyGTRn82QWp
         bWbL4qThAikdY9av81xVoiMTy/q24CKnGCIK5FULMZjLpq2TFw/nMdIXVEhG/b91rncK
         /qZ6yOFEMO1CxtEB123rf6mHdXuH3Ush+5VrKMM+YlapKq43x0ThyO90AkfJJipsTSzo
         HHVw==
X-Gm-Message-State: ANhLgQ1sp+83OTLJZgsM+LAg7D229o4Ju166nVwl/ZD7r5MGEcm8U/8c
        RSIVgul2+O3H3t4+kCRlDGIquivu
X-Google-Smtp-Source: ADFU+vvtZwUp3H8qcdnnIzv+yvtHwIMTB9mu+belfvosBk7NPcEGmuHjXbVDPSNa+wrVld1kfeg8Kw==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr1795452pfg.55.1583306892166;
        Tue, 03 Mar 2020 23:28:12 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:11 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v6 0/7] Add clocks for Unisoc's SC9863A
Date:   Wed,  4 Mar 2020 15:27:23 +0800
Message-Id: <20200304072730.9193-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add SC9863A specific clock driver and devicetree bindings for it,
this patch add to support the new way of specifying parents
without name strings of clocks.

Also this patchset added support gate clock for pll which need to
wait a certain time for stable after being switched on.

Changes from v5:
* Addressed comments from Rob:
- Removed description from "clock-names" and "reg" properties;
- Added maxItem to "reg" property.
* Modified the descriptions for those clocks which are a child node of
  a syscon.

Changes from v4:
* Fixed dt_binding_check warnings.

Changes from v3:
* Rebased onto v5.6-rc1.

Changes from v2:
* Addressed comments from Stephen:
- Remove ununsed header file from sc9863a-clk.c;
- Added comments for clocks which were marked with CLK_IGNORE_UNUSED,
  and removed some unnecessary CLK_IGNORE_UNUSED;
- Added error checking for sprd_clk_regmap_init().

* Addressed comments from Rob:
- Put some clocks under syscon nodes, since these clocks have the same
  physical address base with the syscon;
- Added clocks maxItems and listed out clock-names.

* Added Rob's reviewed-by on patch 4.

Changes from v1:
* Addressed comments:
- Removed redefine things;
- Switched DT bindings to yaml schema;
- Added macros for the new way of specifying clk parents; 
- Switched to use the new way of specifying clk parents;
- Clean CLK_IGNORE_UNUSED flags for some SC9863A clocks;
- Dropped the module alias;
- Use device_get_match_data() instead of of_match_node();

* Added Rob's Acked-by on patch 2.

Chunyan Zhang (6):
  dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC
    specific
  dt-bindings: clk: sprd: add bindings for sc9863a clock controller
  clk: sprd: Add dt-bindings include file for SC9863A
  clk: sprd: Add macros for referencing parents without strings
  clk: sprd: support to get regmap from parent node
  clk: sprd: add clocks support for SC9863A

Xiaolong Zhang (1):
  clk: sprd: add gate for pll clocks

 .../clock/{sprd.txt => sprd,sc9860-clk.txt}   |    2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml      |  105 +
 drivers/clk/sprd/Kconfig                      |    8 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/common.c                     |   10 +-
 drivers/clk/sprd/composite.h                  |   39 +-
 drivers/clk/sprd/div.h                        |   20 +-
 drivers/clk/sprd/gate.c                       |   17 +
 drivers/clk/sprd/gate.h                       |  120 +-
 drivers/clk/sprd/mux.h                        |   28 +-
 drivers/clk/sprd/pll.h                        |   55 +-
 drivers/clk/sprd/sc9863a-clk.c                | 1772 +++++++++++++++++
 include/dt-bindings/clock/sprd,sc9863a-clk.h  |  334 ++++
 13 files changed, 2457 insertions(+), 54 deletions(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
 create mode 100644 drivers/clk/sprd/sc9863a-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h

-- 
2.20.1

