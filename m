Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2624C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80736207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="b+T/oLYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFMTFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:05:48 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36854 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFMTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:05:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kn9k2lXKz9vYjY
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kWRdSWOyIsVE for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 14:05:46 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kn9k15j1z9v90G
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:05:46 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kn9k15j1z9v90G
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kn9k15j1z9v90G
Received: by mail-il1-f198.google.com with SMTP id x63so8932181ilk.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o2FOKEQ94D1GV7+5LNDHjuMFh+VY1uzX12Wnv43ZbD8=;
        b=b+T/oLYviKv/mte4B9pdAcQFXVhNY69kXPGrXUU38u3BOUFasXoyr1Kgej9HVkzXxs
         Ij8d+SfMB2q4QSeN+DyIfLyqpKAcKYYprE5PYt89EyliIe+dP6nEL/71vhcZxEuT6y04
         Q3dwBhcpiRRKbpkVWBIHSyEQjrfJbsdW8e0idsDZLGLlJEDjM6LmHO3WP1o1xA2l6uuC
         RbkC6vl793qCKGP3gEEO9lov999q5Wxe7GsBCkrkX2t1lVYG+PUxmNv9VPVyC1ETO0g5
         d82C1xJlw0XCNEIVoziCsfKDJrBoADvu2ELiZ09FPnNJykyk4gPnxGQjoT5eQw9aFedp
         ua0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o2FOKEQ94D1GV7+5LNDHjuMFh+VY1uzX12Wnv43ZbD8=;
        b=a2RE3fZ58n2fqEXL6ojCZRe8MdBxHumbOaPbb1AXeMsdALA+gLd91m9qHByn0t9/kp
         yFFJfuyfDFDjidad0UpWvKZ853ubgKKkxlT4TTzs+2ntE4Dh5pQ3u5ISgKmRUn1YVJwK
         B0RbEEWian/QZilMdjjX2FUJYD4UV4kAyJlNCfjIzZHNHf2LE5cRATFBv8IlSz4xZmGw
         bX0OnJiExmGfYwobCsgyRrXQTvbVbVUByrxi1eBDZwJFM5S4nON1IHEq/PPQnSOBVmJf
         mhFhzTluPgKR/qlmVRqfdUAvra1D4Qct5UedyDUwg2t4BdshCpkdVwxE5N8BY/G0I13Y
         N0OA==
X-Gm-Message-State: AOAM533uQHevlP4SMUXxLfuMsMfF37jrpnU75ggsVKNs8HUQfaot29ot
        wz2PobDdNfTzE3rOWLw0y1f22KEnaOCxjqu/Z5e8g8NZQthGZt+kwHBS5TcQzQd9ooN0RrsED2p
        w1Qd9Dqnc+B1WkVVoXTpvcJiLmNkl
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr18359194ili.280.1592075145379;
        Sat, 13 Jun 2020 12:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8tFjRdEjUHCtUKGBzZRi4tcOgtgzZ46cDKJIORr6RvgnfT0GzOC80OcYvuDHb06XXjU6pcA==
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr18359175ili.280.1592075145066;
        Sat, 13 Jun 2020 12:05:45 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id r17sm5194889ilc.33.2020.06.13.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:05:44 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 14:05:33 -0500
Message-Id: <20200613190533.15712-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Callback function fw_cfg_sysfs_release_entry() in kobject_put()
can handle the pointer "entry" properly.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/qemu_fw_cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 039e0f91dba8..6945c3c96637 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -605,8 +605,10 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
 				   fw_cfg_sel_ko, "%d", entry->select);
-	if (err)
-		goto err_register;
+	if (err) {
+		kobject_put(&entry->kobj);
+		return err;
+	}
 
 	/* add raw binary content access */
 	err = sysfs_create_bin_file(&entry->kobj, &fw_cfg_sysfs_attr_raw);
@@ -622,7 +624,6 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 
 err_add_raw:
 	kobject_del(&entry->kobj);
-err_register:
 	kfree(entry);
 	return err;
 }
-- 
2.17.1

