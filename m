Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13AC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A7924696
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e/FbEKVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgB0Lbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:31:34 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40730 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728966AbgB0Lbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:33 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CADA1C0F39;
        Thu, 27 Feb 2020 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582803093; bh=g1PNO3dJwapptFFDIh94Tq3o6pR2tpjxuF2ZTzqCpQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=e/FbEKVO3uUAhW35HLE3UQQMuPOCPLX/uZojqRUIr5iCZ06DlOcAHPT1pLDS9dk1s
         XXdvqpCWEhwHva9WR/nuOe3aykLPC71mJvosJulSktwQruEaS6DuCBYCtPbX/ohugy
         syUjLN78NP6Daq9YoKM5+r9aPkEo/aGPFe6jcgsMibEAjPBcO3DUeM34tXtKq93xTP
         RrLPBZBmeuCQheBy8u95FRjhtfXZUCADjs7ezByPbYQTOFa+GLJmc8V6kZjZLrT7A0
         T+yL04MmPRZLj2qVtTcUCD4JvVVOALBxKzIi0aQ4Eosg/d2hRmdWEjjTd7gH9sFl/I
         IspoVc4sQmJ+w==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 87526A005F;
        Thu, 27 Feb 2020 11:31:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 6C9633E9E4;
        Thu, 27 Feb 2020 12:31:26 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 2/4] i3c: Add modalias sysfs attribute
Date:   Thu, 27 Feb 2020 12:31:07 +0100
Message-Id: <a90f64f830128cd12762153de7828b775574c156.1582796652.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create modalias sysfs attribute for modalias devices.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b6db828..925e1ed 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -241,12 +241,34 @@ static ssize_t hdrcap_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(hdrcap);
 
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *da, char *buf)
+{
+	struct i3c_device *i3c = dev_to_i3cdev(dev);
+	struct i3c_device_info devinfo;
+	u16 manuf, part, ext;
+
+	i3c_device_get_info(i3c, &devinfo);
+	manuf = I3C_PID_MANUF_ID(devinfo.pid);
+	part = I3C_PID_PART_ID(devinfo.pid);
+	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
+
+	if (I3C_PID_RND_LOWER_32BITS(devinfo.pid))
+		return sprintf(buf, "i3c:dcr%02Xmanuf%04X", devinfo.dcr,
+			       manuf);
+
+	return sprintf(buf, "i3c:dcr%02Xmanuf%04Xpart%04Xext%04X",
+		       devinfo.dcr, manuf, part, ext);
+}
+static DEVICE_ATTR_RO(modalias);
+
 static struct attribute *i3c_device_attrs[] = {
 	&dev_attr_bcr.attr,
 	&dev_attr_dcr.attr,
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_modalias.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_device);
-- 
2.7.4

