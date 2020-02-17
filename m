Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61288C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FAC2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp1S4bjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBQDXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:23:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39271 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:23:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so6550159pjr.4;
        Sun, 16 Feb 2020 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdpdyX+qh74e/x9oRj15IViPzfI9gUxu2+ZyneQM7WE=;
        b=Lp1S4bjFv9z7K/N+snC61ek2luA4OaF5fnbGKXm5z/o1JTxjD8zDsGjtFex6nIWqmy
         p69m5mVIJcetEK1GN6SLSDdZQGpvKnjc57W4TGceqNZSHpVMbK1GkygNgh5dlp9CrpbS
         WKftJ2tehC5z79XvLAPLhQLQIP7o6Qlsi1KorO4aTOXG/nExQyz/Vo2htgGLqS/1bkcG
         G/qkUXDGA576plhbVbcpnnB/HScdFpqaVA0jAtLjK4S1PaJFfZ0MvKRMVUktNgoS1Hg3
         uQHZG4lwpgtn+EJOEH15kHXyB7MWpQxrdW1aX0Fq48lpf0NfVh+E8xJLtkcNFmrlEjJf
         dPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdpdyX+qh74e/x9oRj15IViPzfI9gUxu2+ZyneQM7WE=;
        b=tm7xkT/HL2iu5E01gtaSSaLTqN7i2VMSMOZ+zdGQKBLzi1sDz2hOaY8lxWrZdzMTja
         d5gCibvrQyorRbe6GQ+JmeniRn6xpyrwOgqptMaYI2fEFzaPr5rvkyyfkhrDBbP7gCRo
         8T3NupvGwtH9w59DGG24bUzhkafSq5ZGnuwkcKNogCAOa4X2HlMf25hoCA8mZkH5PAuS
         B0EMCD8+bsf2Zq0zwol0mt9ejrPz+yjx00xvLOk2hjM5cHinPiQs44e0kVgrRASDVklX
         glyMPE3mwynJIydOsxM78Prysh7BrJ7aMRCpZru0xKPSfOX9ELr2Lz3t93jwPsrsKXjo
         ff7Q==
X-Gm-Message-State: APjAAAXa7Kqm3F43ueYAkCuMQeH+r3IUER+/WUgdL7gXsLQSz79RkXnp
        mIIW1pxrbYfB/PdMcRvb/0k=
X-Google-Smtp-Source: APXvYqxw58LR20P0nOqiPgbVPoG6FQmjzXPIHV7Z72OMm+op/MjkJsBl2KV1Xb9zdJN1PGWPWW70dw==
X-Received: by 2002:a17:902:5a42:: with SMTP id f2mr14278395plm.19.1581909820990;
        Sun, 16 Feb 2020 19:23:40 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 76sm14644383pfx.97.2020.02.16.19.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 19:23:40 -0800 (PST)
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
Subject: [PATCH v4 0/7] Add clocks for Unisoc's SC9863A
Date:   Mon, 17 Feb 2020 11:23:14 +0800
Message-Id: <20200217032321.15164-1-zhang.lyra@gmail.com>
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

