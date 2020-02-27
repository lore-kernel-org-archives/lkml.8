Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48AC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3229B24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DsGFoQGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgB0SpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:45:24 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.216]:41961 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729631AbgB0SpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:45:23 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id AA0A055CC3B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:45:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7O9ujyWXEvBMd7O9uju6Yi; Thu, 27 Feb 2020 12:45:19 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uJRZdiXQDQ8vWpvOfn+fD+OCasED1rNINY7/9EAl050=; b=DsGFoQGJlsQ6EIWRhqw2AeIHKF
        rk4i0rWM2GhgKpHOCLaAALk42x2kesw4DArmujow89wMNa3MNOnsyRUrBuQLc3rJM7qGq19IYn1S4
        QeKCdJIjBKVuJcOhOsryidxy66ShnGyZt+oCWeDnMOXdMO1RDrtTZgHt1gTQ2DhKtatpfy6frqOZF
        7plM2qaba8xiTOA5iKhDQI0hbqMwhainRew+//Ddak9pa33gd7eeo89rB5+ncqs+YSsjX6XJOeZgz
        mc21DAFrWDAR+kkq5I58oJwR2E7snDHTBvIFL1ijm+5itK8iMJtbPB+E9lzjRI96/ViYlZOfAhSH4
        51EKngyA==;
Received: from [201.162.168.186] (port=16949 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7O9r-0040oC-Vw; Thu, 27 Feb 2020 12:45:16 -0600
Date:   Thu, 27 Feb 2020 12:48:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] char: mspec: Replace zero-length array with flexible-array
 member
Message-ID: <20200227184808.GA1925@embeddedor>
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
X-Source-IP: 201.162.168.186
X-Source-L: No
X-Exim-ID: 1j7O9r-0040oC-Vw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.186]:16949
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
 drivers/char/mspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mspec.c b/drivers/char/mspec.c
index a9d9f074fbd6..7d583222e8fa 100644
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -75,7 +75,7 @@ struct vma_data {
 	enum mspec_page_type type; /* Type of pages allocated. */
 	unsigned long vm_start;	/* Original (unsplit) base. */
 	unsigned long vm_end;	/* Original (unsplit) end. */
-	unsigned long maddr[0];	/* Array of MSPEC addresses. */
+	unsigned long maddr[];	/* Array of MSPEC addresses. */
 };
 
 /*
-- 
2.25.0

