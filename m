Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD698C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7651720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lQM3ABr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbgF2UvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgF2TNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46924C08ECAA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so15343020wrm.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYdvmIA/aO0yqwl/SsgbqDwolR2EZeVR55s8HYWjZ70=;
        b=lQM3ABr2yu3+DpwWh1xUyqDLRnRk0fWqJ0c0WDLrDqlTWZi5EcATQOMtQ3wUmvK9Cf
         NPz4ix28ivL1ufa32Q/tCXOEeVDG70sypV8yIUP6v6WIGoUKKm/Ah4/TaqWIKDkgCFJA
         uBENiCQ+XN4uww1HJoDT6cUBMiZqhS7XJPi1OFmuTc4T1A0fCyjJwx/5yrLZLuTJZYAD
         kc+jXcMJYwqsKWz4Ckgt5O9Zn6Gl14jMOpe1h9dMjuwYYKJxykrRw7kXkDf5KNF0Euxo
         leDCOKl6kPwxVN0N8PxIPabbFDC1c9AW00gryL62hR95WtlzxlsyaX9bOkT+hGGmXxGm
         tCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYdvmIA/aO0yqwl/SsgbqDwolR2EZeVR55s8HYWjZ70=;
        b=S6iTKhkh80FdBXVfuhEmlebc6CggIScmkZiva5tWZuO+DU+hvZFjrtUcup1tAyoUTn
         6vm0oHMT5IHOAkTpPkJNTX1zNY9orKKCGJYO3yrFBlIZYWnhz+ibWQF9VH9OH+cTV+oX
         aOZtcoQZgZdBJ2/w2PtlIGaTGsr7lHKpWWjKP1Hnt4bQELUMxWEmTB8vdk+F9LTNF7bN
         DpXWh5ICQvYyG+IAAYTjV2F5VTAPZkydsRzdUhljQ2g7IK/ZbV6zcWl5LORKPDP1iTZ1
         KVNCD7kZhJ6hKyGnhh26dLxgX/S47z0KJ10MUhJ1vsw5soKSdQ5+sJBtlG228On/PxJt
         lf0g==
X-Gm-Message-State: AOAM533ZFkciaa4fycji2xtZIkuQuWRWVpPFp4QHtR07y3f2f1rRai15
        r1gqYk6Ne9AB+2gOOmR9Ph3/xw==
X-Google-Smtp-Source: ABdhPJxSXUj4iKnhhLGYsK+ZiUaZTbhrZ1+Ndci+3V1/CYB3JfQxz6Sy/F7YpiFWbQV5HqGhOpdWbA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr16507503wrn.170.1593413417877;
        Sun, 28 Jun 2020 23:50:17 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z25sm26400850wmk.28.2020.06.28.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:50:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/6] device: remove 'extern' attribute from function prototypes in device.h
Date:   Mon, 29 Jun 2020 08:50:05 +0200
Message-Id: <20200629065008.27620-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629065008.27620-1-brgl@bgdev.pl>
References: <20200629065008.27620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Functions are declared 'extern' implicitly by the compiler. There's no
reason to prepend every prototype with it. Remove the 'extern' keyword
from all function declarations in linux/device.h.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/device.h | 223 ++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 116 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..9cadb647cacc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -145,68 +145,66 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 	struct device_attribute dev_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
 
