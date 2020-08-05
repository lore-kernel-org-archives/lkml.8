Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3622CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJdfVwrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHESXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHESLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518BC061575;
        Wed,  5 Aug 2020 11:10:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so5908678plr.5;
        Wed, 05 Aug 2020 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr1R0/Ze2G4IecD2JkfhRTVYXHTVK1Tx0wo+bfHFfJI=;
        b=sJdfVwrs67VSWJ5Urnu3dK5b8A8dylK7mh1xnF8wRETervUk9RNicZKtC+qvch4EFV
         k26HGRHycRlUbPnzAzmeVzlHJHTPxIuPT0hzGI/0edcqMTs6QxFztZsAYKTzI/3AuyW9
         Q+MMx6BOgb47Xcgt8E6FTwNIFije/ztkRl9lifaif5/f0H0F29Wha7hVxyCaJ3YcoGHu
         aqSTjF1lsue7sZtzPF9fQvJOlQrT5+iWp+K1nLpsudiy+Cuqa1oF9H9EsLdYlmamTQuL
         dQuQQUvftJye8+UOMCuoEqKOivnQGMZ9Ut9CFVD3GznkJVvB9d2ltjwYLrY6OnsjR27k
         mRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr1R0/Ze2G4IecD2JkfhRTVYXHTVK1Tx0wo+bfHFfJI=;
        b=srRNJmEqmpacQ5x2F1rMCosTuXlh07eYdnj7UNe+R3wdQXTsg5rkhgbY1N1gg2VkEe
         4G3aKTZRzlulQXLDUCkG6NvQWF2ujZHONvoVaI1NK2gw0rK9WfkDCn7S47Zj8sZj6YlX
         bD3UnMZ5xAl5UANmCBV93F/4W2IEoArXFu7N7DdBUKt6PZYu5IAQuWwKKEwSSMd5Z8v/
         sGNejzxMXViGwd59G2wg5h6QSFc3urLaxBXqcKVowQFzo7uhzatS30ZwC0U1yUaqOzai
         7XkusGvmP3Xp1t1jiqrIJLWelQcifmY4mBJxlM1uOiSqzgPHFC1rjFNsQ63FCyIILBtW
         R/5w==
X-Gm-Message-State: AOAM532N6u/VgGHAFc38dRXJw9HiP+ZCP57yQ/9fI6Xf4VzK6bvtM/ga
        0gR8c5HcN+wU8szBXD+HukE=
X-Google-Smtp-Source: ABdhPJxyu6VM6PZNHf9Q6CWK4FZqzh1F468GpS4fZ5DdCQVfyzwWEr5vdgsuKzP6qjzcCo2AdWK0ag==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr4520046pjb.30.1596651016370;
        Wed, 05 Aug 2020 11:10:16 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:10:15 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 09/12] fbdev: i740fb: use generic power management
Date:   Wed,  5 Aug 2020 23:37:19 +0530
Message-Id: <20200805180722.244008-10-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using legacy power management .suspen()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a single
"struct dev_pm_ops" variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/i740fb.c | 40 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index c65ec7386e87..8d7f06fc8a5a 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -1175,16 +1175,11 @@ static void i740fb_remove(struct pci_dev *dev)
 	}
 }
 
-#ifdef CONFIG_PM
-static int i740fb_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused i740fb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct i740fb_par *par = info->par;
 
-	/* don't disable console during hibernation and wakeup from it */
-	if (state.event == PM_EVENT_FREEZE || state.event == PM_EVENT_PRETHAW)
-		return 0;
-
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
@@ -1197,19 +1192,15 @@ static int i740fb_suspend(struct pci_dev *dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
 	return 0;
 }
 
-static int i740fb_resume(struct pci_dev *dev)
+static int __maybe_unused i740fb_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct i740fb_par *par = info->par;
 
 	console_lock();
@@ -1218,11 +1209,6 @@ static int i740fb_resume(struct pci_dev *dev)
 	if (par->ref_count == 0)
 		goto fail;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	if (pci_enable_device(dev))
-		goto fail;
-
 	i740fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -1231,10 +1217,17 @@ static int i740fb_resume(struct pci_dev *dev)
 	console_unlock();
 	return 0;
 }
-#else
-#define i740fb_suspend NULL
-#define i740fb_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops i740fb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= i740fb_suspend,
+	.resume		= i740fb_resume,
+	.freeze		= NULL,
+	.thaw		= i740fb_resume,
+	.poweroff	= i740fb_suspend,
+	.restore	= i740fb_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
 
 #define I740_ID_PCI 0x00d1
 #define I740_ID_AGP 0x7800
@@ -1251,8 +1244,7 @@ static struct pci_driver i740fb_driver = {
 	.id_table	= i740fb_id_table,
 	.probe		= i740fb_probe,
 	.remove		= i740fb_remove,
-	.suspend	= i740fb_suspend,
-	.resume		= i740fb_resume,
+	.driver.pm	= &i740fb_pm_ops,
 };
 
 #ifndef MODULE
-- 
2.27.0

