Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD26C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5810620774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255831;
	bh=O5FR41JTbKq16AdmkKYLVI7ggdGMxpluv76/vMSoG50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxFBh/Z9x/MxFtpN0csB7CVV3/vA2sTN7GHtBkj4hhdNtDsRXgm0AqZkW6Mna1Zs+
	 ysPqkEk2sPy/nWq+dQAV4ZG8tOs9oOUJDjOaFOxYQvb2rp8rFHsJPTruxFlXeGUILp
	 NDLCyXTUqbes26/jKB/EDe8tVBwhk7+KXsjoFjmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgD3Nvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgD3NvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D1E2082E;
        Thu, 30 Apr 2020 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254682;
        bh=O5FR41JTbKq16AdmkKYLVI7ggdGMxpluv76/vMSoG50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdyNQUm0SoCwPAJ84fjHfdPbu91Mid8B5qLjr4rvT3x4UWGsB8K/rih/hVMEYhxy+
         fWZ7Vo+xiLbtV3cBi3YtfMfrCC17UkytlHxeJh+k/og90/dc9jkUQQw3cRG6SPZuLq
         cLbdNl7ZWQ1/HdZXJ4BbmYbhloi/tYbzJ4BH5Q9c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 33/79] remoteproc: qcom_q6v5_mss: fix a bug in q6v5_probe()
Date:   Thu, 30 Apr 2020 09:49:57 -0400
Message-Id: <20200430135043.19851-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

[ Upstream commit 13c060b50a341dd60303e5264d12108b5747f200 ]

If looking up the DT "firmware-name" property fails in q6v6_probe(),
the function returns without freeing the remoteproc structure
that has been allocated.  Fix this by jumping to the free_rproc
label, which takes care of this.

Signed-off-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/20200403175005.17130-3-elder@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 0b1d737b0e97d..8844fc56c5f6d 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1607,7 +1607,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
 					    1, &qproc->hexagon_mdt_image);
 	if (ret < 0 && ret != -EINVAL)
-		return ret;
+		goto free_rproc;
 
 	platform_set_drvdata(pdev, qproc);
 
-- 
2.20.1

