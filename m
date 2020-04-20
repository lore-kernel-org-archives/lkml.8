Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01CDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41C82071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tNk46QkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgDTSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:09:55 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.80]:22723 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgDTSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:09:54 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id B48A72848A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:09:52 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Qargj4g9sXVkQQargjFtPS; Mon, 20 Apr 2020 13:09:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wJHD7TM3Fxu768MV0g98UB0HrQgL7g1TGpW7kc7eYmA=; b=tNk46QkHwbkRhl/pIcS2wG+G02
        odFVU+69XYalTXZ55cswb2uY9LTYg1AEqtqpo9b3/S5mIVFEKMATcgSc24hrX3zvXLMZqD34wVlyr
        F/S0uYUIIyY0zom6YAhFTwAwa904HAVlvCRvOuo3QqfHxC4TfpbsbZRd+s5kBiCSgiBbYxlKJxr7d
        HIpwG2vPDiQKSKftvnXky++w/poyCBovxQnoPy0C164JiN+WDau9x5cWfsdKluft6KZzlM7KXfw3u
        iF5O65eIjTpjA1zu1uStxusQYJX7souRp4akcRbIR+cabjI6lB5k2zcz0HgetteNKJdyR47nYmUDC
        QlhL/NLA==;
Received: from [201.166.169.58] (port=24020 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jQarf-0043yr-CF; Mon, 20 Apr 2020 13:09:51 -0500
Date:   Mon, 20 Apr 2020 13:14:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2][next] m68k: amiga: config: Replace zero-length
 array with flexible-array member
Message-ID: <20200420181401.GA32172@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585264062.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.169.58
X-Source-L: No
X-Exim-ID: 1jQarf-0043yr-CF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.169.58]:24020
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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
 arch/m68k/amiga/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index c32ab8041cf6..06c15374200e 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -628,7 +628,7 @@ struct savekmsg {
 	unsigned long magic2;		/* SAVEKMSG_MAGIC2 */
 	unsigned long magicptr;		/* address of magic1 */
 	unsigned long size;
-	char data[0];
+	char data[];
 };
 
 static struct savekmsg *savekmsg;
-- 
2.26.0

