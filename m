Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8420768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464791;
	bh=YTZTX/HW4bzFCEoWYcFvAJ8JvT4/2afAu5EYeErSCCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fy3/ohY4oOqQEJOnQl+RA1FtSRrxzGiuZSbCcLflNHqpxkAFFEefcVvt94IzWeq7u
	 Ff4jQwMZ6LB+i3jcG27QG9NVX+l3Gf8umklA2cLxIZ9K7SAva2L0QSajvkX252NBeq
	 tOJXh5vRfqFzCvqA143lVQ/AUvd8JJvnU3lMbGvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgF2VG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbgF2TKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AF0254BD;
        Mon, 29 Jun 2020 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446015;
        bh=YTZTX/HW4bzFCEoWYcFvAJ8JvT4/2afAu5EYeErSCCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xekcbaSRvuPnq4f3MfuVyuItIpQuO5y3vmNLYLSSKZ05FCe08MrjZNXvuOqjwP26g
         Vmy+BHqa1j7P2ScxqRM08/wNKJhr/eikFI/ZZdfQ13lD6FfjNpMzin0WvxJuT+Ns8i
         ngmFmhK1X9t/0oescYeGftXBsPQRxT3q2EZeLm/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 022/135] staging: sm750fb: add missing case while setting FB_VISUAL
Date:   Mon, 29 Jun 2020 11:51:16 -0400
Message-Id: <20200629155309.2495516-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matej Dujava <mdujava@kocurkovo.cz>

[ Upstream commit fa90133377f4a7f15a937df6ad55133bb57c5665 ]

Switch statement does not contain all cases: 8, 16, 24, 32.
This patch will add missing one (24)

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
Link: https://lore.kernel.org/r/1588277366-19354-2-git-send-email-mdujava@kocurkovo.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/sm750fb/sm750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 860e1c288ad5e..75b47d61318a1 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -894,6 +894,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 16:
+	case 24:
 	case 32:
 		fix->visual = FB_VISUAL_TRUECOLOR;
 		break;
-- 
2.25.1

