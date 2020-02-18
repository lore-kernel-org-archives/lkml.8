Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259CBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8076207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aMDXTYA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBRPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:11:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:33759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgBRPLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582038639;
        bh=iIXeJbJphQxq+Yjke2Cq99I3fwTTqpuEc57IwA/qwI4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aMDXTYA4YdG3w+SBl6RquCH6a8ThrGLNwRS7ClKeD7Ogh3PyYTzPSHGoW6jGO11TQ
         oCGAwzSHH837tYbT2dF85e0a2TEr6toDh9X9UwBEOSDqMvhiZa4KJnNWhPHPDwz24q
         yZhINGa7EXErOqD6EZziRsx6AaSTjgaRPcELXEDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1jRkOc2VlR-012IYf; Tue, 18
 Feb 2020 16:10:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Simplify loop in spi_nor_read_id()
Date:   Tue, 18 Feb 2020 16:10:34 +0100
Message-Id: <20200218151034.24744-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zINvuvI/vP4dAMYLrRwlntPkwlGVie3T+Ss13bG2eo3J/0AfEe3
 0YO3URsROtHRc/YuHX6Y2WTsBDm4RPq3IQZuDJ3RtVaPsl1Z5fePm9ut7QzjIpSvm5wQ7ZG
 9YlU74y9lLrAGcyRYmo0iBc3afl7rasXCmDWKBpbH49NDlU5WtMtZndyKnat3oOFqKnen7c
 9vL97bWk4xTwWVqF4BtGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fDc1hno+pvA=:8siC+ZbWuD87CjZH5hvgke
 mIVrlz83x/OyGaEJq8U1ObxXWQiQjh4VboBx7BDh1KybUCIRgoDSMLFo7S8SGpg/Qly//r2Vk
 zvpson8ii9CHJGJFre+vC2saQYko9rD3+0TZK3KpEyXt/nfrB1EdoQpfqo0IItUWNP1NYG2xJ
 luh7OfhKULfrallMVC2IQPZF5fkrnvuYjAex6x9QUQQJwUwvUtJks6eP1ghSAT3yqpRhKjJ33
 cMP1MpB7NuGnfe6JVi9PKFFg5exADAO8zmFhlmhUUbb/jH4gyQeiQuP+QXA1hyJ8gnYDp9/5H
 SoReeMlcB43HDfj9qTq8Ae33s84NASKl12ggPcC1tX8BTSlzICVyf0M2VW8hJ1vRQsYIgPW4Y
 rcQ8AXxhqFhbbceOyqd/lEroTFHyU8Ri+0ny49K3q0AXxILhzurdNm8EESgbkwYppL8X9ur9y
 QX7gUBZ8dhJMfrDHkxHdRUdJMW51RwzhB4pZuUteL9+8LxN1cjLMTmiNRxu9e7I6eWVpw0Si5
 BhHw1/IJ1Jd752o611fcqcI+VcO7YK06hRGchmn2TtGF+U3NXCCJHMOZ/jxL/lV/emA01Kf4T
 gYndDDS3rywdiIIV2DO4Ztcxdp/oJaP7U1tONeBlhZ/EbB9yFasBUaisWD9xxatkZsX3ISMnV
 +BZTVqUT8fNGfj+ARRzGs406RR+1DAltN9EZXmou5biX8MyQkwcLRKT7Y0TXgCmC/MMJjyJoI
 jAVR/Y4hgYpnUmFWcyzr+7So1XPO+FEBTxRjrOBQ56k+Pzi7MW5lqG/gG2svG+U7c3mTqm+Xj
 /nThGmMt76n51KM9IRHcUd2pFo4VAQHutoSQ4c7TyHZia8jwv1HnHERza1C5aRoTxZpl708PI
 G3PjyLnuLuQez24Srn9xzHMtnO9xmJZ3VK2mXe4WwNy7d87YOia/MICOXrViHeZjprVqFGmNV
 RG4smvPWSlU8R2B68XT0/BfOEUcWRleZFS7IC6XGPEKqmoS2jKXhpDwBKqXJSIWfDY2LdE9IB
 9jnszNArWivDaREhQvWugS/cao7oJeHIgDN8SpYtMVI/ugMdQouE/w4u6s03M4Qu2KUb7marV
 KVQM4ykkOVe6IqDbKv86bnclfz1BqP+4MGITRytX/g7/Gu7ri7FbHDzodTHBiMb9jrigW//Wu
 57fGAJsIM0Gu24HGMQ9N+ZCKNZwUjSuCxYZ678PnEQ9PKAH9rdeq6sr40OvmD1flR0NW4fK2C
 GRe3stiC5DoFqmhR7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Don't use `tmp` for two purposes (return value, loop counter)
- Name the loop counter `i`, as is convention
- Return the pointer variable that the if conditions leading up to the
  return statement already operate on, rather than a different
  expression that evaluates to the same pointer

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mtd/spi-nor/spi-nor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4fc632ec18fe..c491572d5267 100644
=2D-- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2711,7 +2711,7 @@ static const struct flash_info spi_nor_ids[] =3D {

 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
-	int			tmp;
+	int			tmp, i;
 	u8			*id =3D nor->bouncebuf;
 	const struct flash_info	*info;

@@ -2732,11 +2732,11 @@ static const struct flash_info *spi_nor_read_id(st=
ruct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}

-	for (tmp =3D 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
-		info =3D &spi_nor_ids[tmp];
+	for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
+		info =3D &spi_nor_ids[i];
 		if (info->id_len) {
 			if (!memcmp(info->id, id, info->id_len))
-				return &spi_nor_ids[tmp];
+				return info;
 		}
 	}
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
=2D-
2.20.1

