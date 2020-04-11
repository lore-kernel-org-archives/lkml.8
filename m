Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C6C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E71E20769
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647435;
	bh=Iu8YLEv6HTJ0K3Fq7pBORIeZQWWFNqMsiAXrnMBJ7IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dna/rwFgNmW+NMlrO5noVns2gtL4hwsx37iLzCPkMHM841m7kYeAeLGbPFClmXQn6
	 moFbCO8aXaEfzXVyjW76ygqUQTDgHjt52yVlME4IsHbBRjG3R9Daq9bEMqs5hIJSaD
	 DBGFb0yO2LB6buasdLkhrX/jkpzERbzchvsrAp2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgDKXXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgDKXMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:12:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158D721835;
        Sat, 11 Apr 2020 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646764;
        bh=Iu8YLEv6HTJ0K3Fq7pBORIeZQWWFNqMsiAXrnMBJ7IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Px/+5Ly50SGaL3plZBGtuBPAtd6cj1xpuu3ZZXSEOmZLRjjZ6dHxaK8iSknJfVkPP
         CBoJ443yOyyYLaGbZO+y0ZKcEyUNagzlqZu483zY4hcKXap/o5Timdur1ac5spZlkl
         tjU8q42iUM7KlgJtvTYzsEJwPzuw8dkUrxyiPp+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, linux-audit@redhat.com
Subject: [PATCH AUTOSEL 4.19 34/66] audit: CONFIG_CHANGE don't log internal bookkeeping as an event
Date:   Sat, 11 Apr 2020 19:11:31 -0400
Message-Id: <20200411231203.25933-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
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
index 4f7262eba73d8..50952d6d81209 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -317,8 +317,6 @@ static void audit_update_watch(struct audit_parent *parent,
 			if (oentry->rule.exe)
 				audit_remove_mark(oentry->rule.exe);
 
-			audit_watch_log_rule_change(r, owatch, "updated_rules");
-
 			call_rcu(&oentry->rcu, audit_free_rule_rcu);
 		}
 
-- 
2.20.1

