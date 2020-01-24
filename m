Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F922464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864282;
	bh=96w/q7FGFVWBnObjplNmoMiT9LhVX1lrLHcPImmRxuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WpYZbd3fW43GSKWgZQ5NGPwGtS8WInZZ6Y4bkyM3vO3+3UZQ5MtCQCao3V2gec3z9
	 I6LP/wv8U4NoAHnUFzwXAMjgy1pRPy0BuDv6BnGq0INGxX+bTXosv1fJsY+zbSMfxe
	 eJ6yG+3s9zCHvK0zyiFsV01P6a5XuTmIPQC60iC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgAXLLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389887AbgAXLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:11:16 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0974D20708;
        Fri, 24 Jan 2020 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864275;
        bh=96w/q7FGFVWBnObjplNmoMiT9LhVX1lrLHcPImmRxuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phRex/fNfns4xccNybD+gSS/Zkk2Uy3eJY2q+k6Ctqi03SxyCO4ZyjxBewaK1UfrO
         UbngkR5/vg2GK1oImuIJQuQw9S2eHyVqT4qFFYaMhYVQvpdeV+jzDmiF10FJLeZaNx
         AK7woB9p9ga7qcGc6h3vBKtEzqwf6juWff2b1mSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 209/639] staging: r8822be: check kzalloc return or bail
Date:   Fri, 24 Jan 2020 10:26:19 +0100
Message-Id: <20200124093113.188611943@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 53f55f129a760..ec742da030dba 100644
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



