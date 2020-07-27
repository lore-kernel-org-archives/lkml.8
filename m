Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DAC4345F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9892173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858842;
	bh=sBlIDratQge2VL5mKrYyOWXeH5CBn8//65YLzsUrzDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yaMf0raQNRo3bfNKE9pKwZwYwPp4Cjzy/TgE2EjIzEkQHo551sM2Ag7vl2y628YxU
	 t0ct11Dju+VqLsEAyp1x85hLFTb7ZqVoghDRzuWFAjCvFjmIvFSmR4Xg5TKBrFePUO
	 nYHMVqq65f6fm0vwsuC1hH9qSZyToTX+jbBNHgUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgG0OHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgG0OHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7199F2083B;
        Mon, 27 Jul 2020 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858836;
        bh=sBlIDratQge2VL5mKrYyOWXeH5CBn8//65YLzsUrzDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHlbxHLYmx1Ffz+RIqIHjlTHEcC+RcqjBU8XqSYxzoLR2AGgOnUBx7Qnxoq2TMMOA
         YLs8h/KgpcJxm+0CUcRNHjEIIWIsJfxWDRq320JTPyY6FaqQGhw+6brqCFsoibCUZ4
         kNbHHAJPvypY0nvzHG2Nw/SXZvYXkVTDz1ONWK+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/64] xtensa: update *pos in cpuinfo_op.next
Date:   Mon, 27 Jul 2020 16:03:46 +0200
Message-Id: <20200727134911.401001718@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
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
index 92fb20777bb0e..a19c61b261422 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -711,7 +711,8 @@ c_start(struct seq_file *f, loff_t *pos)
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



