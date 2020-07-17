Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A92521744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkHpZeDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGQD6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGQD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:58:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96ADC061755;
        Thu, 16 Jul 2020 20:58:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so4874028ple.0;
        Thu, 16 Jul 2020 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh8xk0TqxiDTOzgBpulOm8nQjP8syH1MFAg9SRwAtT4=;
        b=bkHpZeDqRSgVd8RzRzCZMw6QRew+PPTuu08xAhwIf47nV2SF9HXMNYW5/7FY8z84QE
         Q5h8tth3unWpWI6K9NWW0/qr49YKHx+3npc5kDZ1f0WwQyFUYCN2b1J0tVMPI5hFdHo/
         303/H8n/zhurSEBFF/5Gm9mN27b/oLWKFwb3F9UAY0M+EKFNE951uWNvp2f5yzUXZh3F
         a30kZYpsCJbg6C4aZklctipGdbqjr1kaAbzKDNNjjQ65qy17k2//p3/fr7ukVvbgeJSe
         PA9d5fjom9SM2YRSBK6O9+lJjpHSjanawrIISO1o5frW1PtvCuXr3RcKzObRp8OiFsPk
         eJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh8xk0TqxiDTOzgBpulOm8nQjP8syH1MFAg9SRwAtT4=;
        b=dXTx5WgDZyyQaQWaKRANndoMygXOd+mtce029qTDyb7vYZRjEca31tUQ4R0rkFyTUR
         9uitOmbCtLjO/uarl3Eaa66mY6iS7a1jIS7oQKl3dopGy/EtG4xct82EAtQVwDQ95u7k
         UffMfC5SoYjd90Tyu9QMelJeesDhR5ovMTGAdxMhnF73GYsoiA2IYhwqQYHUr3prvfjO
         4FbmUYXw/1QYIomhUiN+FciOj9jck7ZLwdWXmRMU36w2tT5OAUhhYueRbwwENXXcn/3s
         HYbkrlPezKhHgiTqAiJt4WnBf39sXRRZc58jonnmOmIoGA39rzH9iML8FYOzkN3vU2Sw
         xrUQ==
X-Gm-Message-State: AOAM533DMgjpz9Q+bgVvgAOHAjvizpZDIn3dP3cOQVAGeR1LuaelSMJv
        GGQdyTCHenMq6zlVrMz9iMg=
X-Google-Smtp-Source: ABdhPJw0oHnWuSQKDv/kiHTnDALLcBGVq79bZJCr3BsisCtiY229vXFMXPyuYHbAnso6Bz65GE5RLA==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr6098207plt.91.1594958331257;
        Thu, 16 Jul 2020 20:58:51 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id v11sm6227907pgs.22.2020.07.16.20.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 20:58:50 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 5/6] meye: use generic power management
Date:   Fri, 17 Jul 2020 09:26:07 +0530
Message-Id: <20200717035608.97254-6-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717035608.97254-1-vaibhavgupta40@gmail.com>
References: <20200717035608.97254-1-vaibhavgupta40@gmail.com>
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

The driver was invoking PCI helper functions like pci_save/restore_state()
which is not recommended.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/media/pci/meye/meye.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/meye/meye.c b/drivers/media/pci/meye/meye.c
index 73e064e6f56d..7fb3b1853b87 100644
--- a/drivers/media/pci/meye/meye.c
+++ b/drivers/media/pci/meye/meye.c
@@ -1528,19 +1528,16 @@ static const struct v4l2_ctrl_ops meye_ctrl_ops = {
 	.s_ctrl = meye_s_ctrl,
 };
 
-#ifdef CONFIG_PM
-static int meye_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused meye_suspend(struct device *dev)
 {
-	pci_save_state(pdev);
 	meye.pm_mchip_mode = meye.mchip_mode;
 	mchip_hic_stop();
 	mchip_set(MCHIP_MM_INTA, 0x0);
 	return 0;
 }
 
-static int meye_resume(struct pci_dev *pdev)
+static int __maybe_unused meye_resume(struct device *dev)
 {
-	pci_restore_state(pdev);
 	pci_write_config_word(meye.mchip_dev, MCHIP_PCI_SOFTRESET_SET, 1);
 
 	mchip_delay(MCHIP_HIC_CMD, 0);
@@ -1562,7 +1559,6 @@ static int meye_resume(struct pci_dev *pdev)
 	}
 	return 0;
 }
-#endif
 
 static int meye_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -1788,15 +1784,14 @@ static const struct pci_device_id meye_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, meye_pci_tbl);
 
+static SIMPLE_DEV_PM_OPS(meye_pm_ops, meye_suspend, meye_resume);
+
 static struct pci_driver meye_driver = {
 	.name		= "meye",
 	.id_table	= meye_pci_tbl,
 	.probe		= meye_probe,
 	.remove		= meye_remove,
-#ifdef CONFIG_PM
-	.suspend	= meye_suspend,
-	.resume		= meye_resume,
-#endif
+	.driver.pm	= &meye_pm_ops,
 };
 
 static int __init meye_init(void)
-- 
2.27.0

