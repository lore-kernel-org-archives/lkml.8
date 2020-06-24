Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97992073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593039058;
	bh=UsPcBeVv1Rqr8ERJdYj0ADqcOXxfVl4BMzopt1LKGX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzr0ogmFIvM2DR9gSHuTB8YNDR3LcnWvYdGf7u90k3znpSYtRvYwSeCX1pkhM4y6B
	 nMepSAE9/sX09mX4zwSwkq7AcrmdWswGTAOQrbCe3myRU5SLjcfLZLimHaihKNgGsk
	 QWo9ux312o23WFWi1gAvhQWhu3mWVq8LUTE44Xt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbgFXWu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388364AbgFXWuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:50:54 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D2F2073E;
        Wed, 24 Jun 2020 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593039053;
        bh=UsPcBeVv1Rqr8ERJdYj0ADqcOXxfVl4BMzopt1LKGX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd8+UoJTSFrGXJtiKYWzlIC+Y3XXddwxrKrpVFsrj4mnilokE+0P6gU2AY89HBjOc
         KxA1XLJuIkUhI1en+zzNDBLcr8zpHDlvgnCS35Q1xTEtpNgRRRnJrXMASyrZ7FHMP+
         4KsMEPR5BJ5MPBJbeSq0AX+0X97fnU/+KyRwqD5s=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] selftests/x86/fsgsbase: Add a missing memory constraint
Date:   Wed, 24 Jun 2020 15:50:49 -0700
Message-Id: <432968af67259ca92d68b774a731aff468eae610.1593038991.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593038991.git.luto@kernel.org>
References: <cover.1593038991.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual call to set_thread_area() via int $0x80 was missing any
indication that the descriptor was a pointer, causing gcc to
occasionally generate wrong code.  Add the missing constraint.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f47495d2f070..998319553523 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -285,7 +285,8 @@ static unsigned short load_gs(void)
 		/* 32-bit set_thread_area */
 		long ret;
 		asm volatile ("int $0x80"
-			      : "=a" (ret) : "a" (243), "b" (low_desc)
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
 			      : "r8", "r9", "r10", "r11");
 		memcpy(&desc, low_desc, sizeof(desc));
 		munmap(low_desc, sizeof(desc));
-- 
2.25.4

