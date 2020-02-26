Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74539C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FA21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBZGQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:16:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:34384 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgBZGQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:16:48 -0500
Received: from linux.localdomain (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2sADVZeuNkTAA--.2S3;
        Wed, 26 Feb 2020 14:15:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/2] USB: core: Fix potential memory leak in usb_get_configuration()
Date:   Wed, 26 Feb 2020 14:15:23 +0800
Message-Id: <1582697723-7274-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn2sADVZeuNkTAA--.2S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWfuw18Aw43GrWDXrW7twb_yoW8KFWDpF
        4fta1YyFW5JF4fXa1UGasYga1Ygan7Za45CrWIq343Wr4ayayUXrnakr1rAFyUGr93AF1F
        qrWrG3W7KrZrG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeYFADUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free all the allocated memory before exiting from the function
usb_get_configuration() when an error is encountered.

Additionally, just initialize the variable "bigbuffer" with NULL to avoid
the following build warning:

  CC      drivers/usb/core/config.o
drivers/usb/core/config.c: In function ‘usb_get_configuration’:
drivers/usb/core/config.c:956:2: warning: ‘bigbuffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  kfree(bigbuffer);
  ^

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/usb/core/config.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index bb63ee0..3763390 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -863,7 +863,7 @@ int usb_get_configuration(struct usb_device *dev)
 	struct device *ddev = &dev->dev;
 	int ncfg = dev->descriptor.bNumConfigurations;
 	unsigned int cfgno, length;
-	unsigned char *bigbuffer;
+	unsigned char *bigbuffer = NULL;
 	struct usb_config_descriptor *desc;
 	int result = 0;
 
@@ -885,12 +885,16 @@ int usb_get_configuration(struct usb_device *dev)
 
 	length = ncfg * sizeof(char *);
 	dev->rawdescriptors = kzalloc(length, GFP_KERNEL);
-	if (!dev->rawdescriptors)
-		return -ENOMEM;
+	if (!dev->rawdescriptors) {
+		result = -ENOMEM;
+		goto err_rawdescriptors;
+	}
 
 	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
-	if (!desc)
-		return -ENOMEM;
+	if (!desc) {
+		result = -ENOMEM;
+		goto err_desc;
+	}
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
 		/* We grab just the first descriptor so we know how long
@@ -930,8 +934,7 @@ int usb_get_configuration(struct usb_device *dev)
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s\n", cfgno, "all");
-			kfree(bigbuffer);
-			goto err;
+			goto out;
 		}
 		if (result < length) {
 			dev_warn(ddev, "config index %d descriptor too short "
@@ -945,13 +948,19 @@ int usb_get_configuration(struct usb_device *dev)
 		    &dev->config[cfgno], bigbuffer, length);
 		if (result < 0) {
 			++cfgno;
-			goto err;
+			goto out;
 		}
 	}
 
+out:
+	kfree(bigbuffer);
 err:
 	kfree(desc);
 	dev->descriptor.bNumConfigurations = cfgno;
+err_desc:
+	kfree(dev->rawdescriptors);
+err_rawdescriptors:
+	kfree(dev->config);
 
 	return result;
 }
-- 
2.1.0

