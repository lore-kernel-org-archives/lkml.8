Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254C02072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgHYE5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:37 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:33416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbgHYE50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 72EF6181D337B;
        Tue, 25 Aug 2020 04:57:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bed18_451327127059
X-Filterd-Recvd-Size: 2137
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:24 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] fuse: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:20 -0700
Message-Id: <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/fuse/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..ecb6eed832a0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1362,14 +1362,22 @@ static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
 {
 	unsigned ivalid = iattr->ia_valid;
 
-	if (ivalid & ATTR_MODE)
-		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
-	if (ivalid & ATTR_SIZE)
-		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
+	if (ivalid & ATTR_MODE) {
+		arg->valid |= FATTR_MODE;
+		arg->mode = iattr->ia_mode;
+	}
+	if (ivalid & ATTR_UID) {
+		arg->valid |= FATTR_UID;
+		arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
+	}
+	if (ivalid & ATTR_GID) {
+		arg->valid |= FATTR_GID;
+		arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+	}
+	if (ivalid & ATTR_SIZE) {
+		arg->valid |= FATTR_SIZE;
+		arg->size = iattr->ia_size;
+	}
 	if (ivalid & ATTR_ATIME) {
 		arg->valid |= FATTR_ATIME;
 		arg->atime = iattr->ia_atime.tv_sec;
-- 
2.26.0

