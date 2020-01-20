Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9445C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BC220882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:13:26 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43999 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:13:26 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CDA4B60007;
        Mon, 20 Jan 2020 12:13:23 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] fs: fuse: check return value of fuse_simple_request
Date:   Mon, 20 Jan 2020 15:13:11 +0300
Message-Id: <20200120121310.17601-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `fs/fuse/file.c` `fuse_simple_request` is used in multiple places,
with its return value properly checked for possible errors.

However the usage on `fuse_file_put` ignores its return value. And the
following `fuse_release_end` call used hard-coded error value of `0`.

This triggers a warning in static analyzers and such.

I've added a variable to capture `fuse_simple_request` result and passed
that to `fuse_release_end` instead.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 fs/fuse/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a63d779eac10..9914ee2af311 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -110,6 +110,7 @@ static void fuse_release_end(struct fuse_conn *fc, struct fuse_args *args,

 static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
+	int err;
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;

@@ -117,8 +118,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 			/* Do nothing when client does not implement 'open' */
 			fuse_release_end(ff->fc, args, 0);
 		} else if (sync) {
-			fuse_simple_request(ff->fc, args);
-			fuse_release_end(ff->fc, args, 0);
+			err = fuse_simple_request(ff->fc, args);
+			fuse_release_end(ff->fc, args, err);
 		} else {
 			args->end = fuse_release_end;
 			if (fuse_simple_background(ff->fc, args,
--
2.25.0

