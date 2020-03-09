Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF1C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223FD2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAI8LH89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCILzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCILzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id v4so10709012wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wl7h7MB0G2BXUvEqAv+8JB5mpSUGz57zUw9UrFnUC+Q=;
        b=QAI8LH89pXw1rDMEbEXXEcRXUEImMLQVXZY1W0zBN20emFSI2ilsE7szWqbgadPbFF
         zZ7o4ceBNEq7fm/z6JCd0ZEtNMfI/0SpWxRODezMGMZuD2/eLZTDLMCtGcYiLBrWT4sQ
         EZNO4yevAAKLj7kOk7igoenaPub6zzspcU/bnS1yfXucqYY/PZ3GCoE5zWML3QbdpTwV
         ezH3zT3oi0kz8xRZ2XtzwylCmOSM0mM6ewTWjvXCixLEkjgeFwT5NlRTy8AA2NKBlvxe
         YJwd4HeirCatJpAF1tO6x8KP80XrYmZ/SwYVnmo+ZSeosUlgD8xnF6UtNxu4zpLANq39
         aIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wl7h7MB0G2BXUvEqAv+8JB5mpSUGz57zUw9UrFnUC+Q=;
        b=e2S4tirm6/asNw1q2J7rpxkRK64T3vkdEfQfFBihZJFsTTMA0nXWyZJfAXbW6deL+N
         OPqzXPG8nfm9P5HFM11bqf5S56kxdPCb2jbWpQAnOKJ6iMyRUFczn+tr36xN9rvNE6Ae
         iWqspCruTCeSDSlOnsRb8VFNoIa7g6xcxlhd+d4Guo7PLT80Gyk9CeGf3ueiwh2oePfo
         ql5d5FDXyHTcTwTYCQW8PoMQ0t9ttj3LwlCb1X5kDr9NUjKvzOwoylWNvEHLtrjiftgk
         ypsvOR+phKvg7LkUxg55dvFWP9JzSu7W/vVN4KAGhCf3vYEVrFukNWT828yByx6yIwG2
         CUhw==
X-Gm-Message-State: ANhLgQ2dBbi6gJwStHqOI94LEehQBJLCxywrrKnTRaCiWKUAs8V1LEwd
        QHrNkjrsVR+LB8pvuZaRqJA=
X-Google-Smtp-Source: ADFU+vskomjONPUto2Y90h1MwspfEtgonwvN9Uo7fg/xvCJd2O7UYZYYu7VoXJhLP+apOx0VDVmbRw==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr8425237wrv.137.1583754936503;
        Mon, 09 Mar 2020 04:55:36 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:35 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 2/6] mtd: spinand: micron: Describe the SPI NAND device MT29F2G01ABAGD
Date:   Mon,  9 Mar 2020 12:52:26 +0100
Message-Id: <20200309115230.7207-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add the SPI NAND device MT29F2G01ABAGD series number, size and voltage
details as a comment.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index c028d0d7e236..e4aeafc56f4e 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info micron_spinand_table[] = {
+	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
-- 
2.17.1

