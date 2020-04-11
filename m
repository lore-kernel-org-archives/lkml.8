Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A35FC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE61A20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646319;
	bh=6ujQpcxIGithtYCTLKGJdniW/4CHxY9NdvXu1hLNzmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iXa0kEB4hNm15qrV9KQ6M8VQuYCfx3dte1J/yUd+DtkUCvWSmvfXQkfgwn3RAfKjH
	 gWl8INxkYhAuhC8WVHRLEK/rhs6z3CRHyL1L6lzOPWbDEJcYJoUIEYlzSwARlffONn
	 yIHdNIzSa7/rTZ5/9uJlX/TxR3A3NTAu4plxUApE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDKXFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgDKXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB7D214D8;
        Sat, 11 Apr 2020 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646313;
        bh=6ujQpcxIGithtYCTLKGJdniW/4CHxY9NdvXu1hLNzmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kL81xW8Tm5coN1QxiZzoEFvudor1y/QlYPgrMSH6ZTb1F0XD6+8psJksCDwTi9a8J
         Xjy5iaGLyk4Q8IEchBts44xnV0C3H9P7Ll3cWE7lN6y5ZzPkY7ZPPK1Ox436Dpe82o
         5BYKUZIK98JOjgCqjRhyeNFaNa4Ncgo+FABK5oEU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, linux-audit@redhat.com
Subject: [PATCH AUTOSEL 5.6 070/149] audit: CONFIG_CHANGE don't log internal bookkeeping as an event
Date:   Sat, 11 Apr 2020 19:02:27 -0400
Message-Id: <20200411230347.22371-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>

[ Upstream commit 70b3eeed49e8190d97139806f6fbaf8964306cdb ]

Common Criteria calls out for any action that modifies the audit trail to
be recorded. That usually is interpreted to mean insertion or removal of
rules. It is not required to log modification of the inode information
since the watch is still in effect. Additionally, if the rule is a never
rule and the underlying file is one they do not want events for, they
get an event for this bookkeeping update against their wishes.

Since no device/inode info is logged at insertion and no device/inode
information is logged on update, there is nothing meaningful being
communicated to the admin by the CONFIG_CHANGE updated_rules event. One
can assume that the rule was not "modified" because it is still watching
the intended target. If the device or inode cannot be resolved, then
audit_panic is called which is sufficient.

The correct resolution is to drop logging config_update events since
the watch is still in effect but just on another unknown inode.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit_watch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 4508d5e0cf696..8a8fd732ff6d0 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -302,8 +302,6 @@ static void audit_update_watch(struct audit_parent *parent,
 			if (oentry->rule.exe)
 				audit_remove_mark(oentry->rule.exe);
 
-			audit_watch_log_rule_change(r, owatch, "updated_rules");
-
 			call_rcu(&oentry->rcu, audit_free_rule_rcu);
 		}
 
-- 
2.20.1

