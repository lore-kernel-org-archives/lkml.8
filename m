Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62EC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1020754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cXXJnQ2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCTWN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:13:27 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.71]:16505 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgCTWN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:13:27 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 7E1883AB4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:13:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FPtNjs72qVQh0FPtNj6v4U; Fri, 20 Mar 2020 17:13:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k89j+eS15/9MTQAcINBI98rRT8Bb4ipIVNR2vNEQpOM=; b=cXXJnQ2PI758f5wjGJLPiBUVTp
        JSfcLwH6ttE6l9UGGwgl7KUppJvuQnrkvC4WcDlChXPC7L6DHvLfby6nTpG5zVA7CX06yB4EfmW8W
        RNFTzKCAV1uFDG5FSLAF2SACb/o50bFDIK/GsKgH4+Es75erCprOaez6Hr+ulNRFUMBtYIyDoXFWN
        HjjSZwpSHpVLagLVL46yVcKEgv69bAt0xh0jxxC8hd1HZ24c9SS2U1adOIbUgqp1koAuQiM4s15Jn
        /mlGsHFHgxYOhtiT12UK3gARx2nzA3OezRPjY1NBlEnenMAPSrO+Ro8U1PM6OuMakaMFNf3WriCvO
        kDcEV8aw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:52852 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jFPtM-000pw6-4S; Fri, 20 Mar 2020 17:13:24 -0500
Date:   Fri, 20 Mar 2020 17:13:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] pcmcia: soc_common.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200320221323.GA12585@embeddedor.com>
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
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jFPtM-000pw6-4S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:52852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
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
 drivers/pcmcia/soc_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index b7f993f1bbd0..222e81c79365 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -88,7 +88,7 @@ struct soc_pcmcia_socket {
 
 struct skt_dev_info {
 	int nskt;
-	struct soc_pcmcia_socket skt[0];
+	struct soc_pcmcia_socket skt[];
 };
 
 struct pcmcia_state {
-- 
2.23.0

