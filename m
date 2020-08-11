Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96753C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DFC2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160645;
	bh=fhwF6xiROqtn4Wal/gG+L3S8mxfpUTt7RYU1Fr9icVg=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=xgg9u1g0yzHmKo8U6iS/8xXeWP6PVlBD57L9wmMzN9VfrzRYuI5/0Iwg1xHuIMhIY
	 QZlKuhKZPKbPm0EoP3MgKEd18N+YW9wrn7ppkWWRtrtcz30Gs2TEXsU2zSduak+t0m
	 iWLEsnGke+QjAADorozMMs7KOXOkMIXeq4YPZ4FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgHKPoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgHKPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676D620B1F;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=fhwF6xiROqtn4Wal/gG+L3S8mxfpUTt7RYU1Fr9icVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXTrTtHoBd/Ii7ya+AMB6tEcN6IVe9luJvBc75vH4TrJGohlTQVOflFbamzNvWnzs
         2MOnEwAhdEYEKnSfdszrlPWGLfOdOE0SbONsv1LBW6Ibn6fscXLwk+n6DTe+Lak8zx
         U5lCPu/e8PZPdrW5ILYxZWQv29lKS9SYfzAFR8uo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmb-In; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mayulong <mayulong1@huawei.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/33] spmi: hisi-spmi-controller: fix a typo
Date:   Tue, 11 Aug 2020 17:41:35 +0200
Message-Id: <37d3d01252e011786436791bcfa025c098e77c6c.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chanel -> channel

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/spmi/hisi-spmi-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index bc6847f9a5e7..99cf757d76fe 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -306,7 +306,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
 				   &spmi_controller->channel);
 	if (ret) {
-		dev_err(&pdev->dev, "can not get chanel\n");
+		dev_err(&pdev->dev, "can not get channel\n");
 		return -ENODEV;
 	}
 
-- 
2.26.2

