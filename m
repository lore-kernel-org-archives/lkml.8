Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3034EC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C312072B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221293;
	bh=zlv96CrJzDmIqQ0algpSshTJ33jycy2ZeT8jmRg3rNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YkvuffNCPL2A6mf5FoRuDlWbDVqlIsC02yhJVCLD1A5Bt5U+SIAEXaBWupxfNQ0tW
	 HLz50Ve7uH2v5/Os/T8UC71hiFpToF8vVJhGqQD7tSjpna/irklFjuu2Q64p29U1kk
	 PJ9d6sBv9Q6XnJTU2moR5t3nPAFWUfVnoeCKhVtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgDROn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgDROnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E34B21974;
        Sat, 18 Apr 2020 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221025;
        bh=zlv96CrJzDmIqQ0algpSshTJ33jycy2ZeT8jmRg3rNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEL1GY4WDHozI8Nr2tfrmyvTN2rHKuEPkjSI71NbQScKaCLQ8OebvH7P7AcxBbB1N
         kYH8ohaymh8E7nc/aBswPrguxC0Cju77mOAtXBc2X3ihoI++Rd5UHFynOUvZEdr+Nb
         L6fQzNpyRHqoFVuxAjIBPEKojcVFV0KuWoykS8pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
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
Subject: [PATCH AUTOSEL 4.14 13/28] ipc/util.c: sysvipc_find_ipc() should increase position index
Date:   Sat, 18 Apr 2020 10:43:13 -0400
Message-Id: <20200418144328.10265-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 79b30eee32cd8..7989f5e532198 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -750,13 +750,13 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
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

