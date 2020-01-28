Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CA424699
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221491;
	bh=Jl/m6jnZp9jCJNCIyANC8hoEDN1lD6koiO7lkxw94EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dGDKgq0iEREmslRLtAb1Akvb+8ym+rY73qkw/tazvAdrPA9MKjBu3TGurpV4T9Dil
	 wtnEFqXOG+Z5px8ccCCBPFMETW08RplwSVO5x5oXIa4ao9g7EUJ2Sh8aq9DUmcCw4l
	 iamYKCpgSPvykEl73z45h56jb52NYCvKTVxnR8ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbgA1OYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732757AbgA1OYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8393124690;
        Tue, 28 Jan 2020 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221485;
        bh=Jl/m6jnZp9jCJNCIyANC8hoEDN1lD6koiO7lkxw94EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0YRoWhVoaVl7JodfndaXQceWJN06sOvrPDAqDGCbD94Mwoi1lg5wPJnZz6K27k78U
         sU7Ff1ERyK/C2uW1EYm4dtCMX2pkuDrzZZveYb6P1OuOokjiNS4h6OJbCe+7lpQWNI
         q7OxIyuygflyoJigAw+D07p/dIgBV7k32Oo4EG4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 244/271] hwmon: (core) Simplify sysfs attribute name allocation
Date:   Tue, 28 Jan 2020 15:06:33 +0100
Message-Id: <20200128135910.690862660@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

commit 3a412d5e4a1c831723d0aaf305f1cf9a78ad9c90 upstream.

Allocating the sysfs attribute name only if needed and only with the
required minimum length looks optimal, but does not take the additional
overhead for both devm_ data structures and the allocation header itself
into account. This also results in unnecessary memory fragmentation.
Move the sysfs name string into struct hwmon_device_attribute and give it
a sufficient length to reduce this overhead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/hwmon.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -38,12 +38,15 @@ struct hwmon_device {
 
 #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
 
+#define MAX_SYSFS_ATTR_NAME_LENGTH	32
+
 struct hwmon_device_attribute {
 	struct device_attribute dev_attr;
 	const struct hwmon_ops *ops;
 	enum hwmon_sensor_types type;
 	u32 attr;
 	int index;
+	char name[MAX_SYSFS_ATTR_NAME_LENGTH];
 };
 
 #define to_hwmon_attr(d) \
@@ -232,20 +235,18 @@ static struct attribute *hwmon_genattr(s
 	if ((mode & S_IWUGO) && !ops->write)
 		return ERR_PTR(-EINVAL);
 
+	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
+	if (!hattr)
+		return ERR_PTR(-ENOMEM);
+
 	if (type == hwmon_chip) {
 		name = (char *)template;
 	} else {
-		name = devm_kzalloc(dev, strlen(template) + 16, GFP_KERNEL);
-		if (!name)
-			return ERR_PTR(-ENOMEM);
-		scnprintf(name, strlen(template) + 16, template,
+		scnprintf(hattr->name, sizeof(hattr->name), template,
 			  index + hwmon_attr_base(type));
+		name = hattr->name;
 	}
 
-	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
-	if (!hattr)
-		return ERR_PTR(-ENOMEM);
-
 	hattr->type = type;
 	hattr->attr = attr;
 	hattr->index = index;


