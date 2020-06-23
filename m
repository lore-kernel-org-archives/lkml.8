Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3D20DD4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942613;
	bh=ehPQWl894sbgTNmzS/SIs0Z6pQg1mVWU2x14we6GvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kmhyho7SVOD4EzVHHKURUpGHnhuh6CihMfjv4UM8865jQfJuBzcUnoHwNZpJAhEmW
	 0kugqZu13BvaJVLhiu5HjJ6ohKm8rsfFd6h+iN04o9tPsolM5SNbUXS7qTvYuK3S+h
	 OoZ0jeGEDOB76YkByNKqsjexHHcR1feayBOghOzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgFWUDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbgFWUDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:03:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6A82078A;
        Tue, 23 Jun 2020 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942604;
        bh=ehPQWl894sbgTNmzS/SIs0Z6pQg1mVWU2x14we6GvyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zk2S3qfn6H2fYiWR3s5ezLn4hNfuQ7GY+byZj1BLszRwM8WgLRfO3/BXxG2zey+Y
         RnfF+LnYlBU4bTfyuYlX3pojoIGU04V1udvRC+zz5A6cdayi/OkB6sRZ1/ZrFPmC87
         3KXS7lWce1FiJfFm2YBrdoUqgYA77cAYYZXEFBX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 036/477] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Tue, 23 Jun 2020 21:50:33 +0200
Message-Id: <20200623195409.307067673@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
index 466e4f681d7a4..30a6e07212a42 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -747,11 +747,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
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



