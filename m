Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699EDC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F81206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979451;
	bh=m5M8Awz22GmrEwV0BJ4+h7A02qBUcB/cu5vWpcC9nPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzKIrrpr4G6NNtRlXXyHJ1BlNBtirFVQ/WGvI63+b+qjoeAryg0ZC8/yPU3uXbtCG
	 2VmYksK531zyf5WFXNyNIwcdsKbwaXgl61PmcRzBIpOuAD36iYyIRklrtVGNWyHVV1
	 Kqxene8P6HjZbn6+i6S8Jsw4sADVOYSCZ+uCozDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgIAQ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgIAPXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E400020FC3;
        Tue,  1 Sep 2020 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973804;
        bh=m5M8Awz22GmrEwV0BJ4+h7A02qBUcB/cu5vWpcC9nPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jk5CdyFDZopav0xqTwwPD/kCj0Hy01R/AIQ0YaDVgwlG1sc4C4UBiw58GHhAx6X06
         8AzYNn0mspMltnDZy0L7L09OLrcRs7zbVjzNampBu6MD9OU2PMvX65H53O7v3TrZws
         Tzg1HsgLKrCOrAFHHKnPGtqSFrDFPylno3HGORVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/125] media: gpio-ir-tx: improve precision of transmitted signal due to scheduling
Date:   Tue,  1 Sep 2020 17:10:08 +0200
Message-Id: <20200901150937.150292200@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

[ Upstream commit ea8912b788f8144e7d32ee61e5ccba45424bef83 ]

usleep_range() may take longer than the max argument due to scheduling,
especially under load. This is causing random errors in the transmitted
IR. Remove the usleep_range() in favour of busy-looping with udelay().

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/gpio-ir-tx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/rc/gpio-ir-tx.c b/drivers/media/rc/gpio-ir-tx.c
index cd476cab97820..4e70b67ccd181 100644
--- a/drivers/media/rc/gpio-ir-tx.c
+++ b/drivers/media/rc/gpio-ir-tx.c
@@ -87,13 +87,8 @@ static int gpio_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 			// space
 			edge = ktime_add_us(edge, txbuf[i]);
 			delta = ktime_us_delta(edge, ktime_get());
-			if (delta > 10) {
-				spin_unlock_irqrestore(&gpio_ir->lock, flags);
-				usleep_range(delta, delta + 10);
-				spin_lock_irqsave(&gpio_ir->lock, flags);
-			} else if (delta > 0) {
+			if (delta > 0)
 				udelay(delta);
-			}
 		} else {
 			// pulse
 			ktime_t last = ktime_add_us(edge, txbuf[i]);
-- 
2.25.1



