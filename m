Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C2DC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133420737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StDiSJ50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgCKR67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:58:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgCKR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so3794465wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YK/2vS7Mstiu0XU04PxOhSKonXRCAES7bjkmRXDeYXo=;
        b=StDiSJ50IJOWu7yyuj5a/ZUXGOOdq2kydVzliPuespbcRB9e4BhXXJm275cy8fSQpM
         s+dVf3OjRl83zbDYN6JeW+B3/WfFxcQsU6xkb9PKFdadUUcpyUcyTqyTX0Y0ojFo0e+5
         Ay0L4myHKUGEIkg9LcAIO5b10u6jylyqgq8dttKmBAMIG8Rxx4EYcwDI/LZ5w77Pezpd
         /6Pc+ZHV6tTADcG/TwYaEEyVcb+krWOJyiYOh9YV6yV3JSx9rJ5ageMeNGFc1Xu3rT0a
         yUdYgvxESwO12QKckb6qj0rsPh8DZQ6rv1UFF/lhMSW/n0LGCMBisy97yktDaJOpg+o3
         GsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YK/2vS7Mstiu0XU04PxOhSKonXRCAES7bjkmRXDeYXo=;
        b=rk8xr+ZhxFDoUe/WyJ07D/RIDT1Z+aQ30oAgRAJ+oYGgjdP/DZGi+bTtRjm1xPUKc9
         3v0Rc+6qUnSLdKK4A8GrPCI69YeRaJVnH3biIrSt3+69vNq37AL0cw22ZbFEeapZ0beH
         vHbS3Eh/qVm5A9MRcNHjBRXSAi3CicGoLbb3H6wgyX7+P+NI4vBipVjc/aRR7Znal9cY
         mieGHEpxehR36VfEIClo9398BpSYeRO8yct4WWAUOjAl7uTGt7WTptp6kH4UDUQ9xP2M
         E0n3gEHIKwczG2rCace+cenuEKNrhyEsWbsJt33EYpUyJkMfLiB0i9KahM/R7zCleSrT
         O0FQ==
X-Gm-Message-State: ANhLgQ37wLrt4mbijTy0LPfeFZsB6U4RSGbwh+SqrdlLKbShhMgHhMck
        JaFpfESp9MIsp7YzE/0QvWHzVf/3SZ0=
X-Google-Smtp-Source: ADFU+vvrXctaSwNXrtjIZS/3rEInfb66mtIugnEC6+BTOYQsMiH79l0bulJTiJklABS+mW3UqdswmA==
X-Received: by 2002:adf:b19e:: with SMTP id q30mr5566934wra.163.1583949529858;
        Wed, 11 Mar 2020 10:58:49 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:49 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v7 2/6] mtd: spinand: micron: Describe the SPI NAND device MT29F2G01ABAGD
Date:   Wed, 11 Mar 2020 18:57:31 +0100
Message-Id: <20200311175735.2007-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add the SPI NAND device MT29F2G01ABAGD series number, size and voltage
details as a comment.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/nand/spi/micron.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index cc1ee68421c8..4727933c894b 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info micron_spinand_table[] = {
+	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
-- 
2.17.1