-extern int device_create_file(struct device *device,
-			      const struct device_attribute *entry);
-extern void device_remove_file(struct device *dev,
-			       const struct device_attribute *attr);
-extern bool device_remove_file_self(struct device *dev,
-				    const struct device_attribute *attr);
-extern int __must_check device_create_bin_file(struct device *dev,
+int device_create_file(struct device *device,
+		       const struct device_attribute *entry);
+void device_remove_file(struct device *dev,
+			const struct device_attribute *attr);
+bool device_remove_file_self(struct device *dev,
+			     const struct device_attribute *attr);
+int __must_check device_create_bin_file(struct device *dev,
 					const struct bin_attribute *attr);
-extern void device_remove_bin_file(struct device *dev,
-				   const struct bin_attribute *attr);
+void device_remove_bin_file(struct device *dev,
+			    const struct bin_attribute *attr);
 
 /* device resource management */
 typedef void (*dr_release_t)(struct device *dev, void *res);
 typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
 
 #ifdef CONFIG_DEBUG_DEVRES
-extern void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
-				 int nid, const char *name) __malloc;
+void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
+			  int nid, const char *name) __malloc;
 #define devres_alloc(release, size, gfp) \
 	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
 #define devres_alloc_node(release, size, gfp, nid) \
 	__devres_alloc_node(release, size, gfp, nid, #release)
 #else
-extern void *devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
-			       int nid) __malloc;
+void *devres_alloc_node(dr_release_t release, size_t size,
+			gfp_t gfp, int nid) __malloc;
 static inline void *devres_alloc(dr_release_t release, size_t size, gfp_t gfp)
 {
 	return devres_alloc_node(release, size, gfp, NUMA_NO_NODE);
 }
 #endif
 
-extern void devres_for_each_res(struct device *dev, dr_release_t release,
-				dr_match_t match, void *match_data,
-				void (*fn)(struct device *, void *, void *),
-				void *data);
-extern void devres_free(void *res);
-extern void devres_add(struct device *dev, void *res);
-extern void *devres_find(struct device *dev, dr_release_t release,
-			 dr_match_t match, void *match_data);
-extern void *devres_get(struct device *dev, void *new_res,
-			dr_match_t match, void *match_data);
-extern void *devres_remove(struct device *dev, dr_release_t release,
-			   dr_match_t match, void *match_data);
-extern int devres_destroy(struct device *dev, dr_release_t release,
-			  dr_match_t match, void *match_data);
-extern int devres_release(struct device *dev, dr_release_t release,
-			  dr_match_t match, void *match_data);
+void devres_for_each_res(struct device *dev, dr_release_t release,
+			 dr_match_t match, void *match_data,
+			 void (*fn)(struct device *, void *, void *),
+			 void *data);
+void devres_free(void *res);
+void devres_add(struct device *dev, void *res);
+void *devres_find(struct device *dev, dr_release_t release,
+		  dr_match_t match, void *match_data);
+void *devres_get(struct device *dev, void *new_res,
+		 dr_match_t match, void *match_data);
+void *devres_remove(struct device *dev, dr_release_t release,
+		    dr_match_t match, void *match_data);
+int devres_destroy(struct device *dev, dr_release_t release,
+		   dr_match_t match, void *match_data);
+int devres_release(struct device *dev, dr_release_t release,
+		   dr_match_t match, void *match_data);
 
 /* devres group */
-extern void * __must_check devres_open_group(struct device *dev, void *id,
-					     gfp_t gfp);
-extern void devres_close_group(struct device *dev, void *id);
-extern void devres_remove_group(struct device *dev, void *id);
-extern int devres_release_group(struct device *dev, void *id);
+void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
+void devres_close_group(struct device *dev, void *id);
+void devres_remove_group(struct device *dev, void *id);
+int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
-extern void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
-extern __printf(3, 0)
-char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
-		      va_list ap) __malloc;
-extern __printf(3, 4)
-char *devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...) __malloc;
+void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+__printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
+				     const char *fmt, va_list ap) __malloc;
+__printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
+				    const char *fmt, ...) __malloc;
 static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
 {
 	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
@@ -226,16 +224,14 @@ static inline void *devm_kcalloc(struct device *dev,
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
-extern void devm_kfree(struct device *dev, const void *p);
-extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
-extern const char *devm_kstrdup_const(struct device *dev,
-				      const char *s, gfp_t gfp);
-extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
-			  gfp_t gfp);
+void devm_kfree(struct device *dev, const void *p);
+char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
+const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
+void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
 
-extern unsigned long devm_get_free_pages(struct device *dev,
-					 gfp_t gfp_mask, unsigned int order);
-extern void devm_free_pages(struct device *dev, unsigned long addr);
+unsigned long devm_get_free_pages(struct device *dev,
+				  gfp_t gfp_mask, unsigned int order);
+void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res);
@@ -651,8 +647,7 @@ static inline const char *dev_name(const struct device *dev)
 	return kobject_name(&dev->kobj);
 }
 
