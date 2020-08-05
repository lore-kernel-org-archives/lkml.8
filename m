Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8478C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF26720738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586281;
	bh=xJvegWGk+4xRGSyS7QgiFgHOtwYQUhVUyid9svYyZYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOH00WJpPB2Brm0GbfDgrFR9zmMSjjvQhO4DwBDy99wgakTCRNa186RgU2wZD5flk
	 LLj3uMJUaeykk97K3envLHf5Vz1WsfkcBx17QnQ7/jo6MRBqN5YBwOOOehOC9dH5nL
	 jm87yZBj/oO2RiCZihK8BHaswvn65ToR8JOVUl1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHEALU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgHEAKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BA522CE3;
        Wed,  5 Aug 2020 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586252;
        bh=xJvegWGk+4xRGSyS7QgiFgHOtwYQUhVUyid9svYyZYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=De/W7568wogxYkeBdjD9Grj6FGPpSeOfrKHcF4d7U3KQXt0mV+Rq9kSeCACfhuZsU
         OQJTkWa7E50jGDaxR7OoVUbcJT4jia2kyFPUcJXhStZvbCw8PAxCTRySuDA0Uqxb6S
         PD2tOK4ISir91L7Ly/koSWDfcOv+Orqw8GL4if/U=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 07/14] tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
Date:   Tue,  4 Aug 2020 20:10:36 -0400
Message-Id: <20200805001043.3331907-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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

