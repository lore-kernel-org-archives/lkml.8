Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADCC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C80B20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705069;
	bh=/G2UXOE/MMY941KRkGwqlNScbXeadjs7wXNjjF8Qeh4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhJmW4fNZwj0i5qwua/EPHELoo2/RmceZWMRMbGCYEDBPQf1Rxc2nN+MV1wHtF4Zv
	 SAi/UcpA0UINRNMZBQkcp2SaxdShijzavkC/oB6mZO4rea7WWLSUuLafK9RWIV+33b
	 CK6/53TidnytEZfV+pZ9RjuxC4q6P5fPqXPRVBE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgH2MoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgH2MoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:44:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 326BB20E65;
        Sat, 29 Aug 2020 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705052;
        bh=/G2UXOE/MMY941KRkGwqlNScbXeadjs7wXNjjF8Qeh4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LO+vstC2h7JSoLzqOmKRrkrFnUd215a6qzIoCWzxoqmj8+NvYeXfyuQvjbd+AsKhD
         +qmgr2K69zaxdd/QCm7BF/YZgvAcS/eG+IotDHhTznJyweK4zi7tWyePiYyOLX4y8l
         ZckkRU7w+WtbqvRo787PgwJrP7c2WAFeQ1OnkZQ8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] extcon: max8997: Return error code of extcon_dev_allocate()
Date:   Sat, 29 Aug 2020 14:43:56 +0200
Message-Id: <20200829124356.18148-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829124356.18148-1-krzk@kernel.org>
References: <20200829124356.18148-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_extcon_dev_allocate() can fail of multiple reasons.  The call
returns proper error code on failure so pass it instead of fixed ENOMEM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 172e116ac1ce..337b0eea4e62 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -674,7 +674,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	info->edev = devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
 	if (IS_ERR(info->edev)) {
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(info->edev);
 		goto err_irq;
 	}
 
-- 
2.17.1

