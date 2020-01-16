Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D9DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC9520663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201217;
	bh=WMOf0PsIvlz6mwQpKCU+pj3SqzU5fE5J+eOD7G7xNTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OaUGSDsz9On0sFNm3vQbFIZ3cHKS/kGNAh7KgejoT4B6fvFc2CTJcOasNSzTk/WyL
	 yvynYN5HPCBGZszZy+FhP5OhLzBGuXBubrc7WiDQmlUyFkcSTP73zmfFYmyu+o9Zae
	 +Q9vbcuXXiWZCFdqSCcsNr292o1ka28yEwI/9RZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437239AbgAPTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388906AbgAPRGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A3B207FF;
        Thu, 16 Jan 2020 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194378;
        bh=WMOf0PsIvlz6mwQpKCU+pj3SqzU5fE5J+eOD7G7xNTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I++GBjLpENUWHc6qPKjTh6BIZp0Z+aRc5EAOH1dTAW9k7f5GPr9JVNPPv3U2GIu2s
         DFgJFNq/ruhBEO0NpRpPUMXaQ0O89udu91H4PQNzmIQfvYzGiXnqJyUzZlx7d+uxKb
         idVhqLydwSDRh/sb4fRZEbvjFOmJNUOhZCajg5Ag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 310/671] afs: Fix AFS file locking to allow fine grained locks
Date:   Thu, 16 Jan 2020 11:59:08 -0500
Message-Id: <20200116170509.12787-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 68ce801ffd82e72d5005ab5458e8b9e59f24d9cc ]

Fix AFS file locking to allow fine grained locks as some applications, such
as firefox, won't work if they can't take such locks on certain state files
- thereby preventing the use of kAFS to distribute a home directory.

Note that this cannot be made completely functional as the protocol only
has provision for whole-file locks, so there exists the possibility of a
process deadlocking itself by getting a partial read-lock on a file first
and then trying to get a non-overlapping write-lock - but we got the
server's read lock with the first lock, so we're now stuck.

OpenAFS solves this by just granting any partial-range lock directly
without consulting the server - and hoping there's no remote collision.  I
want to implement that in a separate patch and it requires a bit more
thought.

Fixes: 8d6c554126b8 ("AFS: implement file locking")
Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/flock.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 1bb300ef362b..dffbb456629c 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -432,10 +432,6 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%x:%u},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
 
-	/* only whole-file locks are supported */
-	if (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX)
-		return -EINVAL;
-
 	fl->fl_ops = &afs_lock_ops;
 	INIT_LIST_HEAD(&fl->fl_u.afs.link);
 	fl->fl_u.afs.state = AFS_LOCK_PENDING;
@@ -587,10 +583,6 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	/* Flush all pending writes before doing anything with locks. */
 	vfs_fsync(file, 0);
 
-	/* only whole-file unlocks are supported */
-	if (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX)
-		return -EINVAL;
-
 	ret = posix_lock_file(file, fl, NULL);
 	_leave(" = %d [%u]", ret, vnode->lock_state);
 	return ret;
@@ -618,12 +610,15 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 			goto error;
 
 		lock_count = READ_ONCE(vnode->status.lock_count);
-		if (lock_count > 0)
-			fl->fl_type = F_RDLCK;
-		else
-			fl->fl_type = F_WRLCK;
-		fl->fl_start = 0;
-		fl->fl_end = OFFSET_MAX;
+		if (lock_count != 0) {
+			if (lock_count > 0)
+				fl->fl_type = F_RDLCK;
+			else
+				fl->fl_type = F_WRLCK;
+			fl->fl_start = 0;
+			fl->fl_end = OFFSET_MAX;
+			fl->fl_pid = 0;
+		}
 	}
 
 	ret = 0;
-- 
2.20.1

