Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4EC728EF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495924688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813403;
	bh=cXyWnGOXMDI/RpQ47AsYJXfqH3j09CyQ273gSjmt4ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gl3L/N1A5xGbLr/KbJkTvDZhDtvGiITtP8JDSQHkADhg/ZmWRE9w/fLk9cMKBNopF
	 5PUwa5D+a5eK+62JkBvLkUdDic0s4A0PfyQAxuUvb7g9Ly6B3a0VymWcJUrYuPq9zS
	 A01vPzEmGM08D7DUyv3TiLubgwcdrkSrXCbDTgGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbgB0OOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389160AbgB0OOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BCC24691;
        Thu, 27 Feb 2020 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812880;
        bh=cXyWnGOXMDI/RpQ47AsYJXfqH3j09CyQ273gSjmt4ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KI1PEwXr55OVwEFIas5qsW+fWKpSdBUGEeqUXWa2S5sb7W3F5xaAU1MgPyFSmR9+M
         jCHqOkx0ScUQ/MVTdyuxDCSOXT4wzH2JLfJjZj5I1k42onDRPZW6IHTjAk1o0vmab2
         g/bbYgTwGie3t4RfCqmiKyrWU/1+EKnvzlBRgWAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Nantl <jn@forever.cz>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.5 024/150] USB: serial: ch341: fix receiver regression
Date:   Thu, 27 Feb 2020 14:36:01 +0100
Message-Id: <20200227132236.387789404@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 7c3d02285ad558691f27fde760bcd841baa27eab upstream.

While assumed not to make a difference, not using the factor-2 prescaler
makes the receiver more susceptible to errors.

Specifically, there have been reports of problems with devices that
cannot generate a 115200 rate with a smaller error than 2.1% (e.g.
117647 bps). But this can also be reproduced with a low-speed RS232
tranceiver at 115200 when the input rate matches the nominal rate.

So whenever possible, enable the factor-2 prescaler and halve the
divisor in order to use settings closer to that of the previous
algorithm.

Fixes: 35714565089e ("USB: serial: ch341: reimplement line-speed handling")
Cc: stable <stable@vger.kernel.org>	# 5.5
Reported-by: Jakub Nantl <jn@forever.cz>
Tested-by: Jakub Nantl <jn@forever.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ch341.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -205,6 +205,16 @@ static int ch341_get_divisor(speed_t spe
 			16 * speed - 16 * CH341_CLKRATE / (clk_div * (div + 1)))
 		div++;
 
+	/*
+	 * Prefer lower base clock (fact = 0) if even divisor.
+	 *
+	 * Note that this makes the receiver more tolerant to errors.
+	 */
+	if (fact == 1 && div % 2 == 0) {
+		div /= 2;
+		fact = 0;
+	}
+
 	return (0x100 - div) << 8 | fact << 2 | ps;
 }
 


