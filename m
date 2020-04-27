Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE896C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE682078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fen7SlaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD0QtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgD0QtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:49:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B34C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:49:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so9269444pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SZx79zjZZHQd5ot8L6cTLZwPB/Y8WAZ3ad6NpKenT0M=;
        b=fen7SlaYNevbM1TH0EBcPC1WP4ydnCNaXMoZYuK7i6NpHvUAd3AZAZrZdNH4jXqwIz
         0WcMtb4nV/H9UnTgGXa3rAuo0uc+6I4Jd2tAOTmORnPJHSPz9skOz+t+jJh1ScOZy6ag
         +LFCFHOOGAvJu11EQvpsxaSCw4UDWEzKUJd12PjOfpYBnbvGE4hrJvUde72z9qpiE/5h
         Mbdwn2fWKKo4QkiBX71vdenRckAOGdiwDcg8lGtAOlFwOUNscQznNettnNZqnf6czdd4
         kxHgoh8htNwXR9hSZgViiSWwTCsPVkvhayuiV1e1NQYtKY1XG/J/Y0yVNAHPvA4dsalD
         TSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZx79zjZZHQd5ot8L6cTLZwPB/Y8WAZ3ad6NpKenT0M=;
        b=fXs1LKlZAokz5xJahwu+GYPk2L1UhmfGXtNmQceFYbyTpZdsYcgAlZED99xcOuPTRY
         KIZcrLRLHmC1YBwhU15fpd398B0R50fnTXuvCJ0NMiCWE8W1FGwE+mRCD0+b1jhxNf0o
         kBCoXABBGFGVAuJVvlgV0MdyDHqa1GWLvKR5KL1SakJsBCj1coXc2hUN3IKGP2/bKYH2
         oMRbc0KXaKd/XSzghGDTN/A80NQzWbZYiZzK9wKx6lKUMKEm6IQOusCfFUhQ4M8I6Fhj
         ZpS1jIINOktrOYVuWLsGv1dHPzu6lXE018zcuznv++IKarrUj3nFJVX1Ldwtl3iU+KQf
         +cRw==
X-Gm-Message-State: AGi0PuZr/vMjG+hseUkR+YT8cBuv7n/p3ZlTcrEcZ41qJYyFpPj7aryC
        BVteeflVdjiwPzzxsTwRdkE=
X-Google-Smtp-Source: APiQypKuknnx3/Wdbj59FRBYjmpKIxZDVN6ah149plUDnAvn0sICpRdc2uA9Ids2Mr0AWFsm+z5yPg==
X-Received: by 2002:a63:6302:: with SMTP id x2mr23325827pgb.375.1588006140938;
        Mon, 27 Apr 2020 09:49:00 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id a196sm13013585pfd.184.2020.04.27.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:49:00 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] kernfs: fix possibility of NULL pointer dereference.
Date:   Mon, 27 Apr 2020 09:48:36 -0700
Message-Id: <20200427164836.48765-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dentry is negative, "kernfs_dentry_node" returns NULL.
In this case, "kernfs_root" dereferences NULL pointer.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/kernfs/dir.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..02fb5cc76e33 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1133,15 +1133,16 @@ static int kernfs_iop_mkdir(struct inode *dir, struct dentry *dentry,
 static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct kernfs_node *kn  = kernfs_dentry_node(dentry);
-	struct kernfs_syscall_ops *scops = kernfs_root(kn)->syscall_ops;
+	struct kernfs_syscall_ops *scops;
 	int ret;
 
-	if (!scops || !scops->rmdir)
-		return -EPERM;
-
 	if (!kernfs_get_active(kn))
 		return -ENODEV;
 
+	scops = kernfs_root(kn)->syscall_ops;
+	if (!scops || !scops->rmdir)
+		return -EPERM;
+
 	ret = scops->rmdir(kn);
 
 	kernfs_put_active(kn);
@@ -1154,18 +1155,19 @@ static int kernfs_iop_rename(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct kernfs_node *kn = kernfs_dentry_node(old_dentry);
 	struct kernfs_node *new_parent = new_dir->i_private;
-	struct kernfs_syscall_ops *scops = kernfs_root(kn)->syscall_ops;
+	struct kernfs_syscall_ops *scops;
 	int ret;
 
 	if (flags)
 		return -EINVAL;
 
-	if (!scops || !scops->rename)
-		return -EPERM;
-
 	if (!kernfs_get_active(kn))
 		return -ENODEV;
 
+	scops = kernfs_root(kn)->syscall_ops;
+	if (!scops || !scops->rename)
+		return -EPERM;
+
 	if (!kernfs_get_active(new_parent)) {
 		kernfs_put_active(kn);
 		return -ENODEV;
-- 
2.17.1

