Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08160C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD002065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgENSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:19:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:19:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jZIS8-0003Ip-5A; Thu, 14 May 2020 18:19:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fsinfo: fix an uninialized variable 'conn'
Date:   Thu, 14 May 2020 19:19:26 +0100
Message-Id: <20200514181926.16571-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable conn is not initialized and can potentially contain
garbage causing a false -EPERM return on the !conn check.
Fix this by initializing it to false.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: f2494de388bd ("fsinfo: Add an attribute that lists all the visible mounts in a namespace")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3fd24575756b..ae489cbac467 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4433,7 +4433,7 @@ int fsinfo_generic_mount_all(struct path *path, struct fsinfo_context *ctx)
 	struct mnt_namespace *ns;
 	struct mount *m, *p;
 	struct path chroot;
-	bool conn;
+	bool conn = false;
 
 	m = real_mount(path->mnt);
 	ns = m->mnt_ns;
-- 
2.25.1

