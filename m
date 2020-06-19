Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA262C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A1620809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHBdCnX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395299AbgFSQgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbgFSOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:49:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D4C06174E;
        Fri, 19 Jun 2020 07:49:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b5so4577665pgm.8;
        Fri, 19 Jun 2020 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ctscLOlaKZHuHAvTFyT78hwNlRcZSz4aJaHfOiGs+e0=;
        b=ZHBdCnX7+qH7Kxr7PP2Ge6MSsRgRj0s/ihGp4bPB13nAk+lg2mZ9GPpFQHv5SE351v
         bM5jgHNdHfrUEaaLrMrXiCuqIYiwQEqSrs829H2hVv+qrNrXPAIra7ygBRVJb1mhIt/N
         1uXJzpSK2VT48LrvhU5HdW+QJTwStqm3A26IHPJ9X0mwkp68M1TF85ET6Ul4g606Lnjh
         mTZ9oGfAXFD5HTO+GmCIIMB4dHVTl8BFajZxa2Kk9QbceYPQuGQq5O3WZkk06dO0oIwq
         XOemreiCAGbB5Yr07/Q0AtBCWzBJoqZExVDVf0M3Htqv+XndSHiJh7ib/ft/GHuKHdPn
         WQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ctscLOlaKZHuHAvTFyT78hwNlRcZSz4aJaHfOiGs+e0=;
        b=a5kV3SF6z/NLZ/yFn9rR7ZWCQ+oVnslzXVFzuUbOVd+hbF13JCMRp635+bc9563NXe
         Q6Ke8ehFu1h6E6YujUIyBPrQbU7F291cKey79rRcHQ7iywhqgZkIKY/dprGrYYCWAcrZ
         A2Zd5QKtZkqSIJQBvYjuCT5xJaK2e33EoI8sQscJkhhbdBldY9PtFOm/D2/vChHV52G2
         y5Dv7z+G1ppaPgVbWCw2cfb/dCYr7HFJAHCy6PB8emDekkMLBwTTmqXv9leK9Ng1HKyH
         xVxWUYwzGBIIqG2EteLAfMSbccpUrW/GPOBOZOMTlc7FR8r6/Rcf+8lsIgBAgjp8DijZ
         XggQ==
X-Gm-Message-State: AOAM533L7IjnIaUFsnhEKMOzla6tWRZT0cVUjmwcSud0bt7kXo4qcAj1
        hURz/kdc7yXhojE60H20/fY=
X-Google-Smtp-Source: ABdhPJxerp4UqGlBqo7ylxGcCO9oCGFDfiOp3F5MBCTgeGs6IAVexj7p0hvG8EQQNbo8S8SNGMozPQ==
X-Received: by 2002:a63:1406:: with SMTP id u6mr3318908pgl.108.1592578142495;
        Fri, 19 Jun 2020 07:49:02 -0700 (PDT)
Received: from cnn ([2402:3a80:455:d3c:b10e:bd87:9e7c:d04])
        by smtp.gmail.com with ESMTPSA id n19sm5975012pfu.194.2020.06.19.07.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:49:01 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:18:53 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200619144853.GA18271@cnn>
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
Reported-by: kernel test robot <lkp@intel.com>
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

