Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B190C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C4C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpvRy0Ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgAJGJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:09:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39189 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbgAJGJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:09:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id m1so531142pjv.4;
        Thu, 09 Jan 2020 22:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLzSHRuu9bmmW6Gtn/WpTcD4ks8Vg2pMw5/HU8yOyFA=;
        b=dpvRy0EaOx0Wj//mdrs3zUeJG20C7RUCcNmcOSQ8RH4s5a2zt61FLTq/diBZaSX0oK
         oFUq0rNhagLL1ojZLZ7RuQ+ZRa6Ia/15gMgtSnrtLcTkN+9yPYFHyXxxbHWsh8gjq5Oa
         bLrgHKhUFo4c3u0dHCZHjcASazQ2526Sz6rx5WHMUSYWN2Okckuh8JjsE5FRlxvUPYuk
         0psdRSG6jP/2RnuBhq7LaDBuSUkOqayc7HcOKzvZosBM3qqc3XDKmAnFUuGUrh/otWqm
         G97ZjTf9WCeXF1lpNUh35bCbrvRaCtkLuYJZC8nZDnAUG6h0vl9vfjGMWG4QCy2tA5Bz
         sMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLzSHRuu9bmmW6Gtn/WpTcD4ks8Vg2pMw5/HU8yOyFA=;
        b=ny4MP7lS1yrR4itrWSvS3pXKKWNEi6R9fPQVqwAJt112pXfgi63ZWu1Rr8zcIpod4Q
         p7N6PuTTPje+1OjtrEZS1RNXR3zBPeRp39bEM07/6ezIlW/g+4RsOezRCV4dNtqLPthR
         qtsxerDLrJNq715DjypkYcj9LkRiWlJxEOdSStCZGWz7psKdXcZ4XGJd+sMuO24AYF7c
         SppwwU0Zc3eqFpo/kg9zNrJs3H7yqK0IMpo3urlHkYsCmwXq+m6A6VWCLQMam9ing/AM
         j7+4xKllIVbt/fVuLBEw3+NKBnrVzOxfxPhp1RJk3XVbRlvrtG7+WH8VB28DGPMhoYT+
         bXRA==
X-Gm-Message-State: APjAAAWMIdUkjiyglchigDJeDtWID4c2hs6YPcs4okDwVirLvmljenJI
        tcLMv91WiCT5eLPCxcHBdzQ=
X-Google-Smtp-Source: APXvYqxFOMKdNQ0zymMXopUo4n85T21suc8IbSRZVAGMx/cg4tGxSzrJ3OxDqWxSdYCZDqzmvsErgA==
X-Received: by 2002:a17:902:8547:: with SMTP id d7mr2408741plo.44.1578636575081;
        Thu, 09 Jan 2020 22:09:35 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y76sm1195814pfc.87.2020.01.09.22.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:09:34 -0800 (PST)
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
Subject: [PATCH v3 0/7] Add clocks for Unisoc's SC9863A
Date:   Fri, 10 Jan 2020 14:09:11 +0800
Message-Id: <20200110060918.18416-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add SC9863A specific clock driver and devicetree bindings for it.

Also this patchset added support gate clock for pll which need to
wait a certain time for stable after being switched on.

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
 .../bindings/clock/sprd,sc9863a-clk.yaml      |  103 +
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
 13 files changed, 2455 insertions(+), 54 deletions(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
 create mode 100644 drivers/clk/sprd/sc9863a-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h

-- 
2.20.1

