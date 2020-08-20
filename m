Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EE2204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932048;
	bh=3MdOltG8YQMna49ftWkPa7aprubDtN2/vcl8KDI5weg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPUg9fueAUAhTWk4kB1tgsWZv6KmmcJktL4K+OxVzrDSfcM6pJAnQxU0x5LcWuerx
	 saQ8d+XXmuedbWjO4Gs1hZZXnG1WHCMQ+PjY15strf2wf8UaESZuxGNeTtStgUfBmj
	 E6NH2aZCgviitmd4NU+fhqFykukT2U7i7Seqh8ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHTOAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgHTJ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 310962173E;
        Thu, 20 Aug 2020 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915581;
        bh=3MdOltG8YQMna49ftWkPa7aprubDtN2/vcl8KDI5weg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMaVGDUf7arVHt/cQ5aQHelyz9vrEfUXc6HRhbipZ8AMRslJQmsfEdOhNGJ8GUWbm
         T+CCEv+op9NjiX49eCjcD2+mGjtB/+t5PDHtJHOW1CdZcaNHwSNZFC6InQo2wme7PN
         4uqF+KRnvh+K9SXtHFHYeYy+ibiRlvnhT5EPDogo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 034/232] btrfs: fix messages after changing compression level by remount
Date:   Thu, 20 Aug 2020 11:18:05 +0200
Message-Id: <20200820091614.418036047@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

commit 27942c9971cc405c60432eca9395e514a2ae9f5e upstream.

Reported by Forza on IRC that remounting with compression options does
not reflect the change in level, or at least it does not appear to do so
according to the messages:

  mount -o compress=zstd:1 /dev/sda /mnt
  mount -o remount,compress=zstd:15 /mnt

does not print the change to the level to syslog:

  [   41.366060] BTRFS info (device vda): use zstd compression, level 1
  [   41.368254] BTRFS info (device vda): disk space caching is enabled
  [   41.390429] BTRFS info (device vda): disk space caching is enabled

What really happens is that the message is lost but the level is actualy
changed.

There's another weird output, if compression is reset to 'no':

  [   45.413776] BTRFS info (device vda): use no compression, level 4

To fix that, save the previous compression level and print the message
in that case too and use separate message for 'no' compression.

CC: stable@vger.kernel.org # 4.19+
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -449,6 +449,7 @@ int btrfs_parse_options(struct btrfs_fs_
 	char *compress_type;
 	bool compress_force = false;
 	enum btrfs_compression_type saved_compress_type;
+	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
 
@@ -531,6 +532,7 @@ int btrfs_parse_options(struct btrfs_fs_
 				info->compress_type : BTRFS_COMPRESS_NONE;
 			saved_compress_force =
 				btrfs_test_opt(info, FORCE_COMPRESS);
+			saved_compress_level = info->compress_level;
 			if (token == Opt_compress ||
 			    token == Opt_compress_force ||
 			    strncmp(args[0].from, "zlib", 4) == 0) {
@@ -575,6 +577,8 @@ int btrfs_parse_options(struct btrfs_fs_
 				no_compress = 0;
 			} else if (strncmp(args[0].from, "no", 2) == 0) {
 				compress_type = "no";
+				info->compress_level = 0;
+				info->compress_type = 0;
 				btrfs_clear_opt(info->mount_opt, COMPRESS);
 				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
 				compress_force = false;
@@ -595,11 +599,11 @@ int btrfs_parse_options(struct btrfs_fs_
 				 */
 				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
 			}
-			if ((btrfs_test_opt(info, COMPRESS) &&
-			     (info->compress_type != saved_compress_type ||
-			      compress_force != saved_compress_force)) ||
-			    (!btrfs_test_opt(info, COMPRESS) &&
-			     no_compress == 1)) {
+			if (no_compress == 1) {
+				btrfs_info(info, "use no compression");
+			} else if ((info->compress_type != saved_compress_type) ||
+				   (compress_force != saved_compress_force) ||
+				   (info->compress_level != saved_compress_level)) {
 				btrfs_info(info, "%s %s compression, level %d",
 					   (compress_force) ? "force" : "use",
 					   compress_type, info->compress_level);


