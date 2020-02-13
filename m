Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BBC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA1D217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609870;
	bh=14q4dlDamA7ynQTymSQ6F/bDoF7F0y6K3iUXVOJCl18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bc2nvTb5NjPja8evDcnYahHoxnklctfSwTAt7rjKEBi+jktOVpB3DFJqhQ/7ttJ9y
	 SNDntfGqIzPYni0xvO2SEvoNT3eadMkSVSTRbLHKyXygRmLjLThGJsJNheYqF5PpBS
	 PArL7/DEM73eMMYac082j3XxKDaMbsMjIi8IxtQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgBMPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgBMPXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:07 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199FB246A3;
        Thu, 13 Feb 2020 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607387;
        bh=14q4dlDamA7ynQTymSQ6F/bDoF7F0y6K3iUXVOJCl18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpdQUfN74fMF2nzVCZOXnkAGKrkL+Mh+iEkrxZWiq3FCihMJnxvN/wVghSHtxGbVW
         HrN1Z1tPGW+McqK6dRyLptNO9sPrHcBSMe9bZ0wQrzrn/VKWzU0jywTMjDfp2oAAeX
         c7ccINISEYLfGM8s3OPBC2EKR44pSDQuOTrxQ4JE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xu <m1s5p6688@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 87/91] mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
Date:   Thu, 13 Feb 2020 07:20:44 -0800
Message-Id: <20200213151856.483876231@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/net/wireless/mwifiex/wmm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mwifiex/wmm.c b/drivers/net/wireless/mwifiex/wmm.c
index 7015dfab49cfc..3a2ecb6cf1c3d 100644
--- a/drivers/net/wireless/mwifiex/wmm.c
+++ b/drivers/net/wireless/mwifiex/wmm.c
@@ -978,6 +978,10 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
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



