Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503BC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D42E20674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/Ewrsn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBCWzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:55:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38554 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:55:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so449474pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mbd+zaPlNPETe1wNA306kmUlthg3io89NNBcl5Um8vU=;
        b=n/Ewrsn6zdfXe+bDAPIGD3w+zw4BtAel/beC+kb+eyNw7L+wdmw0WycYfTb+hrX45N
         UMpWIU68uCzrqj6QiPu6oMWFMX7SP3MQsbww6/U+vfGNTz0scu4T3mWiY9wxCfZ98KG0
         83shKxfKPXp0wg3ErXxx0Z5mDtDXAsVKoV018=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mbd+zaPlNPETe1wNA306kmUlthg3io89NNBcl5Um8vU=;
        b=Evd/IWPbt3a8f24O4kOKBDPiyhbOBhQvJxqMaEuzwTOUg8A2cf8FsxpKL2vbqKg4F/
         RTkKJDcpXDx4YHqWprUh3rwgU/DhgfgVSMfwEuboEZumrG3Mg/lGuEFDhRceF5T9zPnq
         D2NP2P3QRVoNFHn/rvXBEy6diJMWXwHv/ZDdabDmygXZuIRWoFEeps3aMvXmqwkp3/m3
         BS4OJe7iQxc48pz7K+jnd6Uwz7+IGSjgVKEu8Qe+NKq3phjUWcqn/HedyjZh7JDIXmtr
         Fx2apBvIFpHEMwLAlklWZv4YVre75RdUX6LY0artYy17iUmyzP7pRm6ewLUh+WN/Kiey
         kqGA==
X-Gm-Message-State: APjAAAWQtqtsZYApwZPP6ICDQSKzFfnc+mul8P7azQgdW1ZwH+jFH/OK
        8WJ7iavf0pNT2MeJcuksCwU5ZnlwS8KxVA==
X-Google-Smtp-Source: APXvYqx+jsm3aHRpCZuleYPzRToyAAYttUTLXeKsaQz19t5aTxTKSmQrhHknk2sbFio8XQdVRyUMJw==
X-Received: by 2002:a17:902:7d8c:: with SMTP id a12mr26028586plm.47.1580770504903;
        Mon, 03 Feb 2020 14:55:04 -0800 (PST)
Received: from yichengli2.mtv.corp.google.com ([2620:15c:202:201:fd9f:cb79:f2f4:c8c7])
        by smtp.gmail.com with ESMTPSA id k5sm485229pju.29.2020.02.03.14.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 14:55:04 -0800 (PST)
From:   Yicheng Li <yichengli@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, lee.jones@linaro.org, gwendal@chromium.org,
        andriy.shevchenko@linux.intel.com, Jonathan.Cameron@huawei.com,
        evgreen@chromium.org, rushikesh.s.kadam@intel.com,
        yichengli@chromium.org, tglx@linutronix.de
Subject: [PATCH v6] platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW
Date:   Mon,  3 Feb 2020 14:53:56 -0800
Message-Id: <20200203225356.203946-1-yichengli@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RO and RW of EC may have different EC protocol version. If EC transitions
between RO and RW, but AP does not reboot (this is true for fingerprint
microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
still uses the protocol version queried before transition, which can
cause problems. In the case of fingerprint microcontroller, this causes
AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
interrupt handler, which in turn prevents RO to clear the interrupt
line to AP, in an infinite loop.

Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
might have been a transition between RO and RW, so re-query the protocol.

Signed-off-by: Yicheng Li <yichengli@chromium.org>
---
Hi Enric and Marek,

> This patch landed recently in linux-next as commit
> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
> Peach-Pit and Peach-Pi):


> Many thanks for report the issue, we will take a look ASAP and revert
> this commit meanwhile.


> Simply removing the BUG_ON() from cros_ec_get_host_event() function
> fixes the issue, but I don't know the protocol details to judge if this
> is the correct way of fixing it.

The issue was those Samsung Chromebooks (Snow, Peach-Pit and Peach-Pi)
do not support mkbp events, yet we applied the same thing to them, which
we shouldn't. This v6 should fix it: I Just added a check

	if (ec_dev->mkbp_event_supported)

in cros_ec_register().



drivers/platform/chrome/cros_ec.c           | 29 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e17..f16804db805b 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	return ret;
 }
 
+static int cros_ec_ready_event(struct notifier_block *nb,
+	unsigned long queued_during_suspend, void *_notify)
+{
+	struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
+						     notifier_ready);
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
+		mutex_lock(&ec_dev->lock);
+		cros_ec_query_all(ec_dev);
+		mutex_unlock(&ec_dev->lock);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
  * @ec_dev: Device to register.
@@ -201,6 +218,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
 			err);
 
+	if (ec_dev->mkbp_event_supported) {
+		/*
+		 * Register the notifier for EC_HOST_EVENT_INTERFACE_READY
+		 * event.
+		 */
+		ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
+		err = blocking_notifier_chain_register(
+			&ec_dev->event_notifier, &ec_dev->notifier_ready);
+		if (err)
+			return err;
+	}
+
 	dev_info(dev, "Chrome EC device registered\n");
 
 	return 0;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 0d4e4aaed37a..a1c545c464e7 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -121,6 +121,8 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @notifier_ready: The notifier_block to let the kernel re-query EC
+ *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
  * @ec: The platform_device used by the mfd driver to interface with the
  *      main EC.
  * @pd: The platform_device used by the mfd driver to interface with the
@@ -161,6 +163,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	struct notifier_block notifier_ready;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
-- 
2.24.1

