Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF124C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B411206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgEVMuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:50:05 -0400
Received: from foss.arm.com ([217.140.110.172]:34898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgEVMuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0461063;
        Fri, 22 May 2020 05:50:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16E1C3F68F;
        Fri, 22 May 2020 05:50:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] base: soc: Add JEDEC JEP106 manufacturer's identification code attribute
Date:   Fri, 22 May 2020 13:49:50 +0100
Message-Id: <20200522124951.35776-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522124951.35776-1-sudeep.holla@arm.com>
References: <20200522124951.35776-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
SiP defined SoC identification value. Indeed of making it custom
attribute, let us add the same as generic attribute to soc_device.

There are various ways in which it can be represented in shortened form
for efficiency and ease of parsing for userspace. The chosen form is
described in the ABI document.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/ABI/testing/sysfs-devices-soc | 31 +++++++++++++++++++++
 drivers/base/soc.c                          | 12 ++++++++
 include/linux/sys_soc.h                     |  1 +
 3 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index ba3a3fac0ee1..fd44c9b1e09a 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -54,6 +54,37 @@ contact:	Lee Jones <lee.jones@linaro.org>
 		Read-only attribute supported ST-Ericsson's silicon. Contains the
 		the process by which the silicon chip was manufactured.
 
+What:		/sys/devices/socX/jep106_identification_code
+Date:		June 2020
+Contact:	Sudeep Holla <sudeep.holla@arm.com>
+Description:
+		Read-only attribute supported on many of ARM based silicon
+		with SMCCC v1.2+ compliant firmware. Contains the JEDEC
+		JEP106 manufacturer’s identification code.
+
+		This manufacturer’s identification code is defined by one
+		or more eight (8) bit fields, each consisting of seven (7)
+		data bits plus one (1) odd parity bit. It is a single field,
+		limiting the possible number of vendors to 126. To expand
+		the maximum number of identification codes, a continuation
+		scheme has been defined.
+
+		The specified mechanism is that an identity code of 0x7F
+		represents the "continuation code" and implies the presence
+		of an additional identity code field, and this mechanism
+		may be extended to multiple continuation codes followed
+		by the manufacturer's identity code.
+
+		For example, ARM has identity code 0x7F 0x7F 0x7F 0x7F 0x3B,
+		which is code 0x3B on the fifth 'page'. This can be shortened
+		as JEP106 identity code of 0x3B and a continuation code of
+		0x4 to represent the four continuation codes preceding the
+		identity code.
+
+		This property represents it in the shortened form:
+		8-bit continuation code followed by 8 bit identity code
+		without the parity bit.
+
 What:		/sys/bus/soc
 Date:		January 2012
 contact:	Lee Jones <lee.jones@linaro.org>
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 4af11a423475..44dc757aadf4 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -36,6 +36,7 @@ static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(jep106_identification_code, S_IRUGO, soc_info_get,  NULL);
 
 struct device *soc_device_to_device(struct soc_device *soc_dev)
 {
@@ -64,6 +65,9 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 	if ((attr == &dev_attr_soc_id.attr)
 	    && (soc_dev->attr->soc_id != NULL))
 		return attr->mode;
+	if ((attr == &dev_attr_jep106_identification_code.attr)
+	    && (soc_dev->attr->jep106_id != NULL))
+		return attr->mode;
 
 	/* Unknown or unfilled attribute. */
 	return 0;
@@ -85,6 +89,8 @@ static ssize_t soc_info_get(struct device *dev,
 		return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
 	if (attr == &dev_attr_soc_id)
 		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+	if (attr == &dev_attr_jep106_identification_code)
+		return sprintf(buf, "%s\n", soc_dev->attr->jep106_id);
 
 	return -EINVAL;
 
@@ -96,6 +102,7 @@ static struct attribute *soc_attr[] = {
 	&dev_attr_serial_number.attr,
 	&dev_attr_soc_id.attr,
 	&dev_attr_revision.attr,
+	&dev_attr_jep106_identification_code.attr,
 	NULL,
 };
 
@@ -214,6 +221,11 @@ static int soc_device_match_attr(const struct soc_device_attribute *attr,
 	    (!attr->soc_id || !glob_match(match->soc_id, attr->soc_id)))
 		return 0;
 
+	if (match->jep106_id &&
+	    (!attr->jep106_id ||
+	     !glob_match(match->jep106_id, attr->jep106_id)))
+		return 0;
+
 	return 1;
 }
 
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index d9b3cf0f410c..394fa70ae16f 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -14,6 +14,7 @@ struct soc_device_attribute {
 	const char *revision;
 	const char *serial_number;
 	const char *soc_id;
+	const char *jep106_id;
 	const void *data;
 	const struct attribute_group *custom_attr_group;
 };
-- 
2.17.1

