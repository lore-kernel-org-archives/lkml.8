Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB1C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9CF24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="BZl1WCjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBZVXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:23:33 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:46198 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727503AbgBZVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:23:33 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7E02954B5A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:23:31 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 749TjFxwYXVkQ749TjbBCH; Wed, 26 Feb 2020 15:23:31 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=96f8kZdh7WxJBTeep/qoxEO5hEENwT7hPTi1FGgDDyQ=; b=BZl1WCjgZtTNu6aGLvvU4/iPRW
        KLaA1o7tDonP3BUGMMHpFTH76EWmdNlvIEgVkNuMfKiiZDRQe7i00Bf5C2djTnOF+TcPoYjgNKncA
        Rlqx5Ed5Ra7TtDi9045eAvLfhpfmdWkr6BdOj1U1j6rxT+1kY/qpWzi2R72Qh49C2R7mauhdDHCTG
        snYO5LP6796MkyQirOLPQ+m483LtTmhx20oZlAze2cojPgR01142altotg30XfkciRi+LRxCckTCd
        HPHeyB5uYVzEWI5qUaAsA2gTE8sOZ2IFKcI4zv9NnCa5B7N0FTXEmmOKZlauQzSKfqO/Ro6LjxnZ8
        gzd3TRow==;
Received: from [201.162.161.180] (port=47722 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j749R-000nRw-Iy; Wed, 26 Feb 2020 15:23:30 -0600
Date:   Wed, 26 Feb 2020 15:26:12 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xen: Replace zero-length array with flexible-array member
Message-ID: <20200226212612.GA4663@embeddedor>
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
X-Source-IP: 201.162.161.180
X-Source-L: No
X-Exim-ID: 1j749R-000nRw-Iy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.161.180]:47722
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
 drivers/xen/xen-pciback/pciback.h | 2 +-
 include/xen/interface/io/tpmif.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index ce1077e32466..7c95516a860f 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -52,7 +52,7 @@ struct xen_pcibk_dev_data {
 	unsigned int ack_intr:1; /* .. and ACK-ing */
 	unsigned long handled;
 	unsigned int irq; /* Saved in case device transitions to MSI/MSI-X */
-	char irq_name[0]; /* xen-pcibk[000:04:00.0] */
+	char irq_name[]; /* xen-pcibk[000:04:00.0] */
 };
 
 /* Used by XenBus and xen_pcibk_ops.c */
diff --git a/include/xen/interface/io/tpmif.h b/include/xen/interface/io/tpmif.h
index 28e7dcd75e82..f8aa8bac5196 100644
--- a/include/xen/interface/io/tpmif.h
+++ b/include/xen/interface/io/tpmif.h
@@ -46,7 +46,7 @@ struct vtpm_shared_page {
 	uint8_t pad;
 
 	uint8_t nr_extra_pages;  /* extra pages for long packets; may be zero */
-	uint32_t extra_pages[0]; /* grant IDs; length in nr_extra_pages */
+	uint32_t extra_pages[]; /* grant IDs; length in nr_extra_pages */
 };
 
 #endif
-- 
2.25.0