-extern __printf(2, 3)
-int dev_set_name(struct device *dev, const char *name, ...);
+__printf(2, 3) int dev_set_name(struct device *dev, const char *name, ...);
 
 #ifdef CONFIG_NUMA
 static inline int dev_to_node(struct device *dev)
@@ -809,39 +804,38 @@ static inline bool dev_has_sync_state(struct device *dev)
 /*
  * High level routines for use by the bus drivers
  */
-extern int __must_check device_register(struct device *dev);
-extern void device_unregister(struct device *dev);
-extern void device_initialize(struct device *dev);
-extern int __must_check device_add(struct device *dev);
-extern void device_del(struct device *dev);
-extern int device_for_each_child(struct device *dev, void *data,
-		     int (*fn)(struct device *dev, void *data));
-extern int device_for_each_child_reverse(struct device *dev, void *data,
-		     int (*fn)(struct device *dev, void *data));
-extern struct device *device_find_child(struct device *dev, void *data,
-				int (*match)(struct device *dev, void *data));
-extern struct device *device_find_child_by_name(struct device *parent,
-						const char *name);
-extern int device_rename(struct device *dev, const char *new_name);
-extern int device_move(struct device *dev, struct device *new_parent,
-		       enum dpm_order dpm_order);
-extern int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
-extern const char *device_get_devnode(struct device *dev,
-				      umode_t *mode, kuid_t *uid, kgid_t *gid,
-				      const char **tmp);
+int __must_check device_register(struct device *dev);
+void device_unregister(struct device *dev);
+void device_initialize(struct device *dev);
+int __must_check device_add(struct device *dev);
+void device_del(struct device *dev);
+int device_for_each_child(struct device *dev, void *data,
+			  int (*fn)(struct device *dev, void *data));
+int device_for_each_child_reverse(struct device *dev, void *data,
+				  int (*fn)(struct device *dev, void *data));
+struct device *device_find_child(struct device *dev, void *data,
+				 int (*match)(struct device *dev, void *data));
+struct device *device_find_child_by_name(struct device *parent,
+					 const char *name);
+int device_rename(struct device *dev, const char *new_name);
+int device_move(struct device *dev, struct device *new_parent,
+		enum dpm_order dpm_order);
+int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
+const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+			       kgid_t *gid, const char **tmp);
 
 static inline bool device_supports_offline(struct device *dev)
 {
 	return dev->bus && dev->bus->offline && dev->bus->online;
 }
 
-extern void lock_device_hotplug(void);
-extern void unlock_device_hotplug(void);
-extern int lock_device_hotplug_sysfs(void);
-extern int device_offline(struct device *dev);
-extern int device_online(struct device *dev);
-extern void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
-extern void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void lock_device_hotplug(void);
+void unlock_device_hotplug(void);
+int lock_device_hotplug_sysfs(void);
+int device_offline(struct device *dev);
+int device_online(struct device *dev);
+void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 
 static inline int dev_num_vf(struct device *dev)
@@ -854,14 +848,13 @@ static inline int dev_num_vf(struct device *dev)
 /*
  * Root device objects for grouping under /sys/devices
  */
-extern struct device *__root_device_register(const char *name,
-					     struct module *owner);
+struct device *__root_device_register(const char *name, struct module *owner);
 
 /* This is a macro to avoid include problems with THIS_MODULE */
 #define root_device_register(name) \
 	__root_device_register(name, THIS_MODULE)
 
