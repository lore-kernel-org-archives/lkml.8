Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE33246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCBIfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:35:03 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7360 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:35:03 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e5cc50a41b-b1e04; Mon, 02 Mar 2020 16:34:19 +0800 (CST)
X-RM-TRANSID: 2ee65e5cc50a41b-b1e04
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.8.194])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e5cc507645-4bbf6;
        Mon, 02 Mar 2020 16:34:19 +0800 (CST)
X-RM-TRANSID: 2ee15e5cc507645-4bbf6
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] drm/amd/display:fix a warning
Date:   Mon,  2 Mar 2020 16:35:06 +0800
Message-Id: <20200302083506.10312-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile the code in X86,there is a warning about
"'PixelPTEReqHeightPTES' may be used uninitialized in
this function".

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index e6617c958..29dad2cc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -1294,7 +1294,7 @@ static unsigned int CalculateVMAndRowBytes(
 	unsigned int MacroTileHeight;
 	unsigned int ExtraDPDEBytesFrame;
 	unsigned int PDEAndMetaPTEBytesFrame;
-	unsigned int PixelPTEReqHeightPTEs;
+	unsigned int PixelPTEReqHeightPTEs = 0;
 
 	if (DCCEnable == true) {
 		*MetaRequestHeight = 8 * BlockHeight256Bytes;
-- 
2.20.1.windows.1



