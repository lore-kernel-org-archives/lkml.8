Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72187C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A5E2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmZd7hGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgGAQxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbgGAQxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:53:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81CC08C5C1;
        Wed,  1 Jul 2020 09:53:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 35so10153293ple.0;
        Wed, 01 Jul 2020 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxBM9njwc9t+8wZt245O1720nVEKK0kOwVAxz9sX+f4=;
        b=jmZd7hGknXKUy0a9GgdamQ46AbPd9jgv/R4OLxdEvG2N9rYfAbv/LvSgjMRsE2ZZLC
         51x+9iissrj7FkAh0f72pBvGkeCN3iHyX3EcGI7nbMc04q5yPpUKBqQEwL1H/qFH7lTq
         pBDshRklIkIp8b1Yojxyk4q1RFF81nN8nDutxL9FFR24k37bih8I8gHD1iMjPJNqHVw8
         B8GWBc6fZzh45dtkLLCskwK5VgtubeOeqU8vXdvPbTW64nsUR4AIwwYy17CpdG5xBBrL
         cflibanG1EDbJ+D4Msj+L86U2toNBqxQuuAilkl8Yyp1aVez68/grwrhAPGfZpNYH+RS
         bAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxBM9njwc9t+8wZt245O1720nVEKK0kOwVAxz9sX+f4=;
        b=ATJR8P/ILdVyUJjsjBMnUzMzvziv7HVbCXsWLF+HK18SFhCmpxXhqsDCh6UgHzZgoh
         PW073HnMrAnxad3eu7UGVPzwx1XFQfthF4ZbX/XeGPjO4wBL3dQv0QiDbayhjqafDNqB
         jGK/k/B++JGRvNiGpDfI4y+fTqBQXIEkSo72UaiZiuS+Sk0W1t5pU9oRDNIY4dWjd9+y
         5IzH2tyxrIp8kJJkziZqkNC4i1KsYmXu7LSmFYMeNvl23JJ14maIg5dcgB0Zou5PDfZW
         BdHvhYtUPeFS4dNh741bw6JejCPG3hSG/9Cl1SbEcMRGF/IrtCjVfmwu3+16GcTTE7YV
         GK8Q==
X-Gm-Message-State: AOAM53057oq9Ubvko+HJB66MR5pbz9Dy3CCHjY/UrTNQ4gYaTEPOpWEf
        T2+4zl3fMV7hmYHBNAe0xvA=
X-Google-Smtp-Source: ABdhPJzb5VNDkBrqSO+KMPZQN8fJs+ljNo6yUFPNo9LcbkMNxn00Mh74RDsyWxRFhOaMso8hbwSv+A==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr23077337pln.300.1593622400123;
        Wed, 01 Jul 2020 09:53:20 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id g140sm6297437pfb.48.2020.07.01.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:53:19 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Dillow <dave@thedillows.org>,
        Ion Badulescu <ionut@badula.org>,
        Netanel Belgazal <netanel@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Zorik Machulsky <zorik@amazon.com>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 06/11] sundance: use generic power management
Date:   Wed,  1 Jul 2020 22:20:52 +0530
Message-Id: <20200701165057.667799-7-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701165057.667799-1-vaibhavgupta40@gmail.com>
References: <20200701165057.667799-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With legacy PM, drivers themselves were responsible for managing the
device's power states and takes care of register states.

After upgrading to the generic structure, PCI core will take care of
required tasks and drivers should do only device-specific operations.

Thus, there is no need to call the PCI helper functions like
pci_enable/disable_device(), pci_save/restore_sate() and
pci_set_power_state().

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/dlink/sundance.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index dc566fcc3ba9..ca97e321082d 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -1928,11 +1928,9 @@ static void sundance_remove1(struct pci_dev *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
-
-static int sundance_suspend(struct pci_dev *pci_dev, pm_message_t state)
+static int __maybe_unused sundance_suspend(struct device *dev_d)
 {
-	struct net_device *dev = pci_get_drvdata(pci_dev);
+	struct net_device *dev = dev_get_drvdata(dev_d);
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->base;
 
@@ -1942,30 +1940,24 @@ static int sundance_suspend(struct pci_dev *pci_dev, pm_message_t state)
 	netdev_close(dev);
 	netif_device_detach(dev);
 
-	pci_save_state(pci_dev);
 	if (np->wol_enabled) {
 		iowrite8(AcceptBroadcast | AcceptMyPhys, ioaddr + RxMode);
 		iowrite16(RxEnable, ioaddr + MACCtrl1);
 	}
-	pci_enable_wake(pci_dev, pci_choose_state(pci_dev, state),
-			np->wol_enabled);
-	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
+
+	device_set_wakeup_enable(dev_d, np->wol_enabled);
 
 	return 0;
 }
 
-static int sundance_resume(struct pci_dev *pci_dev)
+static int __maybe_unused sundance_resume(struct device *dev_d)
 {
-	struct net_device *dev = pci_get_drvdata(pci_dev);
+	struct net_device *dev = dev_get_drvdata(dev_d);
 	int err = 0;
 
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, PCI_D0);
-	pci_restore_state(pci_dev);
-	pci_enable_wake(pci_dev, PCI_D0, 0);
-
 	err = netdev_open(dev);
 	if (err) {
 		printk(KERN_ERR "%s: Can't resume interface!\n",
@@ -1979,17 +1971,14 @@ static int sundance_resume(struct pci_dev *pci_dev)
 	return err;
 }
 
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(sundance_pm_ops, sundance_suspend, sundance_resume);
 
 static struct pci_driver sundance_driver = {
 	.name		= DRV_NAME,
 	.id_table	= sundance_pci_tbl,
 	.probe		= sundance_probe1,
 	.remove		= sundance_remove1,
-#ifdef CONFIG_PM
-	.suspend	= sundance_suspend,
-	.resume		= sundance_resume,
-#endif /* CONFIG_PM */
+	.driver.pm	= &sundance_pm_ops,
 };
 
 static int __init sundance_init(void)
-- 
2.27.0

