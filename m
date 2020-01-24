Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705912087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864584;
	bh=k9bEjcM9khWjU1lvMP8wt8eIb+F2yVIuEAMt2ua6bA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5neGyhTWZPJgDFRpOWDQ/erBQKIkINGXDSlnTSGtZ9ussaStiJSOyoG7O/bFOcRy
	 8nGui3zJ7FsRQOfASjszfS/5if/nHzSISib4JBWOME290hJyG8pqxDrWz7GXH9eSPH
	 5Iw6k7HTw8Mvi8rJQxZl+Ge4fyqYzabZTeWYU9lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbgAXLQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389732AbgAXLQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:16:16 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6482075D;
        Fri, 24 Jan 2020 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864575;
        bh=k9bEjcM9khWjU1lvMP8wt8eIb+F2yVIuEAMt2ua6bA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIPBvHXMHugI9hQMqWWRZ0x0CH3m+jsMTH5eixpoMiKgtQkERZX4Bo6VbPRCSSZQ4
         FxR5qheqxN+xFgNkTFHtRqbRaYLR+ff/+MCNzirahik+qTCMnVEfSrZtu+t7vnxZB8
         PZtM58FZHI1p8mubgTiTz8a96R4bftVRVP4Jo0JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 304/639] scsi: target/core: Fix a race condition in the LUN lookup code
Date:   Fri, 24 Jan 2020 10:27:54 +0100
Message-Id: <20200124093125.033868356@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 63f7479439c95bcd49b7dd4af809862c316c71a3 ]

The rcu_dereference(deve->se_lun) expression occurs twice in the LUN lookup
functions. Since these expressions are not serialized against deve->se_lun
assignments each of these expressions may yield a different result. Avoid
that the wrong LUN pointer is stored in se_cmd by reading deve->se_lun only
once.

Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Fixes: 29a05deebf6c ("target: Convert se_node_acl->device_list[] to RCU hlist") # v4.10
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index e9ff2a7c0c0e6..22e97a93728db 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -85,7 +85,7 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 			goto out_unlock;
 		}
 
-		se_cmd->se_lun = rcu_dereference(deve->se_lun);
+		se_cmd->se_lun = se_lun;
 		se_cmd->pr_res_key = deve->pr_res_key;
 		se_cmd->orig_fe_lun = unpacked_lun;
 		se_cmd->se_cmd_flags |= SCF_SE_LUN_CMD;
@@ -176,7 +176,7 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 			goto out_unlock;
 		}
 
-		se_cmd->se_lun = rcu_dereference(deve->se_lun);
+		se_cmd->se_lun = se_lun;
 		se_cmd->pr_res_key = deve->pr_res_key;
 		se_cmd->orig_fe_lun = unpacked_lun;
 		se_cmd->se_cmd_flags |= SCF_SE_LUN_CMD;
-- 
2.20.1



