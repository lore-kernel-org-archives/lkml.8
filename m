Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DF720725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGKL2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:28:36 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:47256 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGKL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:28:35 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 61E7A1B3FDD;
        Sat, 11 Jul 2020 20:28:34 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 06BBSXcV194079
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Jul 2020 20:28:34 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 06BBSWtt996343
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Jul 2020 20:28:32 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 06BBSVpJ996342;
        Sat, 11 Jul 2020 20:28:31 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+756199124937b31a9b7e@syzkaller.appspotmail.com>
Subject: [PATCH] fat: Fix fat_ra_init() for data clusters == 0
References: <000000000000ebc53005aa18a1a5@google.com>
Date:   Sat, 11 Jul 2020 20:28:31 +0900
In-Reply-To: <000000000000ebc53005aa18a1a5@google.com> (syzbot's message of
        "Fri, 10 Jul 2020 09:14:16 -0700")
Message-ID: <87mu462sv4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If data clusters == 0, fat_ra_init() calls the ->ent_blocknr() for the
cluster beyond ->max_clusters.

This checks the limit before initialization to suppress the warning.

Reported-by: syzbot+756199124937b31a9b7e@syzkaller.appspotmail.com
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/fatent.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index bbfe18c..f7e3304 100644
--- a/fs/fat/fatent.c	2020-07-11 19:58:41.903092419 +0900
+++ b/fs/fat/fatent.c	2020-07-11 19:58:51.545948758 +0900
@@ -657,6 +657,9 @@ static void fat_ra_init(struct super_blo
 	unsigned long ra_pages = sb->s_bdi->ra_pages;
 	unsigned int reada_blocks;
 
+	if (fatent->entry >= ent_limit)
+		return;
+
 	if (ra_pages > sb->s_bdi->io_pages)
 		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
 	reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);
_
