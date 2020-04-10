Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7C220B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490415;
	bh=idCS/o2KJWKLuG5YYj/PRV53FPx4L/x7Hh2m9+2AenI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYF3n9i1U+dL2bhRAsPHjlERCU0T1oZeIUwRpDk4y6OF3puCc2K07JP8CzQuvBA8m
	 o7SKVaXMS6HEMqPGsoX88Hcu427uiC7ywdwLkYcruIuD3DGNaizyavkDJND7lkyJUp
	 0VngNgtzUYJRwCvCcY6NOG1LH245ALwlWulZxbEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDJDqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgDJDqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F68212CC;
        Fri, 10 Apr 2020 03:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490406;
        bh=idCS/o2KJWKLuG5YYj/PRV53FPx4L/x7Hh2m9+2AenI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yVUk49vO0Tzai0p37Gmy8vRynYZPMDvlWRYSgqivmpU9PasEwgNFhaBtJCNMIp+rw
         iUUxAjXRsooaIl+Vs/235Vp8e7oCePfdNkid1CJ/xbs1jvWgB1oFG3Fju+bM87jwSk
         z1opBEiq1eYmD27sFyERs1GrFwGoDs56qXw7+6E0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 09/68] media: venus: hfi_parser: Ignore HEVC encoding for V1
Date:   Thu,  9 Apr 2020 23:45:34 -0400
Message-Id: <20200410034634.7731-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit c50cc6dc6c48300af63a6fbc71b647053c15fc80 ]

Some older MSM8916 Venus firmware versions also seem to indicate
support for encoding HEVC, even though they really can't.
This will lead to errors later because hfi_session_init() fails
in this case.

HEVC is already ignored for "dec_codecs", so add the same for
"enc_codecs" to make these old firmware versions work correctly.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 2293d936e49ca..7f515a4b9bd12 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -181,6 +181,7 @@ static void parse_codecs(struct venus_core *core, void *data)
 	if (IS_V1(core)) {
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_SPARK;
+		core->enc_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 	}
 }
 
-- 
2.20.1

