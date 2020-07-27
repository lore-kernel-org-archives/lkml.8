Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4926C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF1B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859259;
	bh=cqwlgHyPsfPuA8z4WrenfxsuVzf4oQ5bGA82xRt0E4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nduxiGdlErYvNeNri2h8sbgZHZwASx1jxmvWhb8J2MTQzTNxHnCJTincYHw16yp6O
	 uFpwAFBZXeFGea/9Ijw0MhLsaHRNmk1koSEO7Ly6CH0bkrXF8bZNzjcWB6E5w/mCLY
	 P+ITQy5s43rj2TcLK9STlPrEn6e8ZzpGciFmxGJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgG0OOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbgG0OOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60842073E;
        Mon, 27 Jul 2020 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859253;
        bh=cqwlgHyPsfPuA8z4WrenfxsuVzf4oQ5bGA82xRt0E4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgqPhIWeRuipXGA5GlIJWlk7Q4osFBR1gFucyOuEwvxdXny5BEFQw76zbD/2mAKMb
         Bwp0iiP/eb7c5Ymy9EewhuJQRM3+qW0XTbOA02AnAUCnD50TsoMF9h+oP8dNFbR/F7
         N1zuqNbKrtIW4YNjMZvdfy3lAaUeV2n0rqajoeSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/138] xtensa: fix __sync_fetch_and_{and,or}_4 declarations
Date:   Mon, 27 Jul 2020 16:03:22 +0200
Message-Id: <20200727134925.611026484@linuxfoundation.org>
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

[ Upstream commit 73f9941306d5ce030f3ffc7db425c7b2a798cf8e ]

Building xtensa kernel with gcc-10 produces the following warnings:
  arch/xtensa/kernel/xtensa_ksyms.c:90:15: warning: conflicting types
    for built-in function ‘__sync_fetch_and_and_4’;
    expected ‘unsigned int(volatile void *, unsigned int)’
    [-Wbuiltin-declaration-mismatch]
  arch/xtensa/kernel/xtensa_ksyms.c:96:15: warning: conflicting types
    for built-in function ‘__sync_fetch_and_or_4’;
    expected ‘unsigned int(volatile void *, unsigned int)’
    [-Wbuiltin-declaration-mismatch]

Fix declarations of these functions to avoid the warning.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/xtensa_ksyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 4092555828b13..24cf6972eacea 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -87,13 +87,13 @@ void __xtensa_libgcc_window_spill(void)
 }
 EXPORT_SYMBOL(__xtensa_libgcc_window_spill);
 
-unsigned long __sync_fetch_and_and_4(unsigned long *p, unsigned long v)
+unsigned int __sync_fetch_and_and_4(volatile void *p, unsigned int v)
 {
 	BUG();
 }
 EXPORT_SYMBOL(__sync_fetch_and_and_4);
 
-unsigned long __sync_fetch_and_or_4(unsigned long *p, unsigned long v)
+unsigned int __sync_fetch_and_or_4(volatile void *p, unsigned int v)
 {
 	BUG();
 }
-- 
2.25.1



