Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBD72080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YAI1tjUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgEFPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgEFPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D65C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y6so1061301pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWlHBN/3hvShJu+ITQ2VKsWR3g9HqwgdpXyZ5LX21CA=;
        b=YAI1tjUpn5zlOwDJnOxslc63NeKw2d0jLqjUJCgbRGMZA943VBl6kX3k03mQxcjLGv
         22f4mSlg/0BhX87quVIuQPUAv18gpArdRPDfpa/FpFcPw5PrFmHA0eEAKJH4ccKb581/
         M24qxeyX0yfrodUDuJBMqJqCofeYKccEC4yts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWlHBN/3hvShJu+ITQ2VKsWR3g9HqwgdpXyZ5LX21CA=;
        b=n7O5OKm/sP17IGCOxnW/AMpNqMc58jB7+yMkO/0NUM7W7hYXw7aWN7jtNGCSpD1UtY
         4w1K+gcCtMa9uK9cXTUJVKWvuIbiS5xve8o1fsE36u+tgJV3SC+3jDkYw8fL+K8Zhdlz
         adO9EhxXCGp2rpZdfnKhd5QjQkUTvQnMgSAHh/t25fp2A9ur1G3Ve+J3vNDz695sp1Z4
         SKzmk9IP/paF6y8upKmDfJIthKFIocTh+5vG+8Ni2QlyBrGbCpZ07qntzVX0DsIps6zZ
         el2QnyA2TAryRIOfB0dQxD9mvvUncaD0rBYYZfnqQZeCsjZxjlFo5JSZNMWt6EViSTug
         FonQ==
X-Gm-Message-State: AGi0Pua0IiMTcDFRuclzlKmwirKq7D9zyrd5QKJdsDJo882mjKEvH/yx
        J+xKHQuDvJqH3Byung635VOfKg==
X-Google-Smtp-Source: APiQypJf9kdgVvoj0G+zgWGJk7pqjABqsOyRmjsvqCmtvNdvOOBYHPzccyhJuHcyfrjpNp0gSNS4oA==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr9027685plr.0.1588778504733;
        Wed, 06 May 2020 08:21:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm5048438pjr.17.2020.05.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 04/10] pstore: Rename "allpstore" to "records_list"
Date:   Wed,  6 May 2020 08:21:08 -0700
Message-Id: <20200506152114.50375-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "allpstore" doesn't carry much meaning, so rename it to what it
actually is: the list of all records present in the filesystem. The lock
is also renamed accordingly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d99b5d39aa90..5cc09cb315f9 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -29,8 +29,8 @@
 
 #define	PSTORE_NAMELEN	64
 
-static DEFINE_SPINLOCK(allpstore_lock);
-static LIST_HEAD(allpstore);
+static DEFINE_SPINLOCK(records_list_lock);
+static LIST_HEAD(records_list);
 
 struct pstore_private {
 	struct list_head list;
@@ -196,9 +196,9 @@ static void pstore_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 	if (p) {
-		spin_lock_irqsave(&allpstore_lock, flags);
+		spin_lock_irqsave(&records_list_lock, flags);
 		list_del(&p->list);
-		spin_unlock_irqrestore(&allpstore_lock, flags);
+		spin_unlock_irqrestore(&records_list_lock, flags);
 		free_pstore_private(p);
 	}
 }
@@ -302,8 +302,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	WARN_ON(!inode_is_locked(d_inode(root)));
 
-	spin_lock_irqsave(&allpstore_lock, flags);
-	list_for_each_entry(pos, &allpstore, list) {
+	spin_lock_irqsave(&records_list_lock, flags);
+	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
 		    pos->record->psi == record->psi) {
@@ -311,7 +311,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&allpstore_lock, flags);
+	spin_unlock_irqrestore(&records_list_lock, flags);
 	if (rc)
 		return rc;
 
@@ -343,9 +343,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	d_add(dentry, inode);
 
-	spin_lock_irqsave(&allpstore_lock, flags);
-	list_add(&private->list, &allpstore);
-	spin_unlock_irqrestore(&allpstore_lock, flags);
+	spin_lock_irqsave(&records_list_lock, flags);
+	list_add(&private->list, &records_list);
+	spin_unlock_irqrestore(&records_list_lock, flags);
 
 	return 0;
 
-- 
2.20.1

