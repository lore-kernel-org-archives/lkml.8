Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACFF20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV025CDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFJI0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgFJI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:26:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367BC03E96B;
        Wed, 10 Jun 2020 01:26:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so797679pfe.4;
        Wed, 10 Jun 2020 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EeIfeMtC6ZVKYeciuWjHUrT7P8TMj/nqx7gXpKs4XCw=;
        b=gV025CDPRGRjF9olznMwB9I8BVSSZyFb6nZT9v8dhM3lR9EOk99EmbUOrOVBIJkU1k
         XJApj6a9uHsHCS8WuNg9nf8+3fRndJp2++HkXAnOMNh7IslSSunzMND27SdnLZ04HADf
         U4J/FgsvkwskI1E/y4QYWhRM1A7EMeBz6tohFNhyjL0ZowQG/Lxyx8A3R3tUueuKdkEe
         tFC/RQt/vozPGE7s8VeSllKn/BHZXvB9lxuRwD+gSlYOlaONDWioa0AiGRoHBHMMKiyj
         tlLhrr8U3RGcpAaO5qwhlP8RPhiDoLAGib6NyhKfj3Xu7X8LD1UBYgGJO1yWo2wlRB5P
         kDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EeIfeMtC6ZVKYeciuWjHUrT7P8TMj/nqx7gXpKs4XCw=;
        b=YEPIaji7G0ouNDQ6tewjykMgDYycVJOVZ6OLzTqGZjbTOpDhiYON+atmulgF4Ono/d
         /6AkRMQiDKfZp3zz5/ImZgc8T7FxNP5ajLXosBLxK6OG+Apxkl1Bo07QHSNr/Bi+H6Gc
         AUe9zVA1vE0whIWvCxT9nGuEjAHdy4tPWW+baNeFWbR8muJXPrfHqMjU75zYX2MCxhoh
         ARVo2KTCBVM7ilmrSCIn/b0XoBivIVhCj+aoRXHogoT2Bx08WN4ybhd67nMiLR+SWTO7
         lJ6z41v/NnKF5Oiu3kEnhZ+vaXhA0lptKiwF2G6uwbzw7g58b3534ifqaD5Wg2KX14DS
         HvVw==
X-Gm-Message-State: AOAM5314v8iwkppSOeoFhsvKY9aVIJDm38Ay5lgo90Np6apVOoTvsAMD
        FemHbtG2gXdpLnd4oKueldI=
X-Google-Smtp-Source: ABdhPJzl+voonL1FEiRC2ZFApPnKYyVNuEkBlIo+oyZjozrtQXiPPJ2+TVtcMhKqtohIEOSPcJMKpA==
X-Received: by 2002:a63:ce14:: with SMTP id y20mr1710922pgf.186.1591777579132;
        Wed, 10 Jun 2020 01:26:19 -0700 (PDT)
Received: from cnn ([2402:3a80:407:e743:cd72:839f:5826:c552])
        by smtp.gmail.com with ESMTPSA id c9sm12172754pfp.100.2020.06.10.01.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 01:26:18 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:56:11 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200610082611.GA14266@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adm1278 temp attribute need it for openbmc platform .
This feature not enabled by default, so PMON_CONFIG needs to enable it.

v4:
---
changes in conditional check to enable vout & temp1 by default.
v3:
----
fix invalid signed-off.
removed checkpath warnings.
write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
v2:
----
add Signed-off-by.
removed ADM1278_TEMP1_EN check.

Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
---
 drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fb..d4e1925 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
 		tindex = 3;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
-			config |= ADM1278_VOUT_EN;
+		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
+		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
+			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
 			ret = i2c_smbus_write_byte_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
@@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
 			}
 		}
 
-		if (config & ADM1278_TEMP1_EN)
-			info->func[0] |=
-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
-- 
2.7.4

