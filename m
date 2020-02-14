Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876BA206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702590;
	bh=KHdrEN3OtqPPD6L5YgBi2g1IZzGbO2eK07lEomwDnVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POzb3/XjlOfU0+P76EvY4Pc9H1xRp4gnPmUuZsEwM5cgjgzuS0IAuJaMqM2jXpwKJ
	 ec3sGc7zQsyFkFFwAd59qXGnmPpQZhJbmzJB91U5JozXL6cBwBKgi/KmJDLvBCrShp
	 pjQhPG+L3ri2/TqLjyrFYszXLHi2wb31U9ooWrnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgBNRtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbgBNP7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D21B22314;
        Fri, 14 Feb 2020 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695953;
        bh=KHdrEN3OtqPPD6L5YgBi2g1IZzGbO2eK07lEomwDnVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFeECJn0AuExabbjPmCAeuNp8XuVzZnI8GLfHah387c9FbyKrv52H7mIKh9cUHu91
         UvNMAosgjb0FphwiOc9Nv0BFajzH0ghLyHca7f7+uT6ik2S8N/xFkAYjy9M7dD/Pfx
         JZMU2wzZP94iuiRcsu9B+QAGhKkyK2tsw+fveqLY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qing Xu <m1s5p6688@gmail.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 484/542] mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
Date:   Fri, 14 Feb 2020 10:47:56 -0500
Message-Id: <20200214154854.6746-484-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

[ Upstream commit 3a9b153c5591548612c3955c9600a98150c81875 ]

mwifiex_ret_wmm_get_status() calls memcpy() without checking the
destination size.Since the source is given from remote AP which
contains illegal wmm elements , this may trigger a heap buffer
overflow.
Fix it by putting the length check before calling memcpy().

Signed-off-by: Qing Xu <m1s5p6688@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/wmm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 41f0231376c01..132f9e8ed68c1 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -970,6 +970,10 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
 				    "WMM Parameter Set Count: %d\n",
 				    wmm_param_ie->qos_info_bitmap & mask);
 
+			if (wmm_param_ie->vend_hdr.len + 2 >
+				sizeof(struct ieee_types_wmm_parameter))
+				break;
+
 			memcpy((u8 *) &priv->curr_bss_params.bss_descriptor.
 			       wmm_ie, wmm_param_ie,
 			       wmm_param_ie->vend_hdr.len + 2);
-- 
2.20.1

