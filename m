Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33154C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC420842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257559;
	bh=lCoIUC5b0pL0VYMsb5nDT4bqv8J5/fmGWMwPjnMO0QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQQCk7eEMg5/nkmsKWCaFFRfGgOtMUuxQVBkPB2k6qYY+H7n/klf50I2uOPnr+14j
	 E/EXA7wfytjUROBrqqDE/8RUSmvVtxgx9zBhuVeSqec33BoDZ46kxPr6xb3hHzC3KZ
	 wEz3soiRV1WKULDyNl977OtewdcOfeYnxEQAoO3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgCCRp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbgCCRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:45:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785C0215A4;
        Tue,  3 Mar 2020 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257554;
        bh=lCoIUC5b0pL0VYMsb5nDT4bqv8J5/fmGWMwPjnMO0QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TBXylbxcLf9w9JLR8auSgJkJ3RiwreMWboY/mzV+CXqIJoErR3kMrib5hgP5lOXU
         xLFL+33kK3NWgGr6JlntIW36NM5HZFd5lfLwPpYTQsbWWxbKI0eiNPIkfSYfFcV9jX
         xkKHF52jTwrBveNSo6qfxairNt0A/QE4pWT9wQsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 005/176] net: mscc: fix in frame extraction
Date:   Tue,  3 Mar 2020 18:41:09 +0100
Message-Id: <20200303174305.189935639@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mscc/ocelot_board.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -114,6 +114,14 @@ static irqreturn_t ocelot_xtr_irq_handle
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


