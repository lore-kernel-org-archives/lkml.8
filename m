Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF41C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BA020714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="D4Hfn/bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBKXNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:13:32 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.187]:16652 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727668AbgBKXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:13:31 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D7FB4926
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:13:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1eigj9yXOEfyq1eigjJvMw; Tue, 11 Feb 2020 17:13:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z19HB9vM7QmgZU+p7vtVb85trn1iIgCfG7IHgCayt5k=; b=D4Hfn/bRTxSFviLijv5kdGsp2o
        yQ04sUAprSQTq29sv4BJf1jsk3SDcxafODjXhAPRpOwk3gEsll9hr+1395eWzPMmL6IioUpTP6rSd
        VKd2yE+UGDNZ5BkAC5mY9hBJm11rll4B928aZvyi7YmpmgNVGYZOyQ2NATd3O5ktpT9ivW/AxbR/K
        hvMAPCFIHCXep3ucHnsLT1qW8v2C94PmwCuZWLQDih6MFqf0nyKvjo/Y02LVLgGsX/7+TBvg3Sw4X
        e/myAO7xHZIHF+CD/a975hafqYaDVgV/BcqXZAJdQw0xfughDHXX2hQTrbT40eRBjazoY9d5FlnWp
        mS8zX8mw==;
Received: from [200.68.140.36] (port=4623 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1eif-003WDC-HN; Tue, 11 Feb 2020 17:13:29 -0600
Date:   Tue, 11 Feb 2020 17:16:04 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] firmware: arm_scpi: replace zero-length array with
 flexible-array member
Message-ID: <20200211231604.GA17274@embeddedor>
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
X-Exim-ID: 1j1eif-003WDC-HN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:4623
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
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
 drivers/firmware/arm_scpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c7d06a36b23a..0bc52876c79a 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -273,12 +273,12 @@ struct scpi_drvinfo {
 struct scpi_shared_mem {
 	__le32 command;
 	__le32 status;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct legacy_scpi_shared_mem {
 	__le32 status;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct scp_capabilities {
-- 
2.25.0

