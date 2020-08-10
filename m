Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2342080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087197;
	bh=FMih3/NXQq2ch2XERRB4MAPKDg5dZDiGVAUyMNS6M6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFWWPIomz1eZNQol9egvEKbcLcfvXKrGIkQKMYJkVKgrKwfFA0Kp2f9qRYH0bmfbU
	 MBdIBj2HHqK26sMkZgUuogMlT00Nuset8kfPo55A7D39aKQxbsk37eCP9LbQAsABh3
	 8WFfhtJsz+wIqBMcjVgiErzCeimM+sFSgC5O+WQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgHJTOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgHJTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850FB22DCC;
        Mon, 10 Aug 2020 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086832;
        bh=FMih3/NXQq2ch2XERRB4MAPKDg5dZDiGVAUyMNS6M6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZiOsAeRfMi0ma47KvqGmCOCJu3ncaNCzFMpeWSrepTbca3IbI5tgdA6nByn5pE0y
         4LHd2twPHt1HvN32D6KYxdMV6EO6Nw+a1KIOtztJ+4QdhCETpWDhUKrdT55A4tFd0I
         UyGVgZ0CHvIpNKtVfHyxaCaWEghGrN01JTPUb16Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Jani Nikula <jani.nikula@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/22] video: fbdev: neofb: fix memory leak in neo_scan_monitor()
Date:   Mon, 10 Aug 2020 15:13:27 -0400
Message-Id: <20200810191345.3795166-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191345.3795166-1-sashal@kernel.org>
References: <20200810191345.3795166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit edcb3895a751c762a18d25c8d9846ce9759ed7e1 ]

neofb_probe() calls neo_scan_monitor() that can successfully allocate a
memory for info->monspecs.modedb and proceed to case 0x03. There it does
not free the memory and returns -1. neofb_probe() goes to label
err_scan_monitor, thus, it does not free this memory through calling
fb_destroy_modedb() as well. We can not go to label err_init_hw since
neo_scan_monitor() can fail during memory allocation. So, the patch frees
the memory directly for case 0x03.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200630195451.18675-1-novikov@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/neofb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 5d3a444083f74..2018e1ca33eb6 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1820,6 +1820,7 @@ static int neo_scan_monitor(struct fb_info *info)
 #else
 		printk(KERN_ERR
 		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
+		kfree(info->monspecs.modedb);
 		return -1;
 #endif
 	default:
-- 
2.25.1

