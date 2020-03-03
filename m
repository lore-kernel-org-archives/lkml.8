Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B12C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7ED217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204454;
	bh=nX5bWBPqLt3t+hgTg/LTALr6uiPwfRRzf47WjUvO1uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lySKwZ58NkTTIJnOvrJvR0qCzgli226DoN2OdN2iluRJTMfD8UAh5LrmnmSAHULZD
	 QcN/Rhvm1gBQ4kOhF8E4MgcCbVb+LDOY7v+VDSiDNhZ1gWk6ApazXUkjeVnHWacLUp
	 P8T9W6iFmfqvGAA9cAPo0aU2T+4EFrmrg2prKXdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCCCrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgCCCrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBA6246E6;
        Tue,  3 Mar 2020 02:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203626;
        bh=nX5bWBPqLt3t+hgTg/LTALr6uiPwfRRzf47WjUvO1uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxmPc87nzB98WE/4Rgvuk8l8WaMLpJfg6turTWTo7rI1lBsbcf/GZieTEKDSVuXVv
         MgIfmmXnaNMI1ERxre2glv8gLqz3IIQKauN+jinyKu99nnPHcD0uXyHE1youVhEQLR
         YIXYFoG2Hwgfx397SCch7HBjaAPtyDvpUqqWf1yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 40/66] net: mscc: fix in frame extraction
Date:   Mon,  2 Mar 2020 21:45:49 -0500
Message-Id: <20200303024615.8889-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit a81541041ceb55bcec9a8bb8ad3482263f0a205a ]

Each extracted frame on Ocelot has an IFH. The frame and IFH are extracted
by reading chuncks of 4 bytes from a register.

In case the IFH and frames were read corretly it would try to read the next
frame. In case there are no more frames in the queue, it checks if there
were any previous errors and in that case clear the queue. But this check
will always succeed also when there are no errors. Because when extracting
the IFH the error is checked against 4(number of bytes read) and then the
error is set only if the extraction of the frame failed. So in a happy case
where there are no errors the err variable is still 4. So it could be
a case where after the check that there are no more frames in the queue, a
frame will arrive in the queue but because the error is not reseted, it
would try to flush the queue. So the frame will be lost.

The fix consist in resetting the error after reading the IFH.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 2da8eee27e985..ecbd4be145b85 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -114,6 +114,14 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 		if (err != 4)
 			break;
 
+		/* At this point the IFH was read correctly, so it is safe to
+		 * presume that there is no error. The err needs to be reset
+		 * otherwise a frame could come in CPU queue between the while
+		 * condition and the check for error later on. And in that case
+		 * the new frame is just removed and not processed.
+		 */
+		err = 0;
+
 		ocelot_parse_ifh(ifh, &info);
 
 		ocelot_port = ocelot->ports[info.port];
-- 
2.20.1

