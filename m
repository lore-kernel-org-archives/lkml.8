Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFFC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BA222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273319;
	bh=yVKoFQeWdD+kVMucdxCuHDAfygTi7f9NtlyfxyaiVCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbRtsT2aZ3ITvaT+ddOAQdXcVOI69Iqy9Enwhq3AmkGYvdaXkTe9N3d9ncnFBDuR6
	 W7x2oyulEKKrGbv7SSwkBxGg3sLOpCEWckSNyWv/6qIWX+fzojseTybgZ93fgu4GbY
	 hZDT8cTTF4EyT4gs1EihN6do70YYUUrrNLMYqe04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgBUIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgBUIVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:21:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB832465D;
        Fri, 21 Feb 2020 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273310;
        bh=yVKoFQeWdD+kVMucdxCuHDAfygTi7f9NtlyfxyaiVCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ck2VxUerVXhQeH/0MSFPmu8JqHMOMVVfOt8LNA8lw7F7+ge9DpDjrVxp9xlhBS6NL
         o59WpO2ECLcKfpqLkJ5I7YZEvaIsLWbM0FRymY48eXyvX+QK15Gox5fIp6a3i+hKPU
         ZLDqWweogO4nXbqMxZNwAS06LP2Xa882YMysq5NE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/191] vme: bridges: reduce stack usage
Date:   Fri, 21 Feb 2020 08:41:35 +0100
Message-Id: <20200221072305.492040720@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 7483e7a939c074d887450ef1c4d9ccc5909405f8 ]

With CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3, the stack usage in vme_fake
grows above the warning limit:

drivers/vme/bridges/vme_fake.c: In function 'fake_master_read':
drivers/vme/bridges/vme_fake.c:610:1: error: the frame size of 1160 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/vme/bridges/vme_fake.c: In function 'fake_master_write':
drivers/vme/bridges/vme_fake.c:797:1: error: the frame size of 1160 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

The problem is that in some configurations, each call to
fake_vmereadX() puts another variable on the stack.

Reduce the amount of inlining to get back to the previous state,
with no function using more than 200 bytes each.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200107200610.3482901-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vme/bridges/vme_fake.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/vme/bridges/vme_fake.c b/drivers/vme/bridges/vme_fake.c
index 7d83691047f47..685a43bdc2a1d 100644
--- a/drivers/vme/bridges/vme_fake.c
+++ b/drivers/vme/bridges/vme_fake.c
@@ -418,8 +418,9 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 	}
 }
 
-static u8 fake_vmeread8(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u8 fake_vmeread8(struct fake_driver *bridge,
+					   unsigned long long addr,
+					   u32 aspace, u32 cycle)
 {
 	u8 retval = 0xff;
 	int i;
@@ -450,8 +451,9 @@ static u8 fake_vmeread8(struct fake_driver *bridge, unsigned long long addr,
 	return retval;
 }
 
-static u16 fake_vmeread16(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u16 fake_vmeread16(struct fake_driver *bridge,
+					     unsigned long long addr,
+					     u32 aspace, u32 cycle)
 {
 	u16 retval = 0xffff;
 	int i;
@@ -482,8 +484,9 @@ static u16 fake_vmeread16(struct fake_driver *bridge, unsigned long long addr,
 	return retval;
 }
 
-static u32 fake_vmeread32(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u32 fake_vmeread32(struct fake_driver *bridge,
+					     unsigned long long addr,
+					     u32 aspace, u32 cycle)
 {
 	u32 retval = 0xffffffff;
 	int i;
@@ -613,8 +616,9 @@ out:
 	return retval;
 }
 
-static void fake_vmewrite8(struct fake_driver *bridge, u8 *buf,
-			   unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite8(struct fake_driver *bridge,
+					      u8 *buf, unsigned long long addr,
+					      u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
@@ -643,8 +647,9 @@ static void fake_vmewrite8(struct fake_driver *bridge, u8 *buf,
 
 }
 
-static void fake_vmewrite16(struct fake_driver *bridge, u16 *buf,
-			    unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite16(struct fake_driver *bridge,
+					       u16 *buf, unsigned long long addr,
+					       u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
@@ -673,8 +678,9 @@ static void fake_vmewrite16(struct fake_driver *bridge, u16 *buf,
 
 }
 
-static void fake_vmewrite32(struct fake_driver *bridge, u32 *buf,
-			    unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite32(struct fake_driver *bridge,
+					       u32 *buf, unsigned long long addr,
+					       u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
-- 
2.20.1



