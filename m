Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D53C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8BB20716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaEjSifc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgC3Kn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:43:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34957 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgC3Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:43:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so6261009pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SxBpIzPkzU1vl9bySozt1wIiREaZHHXTdsxoYdI/9lw=;
        b=MaEjSifcGOscOl65yWma3+FPGAc2iNPedC49K5dP/XwTurfuNlCQiAfd51ihTo1hAb
         XX9geaEKzGQ3eLNKozHnAnSJP/HeANPraOhjvkR5tAwjydirwsLYtXZRTwBOUzm7DsT3
         74WJZ1TVAUgFzu7Dc3jKTDnYePoSEz7aXjs01BTJ3FXevO+Af/7q3Ky8tCNWYy79gGuS
         56Mzn0URuBLP4qSADpLf7lKzQHRRYdZac3oOinG/pGedktj5JnR6c1NkN+0YHanc371B
         FI9wtRUec8WYdJvxTuo5r1izIWAqlOOBQa2BIiXxgafPj7+G5xgMBgZIzALPXpe0b7F/
         m8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SxBpIzPkzU1vl9bySozt1wIiREaZHHXTdsxoYdI/9lw=;
        b=Mn7J5mjW4kKhV+Zmg806vA5w/8XIlwUHzT5AKddNf56ErBrtHA6oxjPf31dbRBZEZb
         AAmuntyHYnBE3kyzv1RwBMgw/ewjrXF2yXnhCkVfJ+QZ0XS2nubLBR81IAtjskMl1TEH
         0cePaGnXQVkGunHCdlfo5/CqBpJJeqzlnKFWOkcc9KffOmfni5+hBDI0nIprZX1lwQid
         JmE7QR7ksSC0rY06VdOKpDU8pG3blkR/wyhXWtKdDYru7eLlCuVrGyWzys3lRBi3fYus
         ONDiWDtbTza8s6KnKSJNjDdMCyE1rAnhn4X8e8LbrhFmUNtE9E54P9bCmuRNAfqMepp1
         tKnw==
X-Gm-Message-State: ANhLgQ2RqnF1w1lRHvWpAvm3aE0SXW//hJWkEL0wYkSM4P3gaQmYPRNJ
        qVGAlkd65oY2nI/2pCD5Uuk=
X-Google-Smtp-Source: ADFU+vsQ5VhuCnrZLzEJWMc1wnXdeMXTz/Sq3sHHTUK0IP1MylEryoQw9FFPsJZUK33R4fOXNlYbQQ==
X-Received: by 2002:a63:8c51:: with SMTP id q17mr12502479pgn.320.1585565005316;
        Mon, 30 Mar 2020 03:43:25 -0700 (PDT)
Received: from payal-desktop ([157.33.199.31])
        by smtp.gmail.com with ESMTPSA id d71sm10012346pfd.46.2020.03.30.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 03:43:24 -0700 (PDT)
From:   Payal Kshirsagar <payalskshirsagar1234@gmail.com>
To:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Subject: [PATCH] ipc: add blank lines after declarations
Date:   Mon, 30 Mar 2020 16:13:06 +0530
Message-Id: <20200330104306.6672-1-payalskshirsagar1234@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning by adding blank lines.

Signed-off-by: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
---
 ipc/compat.c     | 2 ++
 ipc/ipc_sysctl.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/ipc/compat.c b/ipc/compat.c
index 5ab8225923af..6c03927a4d71 100644
--- a/ipc/compat.c
+++ b/ipc/compat.c
@@ -39,6 +39,7 @@ int get_compat_ipc64_perm(struct ipc64_perm *to,
 			  struct compat_ipc64_perm __user *from)
 {
 	struct compat_ipc64_perm v;
+
 	if (copy_from_user(&v, from, sizeof(v)))
 		return -EFAULT;
 	to->uid = v.uid;
@@ -51,6 +52,7 @@ int get_compat_ipc_perm(struct ipc64_perm *to,
 			struct compat_ipc_perm __user *from)
 {
 	struct compat_ipc_perm v;
+
 	if (copy_from_user(&v, from, sizeof(v)))
 		return -EFAULT;
 	to->uid = v.uid;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index affd66537e87..ea115dfd3774 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -18,6 +18,7 @@ static void *get_ipc(struct ctl_table *table)
 {
 	char *which = table->data;
 	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
+
 	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
 	return which;
 }
@@ -62,6 +63,7 @@ static int proc_ipc_doulongvec_minmax(struct ctl_table *table, int write,
 	void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table ipc_table;
+
 	memcpy(&ipc_table, table, sizeof(ipc_table));
 	ipc_table.data = get_ipc(table);
 
-- 
2.17.1

