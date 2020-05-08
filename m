Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167C7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1D4206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944018;
	bh=nvbuz3/DPXst33UH5bth9F+uJ1+egb9BKR0QfaRwYqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fd+3pc2W4Wkd5u7gTk0RLGSai9G41MePgayjtwefsqY1GXrqbz5PCQRB/gROqe7Sf
	 t0R079+hEFL2n4Lvp18E2TsPc5NmnsVCL8WcPb1xG1GqJeFy8zMVSrygXXt4JMOXXE
	 m2NOwYT/itLfXH2bR8Sb71kYSmPDUYaJ0qc6Z9RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgEHNUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgEHMlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C1724971;
        Fri,  8 May 2020 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941663;
        bh=nvbuz3/DPXst33UH5bth9F+uJ1+egb9BKR0QfaRwYqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egEXr6MreXy8R/wSzTfaSW6/FkfgiXbggYaeASOOk1e8LOxiUBt07B/PToV22j1BV
         3YSTqMVol2BYPy5U4aMVLNC8LUAYzc7pHdANrMKDt6Kjxt0p4JWbrV6wlS3jU9mEDW
         tiMN/6iK1bcqpqlkL//jEGJxqJ0R7eM63IRfF/z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 122/312] Input: edt-ft5x06 - fix setting gain, offset, and threshold via device tree
Date:   Fri,  8 May 2020 14:31:53 +0200
Message-Id: <20200508123133.030897998@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

commit dc262dfaaeda7617ae0b15b5ce1252a6cd102b19 upstream.

A recent patch broke parsing the gain, offset, and threshold parameters
from device tree. Instead of setting the cached values and writing them
to the correct registers during probe, it would write the values from DT
into the register address variables and never write them to the chip
during normal operation.

Fixes: 2e23b7a96372 ("Input: edt-ft5x06 - use generic properties API")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/edt-ft5x06.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -822,16 +822,22 @@ static void edt_ft5x06_ts_get_defaults(s
 	int error;
 
 	error = device_property_read_u32(dev, "threshold", &val);
-	if (!error)
-		reg_addr->reg_threshold = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold, val);
+		tsdata->threshold = val;
+	}
 
 	error = device_property_read_u32(dev, "gain", &val);
-	if (!error)
-		reg_addr->reg_gain = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_gain, val);
+		tsdata->gain = val;
+	}
 
 	error = device_property_read_u32(dev, "offset", &val);
-	if (!error)
-		reg_addr->reg_offset = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset, val);
+		tsdata->offset = val;
+	}
 }
 
 static void


