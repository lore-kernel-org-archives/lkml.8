Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C996C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F79D20853
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590334270;
	bh=72LIESe7ZfL82S+V55dpl4yXI9zYbHv4OcNdyudZjs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BBnCCXU375t32fZbulA+LyuFALdpvxkeyqDoC17ZH4nNv2kf13Qw1Eqbl9zams7/c
	 cWGXEtsxrIbReEjTYCW+RScBn0RsxMRfmZPpINz3mf0l5hfJsOhUWZvdIbYemrbJbY
	 dpIQcqMWSdFyU3DSoLwzl0qbN/bMmTzcdv8BaZcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgEXPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgEXPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:31:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534CC20826;
        Sun, 24 May 2020 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590334267;
        bh=72LIESe7ZfL82S+V55dpl4yXI9zYbHv4OcNdyudZjs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2m9xcHrXE6vgdM905QSpm/9qeRNOifOHmZ1cQ3jJBRJwjVSc4CRVoHnBmjw7TYzd4
         29snaNKdmUeaxlrj1+G+XDETrmj+fUG78BqH7SU15oZnxcoQyH4BADAPN/33yazwhs
         cEwJdeVrL11sWXpG1O7LCE4rQPNAkdjBDPj34yx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is removed from sysfs
Date:   Sun, 24 May 2020 17:30:41 +0200
Message-Id: <20200524153041.2361-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524153041.2361-1-gregkh@linuxfoundation.org>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
after the files are actually gone from sysfs, due to how reference
counting for kobjects work.  This should not be a problem, but it would
be good to properly send the information when things are going away, not
at some later point in time in the future.

Before this move, if a kobject's parent was torn down before the child,
when the call to kobject_uevent() happened, the parent walk to try to
reconstruct the full path of the kobject could be a total mess and cause
crashes.  It's not good to try to tear down a kobject tree from top
down, but let's at least try to not to crash if a user does so.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kobject.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 83198cb37d8d..2509e22ad74a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -620,6 +620,13 @@ void kobject_del(struct kobject *kobj)
 	if (ktype)
 		sysfs_remove_groups(kobj, ktype->default_groups);
 
+	/* send "remove" if the caller did not do it but sent "add" */
+	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
+		pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
+			 kobject_name(kobj), kobj);
+		kobject_uevent(kobj, KOBJ_REMOVE);
+	}
+
 	sysfs_remove_dir(kobj);
 	sysfs_put(sd);
 
@@ -673,13 +680,6 @@ static void kobject_cleanup(struct kobject *kobj)
 		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
 			 kobject_name(kobj), kobj);
 
-	/* send "remove" if the caller did not do it but sent "add" */
-	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
-		pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
-			 kobject_name(kobj), kobj);
-		kobject_uevent(kobj, KOBJ_REMOVE);
-	}
-
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
-- 
2.26.2

