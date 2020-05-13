Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498322064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgEMPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:18:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:37459 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgEMPSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:18:43 -0400
IronPort-SDR: XBAO56FGfdHKvt7Ps5lAsWUCUlMImvJHDIczkVOGX1InYZYtZchCI0ezeQJEP51GfRcjZpEkMB
 bULchRFVDcug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 08:18:43 -0700
IronPort-SDR: ZYUSbumjQv0c93Qa2sJu6X8ea2I6840uLUiFkzZ+VI+MZNfSQZdlNMce96urcLoifwV9JDXFw9
 iSQ364fXHd5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="371935382"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2020 08:18:41 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject: Make sure the parent does not get released before its children
Date:   Wed, 13 May 2020 18:18:40 +0300
Message-Id: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function kobject_cleanup(), kobject_del(kobj) is
called before the kobj->release(). That makes it possible to
release the parent of the kobject before the kobject itself.

To fix that, adding function __kboject_del() that does
everything that kobject_del() does except release the parent
reference. kobject_cleanup() then calls __kobject_del()
instead of kobject_del(), and separately decrements the
reference count of the parent kobject after kobj->release()
has been called.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 lib/kobject.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 65fa7bf70c57..32432036bef8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
 }
 EXPORT_SYMBOL_GPL(kobject_move);
 
-/**
- * kobject_del() - Unlink kobject from hierarchy.
- * @kobj: object.
- *
- * This is the function that should be called to delete an object
- * successfully added via kobject_add().
- */
-void kobject_del(struct kobject *kobj)
+static void __kobject_del(struct kobject *kobj)
 {
 	struct kernfs_node *sd;
 	const struct kobj_type *ktype;
@@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
 
 	kobj->state_in_sysfs = 0;
 	kobj_kset_leave(kobj);
-	kobject_put(kobj->parent);
 	kobj->parent = NULL;
 }
+
+/**
+ * kobject_del() - Unlink kobject from hierarchy.
+ * @kobj: object.
+ *
+ * This is the function that should be called to delete an object
+ * successfully added via kobject_add().
+ */
+void kobject_del(struct kobject *kobj)
+{
+	struct kobject *parent = kobj->parent;
+
+	__kobject_del(kobj);
+	kobject_put(parent);
+}
 EXPORT_SYMBOL(kobject_del);
 
 /**
@@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
@@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
 			 kobject_name(kobj), kobj);
-		kobject_del(kobj);
+		__kobject_del(kobj);
 	}
 
 	if (t && t->release) {
@@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
 		pr_debug("kobject: '%s': free name\n", name);
 		kfree_const(name);
 	}
+
+	kobject_put(parent);
 }
 
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
-- 
2.26.2

