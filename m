Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E7C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0220838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fXZGvH4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBJTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:44:58 -0500
Received: from gateway20.websitewelcome.com ([192.185.69.18]:33402 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgBJTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:44:57 -0500
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 14:44:57 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id F2140400CCD53
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:10:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1EfQj9VRSRP4z1EfQjbaNm; Mon, 10 Feb 2020 13:24:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zLJ411YQzZxcjVivpQCSqDHQIKFunCgqDuGk0Y1oDF8=; b=fXZGvH4sfeNwBs35dvxc4x9IO/
        lGre/eexYjTS79Tv1LTUpIErCF+xC5pMY88XXQBE/ddM44YBKPFEyw+u5ILAQjMYL01Ehq00BAnpF
        vV8szZbddEA/RgJvXUg/F9/NCrmhJbItNsy7Sm1HUwuDSqEW/BbsQo3Lqqm2V8SQcK2aAHQ43hOCW
        KT+l7tcrI4cxNKeexSxXg8U+VlW4D48xCs/pslMnOF/s8LT/ch67cGMiWoPaAcFOsAhGBOax5AU4Q
        u72GiAmyKX6QpUGOshCh2LPBTQFFzObVeWpnNkdOxyy8ac4ovu4z3vMeEh+A0XYsQyaDQKlqU3wK5
        TpSPyqNw==;
Received: from [200.68.141.48] (port=6223 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1EfO-0013oR-Te; Mon, 10 Feb 2020 13:24:23 -0600
Date:   Mon, 10 Feb 2020 13:26:56 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: altera: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20200210192656.GA8412@embeddedor>
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
X-Source-IP: 200.68.141.48
X-Source-L: No
X-Exim-ID: 1j1EfO-0013oR-Te
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.48]:6223
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 300 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is being used in a context
that expects an expression of type u64, but it's currently evaluated
using 32-bit arithmetic.

Addresses-Coverity: 1458369 ("Unintentional integer overflow")
Fixes: 0560ad576268 ("i2c: altera: Add Altera I2C Controller driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/busses/i2c-altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 5255d3755411..526f453f0ff7 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -171,7 +171,8 @@ static void altr_i2c_init(struct altr_i2c_dev *idev)
 	/* SCL Low Time */
 	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
 	/* SDA Hold Time, 300ns */
-	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
+	writel(div_u64(300ULL * clk_mhz, 1000),
+	       idev->base + ALTR_I2C_SDA_HOLD);
 
 	/* Mask all master interrupt bits */
 	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
-- 
2.25.0

