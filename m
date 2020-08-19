Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E56C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D2D207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn+ymFH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHSS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:59:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53000C061757;
        Wed, 19 Aug 2020 11:59:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so11269795plr.7;
        Wed, 19 Aug 2020 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pp7ILrXVpYWERUNp+y3FKEvGmfdJxafp13Cd61iIdo=;
        b=Mn+ymFH5Tc2xZr4mSSRBUl7CNfTA0DlesWU0Sq0Xu1T+OqneWcVq4ekASysyYI2ETT
         NOSB7C2Cedt19yXvJ2upXqZodaCRErUqHBJvXJ+y1AG0d1s3aeoXWgX4ydW1wonG1AQJ
         KyyYcwn0E1nHoVzOPWBujC3D3P2PPODBG13GhGBCib7jUZw+yShRX9TFZfqK5/8JvmIY
         Q9fAysRWcGK4QLyVjz9u8ryaERCmVOEyPJXSzbd+3ZARafIcqDvcV2dqniZXDul1xz43
         LQjdek9dXEkDQpvBHd7Ur9Oo/o0EtG2HR0sFPQG850ujw/PavQIQaX7UXDdE6ivpyEku
         Cp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pp7ILrXVpYWERUNp+y3FKEvGmfdJxafp13Cd61iIdo=;
        b=rC7Y/zR9e+FGO+JyIgJqTYl6rEXWn+IKkxiUemRWJ8/72/E+AIa4l2syR07oi8fC8+
         puiim5kxP519PKuKZM/RPlrezWBL7+9uFmRMg2RXczfeZvGj+aEIG74G5infPGHBVyQg
         HmbtjSD2tMjiNK6yMWsHuNbG/jnZuotzb33QnSULLEnw3wI0GcBdyYJsjLsoEL/+qgZv
         FR9lsSEGX52aPfPqYUG2P+nzJeG67yDw0mDjYfTzHJcQ2CA50GH7nGcDvnhJUWtztvOf
         oZIpodX5wwW+lNFKm6i3BLOJXJ8cnru194/eiyPFni1ZRpaISUU5XjVlu+GmwEM1r3KM
         KX9g==
X-Gm-Message-State: AOAM531IcJL1s+Ka6SUMpBj47iGOQqalMO45jWZz1LDebg4c2XCclz+M
        N5BA8tQvhHCpKCUUZPvTzUM=
X-Google-Smtp-Source: ABdhPJyPQYzgR72iLGG6L45iOOLTCC87J2wjbMAQqVqpLvOesvLqGUTY8VuELv+F5IyITtz4hTGtcA==
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr5130955pjh.179.1597863589786;
        Wed, 19 Aug 2020 11:59:49 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:59:49 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 08/12] fbdev: cyber2000fb: use generic power management
Date:   Thu, 20 Aug 2020 00:26:50 +0530
Message-Id: <20200819185654.151170-9-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
References: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. This way we can
remove the legacy .suspend & .resume bindings from "lxfb_driver".

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/cyber2000fb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 42d37bed518a..d45355b9a58c 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1810,7 +1810,7 @@ static void cyberpro_pci_remove(struct pci_dev *dev)
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused cyberpro_pci_suspend(struct device *dev)
 {
 	return 0;
 }
@@ -1818,9 +1818,9 @@ static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 /*
  * Re-initialise the CyberPro hardware
  */
-static int cyberpro_pci_resume(struct pci_dev *dev)
+static int __maybe_unused cyberpro_pci_resume(struct device *dev)
 {
-	struct cfb_info *cfb = pci_get_drvdata(dev);
+	struct cfb_info *cfb = dev_get_drvdata(dev);
 
 	if (cfb) {
 		cyberpro_pci_enable_mmio(cfb);
@@ -1846,12 +1846,15 @@ static struct pci_device_id cyberpro_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
 
+static SIMPLE_DEV_PM_OPS(cyberpro_pci_pm_ops,
+			 cyberpro_pci_suspend,
+			 cyberpro_pci_resume);
+
 static struct pci_driver cyberpro_driver = {
 	.name		= "CyberPro",
 	.probe		= cyberpro_pci_probe,
 	.remove		= cyberpro_pci_remove,
-	.suspend	= cyberpro_pci_suspend,
-	.resume		= cyberpro_pci_resume,
+	.driver.pm	= &cyberpro_pci_pm_ops,
 	.id_table	= cyberpro_pci_table
 };
 
-- 
2.28.0

