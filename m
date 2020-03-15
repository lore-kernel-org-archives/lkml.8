Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ECC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD020637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="PiXqnaA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgCORI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:08:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36474 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgCORI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:08:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gQrP5N7Mzw;
        Sun, 15 Mar 2020 18:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584292133; bh=CFU5FJmuQdF3qv0nzTWEIX3XxtGpmXCO2Bcuo6/RtV0=;
        h=Date:From:Subject:To:Cc:From;
        b=PiXqnaA20AS+ZPf2FLuiICoBqDqhTadyz5LqerFkVUBgSqRIBBYTJXR8ArbG2AKoO
         /724trCrD+7cm39uQY61t9m6b7oY/diuhGUpEY8RX0P/2FBLp7iojPPAhkI85CemyW
         wiitnfK5PM1b5bfNhafcU9Bw7NKsuTvidPDsNakaqOyj8euJsuXNhDRJ5m5AgaBoA4
         Pp/C9hMiloWng4T5Bm4NeSyVU0xvRB84YapoYHRXsa537fl9PdnB5BB9kJlV62QCxj
         UP8Bdqg332NU3ZtC9+ig4R8Z/u7PiD7enNuH6TSU5GP16liM4jFpf1HsNS3MdTP2jW
         CF9oVWEyRBVjg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 18:08:53 +0100
Message-Id: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] spi: fix cs_change for last transfer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic spi_transfer_one_message() implementation introduced in
commit b158935f70b9 has a bug in cs_change handling: it keeps CS
asserted when cs_change is set. Fix it.

Cc: stable@vger.kernel.org
Fixes: b158935f70b9 ("spi: Provide common spi_message processing loop")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8994545367a2..5012eabde468 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1206,7 +1206,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	bool keep_cs = false;
+	bool keep_cs = true;
 	int ret = 0;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
@@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
 					 &msg->transfers)) {
-				keep_cs = true;
+				keep_cs = false;
 			} else {
 				spi_set_cs(msg->spi, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-- 
2.20.1

