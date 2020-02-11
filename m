Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B0C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EFA206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DdRN6YlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbgBKU5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:57:16 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.187]:20193 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728369AbgBKU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:57:15 -0500
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 15:57:14 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 71888A4CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:57:14 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1caojhTFYAGTX1caojtrfW; Tue, 11 Feb 2020 14:57:14 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V1Z404XEtIf1we24S0h9I5bmknoegUWcJTRAMxr/esg=; b=DdRN6YlC2f8LqTpehtxTjdqX3X
        rgA1gHkpoYex4df+5mrHFGSlZFmOirJ/JtCUfUJLp+appbbG+F+anV+tCHPBg7MZplZgDF994oLM5
        ElJFQ7OH8EuBT3uDLLkd29IQWejPrvIrXfdfqX+9tCU3TawlWJ/SEpxoHxLR+jFD+wOxdeCieyrPd
        zIQXIJR/w5LnI3jMeEj7jWn4i5ZaRmg2z+P8m1xsksQGD1eDLI/S7vUWiv1gntdrUEv8Uss3owSiN
        q5dfn7lhSUBWZoZVHRqOF47hsG1e98J1duSYcqpS9RfgF1u1yGmxXd10FjdDfX3uMkuFKR2LF/XSx
        Zhitvt0Q==;
Received: from [200.68.140.36] (port=19003 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1can-0020zm-3i; Tue, 11 Feb 2020 14:57:13 -0600
Date:   Tue, 11 Feb 2020 14:59:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib/ts_kmp: Replace zero-length array with flexible-array
 member
Message-ID: <20200211205948.GA26459@embeddedor>
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
X-Exim-ID: 1j1can-0020zm-3i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:19003
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 49
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
 lib/ts_kmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ts_kmp.c b/lib/ts_kmp.c
index ffbe66cbb0ed..9dd5e708630e 100644
--- a/lib/ts_kmp.c
+++ b/lib/ts_kmp.c
@@ -40,7 +40,7 @@ struct ts_kmp
 {
 	u8 *		pattern;
 	unsigned int	pattern_len;
-	unsigned int 	prefix_tbl[0];
+	unsigned int	prefix_tbl[];
 };
 
 static unsigned int kmp_find(struct ts_config *conf, struct ts_state *state)
-- 
2.25.0

