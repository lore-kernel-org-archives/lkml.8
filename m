Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FACC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E502073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qD3S4rvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgBKXoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:44:11 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.221]:34222 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbgBKXoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:44:11 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 4EE1C15CDB63
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:44:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1fCMjf244RP4z1fCMj6qsN; Tue, 11 Feb 2020 17:44:10 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HuWWbn9mG6qCqANbQu9GYRVgDmlnQe5rjU+iHf/AjzI=; b=qD3S4rvooZjnwz0ZXghoPw7ZpL
        ngFyK6PbFW5DKFEiTRqdJF3WxsrLAJTFBKSod5A8MT6ahHCKWXh5AsWuJA1VqIcQdeuEqJ11BWW8K
        M7pDnGAv80xQIg3wMeazsVGLx3qOaZeP1RVOBAiU7SVlg1b11u4YAC2romgUrX3lsKTNbgtcg02ua
        OZ3ialpRyByBp2dNzfKBVMBmIubk3wzvJlQnXUN3UlJ5qi+YPeR5NSqsVrL+3Ws5mjZAhqiO03SUq
        QVzq4cQS58Ec/U866KCYtJFwY1c7qkH4PmI7NWWDYWCyZcreqrnXCE3WCP30HJLDEY8xZbuHOIW8F
        fq9ewb5w==;
Received: from [200.68.140.36] (port=6741 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1fBp-003k23-1O; Tue, 11 Feb 2020 17:43:37 -0600
Date:   Tue, 11 Feb 2020 17:46:12 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] regulator: da9062: Replace zero-length array with
 flexible-array member
Message-ID: <20200211234612.GA28682@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1fBp-003k23-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:6741
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index b064d8a19d4c..c3b6ba9bafdf 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -86,7 +86,7 @@ struct da9062_regulators {
 	int					irq_ldo_lim;
 	unsigned				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
-	struct da9062_regulator			regulator[0];
+	struct da9062_regulator			regulator[];
 };
 
 /* BUCK modes */
-- 
2.25.0

