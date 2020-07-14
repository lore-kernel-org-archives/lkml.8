Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F069FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39AE206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737720;
	bh=/oDceVRvBcZtcSeouwu1wm8VWD2sKbRTIpY4H/q1V0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iOgtBa6kHMpL172nKuruonPaMhtVXp57KnNyjqKK7/TY0HFaQyzmE5atmbCfU/guz
	 8SgY64cbskrMLouys0aE/yQt5pTa0w4tERtUc+gVpIkQ1z7y5HGfNg3v0yXqVFfFJv
	 OvRz8cD1V6w9Hiwvyrqtm1Elr/mJVHz0E1ix9kMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgGNOkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbgGNOkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C8C2256C;
        Tue, 14 Jul 2020 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737602;
        bh=/oDceVRvBcZtcSeouwu1wm8VWD2sKbRTIpY4H/q1V0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGOa9VWOxndJJgHevJe3rPaGNIclnKhXxQeJB2wfuc0Ha4Wdrajh/n4cbXpRjmTo8
         FaSwslddzknSprexSZ1wbwZ5Qs2gDmiIeWDOIEH3ASdIPv3bu2o4Llo42kNe8Uv4K1
         xyeIvzNBZ95Kb+kJ5NT6f3AX5M9Tp8DeCSjLsyXg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.14 06/12] xtensa: fix __sync_fetch_and_{and,or}_4 declarations
Date:   Tue, 14 Jul 2020 10:39:48 -0400
Message-Id: <20200714143954.4035840-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143954.4035840-1-sashal@kernel.org>
References: <20200714143954.4035840-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index dc7b470a423a6..58b79e2ea569c 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -82,13 +82,13 @@ void __xtensa_libgcc_window_spill(void)
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

