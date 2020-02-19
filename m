Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C874C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CFA24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQlQz9n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgBSEKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:10:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56240 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:10:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so1994601pjz.5;
        Tue, 18 Feb 2020 20:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/4QfSbNwDiyOq9M2o22bkskTtnXSD/0YCR1iZOhH00=;
        b=rQlQz9n3Bh65kG7Be6Oxhv5mqT/0q2Av2QmfEtyMvE7NHQhXAiRsZ4OpJ869wfv8Yb
         deLcG2vmLMpW0a8SQ5L975ifER4x27wuMLyJlaeF/EdRUVMHvMrorTmj+uNHjOXAtJED
         lHe5VR0S4PAyCcYhzQpWLzrRuI9TvaOUjY+Id/m/KEDJV3Qs8kCrw1QwzmW2+A1EPhGN
         W/4oxlzGwPsg9uO4wRK7eMtm0JDrD0qPh7SwLdLvTKSab+nIWlsuSnPOF39KweK4eV/T
         M+7a09ealDQIBZDab9bYwuh0JbNZNJ757rCwpGHWTo/aW7ZrY1pO+dEI31kQs9I82R5r
         4UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/4QfSbNwDiyOq9M2o22bkskTtnXSD/0YCR1iZOhH00=;
        b=qxxujcDqV5xGyUu8dWrK0jvjOobygHGfi8kseNHFSghHiJCGUJQSaXs+JVcCgHFV6O
         EEeDk6B4Z3QBg0wHC4F9MLialrpHPI5n9OBisL2WUMJeWNuWhPhzq4GVgpTH7804Cvg2
         jQNSc8ssPY7w+5EnDNEzAoD45t1aeE8j7/Ur8viL2WXec9VLNY+oUFrO/+vOHYkG8quC
         0Eo4m4kb8qtZhNc/aoxnTq2XYMPmm9NRg51ohR8TQdGA0jQvbnGFu+VCQwYNMvwkGJBE
         KPBHiW2/DCivF1LpAg3gSJbt+wUu9EprOvyWC0wIuxv0ymstw9W/6sKSzWTNDRACaNT6
         KCBw==
X-Gm-Message-State: APjAAAWU/lDyxQ+CjNjfEuEv5jTq0AuqHL8LP/Ycv6q/I97Ztyq8sF9D
        h/Wyl2/kmJ6qSzKWKV9PHt4=
X-Google-Smtp-Source: APXvYqymNqPwJme5nrYTdfGy2cJNmdMYK0HcgYuu4/fmWNUkkjQI0N8zeHZcw+tJ8kfXBX+66AMLTQ==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr6843144pjk.134.1582085406987;
        Tue, 18 Feb 2020 20:10:06 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm578748pfq.27.2020.02.18.20.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:10:06 -0800 (PST)
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
Subject: [PATCH v5 0/7] Add clocks for Unisoc's SC9863A
Date:   Wed, 19 Feb 2020 12:09:08 +0800
Message-Id: <20200219040915.2153-1-zhang.lyra@gmail.com>
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
 .../bindings/clock/sprd,sc9863a-clk.yaml      |  110 +
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
 13 files changed, 2462 insertions(+), 54 deletions(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
 create mode 100644 drivers/clk/sprd/sc9863a-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h

-- 
2.20.1

