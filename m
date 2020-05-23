Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D17EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D335207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aZv6u+u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgEWN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbgEWN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:27:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482FC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so12688351wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkX2gAQLIXJ9uj3WUomW1bZyEutKwO7zwPcKUvDNbGs=;
        b=aZv6u+u9OcqamzTM8oSsMQCNupHcwIZaVmUQ/fuDEAEexf93ZxyIIjhx/CDw4aXOgv
         NOPwijbXQXl+FdHr6Gj5klzGzceksP3UAh/tC40uAT6uib99m4ACrWQjfI0LuP1TDWvz
         R+rymcQKGqccVYvw53qMdoLS3UoIPQ63N4laBhqwXtg+r8GnxpHw89Odof1q5alrLC9i
         m1uJD4F8+Sp2as/kHK7dAxCVLkML/rW+rE9amtXsHc+eeINmpPp0wVCw0REwh1uCTivn
         owbwr8iy0v3xnFeZaNjnOMrfR7o9IAhLk9WBAE8IPU+/QUkYsJcKepvoMR0SNAPBPs+8
         mKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkX2gAQLIXJ9uj3WUomW1bZyEutKwO7zwPcKUvDNbGs=;
        b=RyJLBUKIWBZLmK6F1pLy68v9pSfXNbHehilzPgbwyFKpDHWzkUNmNz6Ji7ifZS6dkU
         d3oP+plBeedxBNs0vTQYCPd8ccEcGVJSX4HdpFgDW71q53ikZ6D6DaOOh3HDkYjibnPS
         g+sgvVAiVbxOzVNrIFQh2cRqEKDQGnJQ2dsI3iEk8Qc0pVx4Vr1X6uaROB8ifaocFF7C
         RpqTOodLzTIVuyQuiT/0KWEZirlTecQEnuPP9E69drjWlOqDMFejazmgeQh3sa1EgKGz
         zEfveUZvixNPX4OvPS6zVMO3MnSA+1/ytPpeilPF/ZPGjnm9+daCC+BWDCTcacQ2O5JB
         uZkQ==
X-Gm-Message-State: AOAM533cGkp0J+ruhYYvBD+87PQTN6j3Cbjmj7yjEOg/ASFG9Iwbsty0
        bKSNgeIQYg8se6+N7hw8aVmskA==
X-Google-Smtp-Source: ABdhPJxC8nZI33xT+XlLdoH7IBEbX8XggatVzrK5OwzBh8IMeKhz7+y+q4FCGYH/str1A7VuWBOXaw==
X-Received: by 2002:a05:600c:20ca:: with SMTP id y10mr18295681wmm.126.1590240439200;
        Sat, 23 May 2020 06:27:19 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id g69sm8098703wmg.15.2020.05.23.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 06:27:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v2 0/5] net: provide a devres variant of register_netdev()
Date:   Sat, 23 May 2020 15:27:06 +0200
Message-Id: <20200523132711.30617-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Using devres helpers allows to shrink the probing code, avoid memory leaks in
error paths make sure the order in which resources are freed is the exact
opposite of their allocation. This series proposes to add a devres variant
of register_netdev() that will only work with net_device structures whose
memory is also managed.

First we add the missing documentation entry for the only other networking
devres helper: devm_alloc_etherdev().

Next we move devm_alloc_etherdev() into a separate source file.

We then use a proxy structure in devm_alloc_etherdev() to improve readability.

Last: we implement devm_register_netdev() and use it in mtk-eth-mac driver.

v1 -> v2:
- rebase on top of net-next after driver rename, no functional changes

Bartosz Golaszewski (5):
  Documentation: devres: add a missing section for networking helpers
  net: move devres helpers into a separate source file
  net: devres: define a separate devres structure for
    devm_alloc_etherdev()
  net: devres: provide devm_register_netdev()
  net: ethernet: mtk_star_emac: use devm_register_netdev()

 .../driver-api/driver-model/devres.rst        |  5 +
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 17 +---
 include/linux/netdevice.h                     |  2 +
 net/Makefile                                  |  2 +-
 net/devres.c                                  | 95 +++++++++++++++++++
 net/ethernet/eth.c                            | 28 ------
 6 files changed, 104 insertions(+), 45 deletions(-)
 create mode 100644 net/devres.c

-- 
2.25.0

