Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A27C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B2206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fKj5Y5hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBKVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:44:16 -0500
Received: from gateway36.websitewelcome.com ([192.185.188.18]:39150 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgBKVoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:44:16 -0500
X-Greylist: delayed 2916 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 16:44:16 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 1BF4D40BC0795
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:09:40 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cZHjIfMOXVkQ1cZIjgzwJ; Tue, 11 Feb 2020 14:55:40 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zjc5LElXJ0zIygghxh2TaQQ5QMBnKhOZ9bRBJCzRtXs=; b=fKj5Y5hxtG77C4OrRGtRsmqzFH
        LmOdqavyDRDgSomroylBrffEtkaEUQlF/iwt2phvzghztPuyMqar6XMggvExMLKHjY9uj184VB4Mf
        17Q8Ko8/U6QvGAbIGbebs6knEZuUnfu9z8+TGrA9OVskmBEcAbFjJzi1hCZiM9vx5vmaYxidtkLed
        baps6upgIypNw/lIsT1kq/aErDchueSF04reoDkrhxEQdCfob2PsTZhrLbigDDOp2Naeweh6Y4BcJ
        nkMbbK9GuLdHBcrYWzoyztdteIRPM/Ilp3Vxm1MTPwoxtcjUMH5XzPVeRiwu+KpqDLu0zUUy/oG1l
        G3MCiGjw==;
Received: from [200.68.140.36] (port=27335 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cZG-001zvC-G4; Tue, 11 Feb 2020 14:55:38 -0600
Date:   Tue, 11 Feb 2020 14:58:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib/ts_fsm: Replace zero-length array with flexible-array
 member
Message-ID: <20200211205813.GA25602@embeddedor>
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
X-Exim-ID: 1j1cZG-001zvC-G4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:27335
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 47
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
 lib/ts_fsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
index 69557c74ef9f..f7aed7b6f3fe 100644
--- a/lib/ts_fsm.c
+++ b/lib/ts_fsm.c
@@ -36,7 +36,7 @@
 struct ts_fsm
 {
 	unsigned int		ntokens;
-	struct ts_fsm_token	tokens[0];
+	struct ts_fsm_token	tokens[];
 };
 
 /* other values derived from ctype.h */
-- 
2.25.0

