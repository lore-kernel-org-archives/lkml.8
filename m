Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A9EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEDA20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx4Nav7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgFHKoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbgFHKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:44:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC045C08C5C3;
        Mon,  8 Jun 2020 03:44:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so8386096pfb.0;
        Mon, 08 Jun 2020 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qPnSozpEwUzkMm6eKHETr428FnuusYj7UAKssD/B8Gw=;
        b=Nx4Nav7dq7hqOTiO9EpgScp0uHZaMAEuO5ijNJXIiflFvXwujN6NzjfkgdrdObQXw7
         gtsUpoeP9gygnvCak/QpaFDOhAGY+6NMgrD2kko61NQGB+qM++yaROkDh316gvX5WJdD
         kVRcMIFl/HKLLX6DoSoFm3Obxjms1l649M3TvgERYYWDMSfhmM2lKBUX445KYxvraXay
         7/PcCFNkkUbHu37dfYBJcHam4Rh94zVC6XaDru1QTU+0+BKwmIv/KWK80cUDW8LZqAxx
         nk9gHUWLlS8tT+YCPxW4lCvbiX/SOYfP2F4rEG9L6hwwJGrJU0PmeqUHz3tLpV5CCA8q
         Gc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qPnSozpEwUzkMm6eKHETr428FnuusYj7UAKssD/B8Gw=;
        b=tYrNTti5ZN1phKcAJRzM4JoBpqF6Ov1C/aBMZfhFIGD8U9iiodz3qh2xFEDHO43Ewr
         uYVTpDjG4qzwLnVuSFKUVrWJOi/+5aYKfnxojDAvUt7udZZvTUKnybcble7304Q49cSF
         hZCRRIG6oUIvrXinPL0dhJ31QZZoHGgjVxi9o7cXs0E7WyzkGc2NGlGTSIXAELs6oFDc
         sNsnfujtkRD4jsM4I3ClSAspLYENuiazCJ0xjxJcZGuO32jjsAXeM2thyIsbFPCDnafj
         dLmr5qRhxMkDXIOXnKs6zmug8T0cqO6+njSthz3q+0Zncct5H4kOc8NqAUyKpFltJtUh
         ibMw==
X-Gm-Message-State: AOAM5316Am8fdVnkZtQDbppvL8yXZkmgWHO5C8Z8Ah+i16hG9vhy3Vgg
        3y8u+7Vo3SN3ABtUy2CdVDk=
X-Google-Smtp-Source: ABdhPJxgls+P5umjn5ZAfKcl9HEToSKCZ+YAzvgO/qv6hSZewDYAKVnQCujNvqqB9DaDgbuDvUQ/+g==
X-Received: by 2002:a63:63c4:: with SMTP id x187mr20800156pgb.112.1591613044363;
        Mon, 08 Jun 2020 03:44:04 -0700 (PDT)
Received: from cnn ([2401:4900:2349:e80d:cd72:839f:5826:c552])
        by smtp.gmail.com with ESMTPSA id dw17sm14808774pjb.40.2020.06.08.03.44.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:44:03 -0700 (PDT)
Date:   Mon, 8 Jun 2020 16:13:49 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, manikandan.e@hcl.com
Subject: [PATCH v3] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200608104349.GA10918@cnn>
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
 drivers/hwmon/pmbus/adm1275.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fb..4782e31 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
 		tindex = 3;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-		/* Enable VOUT if not enabled (it is disabled by default) */
+		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
 		if (!(config & ADM1278_VOUT_EN)) {
-			config |= ADM1278_VOUT_EN;
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

