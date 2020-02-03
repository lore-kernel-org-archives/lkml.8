Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3C5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602132086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747336;
	bh=UmTtnumsIbudmB10u01PZpWIg9gxzUqeyXo+ysuvURw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1gU6m4muXbrPwVLfIELAhvZBfs/WHKdVmE2D2nilsrADRQ00t7BPlBSv9pvdcxO4
	 B4T6F8x4aBlJ3JtldCJllE8qwJl1uYZEEmOwRufrmDoZpXZl7i0rM7gxeLonopo6FJ
	 SFiGsmuJ0p3ij8nE8b2F5Qm7Epj7o2aAqhZHTePw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBCQ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbgBCQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:28:50 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DA720838;
        Mon,  3 Feb 2020 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747330;
        bh=UmTtnumsIbudmB10u01PZpWIg9gxzUqeyXo+ysuvURw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC4g++0J3O+cksqrT2I8DyXTUO/5+Hs7rwBoUqCFAH/DwKpEjltmpSxLiQrRiyVJJ
         iaX13UeDCi8429P0s+rLNC7gRLT/V0UH25qIgtqFUj9d9R18d7UEypTlUYI44iikkX
         dAv1tvaLjEr/C8QjBJppOGigc2b7J7pcb6D69O44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.14 39/89] PM / devfreq: Add new name attribute for sysfs
Date:   Mon,  3 Feb 2020 16:19:24 +0000
Message-Id: <20200203161922.221278903@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

commit 2fee1a7cc6b1ce6634bb0f025be2c94a58dfa34d upstream.

The commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
sysfs") changed the node name to devfreq(x). After this commit, it is not
possible to get the device name through /sys/class/devfreq/devfreq(X)/*.

Add new name attribute in order to get device name.

Cc: stable@vger.kernel.org
Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/testing/sysfs-class-devfreq |    7 +++++++
 drivers/devfreq/devfreq.c                     |    9 +++++++++
 2 files changed, 16 insertions(+)

--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -7,6 +7,13 @@ Description:
 		The name of devfreq object denoted as ... is same as the
 		name of device using devfreq.
 
+What:		/sys/class/devfreq/.../name
+Date:		November 2019
+Contact:	Chanwoo Choi <cw00.choi@samsung.com>
+Description:
+		The /sys/class/devfreq/.../name shows the name of device
+		of the corresponding devfreq object.
+
 What:		/sys/class/devfreq/.../governor
 Date:		September 2011
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -902,6 +902,14 @@ err_out:
 }
 EXPORT_SYMBOL(devfreq_remove_governor);
 
+static ssize_t name_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct devfreq *devfreq = to_devfreq(dev);
+	return sprintf(buf, "%s\n", dev_name(devfreq->dev.parent));
+}
+static DEVICE_ATTR_RO(name);
+
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -1200,6 +1208,7 @@ static ssize_t trans_stat_show(struct de
 static DEVICE_ATTR_RO(trans_stat);
 
 static struct attribute *devfreq_attrs[] = {
+	&dev_attr_name.attr,
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
 	&dev_attr_cur_freq.attr,


