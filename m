Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B94A20758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l2llVtSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETLZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:25:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE1C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m185so2463447wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8P07aSxqqSoef+7i1vZAK90p0VIQV5p/d9MbWzhwtk=;
        b=l2llVtStUmtcCNTo5afEPmLyvTxIBdwXG1AUMYrSxn9vnU1okPRUTHjy7GcM5SDrIz
         wnqrKQcQklVQ5Yexfv8vxze3+jIIlXWUB0X3CBgCKLBrvTTcBmTqMU33VKQ4MFS3Dw/Y
         hbZ3aDfWsLuQs2OpjYbP9iBfDWXnc1oUCHzC3A6z6gd/c0xGKH5Pp514KF5//oqXI0mZ
         Gxp5YCn4z394NNDDP/cxiFxHqmIcTmvF/1bLlk2eQlnS5o3slS7b8dDjlGpw6GC56jL3
         2KhNbKDHE/CmlAJ0OylL/4CE2bAdvo0Z8522bcE6uAtv4pHLrCoCQk9UfRd+JAaA67S5
         y5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8P07aSxqqSoef+7i1vZAK90p0VIQV5p/d9MbWzhwtk=;
        b=lZlufdk1wkXCufEVCc/493glsI9iys4Xw+jiq4ESnUlMjYDLJQEq83IP45moH9PyER
         spv6UssS/XrrzqIMQY6DPNmUsjrnXVT7SMc6oNIGD1uMZDDbfkmwQz9jHW50Rt3edrz3
         g1UPkpJoMU/5zmvrCc2Wfg+P8m5jmahmkX726kUaxtEXgN5luTglU3n0hwWtq4a7grMn
         c/Mrhn9s3jDt8DPjjMd/7SK7CMu/cWFZEyhyzUMIGHqkeStqtgiQi/bbZifHRO0cYcgX
         KzpEeeb0YXM+N/Qz/UyDShnqd+elc9wgrUBJy6UfvgVjhs7fppmCnJRxotm384Mwjz3W
         fdjg==
X-Gm-Message-State: AOAM531tZFKS8VSgJh+sDweO5fWjQcLPrnuEpSJB9eGw8yb5Ck1viYzp
        ZKc4n3tXgFUHn0747Itf2yLLww==
X-Google-Smtp-Source: ABdhPJzvgBbyoSwS9NaFCCfWo8VDWuaPCd7LiS7WAWX/txGuTULWv1jp3jF8u37ucf8wB3E+cz+ahA==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr4159276wmg.140.1589973931495;
        Wed, 20 May 2020 04:25:31 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id v22sm2729265wml.21.2020.05.20.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:25:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 00/11] mediatek: add support for MediaTek Ethernet MAC
Date:   Wed, 20 May 2020 13:25:12 +0200
Message-Id: <20200520112523.30995-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds support for the Ethernet Controller present on MediaTeK SoCs from
the MT8* family.

First we convert the existing DT bindings for the PERICFG controller to YAML
and add a new compatible string for mt8516 variant of it. Then we add the DT
bindings for the MAC.

Next we do some cleanup of the mediatek ethernet drivers directory.

The largest patch in the series adds the actual new driver.

The rest of the patches add DT fixups for the boards already supported
upstream.

v1 -> v2:
- add a generic helper for retrieving the net_device associated with given
  private data
- fix several typos in commit messages
- remove MTK_MAC_VERSION and don't set the driver version
- use NET_IP_ALIGN instead of a magic number (2) but redefine it as it defaults
  to 0 on arm64
- don't manually turn the carrier off in mtk_mac_enable()
- process TX cleanup in napi poll callback
- configure pause in the adjust_link callback
- use regmap_read_poll_timeout() instead of handcoding the polling
- use devres_find() to verify that struct net_device is managed by devres in
  devm_register_netdev()
- add a patch moving all networking devres helpers into net/devres.c
- tweak the dma barriers: remove where unnecessary and add comments to the
  remaining barriers
- don't reset internal counters when enabling the NIC
- set the net_device's mtu size instead of checking the framesize in
  ndo_start_xmit() callback
- fix a race condition in waking up the netif queue
- don't emit log messages on OOM errors
- use dma_set_mask_and_coherent()
- use eth_hw_addr_random()
- rework the receive callback so that we reuse the previous skb if unmapping
  fails, like we already do if skb allocation fails
- rework hash table operations: add proper timeout handling and clear bits when
  appropriate

v2 -> v3:
- drop the patch adding priv_to_netdev() and store the netdev pointer in the
  driver private data
- add an additional dma_wmb() after reseting the descriptor in
  mtk_mac_ring_pop_tail()
- check the return value of dma_set_mask_and_coherent()
- improve the DT bindings for mtk-eth-mac: make the reg property in the example
  use single-cell address and size, extend the description of the PERICFG
  phandle and document the mdio sub-node
- add a patch converting the old .txt bindings for PERICFG to yaml
- limit reading the DMA memory by storing the mapped addresses in the driver
  private structure
- add a patch documenting the existing networking devres helpers

v3 -> v4:
- drop the devres patches: they will be sent separately
- call netdev_sent_queue() & netdev_completed_queue() where appropriate
- don't redefine NET_IP_ALIGN: define a private constant in the driver
- fix a couple typos
- only disabe/enable the MAC in suspend/resume if netif is running
- drop the count field from the ring structure and instead calculate the number
  of used descriptors from the tail and head indicies
- rework the locking used to protect the ring structures from concurrent
  access: use cheaper spin_lock_bh() and completely disable the internal
  spinlock used by regmap
- rework the interrupt handling to make it more fine-grained: onle re-enable
  TX and RX interrupts while they're needed, process the stats updates in a
  workqueue, not in napi context
- shrink the code responsible for unmapping and freeing skb memory
- rework the barriers as advised by Arnd

Bartosz Golaszewski (11):
  dt-bindings: convert the binding document for mediatek PERICFG to yaml
  dt-bindings: add new compatible to mediatek,pericfg
  dt-bindings: net: add a binding document for MediaTek Ethernet MAC
  net: ethernet: mediatek: rename Kconfig prompt
  net: ethernet: mediatek: remove unnecessary spaces from Makefile
  net: ethernet: mtk-eth-mac: new driver
  ARM64: dts: mediatek: add pericfg syscon to mt8516.dtsi
  ARM64: dts: mediatek: add the ethernet node to mt8516.dtsi
  ARM64: dts: mediatek: add an alias for ethernet0 for pumpkin boards
  ARM64: dts: mediatek: add ethernet pins for pumpkin boards
  ARM64: dts: mediatek: enable ethernet on pumpkin boards

 .../arm/mediatek/mediatek,pericfg.txt         |   36 -
 .../arm/mediatek/mediatek,pericfg.yaml        |   64 +
 .../bindings/net/mediatek,eth-mac.yaml        |   89 +
 arch/arm64/boot/dts/mediatek/mt8516.dtsi      |   17 +
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   34 +
 drivers/net/ethernet/mediatek/Kconfig         |    8 +-
 drivers/net/ethernet/mediatek/Makefile        |    3 +-
 drivers/net/ethernet/mediatek/mtk_eth_mac.c   | 1668 +++++++++++++++++
 8 files changed, 1881 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
 create mode 100644 Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_mac.c

-- 
2.25.0

