Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6001C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D54424653
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194100;
	bh=IUzSGB77D53GljgvthFQefGhyMuKcSOamUi+WgliY20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OeMvJiKjJRhW5IzlV9w3DZcv+ioS06n8cT/beicBzzqRdO6r38cTk2Fl3ANswsZlO
	 fXK9QtPoz/jI6MCmUPY4xKYZi/2iW+zP2B6p/c38KCOc2tcssz/cmOR+FLMxdDroZp
	 SJCm56mOr1bVeLdYjVyJrLiLRISTJdIH+XzniLts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgAPRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgAPRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586892464B;
        Thu, 16 Jan 2020 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194090;
        bh=IUzSGB77D53GljgvthFQefGhyMuKcSOamUi+WgliY20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS29KqC2UPyXhGp6t5iIkLPHTFa/3NqtUkGmsUNhF4T5cU3kaAwbGfxnlzv6KI8Sn
         YrHknx0C9isNwGElu3oZat6ceWn+E2OcX4OkJG06mWoWKni9c/y3YwK+u/uH4AGfY2
         uTHZ9MxoL/h3UeMZEvVPMi/87VZIUBwZHaD3sVFc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 193/671] staging: r8822be: check kzalloc return or bail
Date:   Thu, 16 Jan 2020 11:51:42 -0500
Message-Id: <20200116165940.10720-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit e4b08e16b7d9d030b6475ef48f94d734a39f3c81 ]

The kzalloc() in halmac_parse_psd_data_88xx() can fail and return NULL
so check the psd_set->data after allocation and if allocation failed
return HALMAC_CMD_PROCESS_ERROR.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 938a0447f094 ("staging: r8822be: Add code for halmac sub-drive")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
index 53f55f129a76..ec742da030db 100644
--- a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
+++ b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
@@ -2466,8 +2466,11 @@ halmac_parse_psd_data_88xx(struct halmac_adapter *halmac_adapter, u8 *c2h_buf,
 	segment_size = (u8)PSD_DATA_GET_SEGMENT_SIZE(c2h_buf);
 	psd_set->data_size = total_size;
 
-	if (!psd_set->data)
+	if (!psd_set->data) {
 		psd_set->data = kzalloc(psd_set->data_size, GFP_KERNEL);
+		if (!psd_set->data)
+			return HALMAC_CMD_PROCESS_ERROR;
+	}
 
 	if (segment_id == 0)
 		psd_set->segment_size = segment_size;
-- 
2.20.1

