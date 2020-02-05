Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE54BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8428B2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="v8iIuiyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBEBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:07:20 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56569 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBEBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:07:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0D401891AB;
        Wed,  5 Feb 2020 14:07:19 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580864839;
        bh=kqjbAJec6thyniVcHUdJt5Dd6qFficTHzwWZgqeiHEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=v8iIuiyutm8AUdLhjZJxdL/TApgnGihkZPXzd1N3pKq/Nln4ZoWOU/zoprXPZQP3P
         Uc1+n/o+v9pXkHMKby2aw2UlmeSVzcvwsdKaHcAFv6L1yHaefplMSkosmeijKBB+mr
         CtCmWVOYXBFHOFC01ZDGc+M/nwQACc2eHj0AdbHL9BBodbWbK32vj49qCcXgi3ZxxS
         zE03HnFjFUm9gv6x8hBafDLbult0IOi81OewYnGUF3mKuHAtjQvjk/wJ4RBkotMtzo
         3L8LNw29pwB6w6bSBuAfvlfJmp3Wgbi5VQVhIKoErxqaiMezEH1Wk/FDgimv5urrsI
         qwT50yRNOqwxw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3a15470000>; Wed, 05 Feb 2020 14:07:19 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id 504D713EEDE;
        Wed,  5 Feb 2020 14:07:18 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id C17FA4E9850; Wed,  5 Feb 2020 14:07:13 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     guillaume.ligneul@gmail.com
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (lm73) Add support for of_match_table
Date:   Wed,  5 Feb 2020 14:06:57 +1300
Message-Id: <20200205010657.29483-2-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
References: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the of_match_table.
---
 drivers/hwmon/lm73.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 1eeb9d7de2a0..733c48bf6c98 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -262,10 +262,20 @@ static int lm73_detect(struct i2c_client *new_clien=
t,
 	return 0;
 }
=20
+static const struct of_device_id lm73_of_match[] =3D {
+	{
+		.compatible =3D "ti,lm73",
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, lm73_of_match);
+
 static struct i2c_driver lm73_driver =3D {
 	.class		=3D I2C_CLASS_HWMON,
 	.driver =3D {
 		.name	=3D "lm73",
+		.of_match_table =3D lm73_of_match,
 	},
 	.probe		=3D lm73_probe,
 	.id_table	=3D lm73_ids,
--=20
2.25.0

