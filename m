Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A070FC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3D2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273083;
	bh=FS3L3yG/rhK7rounToW5SqQk3cLwYGBGWRco0CrV6Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yVYNMMUlEB3BbRJsv3Yq2q9UMcNMq9jdOeZnGQial4/0WLfJWPKvFensi0K4LaH3E
	 cD18PnvEhdnDfDrkFnsO/Hq5umJG9BI5dtrPQ9u73zNOiK9ub0YGLKnAMcNKFfUTL7
	 O3ylqRCpygypjknP1hML0P2xJKI/JK8cYA8LAHf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgBUISB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387686AbgBUIRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:17:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1C624682;
        Fri, 21 Feb 2020 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273073;
        bh=FS3L3yG/rhK7rounToW5SqQk3cLwYGBGWRco0CrV6Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1OjTJwJ1gMSAJr8YJN1bUCYCqaOLzNBFII2az8dyPDFg71R20urdQMkRvCiGlJ4u
         9ipUJ2ZiwnpTiX9NWRLEHKhhuSQlQMPhknCs3rFHEt0PTecUhS1p/NaA6HghgBTAeM
         ZsTgxXsvGWFXG0ZWq7r3KMYKH+UqghjX2CnQNCuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai Li <li.kai4@h3c.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/191] jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
Date:   Fri, 21 Feb 2020 08:40:09 +0100
Message-Id: <20200221072255.920372435@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Li <li.kai4@h3c.com>

[ Upstream commit a09decff5c32060639a685581c380f51b14e1fc2 ]

If the journal is dirty when the filesystem is mounted, jbd2 will replay
the journal but the journal superblock will not be updated by
journal_reset() because JBD2_ABORT flag is still set (it was set in
journal_init_common()). This is problematic because when a new transaction
is then committed, it will be recorded in block 1 (journal->j_tail was set
to 1 in journal_reset()). If unclean shutdown happens again before the
journal superblock is updated, the new recorded transaction will not be
replayed during the next mount (because of stale sb->s_start and
sb->s_sequence values) which can lead to filesystem corruption.

Fixes: 85e0c4e89c1b ("jbd2: if the journal is aborted then don't allow update of the log tail")
Signed-off-by: Kai Li <li.kai4@h3c.com>
Link: https://lore.kernel.org/r/20200111022542.5008-1-li.kai4@h3c.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1a2339f2cb49b..568ca0ca0127c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1701,6 +1701,11 @@ int jbd2_journal_load(journal_t *journal)
 		       journal->j_devname);
 		return -EFSCORRUPTED;
 	}
+	/*
+	 * clear JBD2_ABORT flag initialized in journal_init_common
+	 * here to update log tail information with the newest seq.
+	 */
+	journal->j_flags &= ~JBD2_ABORT;
 
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
@@ -1708,7 +1713,6 @@ int jbd2_journal_load(journal_t *journal)
 	if (journal_reset(journal))
 		goto recovery_error;
 
-	journal->j_flags &= ~JBD2_ABORT;
 	journal->j_flags |= JBD2_LOADED;
 	return 0;
 
-- 
2.20.1



