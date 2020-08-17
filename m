Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599CA206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677656;
	bh=VLP/nBpUSkz4WWAdRvAhTstnn307YSe6AuseI60IAGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLzVEGllBkuW77rdUG5qBRiJQr/u4WNp3SkOL8WAG5/ADf/TcihvhIM8Bcs22W0HD
	 noFAMWExg56K5i+FnOJvh/f1V+VHVWSy9FxYLc3g/gttyLrDE06RvZqf14VwlZN/d/
	 DGZF5WmOhXxNLys8/9/4Aqso4vPq7VAYNzHQ4L8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgHQPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbgHQPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:19:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D8B20716;
        Mon, 17 Aug 2020 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677550;
        bh=VLP/nBpUSkz4WWAdRvAhTstnn307YSe6AuseI60IAGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCnwaOgdWXD3d47qc+RswFeZhUlQfz0YZ2FqrETnlLtqXqanTYFqhHax2elctoAOT
         Cue2sQv8gxgQXtCL6KnU7tapSHk0mzd7FGJfa+fr7jGsoMY/+JAW3wIKCsZBNyFMuo
         krAvl4Clq4HU83UJ7BVvi/WOFFxT9prXHdGBAYoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 007/464] x86/mce/inject: Fix a wrong assignment of i_mce.status
Date:   Mon, 17 Aug 2020 17:09:20 +0200
Message-Id: <20200817143834.098171185@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

[ Upstream commit 5d7f7d1d5e01c22894dee7c9c9266500478dca99 ]

The original code is a nop as i_mce.status is or'ed with part of itself,
fix it.

Fixes: a1300e505297 ("x86/ras/mce_amd_inj: Trigger deferred and thresholding errors interrupts")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20200611023238.3830-1-zhenzhong.duan@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0593b192eb8fa..7843ab3fde099 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -511,7 +511,7 @@ static void do_inject(void)
 	 */
 	if (inj_type == DFR_INT_INJ) {
 		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
+		i_mce.status &= ~MCI_STATUS_UC;
 	}
 
 	/*
-- 
2.25.1



