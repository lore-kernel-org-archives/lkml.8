Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DDE206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647183;
	bh=tAFtt0FP/YHelhbw3CZCB6T7kYIbsqFYoxocjmhIj58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qce4UqA2OCqAeyDxgASv6IeKGE+W/tsMm1EyjZpMS2rZtpDBjEW9/UJRjxyegndOc
	 3liEtR9PAFmOcqO7y+AqLUqbl35xTOKRTLT5MyVj2d9AQtv4Dfxl9TkHnEeMmj1gQt
	 FpWOFC5IwrJI3Edqkqy4Lnq5m2mmS9U6K4fADA3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgDKXTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgDKXNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F7E20CC7;
        Sat, 11 Apr 2020 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646833;
        bh=tAFtt0FP/YHelhbw3CZCB6T7kYIbsqFYoxocjmhIj58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUWWGWa9WHNG74UO8qZ2fWAJm0uBiyBwT6rMnLeQxYWUw+m7FrqzdqXjOG3xSGCq7
         yRtKxWN2UkYbhVd4m2pY3BgdzxtndxMlGoEobyfbzTDsfLO6wGcYJh37onF9Mqltc3
         cpNZS4zEJozhgOI0aADeamjuAqKrW6enp8gfAJkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, linux-audit@redhat.com
Subject: [PATCH AUTOSEL 4.14 22/37] audit: CONFIG_CHANGE don't log internal bookkeeping as an event
Date:   Sat, 11 Apr 2020 19:13:11 -0400
Message-Id: <20200411231327.26550-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231327.26550-1-sashal@kernel.org>
References: <20200411231327.26550-1-sashal@kernel.org>
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
index 35f1d706bd5b4..ac87820cc0825 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -316,8 +316,6 @@ static void audit_update_watch(struct audit_parent *parent,
 			if (oentry->rule.exe)
 				audit_remove_mark(oentry->rule.exe);
 
-			audit_watch_log_rule_change(r, owatch, "updated_rules");
-
 			call_rcu(&oentry->rcu, audit_free_rule_rcu);
 		}
 
-- 
2.20.1

