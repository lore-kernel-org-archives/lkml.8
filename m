Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DFF208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4zrrqUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbgEZWJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgEZWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:09:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:09:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e8so2637138qtq.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=76RnCrYuIkxjPD/67W4gWQzeBexPbh4E4FGax1pg7M8=;
        b=v4zrrqUCHGjAdSRZM8NUPTODZaC9BulTFTPNq4ikigV9FNcXtVQAVGLhc8M36bhvwM
         X/ShDKCg/PBndpbavZqQCgT/GSTPKKjFedavuiBfn4wg7HZp1o8sPwSCohXErk/nyE62
         DEI61v5Gepabha43pMC72mKQmQ6vlUKD7JQmpno/x8Y5YxXPlzAEU1PqNlQ6z9jN1ea3
         izE8HTWlJANcpx8BrsLedFpwNLvMpfGyXhukAsS8HL/oinP+pIm6tfF5KwFatdpkvg8Z
         pjp3G5NO+/9RtopQxKyEEXeND71MEhLCgg2PT4iKupbLZIKaKn29JJ93YyS1bGrP0/V+
         Q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=76RnCrYuIkxjPD/67W4gWQzeBexPbh4E4FGax1pg7M8=;
        b=ThywOYtKFGXf/x8Rcg8JH7UVHsEUC1gSfCjP4SXtnoNWIPBcIpZp24SdalymzH88FR
         ZLzFP8cMKlCf0i2eiEHuvDDDAsEstnhmKoo6m2BOdi4ijW6dBCaj5GERSvF1ct+emi0B
         dQy2tV4nyMDgKhW9iT82ySPbSWB2O+5JOLnFb5Avm+tdQksWJS329pJNxhylxm/yaows
         z3AlyXNE0gZFGu4oqtEEEaXTcaKfEZKKaaHr2Tl+tYgAm6rCNzw030HUQtFBimgnQPcO
         JSPTk5egJLFn0VUd2SxH4gzBy4ynd0NKS2Jqb9Mn5BPB7jgKn/S2t7Kfm8cx2+ZYCHXS
         +y9Q==
X-Gm-Message-State: AOAM533rn8ejZKgJ1HFTNNoBxJgaO+CZoZL++dVbSpWfIa05JM6LDsTE
        p0lhrckj5FLvFupCF8WI1tFkkCnxjsDLxCU=
X-Google-Smtp-Source: ABdhPJwd/fhrf0rDUhLOAH8yaPymFMnZy4V2MHeWC/+UdErTwcsr+XenVM4ID8s4+rLSowndXcEYmrAnon+uWW0=
X-Received: by 2002:a0c:8b99:: with SMTP id r25mr20979191qva.174.1590530972841;
 Tue, 26 May 2020 15:09:32 -0700 (PDT)
Date:   Tue, 26 May 2020 15:09:27 -0700
In-Reply-To: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc>
Message-Id: <20200526220928.49939-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3] driver core: Update device link status correctly for
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
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
v1->v2:
- Added code to "revert" the link status if consumer probe fails

v2->v3:
- Fixed copy-pasta where I was checking link->status instead of
  link->flags.

 drivers/base/core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791b7530599f..9a76dd44cb37 100644
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
+			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
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
+			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+			WRITE_ONCE(link->status, DL_STATE_DORMANT);
+		}
 	}
 
 	dev->links.status = DL_DEV_NO_DRIVER;
-- 
2.27.0.rc0.183.gde8f92d652-goog

