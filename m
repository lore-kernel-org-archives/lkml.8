Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4636C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83772086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvoIrwwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbgEZTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389149AbgEZTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:43:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C6C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:43:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i190so21822093ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=NB9RZ9RdGXFtR3wmsPCT6ld5ryX9VoyfJ5DeVtdIcp4=;
        b=DvoIrwwa78TAogla+2FdL0rlzEgjXB4Rktgb0EQfAjrM3lcuA3qcnO5ktM4NJonKRb
         r/T8uZVm+rcjvnuqzBHnXluB89n/xQ+zMmkEpEa9XRatFZCfA8MZB2gsF8x/FHtHkYJJ
         x0h0LZyuiiUZf5q8fkaq5Dyrrinm6JiQYECdF58MCZFD8RYBk7dNqFG7Yv+09E3PsukJ
         EdGm/bUl1VEnfOl4pWIKP3OAOLtBpuAadyf9Q4Hhrz7mxDNNWRrFrDiRdE4RQUWhcyPO
         r3prxi/Y8vIlVbJOu7n3n0ZNGXS1pcBOVycAw9PGtgZY3Na3CC1Ovk728BeQGCAHJgTM
         Q8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=NB9RZ9RdGXFtR3wmsPCT6ld5ryX9VoyfJ5DeVtdIcp4=;
        b=oIgicTHaB6DYemOkZREiJYLinmr9erPX3J4Y+f6QACCCKIbnx+XsiRMW98OB9tn3RK
         DiY0Q8ZMM6sxoEQGf7VXyUTpAJw39UOfWunZ13PRptqO1/vj6lZ4RyUr7vJgcEIbR+jS
         5d63TBiRuPcsBH3yGsND3jOtBRiFuuGnCDcdeqMS67zZbxo5c+I+jnVKz2PkMMN23Zkf
         Xlw95Mg4+yCoWCYRqkhmI3J6tMBodAImn3diXNkJoHjKay86QswCXL3uLhnTKtKjaMsN
         HXEsm95Ohy9M0WARBEwYvf4xI3npKYemxUV//f7qPgtJMcQXHffZGPd0/ZJnVlF3YV3g
         X56w==
X-Gm-Message-State: AOAM532T+9sCLjkzh9HWSn2DIhAkrvgsYkka2O4De9CrXzWKA7Spf0pi
        5332N6IjiktNTRghpfZHjR5KH4A6jVgCtWs=
X-Google-Smtp-Source: ABdhPJw1fzBBUe7e46QkrW4zeZNwEH2qryRHXS1NUbIAjeMeDUYPkZVrk34n/VXE9bqbU5HulxGFA9gSaEqHbUo=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr4152627ybp.227.1590522226385;
 Tue, 26 May 2020 12:43:46 -0700 (PDT)
Date:   Tue, 26 May 2020 12:43:28 -0700
In-Reply-To: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc>
Message-Id: <20200526194328.258722-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Michael Walle <michael@walle.cc>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
core: Add device link support for SYNC_STATE_ONLY flag"),
SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
of not blocking consumer probe if the supplier hasn't probed yet.

That caused a SYNC_STATE_ONLY device link's status to not get updated.
Since SYNC_STATE_ONLY device link is no longer useful once the
consumer probes, commit 21c27f06587d ("driver core: Fix
SYNC_STATE_ONLY device link implementation") addresses the status
update issue by deleting the SYNC_STATE_ONLY device link instead of
complicating the status update code.

However, there are still some cases where we need to update the status
of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
device link can later get converted into a normal MANAGED device link
when a normal MANAGED device link is created between a supplier and
consumer that already have a SYNC_STATE_ONLY device link between them.

If a SYNC_STATE_ONLY device link's status isn't maintained correctly
till it's converted to a normal MANAGED device link, then the normal
MANAGED device link will end up with a wrong link status. This can cause
a warning stack trace[1] when the consumer device probes successfully.

This commit fixes the SYNC_STATE_ONLY device link status update issue
where it wouldn't transition correctly from DL_STATE_DORMANT or
DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the status
back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
fails.

[1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

v1->v2:
- Added code to "revert" the link status if consumer probe fails

Greg,

I think this is the issue Michael ran into. I'd like him to test the fix
before it's pulled in.

Michael,

If you can test this on the branch you saw the issue in and give a
Tested-by if it works, that'd be great.

Thanks,
Saravana

 drivers/base/core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791b7530599f..a3d7e2318b5f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -646,9 +646,17 @@ static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node)
-		if (link->status == DL_STATE_CONSUMER_PROBE)
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (link->status != DL_STATE_CONSUMER_PROBE)
+			continue;
+
+		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+		} else {
+			WARN_ON(!(link->status & DL_FLAG_SYNC_STATE_ONLY));
+			WRITE_ONCE(link->status, DL_STATE_DORMANT);
+		}
+	}
 }
 
 /**
@@ -687,11 +695,11 @@ int device_links_check_suppliers(struct device *dev)
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_MANAGED) ||
-		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
+		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
 
-		if (link->status != DL_STATE_AVAILABLE) {
+		if (link->status != DL_STATE_AVAILABLE &&
+		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			device_links_missing_supplier(dev);
 			ret = -EPROBE_DEFER;
 			break;
@@ -952,11 +960,21 @@ static void __device_links_no_driver(struct device *dev)
 		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
 
-		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
 			device_link_drop_managed(link);
-		else if (link->status == DL_STATE_CONSUMER_PROBE ||
-			 link->status == DL_STATE_ACTIVE)
+			continue;
+		}
+
+		if (link->status != DL_STATE_CONSUMER_PROBE &&
+		    link->status != DL_STATE_ACTIVE)
+			continue;
+
+		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+		} else {
+			WARN_ON(!(link->status & DL_FLAG_SYNC_STATE_ONLY));
+			WRITE_ONCE(link->status, DL_STATE_DORMANT);
+		}
 	}
 
 	dev->links.status = DL_DEV_NO_DRIVER;
-- 
2.27.0.rc0.183.gde8f92d652-goog

