Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA40C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BDC206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoG4wjiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFTEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 00:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFTEfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:35:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE34C06174E;
        Fri, 19 Jun 2020 21:35:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so4851437plb.11;
        Fri, 19 Jun 2020 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LiVphpOlRXGaGXfaOABG1RGoV3+LFuxLuQ5qOuypjgE=;
        b=VoG4wjiOstuvcoF6JJtdY0dAYQzYUVrczUc+WkA+cB6u+sSZuJdJ7CxFkFGhmM8o+4
         El2ys175Ln0yOVQ02V2l6WUtWsZVmErwrCn47spMqBJxAGAeJ38JNToN9b9ClVheJMfZ
         UxGZry0X0pJWdRhEJBfbkxfYVVNkFSRN3iOE+YIyvRKGnmKpTrLqxJy0wVR6gRtVyQ5Z
         eluoy3dHPnavSxOKdIVzxvfXLakrRxe5wKOv/WWWD/BxpYa59ONurmRvJMbnSO7tXDpn
         VbK/i/BqHflhzl6TkW6NdouQyT133RcZxmjPZwP4unufmzdoo/yLY6VAXaVvOPhNdn5a
         KyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LiVphpOlRXGaGXfaOABG1RGoV3+LFuxLuQ5qOuypjgE=;
        b=D8WMNbRzmIP9KMiSC4WdnNeWQKScJmln5CNmZIPFpeCF/92Qqde+VlsNaeoIdsg/R4
         cZvp5uwFVtvvmXw7eH4fkc/HUHr0TmVOOYa0Hkl8BJhvkAvshUzG8X1Os2xe2pEr9AX5
         Jphp2a2cAncuLp1X+QGw9Qw9EqpggOpGYRWbvPVNFcLLJvi7k/O9zl+bAHFIP2PZhGEd
         WG8sMMVxTKGFTCLtJrZ6EFQg57h6w0b7JZhUZf7jHB5gBWYsN0FRHJP/f5pk+W0FqFw2
         3K1UsecDBPrx1sHv4a8LBW8pG/h+pDaL+5am5bSNyEFCgz1AZC2nlui2yl36Qs/fYKwn
         /VDg==
X-Gm-Message-State: AOAM531MrOGIZloAaTHjKnP/8V5pKqhGk2a1yGH+wWxgqTDkoeGuhNwf
        jbL03faUSvO2mLNBHghlgFBWACDh2U4=
X-Google-Smtp-Source: ABdhPJyki36oOBj8oLOeUx0Qp+o1Ryj3uhYf7b3heG9W1GfWzOfAZ33uFiIY3YHa/r5LIhOa/BVWuw==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr6963952pjo.85.1592627715752;
        Fri, 19 Jun 2020 21:35:15 -0700 (PDT)
Received: from cnn ([112.133.236.114])
        by smtp.gmail.com with ESMTPSA id i5sm6669437pjd.23.2020.06.19.21.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 21:35:15 -0700 (PDT)
Date:   Sat, 20 Jun 2020 10:05:09 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v5] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200620043509.GA27532@cnn>
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

Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
---
---    v5 -align commit and change log. 
---    v4 -Reported-by: kernel test robot <lkp@intel.com>
---    v3 -fix invalid signed-off.
---       -removed checkpath warnings.
---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
---    v2 -add Signed-off-by.
---       -removed ADM1278_TEMP1_EN check.
---
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
+		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
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

