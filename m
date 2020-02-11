Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA2C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87ED20659
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="REsq19WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgBKUnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:43:16 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.222]:28965 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgBKUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:43:15 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D11966797A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:43:14 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cNGj73HeEfyq1cNGjH1nY; Tue, 11 Feb 2020 14:43:14 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LQJB9qTDYCP+pqJ+o+EBP152WnYVWjGH4JWUtcOBzIE=; b=REsq19WTHIU6YtgQ7oha9+2aGC
        BUSi2vRfRTfUm9EwFxgSPohhmaNEkO0I4ocLIi3rOC7dZjV1+ED1SqAxmi2ppU2t3bO/puPiurrQk
        lIztZ4Htz6vvkoOJqqggbBEnn2xiD+qsJbZ98bOg5Rty2tsgDwnFrpW7eaC87GZ2ZrxzCsE4GyX3S
        bJ4UuA4OuiYBQLXoZNCKPj6uqOGN39HCHmX1aUZewq37NYNkzAwG7Zl0umNk8Tz7PuDYqIoxsYE1L
        TfQ1sBu1sKkDY175Z3ldLGT1PBEuGfyWBNFikH4nl7o3+I05iFuOGUzfgFjYK3yt97YG7Cae7w3FF
        B3XmduXg==;
Received: from [200.68.140.36] (port=10643 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cNE-001sPr-V3; Tue, 11 Feb 2020 14:43:13 -0600
Date:   Tue, 11 Feb 2020 14:45:47 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] media: rc: iguanair: Replace zero-length array with
 flexible-array member
Message-ID: <20200211204547.GA17869@embeddedor>
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
X-Exim-ID: 1j1cNE-001sPr-V3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:10643
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
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
 drivers/media/rc/iguanair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
index fbacb13b614b..028374b04e47 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -85,7 +85,7 @@ struct send_packet {
 	uint8_t channels;
 	uint8_t busy7;
 	uint8_t busy4;
-	uint8_t payload[0];
+	uint8_t payload[];
 };
 
 static void process_ir_data(struct iguanair *ir, unsigned len)
-- 
2.25.0

