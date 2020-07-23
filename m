Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD4C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B632086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v7UPpnzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGWWhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:37:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50759 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgGWWhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:37:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595543835; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=NvTpLK+2HtZrzYjj1mFAAevssZ2L1wkdq7sGJI8xBY4=; b=v7UPpnzc6pxe4j5uCFukXXEQCuYYJwfHseLvfnL5i7ItvOms/pReqoI05FTG5i+ce/ivde8m
 MWTKKUK4p8msEb8b8rN4C7W+MDkg3IL85wGkWaVI38q3jXYo10kRdLKpSIt0TSWnm80ISZdA
 VdmdnafmAlypiQdgDhN2BFe9aNk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f1a11098423214e1323834f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 22:36:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4634BC4339C; Thu, 23 Jul 2020 22:36:56 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D40DC433C9;
        Thu, 23 Jul 2020 22:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D40DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 10/10] bus: mhi: core: Introduce sysfs entries for MHI
Date:   Thu, 23 Jul 2020 15:36:42 -0700
Message-Id: <1595543802-17859-11-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
References: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs entries to enable userspace clients the ability to read
the serial number and the OEM PK Hash values obtained from BHI. OEMs
need to read these device-specific hardware information values through
userspace for factory testing purposes and cannot be exposed via degbufs
as it may remain disabled for performance reasons. Also, update the
documentation for ABI to include these entries.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 Documentation/ABI/stable/sysfs-bus-mhi | 25 ++++++++++++++++
 MAINTAINERS                            |  1 +
 drivers/bus/mhi/core/init.c            | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi

diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
new file mode 100644
index 0000000..a4e4bd2
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-mhi
@@ -0,0 +1,25 @@
+What:		/sys/bus/mhi/devices/.../serialnumber
+Date:		July 2020
+KernelVersion:  5.8
+Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Description:
+		The file holds the serial number of the client device obtained
+		using a BHI (Boot Host Interface) register read after at least
+		one attempt to power up the device has been done. If read
+		without having the device power on at least once, the file will
+		read all 0's.
+Users:		Any userspace application or clients interested in the device
+		hardware information.
+
+What:		/sys/bus/mhi/devices/.../oem_pk_hash
+Date:		July 2020
+KernelVersion:  5.8
+Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Description:
+		The file holds the OEM PK Hash value of the endpoint device
+		obtained using a BHI (Boot Host Interface) register read after
+		at least one attempt to power up the device has been done. If
+		read without having the device power on at least once, the file
+		will read all 0's.
+Users:		Any userspace application or clients interested in the device
+		hardware information.
diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db..5e49316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11018,6 +11018,7 @@ M:	Hemant Kumar <hemantk@codeaurora.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
+F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
 F:	include/linux/mhi.h
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index d2c0f6e..a7b0d76 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -76,6 +76,56 @@ const char *to_mhi_pm_state_str(enum mhi_pm_state state)
 	return mhi_pm_state_str[index];
 }
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+			mhi_cntrl->serial_number);
+}
+static DEVICE_ATTR_RO(serial_number);
+
+static ssize_t oem_pk_hash_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"OEMPKHASH[%d]: 0x%x\n", i,
+				mhi_cntrl->oem_pk_hash[i]);
+
+	return cnt;
+}
+static DEVICE_ATTR_RO(oem_pk_hash);
+
+static struct attribute *mhi_sysfs_attrs[] = {
+	&dev_attr_serial_number.attr,
+	&dev_attr_oem_pk_hash.attr,
+	NULL,
+};
+
+static const struct attribute_group mhi_sysfs_group = {
+	.attrs = mhi_sysfs_attrs,
+};
+
+static int mhi_create_sysfs(struct mhi_controller *mhi_cntrl)
+{
+	return sysfs_create_group(&mhi_cntrl->mhi_dev->dev.kobj,
+				  &mhi_sysfs_group);
+}
+
+static void mhi_destroy_sysfs(struct mhi_controller *mhi_cntrl)
+{
+	sysfs_remove_group(&mhi_cntrl->mhi_dev->dev.kobj, &mhi_sysfs_group);
+}
+
 /* MHI protocol requires the transfer ring to be aligned with ring length */
 static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
 				  struct mhi_ring *ring,
@@ -917,6 +967,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	mhi_cntrl->mhi_dev = mhi_dev;
 
 	mhi_create_debugfs(mhi_cntrl);
+	if (mhi_create_sysfs(mhi_cntrl))
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to create sysfs entries\n");
 
 	return 0;
 
@@ -940,6 +992,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
 	unsigned int i;
 
+	mhi_destroy_sysfs(mhi_cntrl);
 	mhi_destroy_debugfs(mhi_cntrl);
 
 	kfree(mhi_cntrl->mhi_cmd);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

