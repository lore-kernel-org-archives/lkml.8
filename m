Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82195C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E42082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="z9aOCVC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBKXFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:05:40 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.190]:38695 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbgBKXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:05:38 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6863D815860
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:05:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1eb3jGmIlSl8q1eb3jzrDj; Tue, 11 Feb 2020 17:05:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r6W7e99wqSxpJufs0pmZ8FH4EPi49mq2sFzO815awQ4=; b=z9aOCVC2uJ4Xr1XmZn01NiP+GV
        Q0R2flt6t9U23h95xgj7Yombr8L7FIcJ5DtOXkFjaY0/5hj6eRIrqdq4UznkQWE0q5BJNS7HLGkTG
        lVP2GLTZ+BlvyIbP5N6McBQajtsnX5axvz+uEoHHibx353ZCCDvailIDtb3HcgM7xxZv45CKCsbsV
        2V3/dMK+Vh/Twg0NPJ7MLFA2UqLsqRDoAAN+pf6qRI7spN549Bl5Fdq16mT1THe/fzWa/sh+sAu9e
        sipPrHp8E3REOjkFAjvh2dw6rikqKEyZOlw2hFSG3mHhesKJhtiJAdZ3QF17g8L/CuHQ88Baxwjks
        c7uaWtsA==;
Received: from [200.68.140.36] (port=4449 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1eb1-003SYa-Ll; Tue, 11 Feb 2020 17:05:35 -0600
Date:   Tue, 11 Feb 2020 17:08:10 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] firewire: ohci: Replace zero-length array with
 flexible-array member
Message-ID: <20200211230810.GA12211@embeddedor>
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
X-Exim-ID: 1j1eb1-003SYa-Ll
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:4449
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
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
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 45c048751f3b..afc022b4246f 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -124,7 +124,7 @@ struct descriptor_buffer {
 	dma_addr_t buffer_bus;
 	size_t buffer_size;
 	size_t used;
-	struct descriptor buffer[0];
+	struct descriptor buffer[];
 };
 
 struct context {
-- 
2.25.0

