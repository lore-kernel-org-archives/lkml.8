Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80579C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E03D206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="q4L0P60i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHRBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:35:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48774 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHRBfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:35:54 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BC25F8011F;
        Tue, 18 Aug 2020 13:35:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1597714551;
        bh=+nMOl4l+lQnAE2GXEVZZ2ZEzHC83eJ+/cmtEi5bWFYc=;
        h=From:To:Cc:Subject:Date;
        b=q4L0P60i0YT8xMrlJzHamb7AgP3f2zCOD1mUXEOnqOrF2oQHJIgPrfnDSiuGZc0e4
         JYZH1AIcfnA6VF5Uw1CPzaRpfuBdvd23olqtAVvSHjRHfl9KOXOR0wwSRe+gI5qQrL
         HkLM9/PjLGSHJKBcHZAGLPGsVDZ819sfByCBgvNmBiRaKGdmdn/J5iINoH77un1O9P
         xOaLxX6VzFFbQ4HPvtW559iCwOKNIP52h1k7F9TS5/sdAQ2JvETRhmMHURNkx/eBJ3
         JHZs+4frGLnmytd14or9Ri6K2+/tbGeneo0xDJkzxw5fFcaEYwJi3alK2C7Vr2H/it
         p56oHI2CuqFzw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f3b30740000>; Tue, 18 Aug 2020 13:35:49 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 01E5913EEB7;
        Tue, 18 Aug 2020 13:35:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 04346283AE4; Tue, 18 Aug 2020 13:35:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] rtc: ds1307: Clear OSF flag on DS1388 when setting time
Date:   Tue, 18 Aug 2020 13:35:43 +1200
Message-Id: <20200818013543.4283-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the OSF flag is cleared on the DS1388 when the clock is set.

Fixes: df11b323b16f ("rtc: ds1307: handle oscillator failure flags for ds=
1388 variant")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/rtc/rtc-ds1307.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 54c85cdd019d..c9c3de14bc62 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -352,6 +352,10 @@ static int ds1307_set_time(struct device *dev, struc=
t rtc_time *t)
 		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
 				   DS1340_BIT_OSF, 0);
 		break;
+	case ds_1388:
+		regmap_update_bits(ds1307->regmap, DS1388_REG_FLAG,
+				   DS1388_BIT_OSF, 0);
+		break;
 	case mcp794xx:
 		/*
 		 * these bits were cleared when preparing the date/time
--=20
2.28.0

