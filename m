Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477A92074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUZpHqIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgEPIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726958AbgEPIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:07:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD6C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 01:07:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n33so5146343qtd.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m6FXJWTVjdVibVnBuvWq7S2FSfO+tv4HQu2DRpDNQEM=;
        b=OUZpHqIacF0EjlyoeZty3BJIuBBUFJITwSRluRMVLb36uvGl11S9Y2e+3NLT9N4SJ+
         eA7xLL8KvYBTlr+5i5yPmxHUCnXLou+MI812JH79Mm2DM/sAKxRP/bwbNR3QrQ6PkKhi
         fXyFzc9WmhI9vf06/kp3aKMBSHqJvuI5DQ+h0FE/BwJCCdDqFtnAO+qwVtBSA2cWpRM4
         qiE/+7bjH3b8esojgR5uxeFGKPSsceuAiadaD1IlWnl6l4jgel2i1iF3EwtHLmrfiedw
         MAfOi2X7djt+HafR/evWSM01IWDwEiXtpoaFGCPu/iFJ/rtD03fC6iyCHZcniGwB3VRc
         hBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m6FXJWTVjdVibVnBuvWq7S2FSfO+tv4HQu2DRpDNQEM=;
        b=GrO3Mis3f8WIxqFVY4TbUKdRd3YUweWF0wDDMdbSe26mApR53TjCf/c2tOE8c9FC1d
         kcqQ/18HnSwDPpRnO6VnqY57M1z+iJ7dkQCaCXBGk67WeIhGciuEbS+Oqko+wQp23m1J
         EcWSoTk/iZr0X5hzYp491IY6z/CscK61/WS17JCYWFd3nmYdpL7gj+5NXL5wvkkGj+Bh
         7RzLw2xkYZtsWqIxmb9iIneJ/yF/u8CcZGyv5FwQ5dfF1X9UEz8qw87IQe9tnGsduViD
         HGxLTO2jQ0tb/qqZyRAnbKUKdehFYMqDu/jVNNIeB/TpaQpLSROQxCau7DwbmuoTVrD6
         1eag==
X-Gm-Message-State: AOAM530KZtFn+WM3hutKumvFhJ2DcrIZEiMNMWbER2pIrPgnVWY8M3mq
        HDL0ciPkJQy3f0LmbLPQTk4jiHjW9A+ug8E=
X-Google-Smtp-Source: ABdhPJx18LwhURFMw6en0MLHSwDPcau1vDqd0MZzLikef5cQQL1JC0nc7/3sNdzSBXAFw67BkXXw3p6jshvPIp4=
X-Received: by 2002:a0c:a619:: with SMTP id s25mr7145926qva.21.1589616442680;
 Sat, 16 May 2020 01:07:22 -0700 (PDT)
Date:   Sat, 16 May 2020 01:07:18 -0700
Message-Id: <20200516080718.166676-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1] driver core: Fix memory leak when adding SYNC_STATE_ONLY
 device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     stable@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
core: Add device link support for SYNC_STATE_ONLY flag"),
device_link_add() incorrectly skipped adding the new SYNC_STATE_ONLY
device link to the supplier's and consumer's "device link" list. So the
"device link" is lost forever from driver core if the caller didn't keep
track of it (typically isn't expected to).

If the same SYNC_STATE_ONLY device link is created again using
device_link_add(), instead of returning the pointer to the previously
created device link, a new device link is created and returned. This can
cause memory leaks in conjunction with fw_devlinks.

Cc: stable@vger.kernel.org
Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 84c569726d75..d36e9289b2df 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -436,12 +436,16 @@ struct device_link *device_link_add(struct device *consumer,
 	    flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_resume(supplier);
 
+	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
+	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
+
 	if (flags & DL_FLAG_SYNC_STATE_ONLY) {
 		dev_dbg(consumer,
 			"Linked as a sync state only consumer to %s\n",
 			dev_name(supplier));
 		goto out;
 	}
+
 reorder:
 	/*
 	 * Move the consumer and all of the devices depending on it to the end
@@ -452,12 +456,9 @@ struct device_link *device_link_add(struct device *consumer,
 	 */
 	device_reorder_to_tail(consumer, NULL);
 
-	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
-	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
-
 	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
 
- out:
+out:
 	device_pm_unlock();
 	device_links_write_unlock();
 
-- 
2.26.2.761.g0e0b3e54be-goog

