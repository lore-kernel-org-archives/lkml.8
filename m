Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3FF206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="aeCiUAvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFLKvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgFLKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:51:18 -0400
Received: from mail-lj1-x263.google.com (mail-lj1-x263.google.com [IPv6:2a00:1450:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:51:16 -0700 (PDT)
Received: by mail-lj1-x263.google.com with SMTP id i27so10504952ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9xShxsKUNMqmSQXfpVKNhUGE/vHSJ0ICHSUk07MYv6w=;
        b=aeCiUAvtqmXONLtEJ5VYCH7MXgY/YxyjgLOuKB33gyiMADtTQu/oK7Nc+p4HEXqIjG
         2TRkb2/CjOcWzYdcEls6BpZK1BPC360LJ5+cjzM8m9Co4/GIstshE/Q5FuiZEblDn+kc
         Xfp6RzerJEs2u5zGVQ9s6gGho/U384xfya+2Cj+DD3AzbHqtNQm6coMGvyE7pdC5iTvQ
         QBjt24xopICBs+O6KINq59IRrk+R4efAYeU5KA/XxeqrX0Hax5ZmQQh7APd1DsxcRWfm
         AuWX8dTnWc01K7V6gJNMrVD/GMNS9WXuIWQEDyFZmnzdfl2J8/Q5pQR/vQ2UnaIp+w6Y
         dKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9xShxsKUNMqmSQXfpVKNhUGE/vHSJ0ICHSUk07MYv6w=;
        b=VCB8bPK/DPucjjjEQ5cwgFuUawHz9q2xrpUAnDLL/3R19DI4H8461HT1zfKVEU1t3p
         iozh6gkaHSDkXJcXWgHpebZ5gch8bU5z9C6APRPd3uDUaErhPpqzKnLmtJ3/Qo7wHr4J
         z6qrqqH0y8Fz+HSLyaEWsoLIF/KTuSnq7YVb22d3ButAPVbJS/A8XoO9E4dm6PlM4HAG
         +7SpA+YR9VNLFMxwDI3uMQAMDimF5hqbCmIQTINF/qMwlhYPJFkiFdkFK3QZsWAEg2NW
         NTdGwBRNhsGXwX/Q6ZWAWVQuTxmVmLenq5nTdti7xRGkuNzgvmEWwHj+m0O9tvDkWqJT
         qsAQ==
X-Gm-Message-State: AOAM532Kcd1hvWA+T+5JWhNTT10a2TZF31V7xYSC7pF2vTJLjTjaJ9fb
        4UD+PGGsL/HBsD32HTXY5xExf2HEG2OXReJVwoeU7sEdso+A
X-Google-Smtp-Source: ABdhPJx9t7+m3qnOb2JwYk2bQndYk6kK7fnAklWFqm1Rn+c1vM/aclElSqQK59ZAsoGu97DkcVlJlZiENgja
X-Received: by 2002:a2e:9246:: with SMTP id v6mr6770232ljg.47.1591959074239;
        Fri, 12 Jun 2020 03:51:14 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id h19sm21014lfl.40.2020.06.12.03.51.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Jun 2020 03:51:14 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.38] (port=52492 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jjhHF-0002Me-FJ; Fri, 12 Jun 2020 12:51:13 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9063: fix LDO9 suspend and warning.
Date:   Fri, 12 Jun 2020 12:50:33 +0200
Message-Id: <1591959073-16792-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 99f75ce66619 ("regulator: da9063: fix suspend") converted
the regulators to use a common (corrected) suspend bit setting but
one of regulators (LDO9) slipped through the crack.


This means that the original problem was not fixed for LDO9 and
also leads to a warning found by the test robot.
	da9063-regulator.c:515:3: warning: initialized field overwritten

Fix this by converting that regulator too like the others.


Fixes: 99f75ce66619 ("regulator: da9063: fix suspend")
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 drivers/regulator/da9063-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index e1d6c8f..fe65b5ac 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -512,7 +512,6 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev,
 	},
 	{
 		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-- 
1.9.1

