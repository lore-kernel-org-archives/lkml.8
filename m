Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514E246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3NmP5M5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgB1PD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:03:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgB1PDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id j16so3322198wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wl7h7MB0G2BXUvEqAv+8JB5mpSUGz57zUw9UrFnUC+Q=;
        b=V3NmP5M5P9C/66enV9ymsDk+U3eRCm1zeBei3iBHIqjoE5fd/qG3eawlCcGedG9R4b
         lW+VH9Po7cTUcIFIkcOO21kZ5yFErgCVNm9NaTTG43GZoKf+u/H/kL4cHw+l3N7VwWEz
         n0vIrah+ome/0osmTwO3OHOvwRyo00ll6yIFz2+N3mNFacEOniZc8PrsjJC5LSwlELRE
         b6JeHX3nhqK+4tYq/k/a6Y0jxwcU7QaxDDfbO+IA76pu60pxAoxMGP5LvbOpabf1dDkl
         vVaaMFF1PHRoQmIh3Ow1VFZhzm5emgrCz8A8fFJtlprr772LnA2J5X46Zv/uT8IOsNZ8
         GZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wl7h7MB0G2BXUvEqAv+8JB5mpSUGz57zUw9UrFnUC+Q=;
        b=IaXUdzlGk+ofl4UoB3AACodyGaZuYTnBi7DKATrbDNe+bE18S9bg84ZDojk8e1Jg7g
         mudTZILW4B+o4sYDrZ2ugNSjzh/O0jBJWb57IIwknjwU66D+zAR4+SYwdWH3YXghpbtD
         lp1u4SGvk5p2APkpzLDUh4yCRK6kDd5fuKbGuuNWXVw1RtLhnbU/P/+0v9lkoTLDs3qQ
         slsHEY2klDrkIp/pKXwFHHkc6k2N5wabG6Dx4Algf2Y7XNm+PbOHe5OYNkqqEGYb+Ulu
         /SvyhXNmgX6RWw8ubA89XD0Rg780qAcq+mGHt0Gsu+gBDLlqksJ6lOB2Rau68tmbl7Dj
         LuGQ==
X-Gm-Message-State: APjAAAWRsGqvMdCiZo+EQ1lw5X+cVK3uMPXb+pLCIIjSTaMx5P6pxbJB
        eeuM52Egd1raHAl6sBRHZF8=
X-Google-Smtp-Source: APXvYqzBGPyi5NLZUT3/XVLOunkD9kHjoYlKLBvGxXzzMCe4VfRGmrQFNofZSCStnM+B1q8W19qB0g==
X-Received: by 2002:adf:fac9:: with SMTP id a9mr4994128wrs.232.1582902204040;
        Fri, 28 Feb 2020 07:03:24 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:23 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 2/6] mtd: spinand: micron: Describe the SPI NAND device MT29F2G01ABAGD
Date:   Fri, 28 Feb 2020 16:03:07 +0100
Message-Id: <20200228150311.12184-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
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

