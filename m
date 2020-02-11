Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4855C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D96206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="r+dJJXzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBKXRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:17:37 -0500
Received: from gateway20.websitewelcome.com ([192.185.52.45]:48361 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbgBKXRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:17:37 -0500
X-Greylist: delayed 12966 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 18:17:36 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 0EEC9400C5D1B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:04:02 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1emejedtYRP4z1emej6SvH; Tue, 11 Feb 2020 17:17:36 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hVb/zj0rQi7ExOruAnZZPMpOWXBGiv8uW2JQqbBqmPY=; b=r+dJJXzfXuC1icigTXBmlDzDbj
        qL5VPjDbz0VAIEUjALS/MGwK8xsIF9eaVUbmRu076io4pCjVyb0Qm/TBEzKuSSnV+1F2NSSCkfwYe
        3fFr4zTa4FRq7X89QfQPKKU1BVGawtu2ojw6q1AqYXKuNYD3YatzKV0hc7EUNj1sz8JLIh76xGNCt
        xq75Ta8TrtVmeTT4t+V66LHDOJr1TEIFLVj71RdbIux0pErNApL6jP+2Gbd2dyZXDtY6D1Dn6e6xK
        z9/FKlsCFwwyJVystj3MPyaY6eih5ZCFh+FvJqEHxI62pht3sYqrIMMkIVMNjPN06+Q6CWLqi7ksC
        hFs/9qXw==;
Received: from [200.68.140.36] (port=9123 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1emc-003YKT-Td; Tue, 11 Feb 2020 17:17:34 -0600
Date:   Tue, 11 Feb 2020 17:20:09 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] thunderbolt: icm: Replace zero-length array with
 flexible-array member
Message-ID: <20200211232009.GA19088@embeddedor>
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
X-Exim-ID: 1j1emc-003YKT-Td
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:9123
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
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
 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af682..3eb0501c3875 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -100,7 +100,7 @@ struct icm_notification {
 struct ep_name_entry {
 	u8 len;
 	u8 type;
-	u8 data[0];
+	u8 data[];
 };
 
 #define EP_NAME_INTEL_VSS	0x10
-- 
2.25.0

