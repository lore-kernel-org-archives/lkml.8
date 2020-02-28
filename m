Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E70C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13E82087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqA9ZpZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgB1AAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:00:09 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43897 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgB1AAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:00:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id k194so1203575qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UnGEUXFlTBCBPshIVdS6XExVwEXBFybs+wps5bqBFfU=;
        b=ZqA9ZpZ5GnZovgjwmeGhGPDca2UmvTs4hRN0ST7NikKc3qUD+KGMpwtKGyW5QGxv1A
         lMgbp0lPx36sq+iGlJCBX+ZgfX/+pQ71BCHn95YwwY8PkFF9+SgDGCV9GpWCLzMVxm3X
         9s1drcGlA1wahwzNdlnI06QggAm/iY30ymefmOZ0pe7tM8TZ0kjKkaJaCVmpCpCINUWR
         rKiPs9QLiVGoq78pNXfAit5PURw9miOeDwuG4eaepkqq0sL2WPdjpwWHjl0Uj1GOKzvl
         kOszvSTFEstsDOVZytiBj2/q+bJe0iTFKwN2619P4qYhXPRu/a1GMVTv/RKcJn5WVdGd
         xlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UnGEUXFlTBCBPshIVdS6XExVwEXBFybs+wps5bqBFfU=;
        b=Z7JmRJgM5/tUJL8IsaQ6eHxsofWlrOu7GiVnAJeqxFBkR21UxZy0MpYCNLyAhifRD2
         k3oEp5bGaIf6GqjTs1lZBEVDMMyYRgc8ByklOsSKpTmALcxmGzgr5FvF/Zt4maZkuzIi
         8CpDBM+q+5jCwtXmWa3TfsyyglpzjluHIoI3KuhmuxpOgocQg3yIIgXUq8c+yottpmEi
         yjofSChQRuDcBf7hY5DE3MdVPahYcCCdAjXIPCsMHyxBwRTOMY7IX69AVfHggYtw/Qfm
         3TUcEmnl37Yuu/QHbLQ92xvZdrau61jbsQYeknQ5b0g1G8DILKZyggEr89/Vrgw/4rKi
         u3mA==
X-Gm-Message-State: APjAAAXvV9kUs6HrQ3ImvPnJmdtOMKw/o2LogO/o1Y3jxkCJeM05ZJNT
        bF/XrpBECUtedaXBCLhTlrtvVugDioWBmwF3LvasBA==
X-Google-Smtp-Source: APXvYqx8yOpMNyp9qq3byswIiE05FjNihHdRXbu6Cytxhx3fB0hwlhohcuwYBesKmfcZTuHVXykmLq7u6HLFipt5HCWAYg==
X-Received: by 2002:a37:4f51:: with SMTP id d78mr2117183qkb.28.1582848007962;
 Thu, 27 Feb 2020 16:00:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:00:01 -0800
Message-Id: <20200228000001.240428-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v1] Revert "software node: Simplify software_node_release() function"
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3df85a1ae51f6b256982fe9d17c2dc5bfb4cc402.

The reverted commit says "It's possible to release the node ID
immediately when fwnode_remove_software_node() is called, no need to
wait for software_node_release() with that." However, releasing the node
ID before waiting for software_node_release() to be called causes the
node ID to be released before the kobject and the underlying sysfs
entry; this means there is a period of time where a sysfs entry exists
that is associated with an unallocated node ID.

Once consequence of this is that there is a race condition where it is
possible to call fwnode_create_software_node() with no parent node
specified (NULL) and have it fail with -EEXIST because the node ID that
was assigned is still associated with a stale sysfs entry that hasn't
been cleaned up yet.

Although it is difficult to reproduce this race condition under normal
conditions, it can be deterministically reproduced with the following
minconfig on UML:

CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_KOBJECT_RELEASE=y
CONFIG_KUNIT=y

Running the tests with this configuration causes the following failure:

<snip>
kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 400)
	ok 1 - pe_test_uints
sysfs: cannot create duplicate filename '/kernel/software_nodes/node0'
CPU: 0 PID: 28 Comm: kunit_try_catch Not tainted 5.6.0-rc3-next-20200227 #14
<snip>
kobject_add_internal failed for node0 with -EEXIST, don't try to register things with the same name in the same directory.
kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 100)
	# pe_test_uint_arrays: ASSERTION FAILED at drivers/base/test/property-entry-test.c:123
	Expected node is not error, but is: -17
	not ok 2 - pe_test_uint_arrays
<snip>

Reported-by: Heidi Fahim <heidifahim@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/swnode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 0b081dee1e95c..de8d3543e8fe3 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -608,6 +608,13 @@ static void software_node_release(struct kobject *kobj)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
 
+	if (swnode->parent) {
+		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		list_del(&swnode->entry);
+	} else {
+		ida_simple_remove(&swnode_root_ids, swnode->id);
+	}
+
 	if (swnode->allocated) {
 		property_entries_free(swnode->node->properties);
 		kfree(swnode->node);
@@ -773,13 +780,6 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
-	if (swnode->parent) {
-		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
-		list_del(&swnode->entry);
-	} else {
-		ida_simple_remove(&swnode_root_ids, swnode->id);
-	}
-
 	kobject_put(&swnode->kobj);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
-- 
2.25.1.481.gfbce0eb801-goog

