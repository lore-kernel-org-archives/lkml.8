Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B16C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D30206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gVoeX18X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD0UdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:33:15 -0400
Received: from gateway20.websitewelcome.com ([192.185.4.169]:14810 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgD0UdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:33:14 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 13D5C400C6E3B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:28:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T9hrjB1z5EfyqT9hrj11XN; Mon, 27 Apr 2020 14:46:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2PhqAadEanGA6zu3GS0dpv53aeSLftBKlQlVVXlea+k=; b=gVoeX18XHnlGe6CLXThXRH9LZ
        aKlnSZSAL85rDI3H7sG2EkU+BG476MeXYVRILj1dM5eEci4Cj+82kYaxvwwGvZbmT6SXbBLYmHK9r
        ynot9tkadfyLT2v4IgFRnZRVcCRGXVT5NmmXa7/kaLlpuJrFYO4DFXpVVw6ZTmQ2ebDXXGUOVfgsp
        kpXstOcY0WWLGIWxT02+ujQAZCbYJ7XEc/2PgIKbPkTkYMUYCWq+EmjQS2OndBXdoq4WjL3AFGFMF
        wUE5UJ7ge6+FYBUYPM1w8V+rM39+DfgyXXoXDrLz7dyFPhkPssOW96105KNnNrNjIjFyopVj3vm9A
        Sgk1HzloQ==;
Received: from [201.162.241.110] (port=25072 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT9hr-000yI5-F7; Mon, 27 Apr 2020 14:46:19 -0500
Date:   Mon, 27 Apr 2020 14:50:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 1/3] mtd: lpddr: Fix bad logic in print_drs_error
Message-ID: <3fb0e29f5b601db8be2938a01d974b00c8788501.1588016644.git.gustavo@embeddedor.com>
References: <cover.1588016644.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588016644.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT9hr-000yI5-F7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:25072
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update logic for broken test. Use a more common logging style.

It appears the logic in this function is broken for the
consecutive tests of

        if (prog_status & 0x3)
                ...
        else if (prog_status & 0x2)
                ...
        else (prog_status & 0x1)
                ...

Likely the first test should be

        if ((prog_status & 0x3) == 0x3)

Found by inspection of include files using printk.

Fixes: eb3db27507f7 ("[MTD] LPDDR PFOW definition")
Cc: stable@vger.kernel.org
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - None.

 include/linux/mtd/pfow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
index 122f3439e1af..c65d7a3be3c6 100644
--- a/include/linux/mtd/pfow.h
+++ b/include/linux/mtd/pfow.h
@@ -128,7 +128,7 @@ static inline void print_drs_error(unsigned dsr)
 
 	if (!(dsr & DSR_AVAILABLE))
 		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
-	if (prog_status & 0x03)
+	if ((prog_status & 0x03) == 0x03)
 		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
 						"half with 41h command\n");
 	else if (prog_status & 0x02)
-- 
2.26.0

