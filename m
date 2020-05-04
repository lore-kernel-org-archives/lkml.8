Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3822C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF530205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615458;
	bh=oisrjGC2R519ZWch4BZGf44X1xNE52FyZ8g5AFCBwIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqOsvEls2nwfs/7zGxILuoygY9UHwuFGfhIUDQzjua9cAP6CwRctvT7sf8J0VLYr7
	 goi/BVstd6k/XnVh9aEjlwydvcEfLRjM2/e+1BoRcwr4DRw6SjA3xKk8/B5eyUCldO
	 bcGPSziSV1Q09Eq4hXJDet/URI6h3Tfs1nhVbiDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgEDSER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731632AbgEDSEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:04:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C4A20746;
        Mon,  4 May 2020 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615447;
        bh=oisrjGC2R519ZWch4BZGf44X1xNE52FyZ8g5AFCBwIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JydwQzc/mJSHayTCNcvDypjJMivQephmv8ExoUsMTnRXjQX4IJpFdJH7GOCw7uAQ1
         fOjom0KOdNBYtSuT5yxuPC1jeK7Z2E379GaKbZK1/4dvMB5NODtQGqM76cwAt2Ymwm
         6JcMlQ93Otgg3lgqPzvQL/KFJ6iEXVtHPqT74+AI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.4 43/57] i2c: iproc: generate stop event for slave writes
Date:   Mon,  4 May 2020 19:57:47 +0200
Message-Id: <20200504165500.057640592@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

commit 068143a8195fb0fdeea1f3ca430b3db0f6d04a53 upstream.

When slave status is I2C_SLAVE_RX_END, generate I2C_SLAVE_STOP
event to i2c_client.

Fixes: c245d94ed106 ("i2c: iproc: Add multi byte read-write support for slave mode")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-bcm-iproc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -359,6 +359,9 @@ static bool bcm_iproc_i2c_slave_isr(stru
 			value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
 			i2c_slave_event(iproc_i2c->slave,
 					I2C_SLAVE_WRITE_RECEIVED, &value);
+			if (rx_status == I2C_SLAVE_RX_END)
+				i2c_slave_event(iproc_i2c->slave,
+						I2C_SLAVE_STOP, &value);
 		}
 	} else if (status & BIT(IS_S_TX_UNDERRUN_SHIFT)) {
 		/* Master read other than start */


