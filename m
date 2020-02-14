Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADFBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B424748
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697266;
	bh=IanB/lM2ZpQpeoxyeB6ocDTSzPJwvsxqB0XyUjcUZus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGWzxwfo2FP9DlPYqtr+dgev+DQxcqHmqvi8bKPM0vpoAZJkQYBCIKxEIOr/9J4gI
	 j7evlrbivA1W8UegjJ7KjYt1F+JJhsztA5K4pkfdADAXKNcPJrnLBVrJjW57xU6Chm
	 dTPlEXmSUKC+odcVw83lZmIoJLspmNN/ULAB3cn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbgBNQVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392271AbgBNQT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3BE2471E;
        Fri, 14 Feb 2020 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697195;
        bh=IanB/lM2ZpQpeoxyeB6ocDTSzPJwvsxqB0XyUjcUZus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWi48oFOjwQYky84TFwVfx/F1aORMeZtuKihQaGFabsjNeZ5+MKggY8HsHGAeyhqu
         RCqWalZJE3t+DaQ3pT5VC1uwejoZ/7+DScZhBIKPhxrQwhjhN0v3KNhxaEPkUTA335
         j+KGlwZgS/2RpbJ7KadBZI352RwCfu1vyYtKp6EQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 124/186] vme: bridges: reduce stack usage
Date:   Fri, 14 Feb 2020 11:16:13 -0500
Message-Id: <20200214161715.18113-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 30b3acc938330..e81ec763b5555 100644
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
@@ -613,8 +616,9 @@ static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
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

