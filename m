Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7DDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54F520768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946122;
	bh=nka1z1JeJotYw4mRLwT1jWGnMFhFzOVKfzEffkT2o7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcPw6SB55cLLw9Ri+MqoR59IAuqzgG6IjkTNJD62fmFIx8DWV687l8MmOJ52lK5kv
	 0FwclAtCwFjDyBJvVZqI6qq/I1Frk3fxBoWp1EDxbBBeixLsxPypUKuYAGRtFe7j1/
	 +JdfgHYO6iEvbNnDUIb9Zln2OGB3tgtrxZgnfZgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbgFWVCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392047AbgFWUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:39:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9BB21883;
        Tue, 23 Jun 2020 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944760;
        bh=nka1z1JeJotYw4mRLwT1jWGnMFhFzOVKfzEffkT2o7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dsa+qUdIi3+G6/6bg0bN1aGDzb0q+bVxA/TI/tTpKBeWhGUTHfe+sAKnzujFxxgWR
         HFoHYhgsMiFjNCVj8yXlcwA5J4aun6UTjWpI7wirYc/gpHZUkWxyGrMT6DQ4BQqLmU
         eP9Y9NI2aAA0yZyRqi76ytaFEIq1qPeHVFc0hWsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/206] scsi: target: tcmu: Fix a use after free in tcmu_check_expired_queue_cmd()
Date:   Tue, 23 Jun 2020 21:57:22 +0200
Message-Id: <20200623195322.553626574@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9d7464b18892332e35ff37f0b024429a1a9835e6 ]

The pr_debug() dereferences "cmd" after we already freed it by calling
tcmu_free_cmd(cmd).  The debug printk needs to be done earlier.

Link: https://lore.kernel.org/r/20200523101129.GB98132@mwanda
Fixes: 61fb24822166 ("scsi: target: tcmu: Userspace must not complete queued commands")
Reviewed-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index ac523f247a9ca..8da89925a874d 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1303,13 +1303,13 @@ static void tcmu_check_expired_queue_cmd(struct tcmu_cmd *cmd)
 	if (!time_after(jiffies, cmd->deadline))
 		return;
 
+	pr_debug("Timing out queued cmd %p on dev %s.\n",
+		  cmd, cmd->tcmu_dev->name);
+
 	list_del_init(&cmd->queue_entry);
 	se_cmd = cmd->se_cmd;
 	tcmu_free_cmd(cmd);
 
-	pr_debug("Timing out queued cmd %p on dev %s.\n",
-		  cmd, cmd->tcmu_dev->name);
-
 	target_complete_cmd(se_cmd, SAM_STAT_TASK_SET_FULL);
 }
 
-- 
2.25.1



