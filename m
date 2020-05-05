Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C53FC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49212205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIWZb9I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEEGSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEGSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:18:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E5C061A0F;
        Mon,  4 May 2020 23:18:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so375294pfw.13;
        Mon, 04 May 2020 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HczQXqwB0R1qGeJgz+vzGA9j7JqbZxbL0VHevumtOCA=;
        b=sIWZb9I8mCBXoTcQngXc5UCNeaWbfxEn4MKnuQhQxwLJPyqcdQD5SARHtAEb2K9ZnX
         kdkNMjjS3kiVSLGKuU6gj8r2D0t6ipSpr6v0UcQtp7NBL8X1zaIVJGDfOoDOuODbCkym
         k9IEKfC/T4Wp+8nNQNqcO2Bc6RHTAMwvlbFPJS/vyImRZlQq7sS1dlh/4fR28CnhU1zJ
         SNMP8rm1Fg6ZJ6b1Rafuq/dmrjJjOpW3YwV7JPDZfR/VMw8+Y1iPt0GLA/BYMiV2wRCJ
         Z2ho5iQG15CyyxfYXSSREx18/12fPEQvesk71g6x+nUwmsI3Nw2jB0X1CWQHCJgnskBt
         or9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HczQXqwB0R1qGeJgz+vzGA9j7JqbZxbL0VHevumtOCA=;
        b=GzOMnnf8FQgE0RakvaYBL1AzYxYapM7CX1+N4ntmsA8s0hOeermQSWuY//oKmWYbq+
         qF1fOBZkAcV1HMDlp+Uo5ZCX0TvVjNuyQmhFO6TXM5q5yIPSBxkWIc3Ct9fVEXR47DgQ
         neuvbbxRpoqycpEM0TK/InmpzxK2GSL+0B8Dg20SjHS34y8H74acUMc+ZPTKLYyv6B1a
         XW7TxjVuPK323ETUZ5KEHXhTt1DTqYpZ07PZGB5DjyTC+8y92hek6ADdth3/KHSrEJlZ
         Ns16m71UILgN5UoGP+ppCmQMyQJqvDeq2p+LOwiwnMRVM38mT8usNRtzhFaEK/Tl4ptu
         5Izw==
X-Gm-Message-State: AGi0PubvHDDdHyEAhswQGKc+LviWspdDof1NQzl5egkt9T/DMO3Jmuf5
        Zuk5o9Onn3gQwUn0H7bk8TM=
X-Google-Smtp-Source: APiQypK5tezmezMLIgijN6F0ftN1PBVRc8C85+WLMH2EOlc3JUnxz153AxZ/LEr0lvaj49ptRlHK1Q==
X-Received: by 2002:a62:3383:: with SMTP id z125mr1579520pfz.271.1588659514433;
        Mon, 04 May 2020 23:18:34 -0700 (PDT)
Received: from localhost.localdomain (111-240-39-190.dynamic-ip.hinet.net. [111.240.39.190])
        by smtp.gmail.com with ESMTPSA id u15sm835913pjm.47.2020.05.04.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 23:18:34 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] kobject: documentation: Fix erroneous function example in kobject doc.
Date:   Tue,  5 May 2020 14:18:28 +0800
Message-Id: <20200505061828.42952-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the definitions of some functions listed in the kobject
document, since they have been changed.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 Documentation/core-api/kobject.rst | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
index 1f62d4d7d966..c3ac2963283b 100644
--- a/Documentation/core-api/kobject.rst
+++ b/Documentation/core-api/kobject.rst
@@ -80,11 +80,11 @@ what is the pointer to the containing structure?  You must avoid tricks
 (such as assuming that the kobject is at the beginning of the structure)
 and, instead, use the container_of() macro, found in ``<linux/kernel.h>``::
 
-    container_of(pointer, type, member)
+    container_of(ptr, type, member)
 
 where:
 
-  * ``pointer`` is the pointer to the embedded kobject,
+  * ``ptr`` is the pointer to the embedded kobject,
   * ``type`` is the type of the containing structure, and
   * ``member`` is the name of the structure field to which ``pointer`` points.
 
@@ -140,7 +140,7 @@ the name of the kobject, call kobject_rename()::
 
     int kobject_rename(struct kobject *kobj, const char *new_name);
 
-kobject_rename does not perform any locking or have a solid notion of
+kobject_rename() does not perform any locking or have a solid notion of
 what names are valid so the caller must provide their own sanity checking
 and serialization.
 
@@ -222,17 +222,17 @@ ksets, show and store functions, and other details.  This is the one
 exception where a single kobject should be created.  To create such an
 entry, use the function::
 
-    struct kobject *kobject_create_and_add(char *name, struct kobject *parent);
+    struct kobject *kobject_create_and_add(const char *name, struct kobject *parent);
 
 This function will create a kobject and place it in sysfs in the location
 underneath the specified parent kobject.  To create simple attributes
 associated with this kobject, use::
 
-    int sysfs_create_file(struct kobject *kobj, struct attribute *attr);
+    int sysfs_create_file(struct kobject *kobj, const struct attribute *attr);
 
 or::
 
-    int sysfs_create_group(struct kobject *kobj, struct attribute_group *grp);
+    int sysfs_create_group(struct kobject *kobj, const struct attribute_group *grp);
 
 Both types of attributes used here, with a kobject that has been created
 with the kobject_create_and_add(), can be of type kobj_attribute, so no
@@ -300,8 +300,10 @@ kobj_type::
             void (*release)(struct kobject *kobj);
             const struct sysfs_ops *sysfs_ops;
             struct attribute **default_attrs;
+            const struct attribute_group **default_groups;
             const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
             const void *(*namespace)(struct kobject *kobj);
+            void (*get_ownership)(struct kobject *kobj, kuid_t *uid, kgid_t *gid);
     };
 
 This structure is used to describe a particular type of kobject (or, more
@@ -352,12 +354,12 @@ created and never declared statically or on the stack.  To create a new
 kset use::
 
   struct kset *kset_create_and_add(const char *name,
-                                   struct kset_uevent_ops *u,
-                                   struct kobject *parent);
+                                   const struct kset_uevent_ops *uevent_ops,
+                                   struct kobject *parent_kobj);
 
 When you are finished with the kset, call::
 
-  void kset_unregister(struct kset *kset);
+  void kset_unregister(struct kset *k);
 
 to destroy it.  This removes the kset from sysfs and decrements its reference
 count.  When the reference count goes to zero, the kset will be released.
@@ -371,9 +373,9 @@ If a kset wishes to control the uevent operations of the kobjects
 associated with it, it can use the struct kset_uevent_ops to handle it::
 
   struct kset_uevent_ops {
-          int (*filter)(struct kset *kset, struct kobject *kobj);
-          const char *(*name)(struct kset *kset, struct kobject *kobj);
-          int (*uevent)(struct kset *kset, struct kobject *kobj,
+          int (* const filter)(struct kset *kset, struct kobject *kobj);
+          const char *(* const name)(struct kset *kset, struct kobject *kobj);
+          int (* const uevent)(struct kset *kset, struct kobject *kobj,
                         struct kobj_uevent_env *env);
   };
 
-- 
2.25.1

