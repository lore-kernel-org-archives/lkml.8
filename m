Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78AC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3F32469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UorAoA/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgB0UUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:20:43 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.218]:33158 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0UUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:20:43 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7A8094C593B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:20:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7PeEj0239RP4z7PeEjOZp8; Thu, 27 Feb 2020 14:20:42 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uf8a9vBAJSYVV5Wk+v1AR61ZSb+YDaIsUBmlQZO8jm8=; b=UorAoA/beGmNp854mZM6EhCWQJ
        Wff6qCXV1quzre04qY8DTcR/JJUSLrQBjm5DYFEfnsRnIR6aZMWZsqeAuz4K+AEn+W+Sr6OCdMVJs
        HlUDttPh2a6lKQImcyMasvc0zBxQTJbtdm06fY0LimHxusfcLSnFPVVXI/1Nu6HsIy+6hSYrzGTe7
        D5uKJBoVsOKHXmIt5Vy8WV1TexJmHM0ufOpYBb7tPvTBOa5rbAOt+F4MwaFsPxSWlCOEHCcOQerzT
        fHS48Y9zpNPqpCXhfZKJkz6/ZtEnOD2FecYQMvpLrWqM/QfOmd+xZyWVHuFKy7eEkaYvQ0+u97dK4
        o/f/1cmA==;
Received: from [201.162.169.69] (port=6534 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7PeC-000TA7-FV; Thu, 27 Feb 2020 14:20:40 -0600
Date:   Thu, 27 Feb 2020 14:23:32 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] w1_netlink.h: Replace zero-length array with flexible-array
 member
Message-ID: <20200227202332.GA15501@embeddedor>
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
X-Source-IP: 201.162.169.69
X-Source-L: No
X-Exim-ID: 1j7PeC-000TA7-FV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.169.69]:6534
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
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
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/w1/w1_netlink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index 3041092e84b3..449680a61569 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -73,7 +73,7 @@ struct w1_netlink_msg
 			__u32		res;
 		} mst;
 	} id;
-	__u8				data[0];
+	__u8				data[];
 };
 
 /**
@@ -122,7 +122,7 @@ struct w1_netlink_cmd
 	__u8				cmd;
 	__u8				res;
 	__u16				len;
-	__u8				data[0];
+	__u8				data[];
 };
 
 #ifdef __KERNEL__
-- 
2.25.0

