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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23497C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ADF20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOWhq/zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405952AbgFSQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393343AbgFSQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:52:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D7CC06174E;
        Fri, 19 Jun 2020 09:52:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so4664905pfd.6;
        Fri, 19 Jun 2020 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MojqGVMm/N36ukD1qQOzNiKEH9Yim97rUfkXtpM0HIo=;
        b=lOWhq/zJNBjesFgxGkSn+BtJRwxdpQomhyNHZjlONsvkEN01tr66aBIeORJjSlwrzc
         FU5LcMVd9PShZF8KF7qWB2r9nJTDNzbUQFTIbtZEygCCvfx2SoWdYi3G4ThYpquzn7du
         VjTaDYtDXrCRuMgvTdYBl0LSsSxePM1iVhw0O+4kHjzM9oruFsWA+9t6pDoSSEeytMUq
         ztebVmkrP6goQODaIFcGYuFPm9xXGNRapQ4dceWSPlj7VfBr3vZitoPI5lAVO03aVVvO
         7w9bYuIMXzVmT0/+BmyJmMycx1Ctm9cPdZiWG8cDdpIyaj+6wWD9lfbEGHobj4s5ya5g
         pTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MojqGVMm/N36ukD1qQOzNiKEH9Yim97rUfkXtpM0HIo=;
        b=I5y4PQgEslVtNK+tqqx6lsmdWsJBAfI7qA0B/xyekGA25h54hWNTBYr0za34Z83UVB
         uHTQ9Lvdc6Q60pP1byG7WcoJ7R9PR4ogPGlkD+Xrf79yJIXDdbG7AglejkGJIH7+Kh1V
         oio2GCkhxx+vcCMy+CWSisYjkVPATt3CTRmIgU/cBIhm+4MsMWLks0hZiN6FrvlyYP6s
         KpNVsqWGKAl0Bph3V8KpSUkfeW6JG4zQst6cC5Swkpb3R/7wBU57XoC8fN6ug4xJdhP/
         +pEJUNoATrX8+q+dDJ8J7XXGFWf8V1q+QFP9+3j39wis+ZbugW5Pq8cE7VQThRaa3pY3
         vnVA==
X-Gm-Message-State: AOAM530mZG5qYzzDwTouwFF1zvtIawDutB8ZV3zTOlScdZA/xSltP67m
        i0WQ5UI46tlEM6R5iDrMTJnwKV2/psc=
X-Google-Smtp-Source: ABdhPJxQLpIde5crNDljO1wbiI8PDd931pTpWT7w4Fpd3YuE5eJBQnt/XfFKVMlmlaSaxcOe7PD3Rg==
X-Received: by 2002:a62:8095:: with SMTP id j143mr8678422pfd.62.1592585522685;
        Fri, 19 Jun 2020 09:52:02 -0700 (PDT)
Received: from cnn ([112.133.236.100])
        by smtp.gmail.com with ESMTPSA id w18sm5580656pgj.31.2020.06.19.09.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:52:02 -0700 (PDT)
Date:   Fri, 19 Jun 2020 22:21:54 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200619165154.GA20461@cnn>
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

