Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC482187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698190;
	bh=03m/YZuxHUtpmwUPg60w1w/fNkSrmXYJ/3/BRkmRcWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YhUk46MBrErQ/KrOajqI4MSOHhEYN/fbApXG6Knz0njhCkTJyxDHxMhC4mfFn6dME
	 wElQcTAfVPRj4ML54VvX1ZcOF8d6XfOht7ijVRAy4WfIfzrfanJD4pFi5iQROV0SMG
	 e6vQ7S7gw974fHXZQJB1tn2TKwcXyQ9yFGb7b0Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393702AbgBNQg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405857AbgBNQYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C0824795;
        Fri, 14 Feb 2020 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697458;
        bh=03m/YZuxHUtpmwUPg60w1w/fNkSrmXYJ/3/BRkmRcWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neGE/R5Sm4/rYVA2Eybu5HZoulgNO0yf099M4eWOuclm+DfahwMNYwEGhnoJ7D4O/
         zCM1J1TkTdjy5oqBh4Fd4llFl3i9nKZTie74hiDlUVtMJaXgkdfY8UvMaDsaVeM59b
         SQTlms/UtMltdK7V7MNf/aNfe0jqfyiu6jg6FH+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <sashal@kernel.org>, devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 4.9 141/141] help_next should increase position index
Date:   Fri, 14 Feb 2020 11:21:21 -0500
Message-Id: <20200214162122.19794-141-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 9f198a2ac543eaaf47be275531ad5cbd50db3edf ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/orangefs-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 0748a26598fca..7d7df003f9d8d 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -304,6 +304,7 @@ static void *help_start(struct seq_file *m, loff_t *pos)
 
 static void *help_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	(*pos)++;
 	gossip_debug(GOSSIP_DEBUGFS_DEBUG, "help_next: start\n");
 
 	return NULL;
-- 
2.20.1

