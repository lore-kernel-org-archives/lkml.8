Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924DB206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586265;
	bh=hdSJ0WSegTcwByJEJ9Fu9kUCV4GsRKEAjQS6V1gITUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxsLJXL/Gdaiank7cWBeK94kbFhxRvJr7eO+udP5bs/5c43jcLAzG9qSvdQb/XLOZ
	 LENDTzMPKap2YkHLmXD+lLn78DwXkmhdKGDKAkRbC/TpjsOYJQpZhj6clGeQdiTu6m
	 QcBJXiBic2fcNLT7iRAYqADxVsMdE5k6huJ66pKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHEALE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgHEAK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFCBE22D02;
        Wed,  5 Aug 2020 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586257;
        bh=hdSJ0WSegTcwByJEJ9Fu9kUCV4GsRKEAjQS6V1gITUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zrf9/4Hpzt8dCMlB1VtnKvftlwMMYnqHzNzuhhz2lqBtp1riFr0KSn5QRw3ii+yT3
         iRYZDsYsmX6Fpd/vpB4gdJTbIVykwoNOWCk3AE6XbowJkBIuTihSFz7PHRzX7qcm0Q
         v2QAWQJGo9qgQrSZyN10LNb+4NYq6i4UW470GTFo=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 13/14] tools/lib/lockdep: explicitly declare lockdep_init_task()
Date:   Tue,  4 Aug 2020 20:10:42 -0400
Message-Id: <20200805001043.3331907-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a warning as we can't pull the decleration for lockdep's header.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/preload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 5bd58c51066c4..2928c712f87f8 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -92,6 +92,8 @@ static int (*ll_pthread_rwlock_trywrlock)(pthread_rwlock_t *rwlock)	= __pthread_
 static int (*ll_pthread_rwlock_wrlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_wrlock;
 static int (*ll_pthread_rwlock_unlock)(pthread_rwlock_t *rwlock)	= __pthread_rwlock_unlock;
 
+extern void lockdep_init_task(struct task_struct *task);
+
 enum { none, prepare, done, } __init_state;
 static void init_preload(void);
 static void try_init_preload(void)
-- 
2.25.1

