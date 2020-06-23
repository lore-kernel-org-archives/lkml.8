Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F40B20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942533;
	bh=jkSbYXyGog1baCPe3iUFynA3x9tdbQqs8Pbsgh/8wdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DuMEx7howKoHPTJnSr2xzevd8fNhliCcrPe22Rz8+WDGKrDVGr3H2jDo3SRJqzC6e
	 thf9G8Xh8pcMokIvt7k++M1uPDj45BdGbO+7ECJc3YaterjgytcbZUxcrQRJ5nY1Xw
	 F57T8lw6YemGkf/ZPg13iDGT6eDvCnRgVonj7TCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgFWUCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387734AbgFWUB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BBD2078A;
        Tue, 23 Jun 2020 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942517;
        bh=jkSbYXyGog1baCPe3iUFynA3x9tdbQqs8Pbsgh/8wdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YV0pT4WbVPpOLC3VekRmZOPEswoJzN7vArQ4wo2fWJRG6hX2nWvyNnNfkZ8KHzebf
         3DNVfYdqJsRTZ4BdZqTF20DTsNEKpLXm77MxEZzkH3C5mKS7Ww+MCV2zL++p9XRExI
         9D+a6MhfEHZT5YkhT9fWr3pibX3+XWTB4u2/ZyX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 029/477] Input: edt-ft5x06 - fix get_default register write access
Date:   Tue, 23 Jun 2020 21:50:26 +0200
Message-Id: <20200623195408.973100883@linuxfoundation.org>
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

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 255cdaf73412de13608fb776101402dca68bed2b ]

Since commit b6eba86030bf ("Input: edt-ft5x06 - add offset support for
ev-ft5726") offset-x and offset-y is supported. Devices using those
offset parameters don't support the offset parameter so we need to add
the NO_REGISTER check for edt_ft5x06_ts_get_defaults().

Fixes: b6eba86030bf ("Input: edt-ft5x06 - add offset support for ev-ft5726")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20200227112819.16754-2-m.felsch@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d2587724c52ad..9b8450794a8a2 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -938,19 +938,25 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
 
 	error = device_property_read_u32(dev, "offset", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset, val);
+		if (reg_addr->reg_offset != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset, val);
 		tsdata->offset = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-x", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_x, val);
+		if (reg_addr->reg_offset_x != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset_x, val);
 		tsdata->offset_x = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-y", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_y, val);
+		if (reg_addr->reg_offset_y != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset_y, val);
 		tsdata->offset_y = val;
 	}
 }
-- 
2.25.1



