Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BABC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E806215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490468;
	bh=HfNeRFiC2zUx8WJjFYhP6dY0KTPulHcHSfWzbYvafII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HML9bW39f5Iu7uEK15+UzxR4MItVVXLr5v3tKvMrF9eUJNRqpTU8wfCWvdWPgxFbI
	 sze+xBqgEtote0UeIs4rw3Z+kK0GuGb/QV/BAh1Fz+T381xp05Q2YR19OvcVT6FzoI
	 Ss90X8YdCXvTWwH0VZ9hwJjzbhictr1n2dj6G03s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgDJDrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgDJDrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68E920936;
        Fri, 10 Apr 2020 03:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490465;
        bh=HfNeRFiC2zUx8WJjFYhP6dY0KTPulHcHSfWzbYvafII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUn1C2dzujcCm/uQR7nD9tMD8ehInaC2s8E8qHwQNH3KM3c5zy92uVmZPeiBkKq03
         fcV7CUPeSTCXohVe7ZF76VtN1F15Vpuft0EPJ0Z5rveYwLFvHGi7mmowuaETstzQuF
         psE8DDI7UNl54fjhOFE4PDA72ph66S9JAlIGNn9c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 58/68] md: check arrays is suspended in mddev_detach before call quiesce operations
Date:   Thu,  9 Apr 2020 23:46:23 -0400
Message-Id: <20200410034634.7731-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

[ Upstream commit 6b40bec3b13278d21fa6c1ae7a0bdf2e550eed5f ]

Don't call quiesce(1) and quiesce(0) if array is already suspended,
otherwise in level_store, the array is writable after mddev_detach
in below part though the intention is to make array writable after
resume.

	mddev_suspend(mddev);
	mddev_detach(mddev);
	...
	mddev_resume(mddev);

And it also causes calltrace as follows in [1].

[48005.653834] WARNING: CPU: 1 PID: 45380 at kernel/kthread.c:510 kthread_park+0x77/0x90
[...]
[48005.653976] CPU: 1 PID: 45380 Comm: mdadm Tainted: G           OE     5.4.10-arch1-1 #1
[48005.653979] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./J4105-ITX, BIOS P1.40 08/06/2018
[48005.653984] RIP: 0010:kthread_park+0x77/0x90
[48005.654015] Call Trace:
[48005.654039]  r5l_quiesce+0x3c/0x70 [raid456]
[48005.654052]  raid5_quiesce+0x228/0x2e0 [raid456]
[48005.654073]  mddev_detach+0x30/0x70 [md_mod]
[48005.654090]  level_store+0x202/0x670 [md_mod]
[48005.654099]  ? security_capable+0x40/0x60
[48005.654114]  md_attr_store+0x7b/0xc0 [md_mod]
[48005.654123]  kernfs_fop_write+0xce/0x1b0
[48005.654132]  vfs_write+0xb6/0x1a0
[48005.654138]  ksys_write+0x67/0xe0
[48005.654146]  do_syscall_64+0x4e/0x140
[48005.654155]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[48005.654161] RIP: 0033:0x7fa0c8737497

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=206161

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 469f551863bea..0b30ada971c14 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6184,7 +6184,7 @@ EXPORT_SYMBOL_GPL(md_stop_writes);
 static void mddev_detach(struct mddev *mddev)
 {
 	md_bitmap_wait_behind_writes(mddev);
-	if (mddev->pers && mddev->pers->quiesce) {
+	if (mddev->pers && mddev->pers->quiesce && !mddev->suspended) {
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
 	}
-- 
2.20.1

