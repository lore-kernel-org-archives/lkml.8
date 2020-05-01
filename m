Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEEAC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BDB20787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="z4T0Zz1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgEASA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:00:56 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:11485 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgEASAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:00:55 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 2FB59203B2;
        Fri,  1 May 2020 20:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1588356053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuIPWKHuf1mWWetzWvXNH4rEJK532/abC6YDrHnRli4=;
        b=z4T0Zz1SrWOItrjcZrEGxVJ6Mx3vjPAPeK3vRAZHHfO5yIsU4RKmvJHkt5o/cwLL4ZMqgu
        fnsH86UbYGVpTAnhlyhUwLH49LVTjLItzwLmN6l5Q0wP+rUFF0HUZTBh1CWpe9/68ITlN8
        WfupTHpyPOQR6AxMfvzqf8sVEK/kN4JQqmA+XuDnoL9qK/kKeN5H9h6cSI0NJmMJyol+UH
        eklDtlOCCu/l25jaUNOwHoJJ6Adajt6fZx8b6IQh2uQCqSk7207StMcq70U3655ORDpUVd
        lVmfS4Uu3OWkI2n0b3Uw9hhGF8R8X96Wj57QsyaUqGLg14m+Z9DjZbKUucCCKg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Fri, 1 May 2020
 20:00:52 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Fri, 1 May 2020 20:00:52 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: [PATCH] net: dsa: sja1105: fix speed setting for 10 MBPS
Thread-Topic: [PATCH] net: dsa: sja1105: fix speed setting for 10 MBPS
Thread-Index: AQHWH8IGUD+3Kyn8J0mCBAQgeQXDbqiTgu1i
Date:   Fri, 1 May 2020 18:00:52 +0000
Message-ID: <9018be0b7dc441cd8aad625c6cc44e1c@bfs.de>
References: <20200501134310.289561-1-colin.king@canonical.com>
In-Reply-To: <20200501134310.289561-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [-1.37 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-2.87)[99.42%];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         NEURAL_HAM(-0.00)[-0.901];
         FREEMAIL_TO(0.00)[canonical.com,gmail.com,lunn.ch,davemloft.net,armlinux.org.uk,vger.kernel.org];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO it would be better to use switch case here to improve readability.

switch (bmcr & mask) {

case  BMCR_SPEED1000:
                                 speed =3D SPEED_1000;
                                 break;
case  BMCR_SPEED100:
                                 speed =3D SPEED_100;
                                 break;
case  BMCR_SPEED10:
                                 speed =3D SPEED_10;
                                 break;
default:
                                speed =3D SPEED_UNKNOWN
}

jm2c,
 wh

btw: an_enabled ? why not !enabled, mich more easy to read


________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Colin King <colin.king@canonical.com>
Gesendet: Freitag, 1. Mai 2020 15:43:10
An: Vladimir Oltean; Andrew Lunn; Vivien Didelot; Florian Fainelli; David S=
 . Miller; Russell King; linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org; netdev@vger.kernel.org
Betreff: [PATCH] net: dsa: sja1105: fix speed setting for 10 MBPS

From: Colin Ian King <colin.king@canonical.com>

The current logic for speed checking will never set the speed to 10 MBPS
because bmcr & BMCR_SPEED10 is always 0 since BMCR_SPEED10 is 0. Also
the erroneous setting where BMCR_SPEED1000 and BMCR_SPEED100 are both
set causes the speed to be 1000 MBS.  Fix this by masking bps and checking
for just the expected settings of BMCR_SPEED1000, BMCR_SPEED100 and
BMCR_SPEED10 and defaulting to the unknown speed otherwise.

Addresses-Coverity: ("Logically dead code")
Fixes: ffe10e679cec ("net: dsa: sja1105: Add support for the SGMII port")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja11=
05/sja1105_main.c
index 472f4eb20c49..59a9038cdc4e 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1600,6 +1600,7 @@ static const char * const sja1105_reset_reasons[] =3D=
 {
 int sja1105_static_config_reload(struct sja1105_private *priv,
                                 enum sja1105_reset_reason reason)
 {
+       const int mask =3D (BMCR_SPEED1000 | BMCR_SPEED100 | BMCR_SPEED10);
        struct ptp_system_timestamp ptp_sts_before;
        struct ptp_system_timestamp ptp_sts_after;
        struct sja1105_mac_config_entry *mac;
@@ -1684,14 +1685,16 @@ int sja1105_static_config_reload(struct sja1105_pri=
vate *priv,
                sja1105_sgmii_pcs_config(priv, an_enabled, false);

                if (!an_enabled) {
-                       int speed =3D SPEED_UNKNOWN;
+                       int speed;

-                       if (bmcr & BMCR_SPEED1000)
+                       if ((bmcr & mask) =3D=3D BMCR_SPEED1000)
                                speed =3D SPEED_1000;
-                       else if (bmcr & BMCR_SPEED100)
+                       else if ((bmcr & mask) =3D=3D BMCR_SPEED100)
                                speed =3D SPEED_100;
-                       else if (bmcr & BMCR_SPEED10)
+                       else if ((bmcr & mask) =3D=3D BMCR_SPEED10)
                                speed =3D SPEED_10;
+                       else
+                               speed =3D SPEED_UNKNOWN;

                        sja1105_sgmii_pcs_force_speed(priv, speed);
                }
--
2.25.1

