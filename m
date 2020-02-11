Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6CC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC67206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMF2A0nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBKMlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:41:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37630 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBKMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so5676712pgl.4;
        Tue, 11 Feb 2020 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ta/xN7ibt+T77in/0spMP8Vv8W8F1AAImXcnffdDmE=;
        b=dMF2A0nXHaqBW163aXh9SYI+GkTPe0xRrsia2BvafyJ1fcpcf0+R+gcP2bRZahm8Vc
         Jxo4ZWHidfa6woObm5roDYiaV7iHQcUg4AwHkyoiJ6LTClKD1CqGMP/Satu2Bp/AC7Vd
         mekoYYU/3NDfHOJ85K6XYbsPyO+0PZV1rim3STZA6yTn7J24nIxJSpgc4sSHDz+IDH+9
         y875yzt0fhtapnXJViut3oTM+xKksBj1kwnf3oYVjmHP84Us2cH1BrmU4tzDIqxQArRd
         5dR3hH+Dy/ERT+d3KRlM5xUNHE7u2iUBLo7IMgRlx2lONwBjvqd41sCirk7e8AjIH114
         MmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ta/xN7ibt+T77in/0spMP8Vv8W8F1AAImXcnffdDmE=;
        b=rmIotMzOFBKpuEeA098WIZJoi+GSjTmI938PlJb99F1qXKnLtlTwBGa4d/rJbEK0Vb
         NROSYo55cSMZc8j6pXHEyWfTJCMwGCUORQ9/KQUn+NSSIzLE6DGe0zwGxlh5ZLbTOcQp
         ihnh5BjTryRXSsm0TqJCWKt2yAr+z8dbEgq81XEHWdcwVrmu/dLw6zDeRFDl7lD1vg+K
         PcAajxokHLkDGrrn+eHrIWJZOd4Pk2jLsqC4bfHDBjSnJRC3WJfL796vTz/0Joxb8K8k
         QQP9FlJPHinvElL0OrEF0He6l6yGQn/Rh0wqRWpTb6E3fsCx98I3rYjAMWf3i8gbdcgJ
         acNQ==
X-Gm-Message-State: APjAAAXpzCrIfvNipvF2C3a/WdRi6OhzC9EcM1pzI1VRJUOTAmHYBV2P
        BW8azrse89bWwg/93jT0n0JyVmwrEZs=
X-Google-Smtp-Source: APXvYqwtWIs1C5aTU+Az8XdsdfcbYa/Wellc0burgYlWjDs7rM4/stxvOvSOVZ/+y328JTtqOj9yhw==
X-Received: by 2002:a63:7457:: with SMTP id e23mr6877579pgn.386.1581424902127;
        Tue, 11 Feb 2020 04:41:42 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:41 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 15/18] staging: exfat: Rename function "ffsMapCluster" to "ffs_map_cluster"
Date:   Tue, 11 Feb 2020 18:08:56 +0530
Message-Id: <20200211123859.10429-16-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsMapCluster" to "ffs_map_cluster"
in source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5fb084941c3b..87a7bcba4921 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1638,7 +1638,7 @@ static int ffs_write_stat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
+static int ffs_map_cluster(struct inode *inode, s32 clu_offset, u32 *clu)
 {
 	s32 num_clusters, num_alloced;
 	bool modified = false;
@@ -2954,7 +2954,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsMapCluster(inode, clu_offset, &cluster);
+	err = ffs_map_cluster(inode, clu_offset, &cluster);
 
 	if (!err && (cluster != CLUSTER_32(~0))) {
 		*phys = START_SECTOR(cluster) + sec_offset;
-- 
2.17.1

