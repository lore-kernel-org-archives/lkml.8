Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD6C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D082077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mUaod4H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgCZXZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:38 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:42655 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728358AbgCZXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:34 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 257D1400CD14E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 18:25:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id HbsUjuNnNSl8qHbsUjRTL3; Thu, 26 Mar 2020 18:25:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=grjM/OY0LIHkZOW5PwdnOjNYCjbw7mdOQ737LWQGQaQ=; b=mUaod4H59x4GUF3M2NUv02zzcD
        2i/pHWdG2UoLJnlKylZFnWgLiY+wRr0KRJFiRmURQHznwc4hYItpI2eSxYElv2K3ztlwcF+4Gq4LX
        Dq1yoytjZD+k3ZYLOuDu/zyJbO+787SSLYfii1aIBm3rPno1W80Yoe2IfIMx5ek3cXz0lNT/HgB4Z
        1K1Pu+AuljC8KeqTfEQZYjbtAw371aOGkqIusZ3rKUyv/h8CilJwhdyMcQXi0x+DOI427+aaJF5aN
        JUQ1MHl/AwKSo23FujCM9w+bLKrEYjIg8HpY+y6vEvEAMGu3Ai4vWPbERx97u+bwfaBYhF8epPk39
        dTrLxPVA==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:33836 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jHbsS-0014sJ-Nb; Thu, 26 Mar 2020 18:25:32 -0500
Date:   Thu, 26 Mar 2020 18:29:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] m68k: amiga: config: Mark expected switch
 fall-through
Message-ID: <14ff577604d25243c8a897f851b436ba87ae87cb.1585264062.git.gustavo@embeddedor.com>
References: <cover.1585264062.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1585264062.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jHbsS-0014sJ-Nb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:33836
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: allmodconfig m68k):

arch/m68k/amiga/config.c: In function ‘amiga_identify’:
./arch/m68k/include/asm/amigahw.h:42:50: warning: this statement may fall through [-Wimplicit-fallthrough=]
 #define AMIGAHW_SET(name) (amiga_hw_present.name = 1)
                           ~~~~~~~~~~~~~~~~~~~~~~~^~~~
arch/m68k/amiga/config.c:223:3: note: in expansion of macro ‘AMIGAHW_SET’
   AMIGAHW_SET(PCMCIA);
   ^~~~~~~~~~~
arch/m68k/amiga/config.c:224:2: note: here
  case AMI_500:
  ^~~~

Replace the existing /* fall through */ comments and fix the issue above
by using the new pseudo-keyword fallthrough;

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/m68k/amiga/config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 06c15374200e..4eb911d64e8d 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -221,6 +221,7 @@ static void __init amiga_identify(void)
 	case AMI_1200:
 		AMIGAHW_SET(A1200_IDE);
 		AMIGAHW_SET(PCMCIA);
+		fallthrough;
 	case AMI_500:
 	case AMI_500PLUS:
 	case AMI_1000:
@@ -233,7 +234,7 @@ static void __init amiga_identify(void)
 	case AMI_3000T:
 		AMIGAHW_SET(AMBER_FF);
 		AMIGAHW_SET(MAGIC_REKICK);
-		/* fall through */
+		fallthrough;
 	case AMI_3000PLUS:
 		AMIGAHW_SET(A3000_SCSI);
 		AMIGAHW_SET(A3000_CLK);
@@ -242,7 +243,7 @@ static void __init amiga_identify(void)
 
 	case AMI_4000T:
 		AMIGAHW_SET(A4000_SCSI);
-		/* fall through */
+		fallthrough;
 	case AMI_4000:
 		AMIGAHW_SET(A4000_IDE);
 		AMIGAHW_SET(A3000_CLK);
-- 
2.26.0

