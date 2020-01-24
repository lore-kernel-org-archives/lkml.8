Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B646C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65F02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864339;
	bh=ya/AezvtgHFN4hXLdrztXrrIthcM0XuiWQn0W94s3r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sokA8K16R7BsRytCDVU5RwgNHupZJ8IPru9clH4eFIP9HzJwLHec/h775j8A/rEsU
	 EsVDH3bYB3d1UXVgpfl8OZcrywoz4IJD1sUj/H4OhIpVeltCJC+2njLFdB3nyJzrT/
	 dv0zibfCuDbg3ImXXJgdvr1ETuDGtGOGlhN8vFYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbgAXLMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389975AbgAXLMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:12:16 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E1B20663;
        Fri, 24 Jan 2020 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864335;
        bh=ya/AezvtgHFN4hXLdrztXrrIthcM0XuiWQn0W94s3r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt8uJLwt4hPVCPZjB+niQ7BP6YNcYwngXdr1CIUBHTpZ2nwcyIDorBz5dQ0SX0XE0
         irdiA3+RwY/rsNBTHYfiUXgV/w879YTa/IRktLJ8n74R0GfJPEPxUMIt7VVPDuVHDk
         VUG0wk/KuLO26AZRNeKGyXfZ6yH11ZXfwcI3e8rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 225/639] staging: rtlwifi: Use proper enum for return in halmac_parse_psd_data_88xx
Date:   Fri, 24 Jan 2020 10:26:35 +0100
Message-Id: <20200124093115.084947841@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit e8edc32d70a4e09160835792eb5d1af71a0eec14 ]

Clang warns:

drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c:2472:11:
warning: implicit conversion from enumeration type 'enum
halmac_cmd_process_status' to different enumeration type 'enum
halmac_ret_status' [-Wenum-conversion]
                        return HALMAC_CMD_PROCESS_ERROR;
                        ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

Fix this by using the proper enum for allocation failures,
HALMAC_RET_MALLOC_FAIL, which is used in the rest of this file.

Fixes: e4b08e16b7d9 ("staging: r8822be: check kzalloc return or bail")
Link: https://github.com/ClangBuiltLinux/linux/issues/375
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
index ec742da030dba..ddbeff8224ab6 100644
--- a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
+++ b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
@@ -2469,7 +2469,7 @@ halmac_parse_psd_data_88xx(struct halmac_adapter *halmac_adapter, u8 *c2h_buf,
 	if (!psd_set->data) {
 		psd_set->data = kzalloc(psd_set->data_size, GFP_KERNEL);
 		if (!psd_set->data)
-			return HALMAC_CMD_PROCESS_ERROR;
+			return HALMAC_RET_MALLOC_FAIL;
 	}
 
 	if (segment_id == 0)
-- 
2.20.1



