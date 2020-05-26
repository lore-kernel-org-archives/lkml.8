Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7902C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65DB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr3Lwp/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgEZHFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgEZHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:05:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B88C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:05:49 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t10so18998808qvz.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=IuPg7YQR7XimhfoCAA0U7un87KiB0XJwsB5SGjyesEc=;
        b=Mr3Lwp/h+KMpZVoP1lNlvfsOPbMsdnaczSSwVHuMyCYh0mZTn40xLqV7wDddY1DN/s
         pmqDNPGdoYDGSwzFin/ni4tVe3+cXURRDmrJWzwQFDjxrQbpT7bVBjDna4rT/9WBPTNQ
         metbjtuymC74YfXHPfn2WiZG+v1kDEpN/FYOvTrXoRG2KtyZUbEiJHxVhtubneB7Y+FC
         4ZJ8tyPjRzXjajxRfZQN68F2yLwplXFBCX0mdmolDssFb9xaCyhnbaWGFVSUI0bdKdIT
         WbEBcXKpksXEf2vYtDamz2gtYEIweS2uu4LVhPXzHX2Ykaog+htrRIDhkgSPHLYQoz9b
         1laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=IuPg7YQR7XimhfoCAA0U7un87KiB0XJwsB5SGjyesEc=;
        b=LIGcI2MyDGE97Ym4t0HojYYEZLCp9WFTEBok04ISdHz2JsRD8Hh0jz/1SFhfKaYUJs
         GW4hbe7nHEtGke2YDPK14Q+fxte/LwSGIENBImcLkjW5PQxVgqZLYZP/IZFjeC/NxUeZ
         t95VA5nN/m2gWkfydsUbFAdwadHyzWnAtDsIaSGKAzpPFptauOjOFUHJPTx+rcIxRBtg
         Co+AAq4HohplrOmrgoRCJ/xYbHW52/hI2wGoFFc4CzvyQOOoIaBmlP/Q9EOMd/W6r25c
         JJaACBgrvJYncuPB6qn1ApAssmR14NKkh06t14a3jgXYFJe676MxJfEwWfFhJX8VtrpE
         a9fg==
X-Gm-Message-State: AOAM530mYsb338Rglvuw3F5jiW3Cngqf1dW+I+FEfeE5JoYK+Vv9BpWD
        dxdyG0qoMcgaCPmAjSihfF/qYTT9M7SWCZ0=
X-Google-Smtp-Source: ABdhPJxwjwwjzuOyP/n8IXGL9cgFNJkiLo85z8ooMh7NdTU5sv6g18shEJsMBPRg5IobOBGNSOQWEWPYE3aov44=
X-Received: by 2002:ad4:4b26:: with SMTP id s6mr18984998qvw.146.1590476748593;
 Tue, 26 May 2020 00:05:48 -0700 (PDT)
Date:   Tue, 26 May 2020 00:05:17 -0700
In-Reply-To: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc>
Message-Id: <20200526070518.107333-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v1] driver core: Update device link status correctly for
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
of a SYNC_STATE_ONLY device link.  A SYNC_STATE_ONLY device link can
later get converted into a normal MANAGED device link when a normal
MANAGED device link is created between a supplier and consumer that
already have a SYNC_STATE_ONLY device link between them. If a
SYNC_STATE_ONLY device link's status isn't maintained correctly till
it's converted to a normal MANAGED device link, then the normal
MANAGED device link will end up with a wrong link status. This can
cause a warning stack trace[1] when the consumer device probes.

This commit fixes the SYNC_STATE_ONLY device link status update issue
where it wouldn't transition correctly from DL_STATE_AVAILABLE to
DL_STATE_CONSUMER_PROBE.

[1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg,

I think this is the issue Michael ran into. I'd like him to test the fix
before it's pulled in.

Michael,

If you can test this on the branch you saw the issue in and give a
Tested-by if it works, that'd be great.

Thanks,
Saravana

 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791b7530599f..9511be3f9a32 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -687,11 +687,11 @@ int device_links_check_suppliers(struct device *dev)
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
-- 
2.27.0.rc0.183.gde8f92d652-goog

