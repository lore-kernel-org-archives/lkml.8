Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C60C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D152173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859265;
	bh=07Y0K6B/jas/WfqhlgWNpkqqZf+TC6BP68ukDb77Of0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lH1G605J8HFo2hodXs7ZQhHeTEfP/dV1wDy/QmIQZtN4E2foin4r1ZfbPq4DjE5cb
	 7DyBLLRR3RMyZYYbQukXlVxRhaL7NMNCao3tEJzPyeEGM1/gFu9+33uQPcuFbhohRQ
	 ODW/1q5Xekn78fUem6uHGvMr6I1QSvSHbGO0Ebho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgG0OOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729945AbgG0OOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09142073E;
        Mon, 27 Jul 2020 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859256;
        bh=07Y0K6B/jas/WfqhlgWNpkqqZf+TC6BP68ukDb77Of0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDZeuwFQfPPoJmd4OIvOVKhJVYs1zCZZI1+w12sYA8KKFAtdLOiaZBEQ1wMQLD3Lq
         kvYhg1abE2aJH+Xx2ygQS+cSHmoEEpBSukbConBsuL6GrON0XsSxWLHUmUWTr7tKYE
         zQRTKaH7o4CzrX68W1DsTvT5ynjruYX7CzvxWnFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 008/138] xtensa: update *pos in cpuinfo_op.next
Date:   Mon, 27 Jul 2020 16:03:23 +0200
Message-Id: <20200727134925.661395495@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 0d5ab144429e8bd80889b856a44d56ab4a5cd59b ]

Increment *pos in the cpuinfo_op.next to fix the following warning
triggered by cat /proc/cpuinfo:

  seq_file: buggy .next function c_next did not update position index

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index e0e1e1892b86b..d08172138369b 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -716,7 +716,8 @@ c_start(struct seq_file *f, loff_t *pos)
 static void *
 c_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	return NULL;
+	++*pos;
+	return c_start(f, pos);
 }
 
 static void
-- 
2.25.1



