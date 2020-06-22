Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96183C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7855C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJEN13ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgFVPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgFVPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:37:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C87C061795;
        Mon, 22 Jun 2020 08:37:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so5451182pgk.2;
        Mon, 22 Jun 2020 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Es07PooiZSXxjxOYZMyYhw0eShmysXjcokuuPID8SBQ=;
        b=VJEN13ezcBfitU/knBaJoVjUSPO7tRSy83x0iwvXUroVjfpM1abAak06Wby0HSJhjW
         3TAfZpgTv5+0lDjXEjJJlg4Ai0WaUmrBG8tLcFguItP0s4OInG1dE5CppJ4yEPr6CFvu
         Le+uPayyeugMSGDo7/YB+3yVZh7NPR07n2yylWV2gnwIR5e77Mk/7B64mp/FAWkbSdI1
         b5g0nUUh1on9k6+eN7HTXF48a/YBefUH8//I9p7iq0oK2Q1njJgntodYvewj7VCSpsT8
         r6UfaGjUzB2Z496qnfeHts1VvCxbPOuCD3RSdxHoMHxZw430Oo/i4if0cUpTTuAqpQon
         LoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Es07PooiZSXxjxOYZMyYhw0eShmysXjcokuuPID8SBQ=;
        b=lnkvdayAj2lo7IR/q5iW0Ci+5keU1XI/ho0qJ36xLVEUJaG3WYmzw3rcEGfYclxCSa
         Wgnwm4n2py/vPTztQyuSI0QWj6MLM7kSkdPHB6wTf/hhlFQzA15FhaqtLr9RoNUEHIG0
         ZPdgFs5DZDIYqVnkAWf8tPEkMtGePGJAjGrNUColIQfZSSHZcGYRFqxBXLnU/H4zP2Ww
         wE9Kp6w636gA6azyxHc1H2D/SzqFwaCwKwRaxk1jmqOIkL8xFRkboI5cOElCP4befHW5
         ey+yz6a0KEjfOAZeVGRfXeAOZuxlNGtzQIQHfy4IoUO4hErWtWmRI5aahB/N23/gqc9S
         B7Zg==
X-Gm-Message-State: AOAM531ueIoO9IDZgKzCtSujNu4GC3HrXeI6Sxz7fy/+T1LiW0ghcXpU
        RKEFKGwYBdB3aUrYm/MxO+4=
X-Google-Smtp-Source: ABdhPJyrpuylIa7V3BVep59iIW7Hr5hWwlEONFn+NSvjqQKwf6Zd3Di3SEEpmzlZnQBAKhFy8LxKJw==
X-Received: by 2002:a62:7841:: with SMTP id t62mr19835568pfc.273.1592840256516;
        Mon, 22 Jun 2020 08:37:36 -0700 (PDT)
Received: from cnn ([2402:3a80:462:12d4:244f:2b0c:295:2c0b])
        by smtp.gmail.com with ESMTPSA id i12sm14333391pfk.180.2020.06.22.08.37.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:37:36 -0700 (PDT)
Date:   Mon, 22 Jun 2020 21:07:27 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>, miltonm@us.ibm.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v6] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200622153727.GA9347@cnn>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
---
v5 -> v6: 
add Reported-by in commit log
align commit and change log as per guidelines.
v4 -> v5: 
align commit and change log. 
v3 -> v4: 
kernel test robot CI warning
v2 -> v3: 
fix invalid signed-off.
removed checkpath warnings.
write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
v1 -> v2: 
add Signed-off-by.
removed ADM1278_TEMP1_EN check.

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

