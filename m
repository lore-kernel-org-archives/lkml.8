Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C07720780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943735;
	bh=G7i77aO64Vn/HuKmSBMIphAENT2GJ98ArI3jrKSoYhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vn9CADbyI90ROzqT0vv0baKqaVAwdOLbDSv6bfAozeGUgRhcOM9d5/8zaVWM5ypyT
	 cxdVFieVcZoeYvWnA+WzBvsqRChF3Q2rAnbqE7t/2U/+o6ODyx73408tDqOwBYZQHN
	 WgRlGHfoIHO/ptQib1exuJYGG12hq7X2AnyQgscw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgFWUWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390126AbgFWUWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:22:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2A62064B;
        Tue, 23 Jun 2020 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943729;
        bh=G7i77aO64Vn/HuKmSBMIphAENT2GJ98ArI3jrKSoYhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZawG/Dz5M9huVfhr5aM/HPxB8dlDCLA964UUeRZ+Vt4/0lnNLO5ZLfeX4TOyCVMs
         URztqDaaji6Vk2FUJ0KBgfDJUZrnKtSueQkYFFiNwJ6eioqBMYXWC/8qtah0VGnapA
         /OJO87G75NDxSrvw6cYlm6Uf/b5AUUYNFkHEng6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/314] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Tue, 23 Jun 2020 21:53:42 +0200
Message-Id: <20200623195340.103938497@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit e81c979f4e071d516aa27cf5a0c3939da00dc1ca ]

If we timeout during a message transfer, the control register may
contain bits that cause an action to be set. Read-modify-writing the
register leaving these bits set may trigger the hardware to attempt
one of these actions unintentionally.

Always clear these bits when cleaning up after a message or after
a timeout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2c3c3d6935c0f..c9cbc9894bacf 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -706,11 +706,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
 {
 	u32 icr;
 
-	/*
-	 * Clear the STOP and ACK flags
-	 */
+	/* Clear the START, STOP, ACK, TB and MA flags */
 	icr = readl(_ICR(i2c));
-	icr &= ~(ICR_STOP | ICR_ACKNAK);
+	icr &= ~(ICR_START | ICR_STOP | ICR_ACKNAK | ICR_TB | ICR_MA);
 	writel(icr, _ICR(i2c));
 }
 
-- 
2.25.1



