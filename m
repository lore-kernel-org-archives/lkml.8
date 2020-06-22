Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C5020767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865850;
	bh=xJvegWGk+4xRGSyS7QgiFgHOtwYQUhVUyid9svYyZYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAEfOdV4KT+gALR3f6QftVLJRUmMKyvNVTZ2lH00YsXpzoyHL9Cnj15k4D18/ocAd
	 2N+6p9vzG2RfIi3t1lWhUGBBecdnWsZNoS3te0kGBiw7Gv3vzrjSJIbPe/IpJsWoPS
	 JOBJ0PUgt4wU4LXqkO8QMVyZeAKNKqhgj9TuiK7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgFVWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbgFVWnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1CB20809;
        Mon, 22 Jun 2020 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865791;
        bh=xJvegWGk+4xRGSyS7QgiFgHOtwYQUhVUyid9svYyZYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVQAhgGU/VfPmvdzUF0hoi3A+ZxLOZEp3FDWXnWFdIRmVtt6CQWUnt4DlKh9KPJND
         foHKEn0nr5d4pNaItH+umKYIGp9LDniZcMFNELJkOH91A7/jfJLuDui2trqLCfHr/e
         gJpVV4/lxqRinWup5v1ouRcV+f75kwc1ey/fAxQk=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 07/14] tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
Date:   Mon, 22 Jun 2020 18:42:51 -0400
Message-Id: <20200622224258.1208588-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They already exist in tools/lib/, and are now required by liblockdep, so
just add them to the build manifest.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
index 219a9e2d9e0ba..1e7c25690b8ea 100644
--- a/tools/lib/lockdep/Build
+++ b/tools/lib/lockdep/Build
@@ -1 +1 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o
+liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o ../../lib/vsprintf.o ../../lib/find_bit.o ../../lib/hweight.o
-- 
2.25.1

