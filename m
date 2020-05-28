Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF25205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCWVEKUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgE1OPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390900AbgE1OPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:15:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B8C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:15:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 131so5213756pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XGHYTbTFj/idv0dnWf7QG+Cg8moRXHsLIYq+mHlWJb8=;
        b=qCWVEKUVVPY6pQHiNV4vRZJ6TSUEiBOow8qeJL4gok+AOw5vxOBAkyIT3LOwhMYykb
         Fm4qewkHOpojjxq2i7QNqJ3WgmbZb2U5MAMngxeXRFFqpOfg0IrDne+kuiAYM82x3wVb
         2RHSff9MyvXGBhsSyTO9/S190iakall9JQiGcw4qy8fknGUPJ9DvwHhW8f11UrGds2Vu
         i5X88+TSK0fE+1SBMNEwJUpu6E15v3GFhu/m8zsOxuUsb/duRV7DB1JNNAzDaba2bgdO
         78oXeJi8wPJF0+qB4qY+Yyn6BxZu8vIKyLhYOyQZuINlpZIJcmwtM8pMldYNUS/oCfpg
         l3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XGHYTbTFj/idv0dnWf7QG+Cg8moRXHsLIYq+mHlWJb8=;
        b=pX+WzloymsTx5+wGMMiboblndlzfabdBFBuo2ahb9A9ETxYWntTvEl0ORwCJfdkE5r
         gJGawGtKAOcn9mJtNrdGq36LyQUDiHa6FMtGRTi0IXpFztsAzKY8ReQKW71XSf608cB2
         NfnwtHjSvCAr/cyU/FRlQKLder1bCCrysCFSVN3sDK8TAKmtkdyaeekC2j9rb5gANRKn
         +/5PxFZlofbeMEPB0gQRNtusI1FXLh2fWWUgPxKzD1te6hKtaomzyqNg6gjWfY3zbAqQ
         R0S20Fbv7PNfFPprD08Ayd4MsnHAazUPy9XkuJ6FT9RBaLK9tD6lz5PSJLFSfDohXzbJ
         5Adg==
X-Gm-Message-State: AOAM5306gel57pJHxguVbpqFfZ3ZlIi5mt2CzIcPotJzlvWlCKRJjTtg
        0T2pP0x7OB7gwZ9dS8KQXjA=
X-Google-Smtp-Source: ABdhPJyau0j9Gb7aMiVeAX7Qn4Fk0I16yYO/uepxNvkUntW/6CaN1T0YBq4Feb5ZsJNRhu539fsgSw==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr3211576pfc.116.1590675335154;
        Thu, 28 May 2020 07:15:35 -0700 (PDT)
Received: from cnn ([2401:4900:2340:a919:a888:ed6a:9872:b822])
        by smtp.gmail.com with ESMTPSA id j26sm4958399pfr.215.2020.05.28.07.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 07:15:34 -0700 (PDT)
Date:   Thu, 28 May 2020 19:45:23 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     sdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        manikandan.e@hcl.com
Subject: [PATCH] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200528141523.GA8810@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The adm1278 temperature sysfs attribute need it for one of the our openbmc platform . 
This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.

---
 drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fb..47b293d 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -681,6 +681,21 @@ static int adm1275_probe(struct i2c_client *client,
 			}
 		}
 
+		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+		if (config < 0)
+			return config;
+
+		/* Enable TEMP1 by defult */
+		config |= ADM1278_TEMP1_EN;
+		ret = i2c_smbus_write_byte_data(client,
+					ADM1275_PMON_CONFIG,
+					config);
+		if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to enable temperature config\n");
+		return -ENODEV;
+		}
+
 		if (config & ADM1278_TEMP1_EN)
 			info->func[0] |=
 				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-- 
2.7.4

