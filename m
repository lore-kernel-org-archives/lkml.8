Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F214C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1DF20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615242;
	bh=IfDLe6lN7eIdQXF70MOOOos/2QGEaSxCOrUAJ3Yl/j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDGOvd85tmf4hujR3ByEHJNW7m/itrLvXrVZosLm8BTteXH+S4UJRKujlSeqAj2Zx
	 kkNt6xnLZ2upUdAoVYJar979Ygx66ntT8D/XtQC7/5gpAb5nvj6U/9u7bnM4mubuPt
	 Zn7a4aObKOEnm/eCMLCSlha31YL980dytP2mFjoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgEDSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbgEDSAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D293320663;
        Mon,  4 May 2020 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615236;
        bh=IfDLe6lN7eIdQXF70MOOOos/2QGEaSxCOrUAJ3Yl/j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGmOizahxryKy6uyfTpzI8EyrgOSGdB5Yb1Qu5bdZ14NtXX/zg8LTOtjsN/OzFHMK
         ST9J4AtbVuwJQcUudQtF4ZDc84cxtfi3FrvdLnTyDMQkLb+GA9ohbiJD1KskZ3082t
         jWaTCHC+r0/nq7Z35RFvwMJB3DC2fwckGYCIQY5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.14 20/26] iommu/qcom: Fix local_base status check
Date:   Mon,  4 May 2020 19:57:34 +0200
Message-Id: <20200504165447.052905233@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

commit b52649aee6243ea661905bdc5fbe28cc5f6dec76 upstream.

The function qcom_iommu_device_probe() does not perform sufficient
error checking after executing devm_ioremap_resource(), which can
result in crashes if a critical error path is encountered.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200418134703.1760-1-tangbin@cmss.chinamobile.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/qcom_iommu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -775,8 +775,11 @@ static int qcom_iommu_device_probe(struc
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
+	if (res) {
 		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qcom_iommu->local_base))
+			return PTR_ERR(qcom_iommu->local_base);
+	}
 
 	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
 	if (IS_ERR(qcom_iommu->iface_clk)) {


