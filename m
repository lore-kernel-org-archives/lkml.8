Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1E2206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0NIB4N04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgFVKBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFVKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:01:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48233C0617B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y20so15094638wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okWA8PmH0C2v2F1PxoaaMH4dinGpC6QBNEa7DW2Zh+g=;
        b=0NIB4N040OCOlLgg1O0x3F3JvByO2McpYkbxqJlqEN6Uq58x4AMdQ+vmj+3LegiabQ
         Qi5h6Dcv3VNEw+1qhAS9iL+Ip15A313D+S5s7uJcHHRwosRSi7RgslmsGIt0O228NVDo
         PoTwoUyuwGRep31ekyLWFFUPoZ/TiBca0eNIeHgmWQ1XaehWYL72IoRRCRAZdx1cSaJ3
         OlWtHwtJz9u+WM0ep6ON0EkIZ8Sve2lyWWwlIAcWWWiut3v+6NKMu8uaSloirjUY3JBr
         9Z8QSzo7FQnOxk4qsBB/iDIcaICDzSEM/QDfagcUetqaFwncNnOOvWoj+ek6OenujuR7
         /TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okWA8PmH0C2v2F1PxoaaMH4dinGpC6QBNEa7DW2Zh+g=;
        b=IiP0z12HJVyG9VuPyPvRLAWLjWBuLbI0/1TQXH+pFWAE+584JqL6CCPUnhnM+yAxmr
         opkAejiuYsPzAUPAGFyiXi5ii2IcvtKhW3vPqBUbk4dvpp4yGB3Vm8O0j+h3ZPbLbOe9
         n+GcQTXNH26r+XoIWagK2JjqNuTqbFll5/i0sieWCexMC6WlehLuz2h0omtwhjgzSxn3
         lbt0/Jxdtx0wuJ1PpkwdMJ6u+XUtmE43akJ4lRTFazMKee5tc5Bridjv44Ob4VRZsjqu
         pMud9xVi5du+cn2B4YWC94Vj9LqHWOWOlhjFUXFvzBWZMu50fqWktoinu6yBt7wwwtcw
         vD/w==
X-Gm-Message-State: AOAM530msp2LIX5mPTcPKt6o8C4jEGCnpsWTCXNLwx1Ds75JdEKGiSRp
        tolagbKOGueYUBaGlKOPll5tBQ==
X-Google-Smtp-Source: ABdhPJwS5xS9WKkHvow7dKsFvCMdQtYLfCBeItKxhFKFlwRPqAUaAjn5C3o1Oi23Aq0D8zU5tG1vjg==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr698464wmd.59.1592820070021;
        Mon, 22 Jun 2020 03:01:10 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x205sm16822187wmx.21.2020.06.22.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:01:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/11] net: devres: relax devm_register_netdev()
Date:   Mon, 22 Jun 2020 12:00:48 +0200
Message-Id: <20200622100056.10151-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This devres helper registers a release callback that only unregisters
the net_device. It works perfectly fine with netdev structs that are
not managed on their own. There's no reason to check this - drop the
warning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/devres.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/net/devres.c b/net/devres.c
index 57a6a88d11f6..1583ccb207c0 100644
--- a/net/devres.c
+++ b/net/devres.c
@@ -46,14 +46,6 @@ static void devm_netdev_release(struct device *dev, void *this)
 	unregister_netdev(res->ndev);
 }
 
-static int netdev_devres_match(struct device *dev, void *this, void *match_data)
-{
-	struct net_device_devres *res = this;
-	struct net_device *ndev = match_data;
-
-	return ndev == res->ndev;
-}
-
 /**
  *	devm_register_netdev - resource managed variant of register_netdev()
  *	@dev: managing device for this netdev - usually the parent device
@@ -61,22 +53,13 @@ static int netdev_devres_match(struct device *dev, void *this, void *match_data)
  *
  *	This is a devres variant of register_netdev() for which the unregister
  *	function will be call automatically when the managing device is
- *	detached. Note: the net_device used must also be resource managed by
- *	the same struct device.
+ *	detached.
  */
 int devm_register_netdev(struct device *dev, struct net_device *ndev)
 {
 	struct net_device_devres *dr;
 	int ret;
 
-	/* struct net_device must itself be managed. For now a managed netdev
-	 * can only be allocated by devm_alloc_etherdev_mqs() so the check is
-	 * straightforward.
-	 */
-	if (WARN_ON(!devres_find(dev, devm_free_netdev,
-				 netdev_devres_match, ndev)))
-		return -EINVAL;
-
 	dr = devres_alloc(devm_netdev_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
 		return -ENOMEM;
-- 
2.26.1

