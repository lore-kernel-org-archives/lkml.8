Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20A320774
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2eTvr2el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHXC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:57:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56226 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:57:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1903B891AF;
        Mon, 24 Aug 2020 14:57:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1598237870;
        bh=o4lNcSIrdI/eNUWihGfzjOy8zXW6NxDz/kki0266Xb8=;
        h=From:To:Cc:Subject:Date;
        b=2eTvr2el0/SDY1f2lyA/zMSW5cnGuDa+Q93ZQTu1MufoMVf7qJCsJNScgcg4B3T1v
         ca20fPMSUoOnt6Q7/s7zuzuu7xY1zdSsymbmW+Z6ZEZ3daoxtZHahaNbKa0P30tHnb
         2tHKydqD4knI+ngki+Jh2SkwFBDM5tPJ1tNH853o+NrnBdQmA89qR4mFbhNfLvmZTv
         OiwiaRLytYVCqmh7j7oyb+EisX3SQxZ45wLEtpC2brwHQcADJvO6cjFn6lPl5OmxGb
         /5lCFqExOomFTcR58iKHL2c1RaOU2/OAL1qg0kqXharwpisQx8Tb5YHwLofg3qGL9+
         O2W7o+XJXvTzA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f432cae0000>; Mon, 24 Aug 2020 14:57:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 125C013EEB7;
        Mon, 24 Aug 2020 14:57:48 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 29427280032; Mon, 24 Aug 2020 14:57:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: maps: physmap: Retain mtd-name property from dts
Date:   Mon, 24 Aug 2020 14:57:44 +1200
Message-Id: <20200824025744.25992-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In physmap_flash_of_init() the maps[].name can be populated based on the
optional 'linux,mtd-name' property in the dts. Make sure this is
retained when filling in the rest of the map[] data.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/maps/physmap-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-c=
ore.c
index 8f7f966fa9a7..6372197ad865 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -515,7 +515,8 @@ static int physmap_flash_probe(struct platform_device=
 *dev)
 		dev_notice(&dev->dev, "physmap platform flash device: %pR\n",
 			   res);
=20
-		info->maps[i].name =3D dev_name(&dev->dev);
+		if (!info->maps[i].name)
+			info->maps[i].name =3D dev_name(&dev->dev);
=20
 		if (!info->maps[i].phys)
 			info->maps[i].phys =3D res->start;
--=20
2.28.0

