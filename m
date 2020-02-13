Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C0C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EF72073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609108;
	bh=p5Vka3MWRnnxWQWS9554okQybQol3sSg6zPQmh524Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFSGBZuWZeM0HwehTNRjQ6lToEcU6eIvdF0MzkmaZyRjo7VjPfNEVa21LckeIgbIq
	 473Yls+gRC+xXqO7F0KCBZaQIPQbDdlLTQrfDl7Jz8NHBHmMPuuLZqGDcIuM+KjHnI
	 DvTdSpCaISQYqAu8UYu5tzXq0dvfo20zQuacfF9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBMP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbgBMPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:23 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC49C246B8;
        Thu, 13 Feb 2020 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607462;
        bh=p5Vka3MWRnnxWQWS9554okQybQol3sSg6zPQmh524Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YC7Y4I2rxCAJjfmqvlpOlqpWVNh5nW9fDapWGm6Dj/RBGpaPOV0Oxm76m5BR7tAK+
         LSNQfugA+K5FcIsLokWjyxan7XB50AVdFEfk4zGOed+iaAjwA+xImewJQvBJwhDnTj
         fYMaqWGkB42uQ6v56z5/9swR3tu9lkk/1y6T+AQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xu <m1s5p6688@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 113/116] mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
Date:   Thu, 13 Feb 2020 07:20:57 -0800
Message-Id: <20200213151925.781939440@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
 drivers/net/wireless/marvell/mwifiex/wmm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 9843560e784fe..c93fcafbcc7a6 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -980,6 +980,10 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
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



