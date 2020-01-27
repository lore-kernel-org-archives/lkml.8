Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B707C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC3214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgA0Qnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:43:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:40704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgA0QnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:43:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56CA2B15B;
        Mon, 27 Jan 2020 16:43:20 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 3/3] ceph: add module param to throttle 'copy-from2' operations
Date:   Mon, 27 Jan 2020 16:43:21 +0000
Message-Id: <20200127164321.17468-4-lhenriques@suse.com>
In-Reply-To: <20200127164321.17468-1-lhenriques@suse.com>
References: <20200127164321.17468-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a ceph kernel module parameter that allows to throttle the
amount of parallel requests that can be sent to the OSDs before waiting
for the completion.  This allows to prevent DoS'ing the ODSs with too many
requests at once when copying a big file.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c  | 10 ++++++++++
 fs/ceph/super.c |  4 ++++
 fs/ceph/super.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5d8f0ba11719..bf18712f3bd3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1973,6 +1973,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	int src_got = 0, dst_got = 0, err, dirty;
 	bool do_final_copy = false;
 	LIST_HEAD(osd_reqs);
+	unsigned int ncopies = cfr_throttle;
 
 	if (src_inode->i_sb != dst_inode->i_sb) {
 		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
@@ -2151,6 +2152,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		src_off += object_size;
 		dst_off += object_size;
 		ret += object_size;
+		if (cfr_throttle && (--ncopies == 0)) {
+			err = wait_copy_from_reqs(&osd_reqs);
+			if (err) {
+				if (!ret)
+					ret = err;
+				goto out_caps;
+			}
+			ncopies = cfr_throttle;
+		}
 	}
 
 	err = wait_copy_from_reqs(&osd_reqs);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b62c487a53af..02e8b6f93d50 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1238,6 +1238,10 @@ static void __exit exit_ceph(void)
 	destroy_caches();
 }
 
+unsigned int cfr_throttle = 0;
+module_param(cfr_throttle, uint, 0644);
+MODULE_PARM_DESC(cfr_throttle, "copy_file_range throttle value.");
+
 module_init(init_ceph);
 module_exit(exit_ceph);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b2f86bed5c2c..fb98b4b1ec72 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -72,6 +72,8 @@
 #define CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT      5  /* cap release delay */
 #define CEPH_CAPS_WANTED_DELAY_MAX_DEFAULT     60  /* cap release delay */
 
+extern unsigned int cfr_throttle;
+
 struct ceph_mount_options {
 	unsigned int flags;
 
