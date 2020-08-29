Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9AC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C9420CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705070;
	bh=peGWSx6YXMRar3ybnA8IvphCc/WLWnFCxTQJJp1BrNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3lFHy6wCk/e0eKq/M2lM2KwY1Pu3YTeve7QQzprZDp+FsETfhIqJDjELvmNVZEZS
	 gk4B8F0z9UqVYldJq1V4ETOOyIbfDxCwgCbMJd9XRat9/N1OdqrC78Ef8oe0RbeSZd
	 uRAGq+9GZ4Jv55omxdyAWiJ72crwrtCv9K3r8yeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgH2MoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgH2MoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:44:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E0520EDD;
        Sat, 29 Aug 2020 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705049;
        bh=peGWSx6YXMRar3ybnA8IvphCc/WLWnFCxTQJJp1BrNQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Iiu9f86X31duBz57vlOPKFXZGItXzKvK5BoXDr7aCwQcThEUToyW8tvqF3pfvjor8
         3JNewNWJ7+QMTGQnlwWYRj4kvazBucm7Mma8hXQyaDabtQOwDr6QqYFDkKzWUv7J1Z
         PsTNiIvnpDXc2j1D8Z5j7HDajU7/iIItBJgYCnu0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] extcon: max77693: Return error code of extcon_dev_allocate()
Date:   Sat, 29 Aug 2020 14:43:54 +0200
Message-Id: <20200829124356.18148-2-krzk@kernel.org>
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
 drivers/extcon/extcon-max77693.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 32fc5a66ffa9..4a410fd2ea9a 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1157,7 +1157,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
 					      max77693_extcon_cable);
 	if (IS_ERR(info->edev)) {
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		return -ENOMEM;
+		return PTR_ERR(info->edev);
 	}
 
 	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
-- 
2.17.1