-extern void root_device_unregister(struct device *root);
+void root_device_unregister(struct device *root);
 
 static inline void *dev_get_platdata(const struct device *dev)
 {
@@ -872,33 +865,31 @@ static inline void *dev_get_platdata(const struct device *dev)
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern int __must_check device_bind_driver(struct device *dev);
-extern void device_release_driver(struct device *dev);
-extern int  __must_check device_attach(struct device *dev);
-extern int __must_check driver_attach(struct device_driver *drv);
-extern void device_initial_probe(struct device *dev);
-extern int __must_check device_reprobe(struct device *dev);
+int __must_check device_bind_driver(struct device *dev);
+void device_release_driver(struct device *dev);
+int  __must_check device_attach(struct device *dev);
+int __must_check driver_attach(struct device_driver *drv);
+void device_initial_probe(struct device *dev);
+int __must_check device_reprobe(struct device *dev);
 
-extern bool device_is_bound(struct device *dev);
+bool device_is_bound(struct device *dev);
 
 /*
  * Easy functions for dynamically creating devices on the fly
  */
-extern __printf(5, 6)
-struct device *device_create(struct class *cls, struct device *parent,
-			     dev_t devt, void *drvdata,
-			     const char *fmt, ...);
-extern __printf(6, 7)
-struct device *device_create_with_groups(struct class *cls,
-			     struct device *parent, dev_t devt, void *drvdata,
-			     const struct attribute_group **groups,
-			     const char *fmt, ...);
-extern void device_destroy(struct class *cls, dev_t devt);
-
-extern int __must_check device_add_groups(struct device *dev,
-					const struct attribute_group **groups);
-extern void device_remove_groups(struct device *dev,
-				 const struct attribute_group **groups);
+__printf(5, 6) struct device *
+device_create(struct class *cls, struct device *parent, dev_t devt,
+	      void *drvdata, const char *fmt, ...);
+__printf(6, 7) struct device *
+device_create_with_groups(struct class *cls, struct device *parent, dev_t devt,
+			  void *drvdata, const struct attribute_group **groups,
+			  const char *fmt, ...);
+void device_destroy(struct class *cls, dev_t devt);
+
+int __must_check device_add_groups(struct device *dev,
+				   const struct attribute_group **groups);
+void device_remove_groups(struct device *dev,
+			  const struct attribute_group **groups);
 
 static inline int __must_check device_add_group(struct device *dev,
 					const struct attribute_group *grp)
@@ -916,14 +907,14 @@ static inline void device_remove_group(struct device *dev,
 	return device_remove_groups(dev, groups);
 }
 
-extern int __must_check devm_device_add_groups(struct device *dev,
+int __must_check devm_device_add_groups(struct device *dev,
 					const struct attribute_group **groups);
-extern void devm_device_remove_groups(struct device *dev,
-				      const struct attribute_group **groups);
-extern int __must_check devm_device_add_group(struct device *dev,
-					const struct attribute_group *grp);
-extern void devm_device_remove_group(struct device *dev,
-				     const struct attribute_group *grp);
+void devm_device_remove_groups(struct device *dev,
+			       const struct attribute_group **groups);
+int __must_check devm_device_add_group(struct device *dev,
+				       const struct attribute_group *grp);
+void devm_device_remove_group(struct device *dev,
+			      const struct attribute_group *grp);
 
 /*
  * Platform "fixup" functions - allow the platform to have their say
@@ -940,21 +931,21 @@ extern int (*platform_notify_remove)(struct device *dev);
  * get_device - atomically increment the reference count for the device.
  *
  */
-extern struct device *get_device(struct device *dev);
-extern void put_device(struct device *dev);
-extern bool kill_device(struct device *dev);
+struct device *get_device(struct device *dev);
+void put_device(struct device *dev);
+bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
-extern int devtmpfs_mount(void);
+int devtmpfs_mount(void);
 #else
 static inline int devtmpfs_mount(void) { return 0; }
 #endif
 
 /* drivers/base/power/shutdown.c */
-extern void device_shutdown(void);
+void device_shutdown(void);
 
 /* debugging and troubleshooting/diagnostic helpers. */
-extern const char *dev_driver_string(const struct device *dev);
+const char *dev_driver_string(const struct device *dev);
 
 /* Device links interface. */
 struct device_link *device_link_add(struct device *consumer,
-- 
2.26.1

