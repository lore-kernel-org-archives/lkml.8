Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B34C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A4322522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220476;
	bh=SJ5RdmOGfQs5mLEPAX0sUe3M8Uc/nvXTm72BCGqymo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYuNxKD1O7SpPmxab7Qt8oIFw7NEIekTpBYyo+Jwi6n8sUMk1Y4v/7X9NJANaBAq5
	 ThVLKLbfuYm3BAwhg5EXbGtawfOYkg5d9pZWEKh/tlmv58WnT0kcQRSw9SuWttlbgk
	 2v8H/qrZclSIHO9AlQ4zKlAidKaO3eyh/NG05v6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgA1OHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgA1OHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:07:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFDD2468A;
        Tue, 28 Jan 2020 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220472;
        bh=SJ5RdmOGfQs5mLEPAX0sUe3M8Uc/nvXTm72BCGqymo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LULCNy4B6uc1v3ZuJ7z+khtTZWngLkg/TcaW3om5DP3s7N7MCXJcJDkCF6YcvIDx3
         ieELHj2DAS3GfneYTu4LHb1iYOoW06tvvDI9V72JFKiSqC3Lk/syMW/GANfHOFuTcB
         Ax2F3WS+A9xamvOk3ARWqyqhT+O++nJrU7r442xI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/183] Input: nomadik-ske-keypad - fix a loop timeout test
Date:   Tue, 28 Jan 2020 15:03:59 +0100
Message-Id: <20200128135831.917124982@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4d8f727b83bcd6702c2d210330872c9122d2d360 ]

The loop exits with "timeout" set to -1 not to 0.

Fixes: 1158f0f16224 ("Input: add support for Nomadik SKE keypad controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 8567ee47761e1..ae3b045570740 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -100,7 +100,7 @@ static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
 		cpu_relax();
 
-	if (!timeout)
+	if (timeout == -1)
 		return -EINVAL;
 
 	/*
-- 
2.20.1



