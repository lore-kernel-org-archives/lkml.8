Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F69C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A8C20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEOaL+ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEFPVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgEFPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC1C061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so1132768pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnDu3tZEBuDEdkah0E91muUvxOc37NwJBlrIsTXyDX4=;
        b=SEOaL+ZTp6AU/8DsJmrVhdThhOeF+iFeYv4VY3pk/57OnoLmKbB6caoJgIgwJAfGS+
         3F0kvKXV0zV8FWf5cpsy+Gco8hcIIxOJaeBJYQaj0Su0tQXMUxDF0I/1T3AGyIRM6teK
         22CfJXAbVu596XkudelUD0YRb+ssyRiWUc7Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnDu3tZEBuDEdkah0E91muUvxOc37NwJBlrIsTXyDX4=;
        b=lHstzrktiMDUJq3dOXC9O6bvmW6F67P8f0YdR7opcE1gMx2Lu/Qc4yt7lf8J/QxaiF
         ykkaQQU/Y3EgkrD6cKyOfB+ubTNlYhvd0V/JH7IsI0oGYZcXwXkEo7a2e6zKAykCjuoR
         avld0ia3xBX/5CwwuvSrK65FLKFzpEjx+gAK7mU7iXCQR7l2rrqcXe/U6z+SLILDI70z
         /3CYIKjKerhixnHA91QSa73otmB907pnEk5xOROrg6JjsMpM5sMj+ry3t8Q78FyZlRFN
         eoYiAMMEkx5eoyTjliyjr79uIHi/iWwfrSGt/MW6njXi8vFLWRgT/DOdzRf+9XbsGTKX
         bdow==
X-Gm-Message-State: AGi0PuYlzyWVdaSOG+r2Qe2SmAPiJLXy6ViCw0IQuf3dxCu/YoWuqcdX
        KClDFnohsRDnZEdgFrWlOwiHmw==
X-Google-Smtp-Source: APiQypIWSULl1oSen40Hk9tsVsH4QAL8lM3EbX1mpQ9nhUX5fAi4/jGssKYijSqyhBXKfx3iyjANtQ==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr8922923pff.168.1588778508246;
        Wed, 06 May 2020 08:21:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p1sm5360532pjf.15.2020.05.06.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 05/10] pstore: Convert "records_list" locking to mutex
Date:   Wed,  6 May 2020 08:21:09 -0700
Message-Id: <20200506152114.50375-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstorefs internal list lock doesn't need to be a spinlock and will
create problems when trying to access the list in the subsequent patch
that will walk the pstorefs records during pstore_unregister(). Change
this to a mutex to avoid may_sleep() warnings when unregistering devices.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5cc09cb315f9..92ebcc75434f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -22,14 +22,13 @@
 #include <linux/magic.h>
 #include <linux/pstore.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
 #include "internal.h"
 
 #define	PSTORE_NAMELEN	64
 
-static DEFINE_SPINLOCK(records_list_lock);
+static DEFINE_MUTEX(records_list_lock);
 static LIST_HEAD(records_list);
 
 struct pstore_private {
@@ -192,13 +191,12 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
 static void pstore_evict_inode(struct inode *inode)
 {
 	struct pstore_private	*p = inode->i_private;
-	unsigned long		flags;
 
 	clear_inode(inode);
 	if (p) {
-		spin_lock_irqsave(&records_list_lock, flags);
+		mutex_lock(&records_list_lock);
 		list_del(&p->list);
-		spin_unlock_irqrestore(&records_list_lock, flags);
+		mutex_unlock(&records_list_lock);
 		free_pstore_private(p);
 	}
 }
@@ -297,12 +295,11 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
-	unsigned long		flags;
 	size_t			size = record->size + record->ecc_notice_size;
 
 	WARN_ON(!inode_is_locked(d_inode(root)));
 
-	spin_lock_irqsave(&records_list_lock, flags);
+	mutex_lock(&records_list_lock);
 	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
@@ -311,7 +308,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&records_list_lock, flags);
+	mutex_unlock(&records_list_lock);
 	if (rc)
 		return rc;
 
@@ -343,9 +340,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	d_add(dentry, inode);
 
-	spin_lock_irqsave(&records_list_lock, flags);
+	mutex_lock(&records_list_lock);
 	list_add(&private->list, &records_list);
-	spin_unlock_irqrestore(&records_list_lock, flags);
+	mutex_unlock(&records_list_lock);
 
 	return 0;
 
-- 
2.20.1

