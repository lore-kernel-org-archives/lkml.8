Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E5C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAA620836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lPOrAfHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBWRhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:37:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:57409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgBWRhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582479439;
        bh=if6WbC/yoW5hMRNOq9FgOOoRavmhfqy0phCb2wgo+hI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lPOrAfHfNw2oIMGaCptqEEwINZ+KsDREJgameG6RNZllmX1o+f09goylmTGa7r1Em
         w11ezAF0cmQhJu4yjpgWElv4TwzsUDHEg8F4xXoBYVM541dC4fET14s6/RmWV5PGPd
         7GLBsZ21sJ4PI4tOTQl56Ve9B9EGR7v//fHdM4qo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.253]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1iofQF3bW5-00HwyG; Sun, 23
 Feb 2020 18:37:18 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: Refactor spi_nor_read_id()
Date:   Sun, 23 Feb 2020 18:37:13 +0100
Message-Id: <20200223173713.2981-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pOOYy+2VyeB4DO6YBx0MwWV3mayZ/r15ZXaJYewCpadoPcSimqX
 qG+PAzlscD6iEsctfpG9pQWBA93s6MqaLDhU3v8ZFm0tEkncBla8EDSe8dvQubofnkS8c8E
 5XWJIfiTCnTf3dmE619N6GDKyEs+ezdYXASrLDJ9mE0msx107zYqicz5t1JoJdrP0Ku/Ikb
 oI5ZbDQF7A8z9QGV2dRFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IaRFzAZsYdM=:bkIM9+TXMp62Zh5phSY6bU
 zB65nk1WA7xu5eRiuYVNKTh9R8CzmKlsmvkl2lqyBQyXAD8UFB9W/hG1kZIbsysJmKWNpvP8E
 bjh7uSq+Q8kB0D2PSd29A+8+hNEaIjjADK1/aoFGlY3VBoeT5+6ASUh7SOSWO9fu7TCpRwqYD
 uwfxwMv76akJjUSN5LoPi1WjirkwiYU0AnIflhhCauMZrEBG8MqM3hgYKyKdjS3H8pHvtwa/I
 5p/95ZO32QNiJzGhs3TybBD9Ue3SR1GMt//30LRov5GVLumzGBvO0wB50nsLRxuBJBg1PaKyn
 Fa1gjyIR/PKMJFpadKnxu50ymFXk9FiqxcUvAUv5Rznaekf6HMsuQADtPgl9XpNEUzJj9HFVn
 vh3DDqK2YusKUMnoUKdUu92UK9KpKPzZMNrJQ98imvlF/QMUXkL6CAdAb3hIlAsqD6XuE4dRA
 rpiurGmN/6vB1fmJFem0Cp06WAmT9APLeJ+cmc5UrJz9vrOvUSkEtwkWOqDHT7FUvz73m0k9T
 kYV8Yh/jHgGW71sFcvJDXwC7O1vCwTolwwJ/sOdhszCtBM85nwEIsQiGfD2j6SZ4ehr5XJJte
 2ZtLMiTsJHf9w4ettD5ocwf5iMKrW5AZHzlPxeQUG2FpoVgyk6JfkihRoJ96vgK9Zwcr54UWT
 5XYhapIrDNB/QhKtzp/S2KscijobIa6da6Myb3lT9MceJ3/tpKr2S55AlBoQ2oBHdpqM6IS+Z
 YFBgFBpo4jN8pZKLxpqRvE06rsHYAYE2YKRj0tM2ZNLXkIrIbRZgc8sZetjI/qgT868KkBPrW
 xlUbCjVownESLd6jUXvOO5LDPbyww+WXUNPfjHYf2OAXpVxUoXxl+B4oyNkLj+wBMv9gmlD10
 rKgiJzNMv1uIKysv6vlKyLSJJe6lotINmrdt0z46+E+gOwyp1HIxBjwIZ4u71cs9ZBXCx50Mn
 X9fWDdIKClgYlEJiRPkwLo8vN79pj47jwB9kpeiZF93frlvBnf4PC+UdS+rm4D6xj2oc1Oig2
 9GxN6FjS+6hoRUh+m1zGW2rt1TEAc3CjZZU8hszJY1t7ujrr3SUkt1LmtS0ljz4wP5/rq4f8d
 BwCBNCrdpTGgHv0Kq5obsFFpdXvEesw1fuUD6DvHYcwWbhxZeyOOLWyoXIg+pZdKhv0SGSaJt
 RhD5ZcyBubZn+2X/HgA4wqIKeVKsNdF4f2mKRUZ7+GmFuhl27/DWt7N+9EDlNEYMXc1llp+Rs
 KT8ljn5ky0s6pOIMS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Don't use `tmp` for two purposes (return value, loop counter).
  Instead, use `i` for the loop counter, and `ret` for the return value.
- Don't use tabs between type and name in variable declarations,
  for consistency with other functions in spi-nor.c.
- Rewrite nested `if`s as `if (a && b)`.
- Remove `info` variable, and use spi_nor_ids[i] directly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- As suggested by Tudor Ambarus:
  - rename tmp to ret
  - remove tabs between variable type and name
  - remove `info` variable

v1:
- https://lore.kernel.org/lkml/20200218151034.24744-1-j.neuschaefer@gmx.ne=
t/
=2D--
 drivers/mtd/spi-nor/spi-nor.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4fc632ec18fe..4c01ebb38da8 100644
=2D-- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2711,9 +2711,8 @@ static const struct flash_info spi_nor_ids[] =3D {

 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
-	int			tmp;
-	u8			*id =3D nor->bouncebuf;
-	const struct flash_info	*info;
+	int ret, i;
+	u8 *id =3D nor->bouncebuf;

 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -2722,22 +2721,20 @@ static const struct flash_info *spi_nor_read_id(st=
ruct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));

-		tmp =3D spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		tmp =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
 						    SPI_NOR_MAX_ID_LEN);
 	}
-	if (tmp) {
-		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
-		return ERR_PTR(tmp);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
+		return ERR_PTR(ret);
 	}

-	for (tmp =3D 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
-		info =3D &spi_nor_ids[tmp];
-		if (info->id_len) {
-			if (!memcmp(info->id, id, info->id_len))
-				return &spi_nor_ids[tmp];
-		}
+	for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
+		if (spi_nor_ids[i].id_len &&
+		    !memcmp(spi_nor_ids[i].id, id, spi_nor_ids[i].id_len))
+			return &spi_nor_ids[i];
 	}
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 		SPI_NOR_MAX_ID_LEN, id);
=2D-
2.20.1

