Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674AC18E7A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBB424691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845646;
	bh=j/cTGtyx0i2W8prlaQJxrHhlNQJqNPuJz2rSwBTjyBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1/YIR+R8lnOi4GPQUUG86tFeWq9YjG19DQxXZ6P1PcIhq1M3//8gSZt479l1nl4c
	 dow+SBtVdFcm/ZPILmMyI55xNG60zldzFsWP7ERCqRfqyHlRCy/M4zf/1g0JX2qyE8
	 7Qb4whxllW9NXFFGYHERfFVfbaKdKSIwNYVa51fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgCJNHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgCJNHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:07:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A3220873;
        Tue, 10 Mar 2020 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845641;
        bh=j/cTGtyx0i2W8prlaQJxrHhlNQJqNPuJz2rSwBTjyBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsMTXbkUhqJNU3ubbqn60Nhf+WAlAZUHudrn3XVZMD1GnHm9qbSP7OfApenDE50eM
         Mgh2wuzIKLLtGglD7lzeLODzmP82C/VUnhJe+7epgRpHfP+r0Dc0U+3+hSt4/gEpJN
         /O+l/zDD+SI0de845HTDGbGhqq1tFf6pQLM2Mr0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 046/126] i2c: altera: Fix potential integer overflow
Date:   Tue, 10 Mar 2020 13:41:07 +0100
Message-Id: <20200310124207.229610173@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 54498e8070e19e74498a72c7331348143e7e1f8c upstream.

Factor out 100 from the equation and do 32-bit arithmetic (3 * clk_mhz / 10)
instead of 64-bit.

Notice that clk_mhz is MHz, so the multiplication will never wrap 32 bits
and there is no need for div_u64().

Addresses-Coverity: 1458369 ("Unintentional integer overflow")
Fixes: 0560ad576268 ("i2c: altera: Add Altera I2C Controller driver")
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-altera.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -182,7 +182,7 @@ static void altr_i2c_init(struct altr_i2
 	/* SCL Low Time */
 	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
 	/* SDA Hold Time, 300ns */
-	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
+	writel(3 * clk_mhz / 10, idev->base + ALTR_I2C_SDA_HOLD);
 
 	/* Mask all master interrupt bits */
 	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);


