Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54872C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B21020728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNmMCJFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEOFfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbgEOFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:35:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79043C05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y8so1397312ybn.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUCHt3IUTaAuIZ5RcDy4DbI7lEInPDSWSCSV1x0aJWU=;
        b=NNmMCJFsnc8QFuD5OYt292G7roqEzHRNUYulBcoESHwmzCM16suaXcwxL7JDzWuXay
         Dz81ANTMnpkXBwhmnbiMvHbNioUQM/0Jpu3HXydj063az53GvyNz/ybUZi60vtEftqsX
         5y3CuDlXPN0VWTHOizdO8em6WneEBZOh05j/7gzZ+EyL4MN+N+nBFKGcWK9B06gY26KJ
         EGI22WFBwOcvhbXCvYFfJ+BLuzRTTJq8pGhTf0uMvGUdpHIb43ZqlK9z+ik7oP4ePFz0
         M6M70Lurbci12BP0XFdJqAvYdNFGYV/6XA+xhipiiPq+tnAWLrAKkNFkoATNHlcwVIG2
         kS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUCHt3IUTaAuIZ5RcDy4DbI7lEInPDSWSCSV1x0aJWU=;
        b=eLu4gjbzeFRqF4cM5mOkZC06n6Zr/+R84j4z/3wIBeKLizwx1UT4u2OnxOg5KBkVJd
         Tf0xpH65lf3Z3M+4//gLCnpHizjJE+CMkHxZGzsPor2MvCngCKbFkstBFkYtYIoEogoO
         zC/cqdqIiNunAqbY+ZwSNKKfiz3a3MaQSXT5hruM7KOXb/Ez/75C52G88Nvz0p/13ozr
         q0iHoRAqHogvIMWJolWX5g1PyorETEAzvWFlr1/pYnaDfAteqc2PiW2G6zZJ97UlkVZt
         gufRQrLmoOB6hH5NI2lmwNPhHrtVbIoGqE9ldQjs6f4sHCxiCvzMn06A16UNoQvwUiMU
         TFAA==
X-Gm-Message-State: AOAM531yRbjfJfhcn7l06zY7snqikZ1R2ew+kVaFAmJcH9SIhbbvQEpD
        Q5Ahqnlhcv0xVp6zmD2mFLahENMEcADN9Fo=
X-Google-Smtp-Source: ABdhPJz5Il4KBtVez3mKTqB6IUL3C6pYb+iGjAt2GhlZ7PEp1DIpmYHxcPfv+5v4AeIr7I9PrnjCEiAD3DCPmSY=
X-Received: by 2002:a25:ba8b:: with SMTP id s11mr2591447ybg.310.1589520908664;
 Thu, 14 May 2020 22:35:08 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:58 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 2/4] driver core: Look for waiting consumers only for a
 fwnode's primary device
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4dbe191c046e ("driver core: Add device links from fwnode only for
the primary device") skipped linking a fwnode's secondary device to
the suppliers listed in its fwnode.

However, a fwnode's secondary device can't be found using
get_dev_from_fwnode(). So, there's no point in trying to see if devices
waiting for suppliers might want to link to a fwnode's secondary device.

This commit removes that unnecessary step for devices that aren't a
fwnode's primary device and also moves the code to a more appropriate
part of the file.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b454aae64b5..f585d92e09d0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1173,6 +1173,21 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
 }
 
+static void fw_devlink_link_device(struct device *dev)
+{
+	int fw_ret;
+
+	device_link_add_missing_supplier_links();
+
+	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
+		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
+		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
+			device_link_wait_for_mandatory_supplier(dev);
+		else if (fw_ret)
+			device_link_wait_for_optional_supplier(dev);
+	}
+}
+
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
@@ -2407,7 +2422,7 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
-	int error = -EINVAL, fw_ret;
+	int error = -EINVAL;
 	struct kobject *glue_dir = NULL;
 	bool is_fwnode_dev = false;
 
@@ -2524,16 +2539,8 @@ int device_add(struct device *dev)
 	 * waiting consumers can link to it before the driver is bound to the
 	 * device and the driver sync_state callback is called for this device.
 	 */
-	device_link_add_missing_supplier_links();
-
-	if (fw_devlink_flags && is_fwnode_dev &&
-	    fwnode_has_op(dev->fwnode, add_links)) {
-		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
-			device_link_wait_for_mandatory_supplier(dev);
-		else if (fw_ret)
-			device_link_wait_for_optional_supplier(dev);
-	}
+	if (is_fwnode_dev)
+		fw_devlink_link_device(dev);
 
 	bus_probe_device(dev);
 	if (parent)
-- 
2.26.2.761.g0e0b3e54be-goog

