Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56999C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2975720658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918859;
	bh=DCP153UuCuLNtr0k7Pe5NsMiXDM87xdDviXKXADwZ44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUmZFk5MZEQXNq9Gwtr++Gsd8ukmsLq+7NIJfLzES6jixIZ5XlkEvq0Ta6KmOiT96
	 0W6QANFT+ppQ0QwHkQcLdWFh6kA1Z4ea4PnPvCuDL6YnGVKpENrlgTkWOTaARHjoxp
	 YkpzQ8ScYK6EenpBh1Lz0UYudvxcYqkeOXRbVCTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgHTKU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbgHTKUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FDA20658;
        Thu, 20 Aug 2020 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918851;
        bh=DCP153UuCuLNtr0k7Pe5NsMiXDM87xdDviXKXADwZ44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9Euzh9M7aAjDsBXEzFgZW3UQ+4GsnDrNYqCKqKZDcvLpI2xfXIUea5cDW9PNTKDl
         pDZcHYY8fi0UTkPqBPGpgLxSKihu80N/mO9m/sZIH3DnhJ344F+DBbSiknBOeSBpNe
         RhzmE9Q9Vqtqcqk9ySurCNUODv7LBbJHazc5XVok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 089/149] media: exynos4-is: Add missed check for pinctrl_lookup_state()
Date:   Thu, 20 Aug 2020 11:22:46 +0200
Message-Id: <20200820092130.037191704@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 18ffec750578f7447c288647d7282c7d12b1d969 ]

fimc_md_get_pinctrl() misses a check for pinctrl_lookup_state().
Add the missed check to fix it.

Fixes: 4163851f7b99 ("[media] s5p-fimc: Use pinctrl API for camera ports configuration]")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/exynos4-is/media-dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 4f5586a4cbffa..31cc7d94064e3 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1172,6 +1172,9 @@ static int fimc_md_get_pinctrl(struct fimc_md *fmd)
 
 	pctl->state_idle = pinctrl_lookup_state(pctl->pinctrl,
 					PINCTRL_STATE_IDLE);
+	if (IS_ERR(pctl->state_idle))
+		return PTR_ERR(pctl->state_idle);
+
 	return 0;
 }
 
-- 
2.25.1



