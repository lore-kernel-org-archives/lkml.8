Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A01C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482D4215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YL2uiFT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgEFPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgEFPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8518C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so1151952pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYP6yxdymrxxL7hUVPNJiyuT/lyDa/+W7RPc1DbYPHc=;
        b=YL2uiFT8hDsK5U6H0DNA4rGJ4iLiS87bkVFGZgceoC5OLrZspZqhasZRGqHyw9vEAa
         s9XlnM/1Fn3F/Ij8OzmWwOgALL0FbKAuMoB8IBWoKEAcP5kn3DFrNWqQ5Y4KvvjCiS9O
         hKo3tqEoLGUCkJFXiNPcPscNPZHFDHpi3hemI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYP6yxdymrxxL7hUVPNJiyuT/lyDa/+W7RPc1DbYPHc=;
        b=WCLbnpYJ2wn76Zwd1rmYjXAseK/dpBTw8lf7pyet5CpYV+zCTtTpOPMUm7hV07LuBC
         kXSdenqos5wJxHu+D9wNk2LnrzAR8aAAHt+2bvw4dBapmyJIYne3TzE1SensmTIgz9ZZ
         UC+hMWvbnneDWFKlfA3R0Q1IgQ/IbaBWkQSdg9TE9BJyoxX+Ua2aTcmdTRPlhaDvi8wY
         wyFoYUrHbjutm3TtTYlKdnk/Y/0rvFitpiTxFF+6gRweP6zFVNXNbc4shlzhhVzIda3+
         8YgqRqaclKRmvjbYxCvaEN946bUTXibNBPk3RXaRo7ICy0qOmtGiSXGpESiS0gEwR6qc
         DSsg==
X-Gm-Message-State: AGi0PuY7yA+1tT7hkNjc0mNHRIUAQy2ueaRsiQXndUlLeFR1IDNjpVZJ
        80f9dnsKlHzPxycwbOsOgeJrHA==
X-Google-Smtp-Source: APiQypKsPGQTXvWajEoICKm/o+r5Lp4Itu7fJOsuFBcfRstMYwMcoK8cNblDOotBDBm6wLDOYj2HBw==
X-Received: by 2002:a62:f247:: with SMTP id y7mr8793849pfl.200.1588778507388;
        Wed, 06 May 2020 08:21:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t80sm2231606pfc.23.2020.05.06.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 07/10] pstore: Refactor pstorefs record list removal
Date:   Wed,  6 May 2020 08:21:11 -0700
Message-Id: <20200506152114.50375-8-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "unlink" handling should perform list removal (which can also make
sure records don't get double-erased), and the "evict" handling should
be responsible only for memory freeing.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 92ebcc75434f..5f08b21b7a46 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -177,10 +177,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct pstore_private *p = d_inode(dentry)->i_private;
 	struct pstore_record *record = p->record;
+	int rc = 0;
 
 	if (!record->psi->erase)
 		return -EPERM;
 
+	/* Make sure we can't race while removing this file. */
+	mutex_lock(&records_list_lock);
+	if (!list_empty(&p->list))
+		list_del_init(&p->list);
+	else
+		rc = -ENOENT;
+	mutex_unlock(&records_list_lock);
+	if (rc)
+		return rc;
+
 	mutex_lock(&record->psi->read_mutex);
 	record->psi->erase(record);
 	mutex_unlock(&record->psi->read_mutex);
@@ -193,12 +204,7 @@ static void pstore_evict_inode(struct inode *inode)
 	struct pstore_private	*p = inode->i_private;
 
 	clear_inode(inode);
-	if (p) {
-		mutex_lock(&records_list_lock);
-		list_del(&p->list);
-		mutex_unlock(&records_list_lock);
-		free_pstore_private(p);
-	}
+	free_pstore_private(p);
 }
 
 static const struct inode_operations pstore_dir_inode_operations = {
@@ -417,6 +423,7 @@ static void pstore_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
 	pstore_sb = NULL;
+	INIT_LIST_HEAD(&records_list);
 }
 
 static struct file_system_type pstore_fs_type = {
-- 
2.20.1

