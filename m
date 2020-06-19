Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE092158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580253;
	bh=hX12khJAdZqJIox8b1e42ktmh3BYm/+28o1Cp2ygp9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvU7soVzKyvaGOsD8eEPVxKSifPHJkN0u/XosA71Ynk9NdRO0diYLFHpsGyrB1ynM
	 XpFPw9fps4c5J4GaFS4tegwqJEczsmkyS5XPgN9e/a/B2z25XA2D7ztJdkFXYTKpEc
	 5mAHgq8OODfGw6NLPGKKQdzhycjRXan1ln8vmJwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404062AbgFSPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392735AbgFSPUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:20:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D8A20B80;
        Fri, 19 Jun 2020 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580043;
        bh=hX12khJAdZqJIox8b1e42ktmh3BYm/+28o1Cp2ygp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0X/6FC2/VRY56IhuoSb6eYEBLq0AWe/m7adPXVVevzs7SB9hzGgQIRoC7R8mwxPdq
         wh+5Run5jEvCaa7QOWDoI08wfxYloydlG1vIH33l7LScg0JBiQwxEjeOLoUg09TZEM
         /nGqw+WnEb3W1PGwmlLZdttgOIfUIVJE8DOpuygo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 100/376] media: dvb: return -EREMOTEIO on i2c transfer failure.
Date:   Fri, 19 Jun 2020 16:30:18 +0200
Message-Id: <20200619141715.082043748@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 96f3a9392799dd0f6472648a7366622ffd0989f3 ]

Currently when i2c transfers fail the error return -EREMOTEIO
is assigned to err but then later overwritten when the tuner
attach call is made.  Fix this by returning early with the
error return code -EREMOTEIO on i2c transfer failure errors.

If the transfer fails, an uninitialized value will be read from b2.

Addresses-Coverity: ("Unused value")

Fixes: fbfee8684ff2 ("V4L/DVB (5651): Dibusb-mb: convert pll handling to properly use dvb-pll")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dibusb-mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dibusb-mb.c b/drivers/media/usb/dvb-usb/dibusb-mb.c
index d4ea72bf09c5..5131c8d4c632 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mb.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
@@ -81,7 +81,7 @@ static int dibusb_tuner_probe_and_attach(struct dvb_usb_adapter *adap)
 
 	if (i2c_transfer(&adap->dev->i2c_adap, msg, 2) != 2) {
 		err("tuner i2c write failed.");
-		ret = -EREMOTEIO;
+		return -EREMOTEIO;
 	}
 
 	if (adap->fe_adap[0].fe->ops.i2c_gate_ctrl)
-- 
2.25.1



