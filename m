Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91171C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DA222206
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGNK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:56:16 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:17406 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:56:15 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id A40A86FC34F467CF4C93;
        Tue, 14 Jul 2020 18:56:13 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 06EAuCTB079975;
        Tue, 14 Jul 2020 18:56:12 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020071418562575-4282340 ;
          Tue, 14 Jul 2020 18:56:25 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, vbabka@suse.cz, yanaijie@huawei.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] ipc/shm.c: Remove the superfluous break
Date:   Tue, 14 Jul 2020 18:59:21 +0800
Message-Id: <1594724361-11525-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-14 18:56:26,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-14 18:56:14,
        Serialize complete at 2020-07-14 18:56:14
X-MAIL: mse-fl2.zte.com.cn 06EAuCTB079975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove the superfuous break, as there is a 'return' before it.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 ipc/shm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0a6dd94..fbf369fa 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1381,7 +1381,6 @@ static long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr, int versio
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 		return shmctl_do_lock(ns, shmid, cmd);
-		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.9.5

