Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B24C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E820746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BnhSIlLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgEKPI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730191AbgEKPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34AC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so11430611wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=BnhSIlLGUOMFfC52MRwFwUpau+oL5+IxT7j73mv3XA1jTJZIJIQz2A/+dUwdH20AGh
         coCnf65IfW/UjA0wdDtQEthrmM8Ua/pXygXmqI4yi88+KH4Uab82HS2/hHcO4784GWdB
         0iqX/pvaP0IKonT6d12xExIGCNHih0ZfZQU8HVvdvGkTTHUxUKAb8glPwIZ6XV94TsaT
         dxCnvPFTg9k8b7kDnf62Wlr7b6Ux+/TCMYSL3XMCogB5LHqGBfCnPXkFZHH0b7TeHnja
         qCqPTnXSnlMojw3lCfew9QmkzTsHB8hA3NlY5bQ7vBpf0MxDJz4DQ4jVFgerZnnu2hS4
         r0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=iNArpuH9tscxc+VMBCHpTQ2U2d9AxNTeVfRqvnnZURdwn7+a2rhJP5JHhI9IOxYZyV
         UfBrPqm3VZ1w9YI4BIMLCh/ZMZhwZbf+GHNZGeMfOYV1B3GF1+PQVaymQ7qEaKYwt2ey
         +xBswX9JLQ+xyUr0YY4Rlpr6Zken5Z/LXR346VtR8kdPUf5QxVsyVtWM40TM/Vdprp9H
         Wx0EBOkw3ML2ImM4RZHhGjDN8mtbuECSEgFdPZYhldpdZRvb9P3HdWrJpSph/SxC5VQD
         gEYxRy1/u4geNFUSqThjkNGbjjYgpjS6br/sx7/k4U4p4I+fzEywdrJxbvy0td69Ipdl
         U5fw==
X-Gm-Message-State: AGi0Pua5EkIkbYwFDdtLOLVQ1Hh/c5PU4uF67Z/DNf/1kYrjC15AwKLu
        kWHbWzF3jbWp+RAMcvMWeEUVQA==
X-Google-Smtp-Source: APiQypLau2nbF8LlznCAI/x+Zn88CGRz70T0Uof7qjtAsaEtaADMu0aaeRnM9pZ/buyq3Tlceyfynw==
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr19191837wrv.79.1589209704001;
        Mon, 11 May 2020 08:08:24 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:23 -0700 (PDT)
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
Subject: [PATCH v2 03/14] net: ethernet: mediatek: rename Kconfig prompt
Date:   Mon, 11 May 2020 17:07:48 +0200
Message-Id: <20200511150759.18766-4-brgl@bgdev.pl>
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

We'll soon by adding a second MediaTek Ethernet driver so modify the
Kconfig prompt.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index 4968352ba188..5079b8090f16 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_VENDOR_MEDIATEK
-	bool "MediaTek ethernet driver"
+	bool "MediaTek devices"
 	depends on ARCH_MEDIATEK || SOC_MT7621 || SOC_MT7620
 	---help---
 	  If you have a Mediatek SoC with ethernet, say Y.
-- 
2.25.0

