Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A14C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227C42051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341591;
	bh=MVIksO+Ihzwb/MQhxnPtAiLylvCrk8ZR2r+pMllTCrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sGLMMwP0ayjc3+Dh7Ge3zwaNTtrYDsPYx3KKfDMzHhOIZEc3B+wgd/ceLaFTkOIbK
	 mjKA9K+cqCm3YbKhQfC4+T7bO3yN0p4JhBa3xrgYM40D4bMx3uaKgw9TJxEM3f1Bwj
	 KSI68Q4w/EI+f+xqbA6yIx1angwVV7Cuu9dGkZQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgEAN7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgEAN2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:28:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC1320757;
        Fri,  1 May 2020 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339704;
        bh=MVIksO+Ihzwb/MQhxnPtAiLylvCrk8ZR2r+pMllTCrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSk2CV5q4G3ZEmzXclzUpwqqmU5dPHj5RzsD5paHuMfaHyxs+2G3V8nNnrtv0glWs
         +2Z5ttwojjIvo0tReBGrxO+M6XUU7PefZ4upd5EzNf8e4Gpo5Qa9HPjdUkY/DJznRy
         +pyxoKki1PuwFKB2nB97BflwUHJaki+eiu7tL/LQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, NeilBrown <neilb@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/80] ipc/util.c: sysvipc_find_ipc() should increase position index
Date:   Fri,  1 May 2020 15:21:09 +0200
Message-Id: <20200501131518.714809014@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 89163f93c6f969da5811af5377cc10173583123b ]

If seq_file .next function does not change position index, read after
some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: NeilBrown <neilb@suse.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 ipc/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/util.c b/ipc/util.c
index 798cad18dd878..e65ecf3ccbdab 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -751,13 +751,13 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 			total++;
 	}
 
+	*new_pos = pos + 1;
 	if (total >= ids->in_use)
 		return NULL;
 
 	for (; pos < IPCMNI; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
-			*new_pos = pos + 1;
 			rcu_read_lock();
 			ipc_lock_object(ipc);
 			return ipc;
-- 
2.20.1



