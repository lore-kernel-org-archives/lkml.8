Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01EA2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fq6caj6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgCaC2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:28:40 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:36182 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgCaC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:28:39 -0400
Received: by mail-yb1-f202.google.com with SMTP id u1so7682808ybm.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=wcHOUyNyWvsDheDbqs/1406ENgHkhru6zuh5wukvqu8=;
        b=fq6caj6e0DkW061ixX2SM9kwK/+hjZ8IPJCPmJ4gLtZze89R54Nd5KVdDnFKdTEKU1
         8qciiW70D4PrgYex6q3V3EVtwkNOFeof1onnGeF1xprFJz1ZIJ9Z9bMRXBDnnjci9+Hm
         qTPKGNhcgnHYQxhiq4qsUHIJjqEuRPRhgbDKGtFTnV1mT8l3FfsNcgHS5SGV8dj5oAZj
         PyoA2U8XsjF8cfBNWAhHMFTGTgjLrOYAqxVHcfwe0/PZlkBI4TseGKD6y6/SgIybByRc
         TJQB9Dr8xaFqKfz9E6eI+zkoq+JhK1JBbm/089GQT1j+pzQ87BfFm7Pc7OxzEMMjik+N
         kKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=wcHOUyNyWvsDheDbqs/1406ENgHkhru6zuh5wukvqu8=;
        b=nPJYLvKq3hWGB0jCCIWkkCxL5SNjQDxntu/uRwJeYxpCeOXVlhAhOxMHFMKFWBR3oe
         HwWJpYKXVsu29QPfSlZFr870zoBHiVjH/oAuBS+HERfnPpihjOygMv8356swMEwWf/se
         MwyKCQ1m0CzRiyFy2IeJ+fENEAwqlvf7YF+muJtOm9BYYRT2sZbVRc8hJqDl1PDKM7MD
         k6xQjBbG5PTYcJ1VUIi9eaQYHYO9cAcQk/PFq4Xmi0ttzJqqL0XUF/JUVn3c3ORTr/ld
         agJJTRrvPKzqoKLOTr5UKXPk3XIG9fGOcCCMFTqiidLYyxshqqoTsGQ5ZzwKiylSa6Lj
         Or/Q==
X-Gm-Message-State: ANhLgQ39JAjQMcDIYsEHkEi3fOQvsscNVrVjq+SosxIddXzETAxjM7t/
        W/mavlcDJAX3GlpVcegHDAjTXJYI6/h25XE=
X-Google-Smtp-Source: ADFU+vvVs8cPkJsMZgfz9suRZZsRYAjo7ErBqpuhJ8If7QApLS5BPo1lpVF5tun2tbzfFFAKQBydj6JBilhb3hU=
X-Received: by 2002:a25:9d8f:: with SMTP id v15mr23139034ybp.49.1585621718137;
 Mon, 30 Mar 2020 19:28:38 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:28:32 -0700
In-Reply-To: <CAGETcx9nhF4hjs6BQ21Ees4LJLM7kENj6Ja619Sonjvvt1o7wA@mail.gmail.com>
Message-Id: <20200331022832.209618-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
commandline option") added fw_devlink, it didn't implement "permissive"
mode correctly.

That commit got the device links flags correct to make sure unprobed
suppliers don't block the probing of a consumer. However, if a consumer
is waiting for mandatory suppliers to register, that could still block a
consumer from probing.

This commit fixes that by making sure in permissive mode, all suppliers
to a consumer are treated as a optional suppliers. So, even if a
consumer is waiting for suppliers to register and link itself (using the
DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
blocked from probing.

Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Hi Marek,

If you pull in this patch and then add back in my patch that created the
boot problem for you, can you see if that fixes the boot issue for you?

Thanks,
Saravana

 drivers/base/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5e3cc1651c78..1be26a7f0866 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2370,6 +2370,11 @@ u32 fw_devlink_get_flags(void)
 	return fw_devlink_flags;
 }
 
+static bool fw_devlink_is_permissive(void)
+{
+	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
+}
+
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
@@ -2524,7 +2529,7 @@ int device_add(struct device *dev)
 	if (fw_devlink_flags && is_fwnode_dev &&
 	    fwnode_has_op(dev->fwnode, add_links)) {
 		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV)
+		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
 			device_link_wait_for_mandatory_supplier(dev);
 		else if (fw_ret)
 			device_link_wait_for_optional_supplier(dev);
-- 
2.26.0.rc2.310.g2932bb562d-goog

