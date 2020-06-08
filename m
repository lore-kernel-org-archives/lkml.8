Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C107C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2827F2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659814;
	bh=Q1MnH9RZEWmo/MLTr/txxuhrn1OC1QQbfLP0JeFzoCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0pK4OtM3F2HWqQUWU/xospsmVylHxgqX5XPo1eJKpdm14lc6nnNP6rkohZK5W6rl
	 LRrBZS5KHKpV2E1NyrHtHECPTrxCfrm3Phi6TQ9Gyc+smvbnIee5TlgLJ6AMtpwUA3
	 t5JNx7zOo8hpQtz8JiYwZCWREgmBrydf46wzH508=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgFHXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387598AbgFHX1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E85F20775;
        Mon,  8 Jun 2020 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658829;
        bh=Q1MnH9RZEWmo/MLTr/txxuhrn1OC1QQbfLP0JeFzoCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcSUYjMibokDUC++6FlPZRMe1EB5rhDEnibODQxWhMslR4y+nZLyExP92bC1YRFU/
         AbwRgZvwgeGglUK22I0fVuprWLkGoVMOjPtba/yD5cTOVByy25rLPLB2ltRMxGx0A2
         VE9efUzUsFWPkxw2bARePJ9kEPHG3qFa1fGKT0Nw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/50] media: dvb: return -EREMOTEIO on i2c transfer failure.
Date:   Mon,  8 Jun 2020 19:26:10 -0400
Message-Id: <20200608232640.3370262-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a0057641cc86..c55180912c3a 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mb.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
@@ -84,7 +84,7 @@ static int dibusb_tuner_probe_and_attach(struct dvb_usb_adapter *adap)
 
 	if (i2c_transfer(&adap->dev->i2c_adap, msg, 2) != 2) {
 		err("tuner i2c write failed.");
-		ret = -EREMOTEIO;
+		return -EREMOTEIO;
 	}
 
 	if (adap->fe_adap[0].fe->ops.i2c_gate_ctrl)
-- 
2.25.1

