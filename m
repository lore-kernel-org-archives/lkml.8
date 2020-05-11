Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67FC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588082080C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lGEfjqd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgEKPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730274AbgEKPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34113C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so11400219wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLMq2XwRgUC25FFpg44rE1jATuYcYABivRm1tKC5XTM=;
        b=lGEfjqd/Aqo91nNbYHQC/XXhvPNRro/VrpfSU0EKrgUiO5UJ0lZXxyaNjy0vwymwSb
         uxwP22CTUu7BkW2bIoeK3qhHOwvoFsYhIhZngMUlHLW4GZlrj2EaI2Od7rJuyEum2hPJ
         mOOddMd5+KhA4BsHVTsFc1TO02ZsDR/PDJsjrmcYeCSNntHIyaYLDAKJYR4kDyHYUkdo
         fa8cnqPq4/GDF/sZDgDOT2ZTLehxieagSqPBErq+zM756mvMYXQKGiraMxfd2vT4/Pq4
         A/Z1mAM/jRHFEXGLC9eB34BPWmePWBU9/Ou4b7W0qT+98gs2/rruU5IXXYcZJR3Y5Amy
         Dh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLMq2XwRgUC25FFpg44rE1jATuYcYABivRm1tKC5XTM=;
        b=UqGF3kO3zEOxHE8dobmQBo+9kboMPkd1iLvOJvYVJc700qJSwvMnqUxyuHPyo3VHqz
         BaDcZTX4r0w22E1A0XI1QNt3DPZZgDI+i9HlfU6DEcj8fpsgNXtvvDB7kPnErJH3UR1D
         mDyoibZ28SfwNz7yRgG8uq/U8lQ0FauFTKDnNif+FtCo7qNQWIWqlhH0bOTFICflBJLh
         L18o0n2cd8H7iZ3x4W2Svg7cTN7i9dDBBod7e48OtOGHg/Aykwah35JwcIr4ocFhOsdd
         0oktgdu6FxN/ntNkeV+0LV04VBpLXr4vwXWupj4fEFe1z2hM1LHFUuw764fCut/xwXJa
         sPBg==
X-Gm-Message-State: AGi0PuYVdo2aRN/8gBE5XHUPPc83oTJaOP+2u583UevJFWH3JTded3HO
        iCPYccRHaAN+u4/7NzNPCHG4DMK6xHw=
X-Google-Smtp-Source: APiQypLrstV08k3pPp3S+tVHPnE3B6GnlgxYC6jtUQXLXJtg4uaQOjgd0DZV0NaM/PAy80Q8A9SMbg==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr18746418wrq.235.1589209706975;
        Mon, 11 May 2020 08:08:26 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:26 -0700 (PDT)
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
Subject: [PATCH v2 05/14] net: core: provide priv_to_netdev()
Date:   Mon, 11 May 2020 17:07:50 +0200
Message-Id: <20200511150759.18766-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Appropriate amount of extra memory for private data is allocated at
the end of struct net_device. We have a helper - netdev_priv() - that
returns its address but we don't have the reverse: a function which
given the address of the private data, returns the address of struct
net_device.

This has caused many drivers to store the pointer to net_device in
the private data structure, which basically means storing the pointer
to a structure in this very structure.

This patch proposes to add priv_to_netdev() - a helper which converts
the address of the private data to the address of the associated
net_device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/netdevice.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 130a668049ab..933c6808a87f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2249,6 +2249,18 @@ static inline void *netdev_priv(const struct net_device *dev)
 	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
 }
 
+/**
+ *	priv_to_netdev - get the net_device from private data
+ *	@priv: net_device private data
+ *
+ * Get the address of network device associated with this private data.
+ */
+static inline struct net_device *priv_to_netdev(void *priv)
+{
+	priv = (char *)priv - ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return (struct net_device *)priv;
+}
+
 /* Set the sysfs physical device reference for the network logical device
  * if set prior to registration will cause a symlink during initialization.
  */
-- 
2.25.0

