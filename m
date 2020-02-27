Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FD9C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB732468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="hZTek6b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgB0LP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:15:59 -0500
Received: from mx01-muc.bfs.de ([193.174.230.67]:37607 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgB0LP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:15:59 -0500
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id E1BCE20342;
        Thu, 27 Feb 2020 12:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1582802155; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSPfkAcD4QDEe9iSfKSFzw4oTZNpL0r5C0vE0nEBfi8=;
        b=hZTek6b2Y4HMl5mxHAmJ4zxsXbSz4FzU8KeGrX18+sHYSvU2k5tt2oM0qYHB6psoEXGHFq
        Uho6MeghLCDarNitxYByWjE2JP2spLWNKY0P6iWggFJHne8qpiCnbqoZuxx8sJvyUTRsUV
        p0Syd7KVDaU3JtvOgkHmu1xUd8mrvTt6c67MW7fXuwtKRtXS/Ssk2ZVbY9BhmrnvcQAvFh
        LYSSifQCD2THJP5f4u+Rn2Vwo5g4uv9EkTRAKlNWpFuwzWwCxc1sjscHUiwQ9Hixv0Ab5t
        wic11wWremaDuctMTYuKnhuouxIcK/5FO69d6XQ18rHZbFwDbQFxjUqwJiodow==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Thu, 27 Feb
 2020 12:15:55 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Thu, 27 Feb 2020 12:15:55 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Bryan Wu <cooloney@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH][V2] backlight: sky81452: insure while loop does not allow
 negative array indexing
Thread-Topic: [PATCH][V2] backlight: sky81452: insure while loop does not
 allow negative array indexing
Thread-Index: AQHV7N8n5fHjoG7xokCkDx0n/hJSlagu4ztb
Date:   Thu, 27 Feb 2020 11:15:55 +0000
Message-ID: <cb14e57edc1c4f3a81b0aef6f1099b9c@bfs.de>
References: <20200226195826.6567-1-colin.king@canonical.com>
In-Reply-To: <20200226195826.6567-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-muc.bfs.de
X-Spamd-Result: default: False [-2.99 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         NEURAL_HAM(-0.00)[-0.990,0];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-2.99)[99.98%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
i would suggest converting this in to a more common for() loop.
Programmers are bad in counting backwards. that kind of bug is=20
common.

re,
 wh
________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Colin King <colin.king@canonical.com>
Gesendet: Mittwoch, 26. Februar 2020 20:58
An: Lee Jones; Daniel Thompson; Jingoo Han; Bartlomiej Zolnierkiewicz; Gyun=
goh Yoo; Bryan Wu; dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel=
.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: [PATCH][V2] backlight: sky81452: insure while loop does not allow =
negative array indexing

From: Colin Ian King <colin.king@canonical.com>

In the unlikely event that num_entry is zero, the while loop
pre-decrements num_entry to cause negative array indexing into the
array sources. Fix this by iterating only if num_entry >=3D 0.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight dr=
iver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: fix typo in commit subject line

---
 drivers/video/backlight/sky81452-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/b=
acklight/sky81452-backlight.c
index 2355f00f5773..f456930ce78e 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -200,7 +200,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_pa=
rse_dt(
                }

                pdata->enable =3D 0;
-               while (--num_entry)
+               while (--num_entry >=3D 0)
                        pdata->enable |=3D (1 << sources[num_entry]);
=20
              int i;
                for(i=3D0;i<num_entry;i++)
                         pdata->enable |=3D (1 << sources[i]);

        }

--
2.25.0

