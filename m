Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E69C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC58E2468F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220677;
	bh=t5ny8PEuCs5am1D3TXfcmm8yHKeBcbZDpHXebyKuT78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6/8Fne+ntzVzF5Hbb4n2PiJDWUUHrBXPYIgA660GX8GeyLGkR4hpMpvkPKUTW2Yb
	 jdMD0gNTO55Qov6oxfMFHaeKT3IgRgJNqDQDjE2LePJ7eLWWIMBUORZZ+X5QLi4c3G
	 nD33CrvP2rte51pJwfTML/M4XxzPW+gyo0KlBoOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgA1OLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgA1OLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:11:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6507D2468E;
        Tue, 28 Jan 2020 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220671;
        bh=t5ny8PEuCs5am1D3TXfcmm8yHKeBcbZDpHXebyKuT78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTYd1MDqNls3CkI89gU7307CVpYJU9d2yvseFmJ49T3tUHUdTIR3kaBqh2cEc9fA9
         f4523sBQJ65DPUomfLbryWcTr0MHwv8FTJP69KZJJ5ZIuR92L6KZzPfJ14eVF95B+H
         KCG+TlwKgqwRKft1HwFeQoQKatjmhZdYFjbdFuVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 100/183] media: vivid: fix incorrect assignment operation when setting video mode
Date:   Tue, 28 Jan 2020 15:05:19 +0100
Message-Id: <20200128135840.024081004@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit d4ec9550e4b2d2e357a46fdc65d8ef3d4d15984c ]

The assigment of FB_VMODE_NONINTERLACE to var->vmode should be a
bit-wise or of FB_VMODE_NONINTERLACE instead of an assignment,
otherwise the previous clearing of the FB_VMODE_MASK bits of
var->vmode makes no sense and is redundant.

Addresses-Coverity: ("Unused value")
Fixes: ad4e02d5081d ("[media] vivid: add a simple framebuffer device for overlay testing")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vivid/vivid-osd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-osd.c b/drivers/media/platform/vivid/vivid-osd.c
index e15eef6a94e55..f3afc74f98eda 100644
--- a/drivers/media/platform/vivid/vivid-osd.c
+++ b/drivers/media/platform/vivid/vivid-osd.c
@@ -167,7 +167,7 @@ static int _vivid_fb_check_var(struct fb_var_screeninfo *var, struct vivid_dev *
 	var->nonstd = 0;
 
 	var->vmode &= ~FB_VMODE_MASK;
-	var->vmode = FB_VMODE_NONINTERLACED;
+	var->vmode |= FB_VMODE_NONINTERLACED;
 
 	/* Dummy values */
 	var->hsync_len = 24;
-- 
2.20.1



