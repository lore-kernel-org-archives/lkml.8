Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D8C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D393020836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NwE6Cmyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgEFPWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgEFPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FEC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so620560plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERUWIfdOS9Cj0+BLPXW5aMS+Ag/wqQVbo+Lakxt+p9w=;
        b=NwE6Cmytxmng/k7TS8r+iw6OzdunDB+XANkla0hlb1btZAm9RQaV5b4QkRbHgQfIzF
         g63fy0r0ifyQS1Qm/v+kM5dvZsFAA9+Frk/sTUU4KjWPI3cCG3kliHa3gNBLEyr8VL1G
         UDHsA8QOkjG39vEBy02FivrKgKNtjP4p7RhI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERUWIfdOS9Cj0+BLPXW5aMS+Ag/wqQVbo+Lakxt+p9w=;
        b=SBzGiYBh7Nv12R58FSvVkwxN7xIxFlstdEfOAv5qcbFVcdoxvHgUVLZ2/SE8hjtaj3
         ODDofHLB0LcnJjfA1uIatzaqO/Gsg+3GflM27hsJFySQ+oL+tk5oeJckpKA5M96VMOmD
         7D15A4rwKVK/C7101WXaoS+iA5kEtME38se8atuOdQnQRXnNPFhS52/F6BjLffHqrYb4
         KyrCQZDr/uaazYSuJP1rPTToO+3JcZ2xisYUCSiHWTzWrUKxqYJUqyEp3jIUVcNFPTdL
         kAQ3nyc4zcges+osSIKDCu/oVmZB8qNQUCfjnkmwaNZ8h2l4mGQNKyuKkQFeyTWBdreD
         nKKA==
X-Gm-Message-State: AGi0PuafnNoTkAamaBfCX7OSt71zlFpAqwOobigk0wQxgKfJ2oGr6NTH
        KzrfhMfyYCCtHHFPLJfP4q5jAA==
X-Google-Smtp-Source: APiQypLJ3ehC3xsgpfYaecchyxZdis0SCrOnZ0jKW7QF2tBHXpNTEnDnuXpozvvGmyRXq9CbaGcm0Q==
X-Received: by 2002:a17:902:eb12:: with SMTP id l18mr8259388plb.239.1588778509550;
        Wed, 06 May 2020 08:21:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm2153258pfc.7.2020.05.06.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Henriques <lhenriques@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 10/10] pstore: Remove filesystem records when backend is unregistered
Date:   Wed,  6 May 2020 08:21:14 -0700
Message-Id: <20200506152114.50375-11-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a backend was unloaded without having first removed all its
associated records in pstorefs, subsequent removals would crash while
attempting to call into the now missing backend. Add automatic removal
from the tree in pstore_unregister(), so that no references to the
backend remain.

Reported-by: Luis Henriques <lhenriques@suse.com>
Link: https://lore.kernel.org/lkml/87o8yrmv69.fsf@suse.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c    | 30 ++++++++++++++++++++++++++++++
 fs/pstore/internal.h |  1 +
 fs/pstore/platform.c |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index e13482c8e180..499d91a669bb 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -36,6 +36,7 @@ static struct super_block *pstore_sb;
 
 struct pstore_private {
 	struct list_head list;
+	struct dentry *dentry;
 	struct pstore_record *record;
 	size_t total_size;
 };
@@ -306,6 +307,34 @@ struct dentry *psinfo_lock_root(void)
 	return root;
 }
 
+int pstore_put_backend_records(struct pstore_info *psi)
+{
+	struct pstore_private *pos, *tmp;
+	struct dentry *root;
+	int rc = 0;
+
+	root = psinfo_lock_root();
+	if (!root)
+		return 0;
+
+	mutex_lock(&records_list_lock);
+	list_for_each_entry_safe(pos, tmp, &records_list, list) {
+		if (pos->record->psi == psi) {
+			list_del_init(&pos->list);
+			rc = simple_unlink(d_inode(root), pos->dentry);
+			if (WARN_ON(rc))
+				break;
+			d_delete(pos->dentry);
+			dput(pos->dentry);
+		}
+	}
+	mutex_unlock(&records_list_lock);
+
+	inode_unlock(d_inode(root));
+
+	return rc;
+}
+
 /*
  * Make a regular file in the root directory of our file system.
  * Load it up with "size" bytes of data from "buf".
@@ -352,6 +381,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (!dentry)
 		goto fail_private;
 
+	private->dentry = dentry;
 	private->record = record;
 	inode->i_size = private->total_size = size;
 	inode->i_private = private;
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index fe5f7ef7323f..8efd72d93b10 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -31,6 +31,7 @@ extern void	pstore_set_kmsg_bytes(int);
 extern void	pstore_get_records(int);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
 					   struct dentry *root, int quiet);
+extern int	pstore_put_backend_records(struct pstore_info *psi);
 extern int	pstore_mkfile(struct dentry *root,
 			      struct pstore_record *record);
 extern void	pstore_record_init(struct pstore_record *record,
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03a17b401533..6fb526187953 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -658,6 +658,9 @@ void pstore_unregister(struct pstore_info *psi)
 	del_timer_sync(&pstore_timer);
 	flush_work(&pstore_work);
 
+	/* Remove all backend records from filesystem tree. */
+	pstore_put_backend_records(psi);
+
 	free_buf_for_compression();
 
 	psinfo = NULL;
-- 
2.20.1

