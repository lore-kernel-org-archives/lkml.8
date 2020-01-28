Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DAEC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8724656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XOxGeOfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA1Aim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:38:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgA1Aim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:38:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so13974934wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BvCx+GGin1m9Xq7Oj/YFcqGJi/zTNFOV1E+5/BsLcV8=;
        b=XOxGeOfM/jYivd+YFd6WlQpnRSlifN0chcYNtl+1Bahviwc0N1ArYy88KYynhnfnwJ
         5aMBZc4JAS8zpfGP6u5kMpRH1/5lzgm97NR4WpbPqYG33F5Cw/IdHK+NbMFV2GpbzoBo
         NSBaunbWoIgLs0c7UpC5TlGwNO9fss5eSR2TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BvCx+GGin1m9Xq7Oj/YFcqGJi/zTNFOV1E+5/BsLcV8=;
        b=IO3Iqz203D56zqGx2V+UUrTR33owodWNBblFsl8fAhhOV0OMjkeqStssLIIDcmm1ke
         edoZAhPyTShZEmrCjpErEyw8M2fEJfKgAzaiZuv9ik6BI6JEsfDKinnT3qv9eiYLQ2WX
         5DDq/qT2PxuGBrhuuVQUqR3J3Rsm/g0oki8mu0pmEsQ1D8JXsvpdqJ3iLOHa3dr4Pd7z
         2E2WvkwwCxsliPGHfA/pJ0yS5DjdXOk50wTWk1QLpJU3tbXwWNmWJrmXy/HHXKF4TWlV
         c1isz4IVUNftTiuqrKy2bsUIXI9vWyZlP0EsO+Kc+mW3L60hQ302iEcpY3DDBdCU0TSr
         W9dw==
X-Gm-Message-State: APjAAAUnDR4PoO0+SOw8IEghL78/CWiGSokrxc8pXkBROYKEAstilwy2
        37sZas70ejLRitPfnd/Hb2uslA==
X-Google-Smtp-Source: APXvYqz+T7/gzM41/abtTH9r6AoYnsKVJxrhCNkNFgKDrdKjW5d53iyNfSywkRM1kFINyWTmImx3Qw==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr24938413wro.202.1580171920707;
        Mon, 27 Jan 2020 16:38:40 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l7sm22659156wrq.61.2020.01.27.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:38:40 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/1] net: phy: add default ARCH_BCM_IPROC for MDIO_BCM_IPROC
Date:   Mon, 27 Jan 2020 16:38:28 -0800
Message-Id: <20200128003828.20439-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add default MDIO_BCM_IPROC Kconfig setting such that it is default
on for IPROC family of devices.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 8dc461f7574b..b6315a01f36e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -38,6 +38,7 @@ config MDIO_BCM_IPROC
 	tristate "Broadcom iProc MDIO bus controller"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on HAS_IOMEM && OF_MDIO
+	default ARCH_BCM_IPROC
 	help
 	  This module provides a driver for the MDIO busses found in the
 	  Broadcom iProc SoC's.
-- 
2.17.1

