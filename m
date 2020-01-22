Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3EC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3694021835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6BEkR9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45641 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAVQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so3184159pls.12;
        Wed, 22 Jan 2020 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+A9ykUPfPxJXCw9WtHI2g/2sRcbbhg6dL7PEV6UBAQU=;
        b=L6BEkR9P8vKY5SGcvcW0rJIeE5nVeTg9l/t24JYJJv3fTtJtF7++OSndbpK2efGded
         OvlY8WFTiRlO4BU+tiav/ryaj/9nOmnn++hRfy1t+0tBv2TRYIczThgYC9pURYAmyssB
         ldJWH/v4pAPg30nP9xqh/bLdZ+5uFJmxpfA4GyFHGbC/hPoTB+00tZUl9ufFB2Z70mrS
         wy+U9KamEZGK6JSrcunqFjwpj4ct17kAR34Bbb62f1dZs3I0PA+ct0wLwbPMkjAcHrc2
         dtkLX4vWROkBgrnVq2nHn6vQGX6wsCPwD1AIEfyftLeI2UCcRycB/F52WJa/gT3mwIKr
         SJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+A9ykUPfPxJXCw9WtHI2g/2sRcbbhg6dL7PEV6UBAQU=;
        b=CkUTe0hBwbaQj+tS9jCEkfu/wdPlKox9dy+6dIOtggT5lpwAepOUp80L/bRxLdwm+0
         muawNrcci948d4w/xVV35PGSTEKNvBchZAn9QWJRftLQhbRJIqKryacBCZOGROMXgJkW
         lFE6wOorZB9OcHGsJd+SYGR/g7siUnF1HgBchB9WWfD8SIu/yMPK0ZzexavMdhNIH8gD
         sYZmT0sc+pMp3sVBWdx+nQSjilmF7nvrpHR67Ko20mfXEOEGa3gl43YRgnEU9tRQyuqP
         gt08shvNyantmjwyr/Bql6AAO6FRBGnPzCMaT7Yitbs0AXCX1KVpHT8gFGoacYrYvwWX
         0iGg==
X-Gm-Message-State: APjAAAWXNoXJvk3Jp9oN13wwK7i+K+dX7DLLQ6ULU/wyXP7yqe36XrVM
        H+guKGryWUDkUIGVxOIfSyyNE1Pd
X-Google-Smtp-Source: APXvYqxFnKCI2USSxZjJ1GD7zCIJh/usyDrJIhPq9giT+5vJVfgKGP2i7V0rNbr5RTKS7p0v3YNUzw==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr3811531pjb.93.1579709296038;
        Wed, 22 Jan 2020 08:08:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21sm47637074pff.100.2020.01.22.08.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:15 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 6/6] hwmon: (k10temp) Add debugfs support
Date:   Wed, 22 Jan 2020 08:08:00 -0800
Message-Id: <20200122160800.12560-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show thermal and SVI registers for Family 17h CPUs.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 78 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 4a470b5195ee..5e3f43594084 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
@@ -442,6 +443,76 @@ static bool has_erratum_319(struct pci_dev *pdev)
 	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_stepping <= 2);
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+static void k10temp_smn_regs_show(struct seq_file *s, struct pci_dev *pdev,
+				  u32 addr, int count)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (!(i & 3))
+			seq_printf(s, "0x%06x: ", addr + i * 4);
+		amd_smn_read(amd_pci_dev_to_node_id(pdev), addr + i * 4, &reg);
+		seq_printf(s, "%08x ", reg);
+		if ((i & 3) == 3)
+			seq_puts(s, "\n");
+	}
+}
+
+static int svi_show(struct seq_file *s, void *unused)
+{
+	struct k10temp_data *data = s->private;
+
+	k10temp_smn_regs_show(s, data->pdev, F17H_M01H_SVI, 32);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(svi);
+
+static int thm_show(struct seq_file *s, void *unused)
+{
+	struct k10temp_data *data = s->private;
+
+	k10temp_smn_regs_show(s, data->pdev,
+			      F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, 256);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(thm);
+
+static void k10temp_debugfs_cleanup(void *ddir)
+{
+	debugfs_remove_recursive(ddir);
+}
+
+static void k10temp_init_debugfs(struct k10temp_data *data)
+{
+	struct dentry *debugfs;
+	char name[32];
+
+	/* Only show debugfs data for Family 17h/18h CPUs */
+	if (!data->show_tdie)
+		return;
+
+	scnprintf(name, sizeof(name), "k10temp-%s", pci_name(data->pdev));
+
+	debugfs = debugfs_create_dir(name, NULL);
+	if (debugfs) {
+		debugfs_create_file("svi", 0444, debugfs, data, &svi_fops);
+		debugfs_create_file("thm", 0444, debugfs, data, &thm_fops);
+		devm_add_action_or_reset(&data->pdev->dev,
+					 k10temp_debugfs_cleanup, debugfs);
+	}
+}
+
+#else
+
+static void k10temp_init_debugfs(struct k10temp_data *data)
+{
+}
+
+#endif
+
 static const struct hwmon_channel_info *k10temp_info[] = {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX |
@@ -553,7 +624,12 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "k10temp", data,
 							 &k10temp_chip_info,
 							 NULL);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	k10temp_init_debugfs(data);
+
+	return 0;
 }
 
 static const struct pci_device_id k10temp_id_table[] = {
-- 
2.17.1

