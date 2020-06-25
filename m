Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FCDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2292080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2NxEfmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406639AbgFYTRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406552AbgFYTR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E06C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so6656725wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLynNpCT3aHwFMp9X5o+Fu0+7LET71ajpqSGjxj/VKI=;
        b=U2NxEfmvuzlHjSdqFrB1DTCE1IiLf6GxQI/mZCkymUUYetLIbpidegjuARBEpicPGQ
         SNxET/9290AhKWxrDFozhx518+EeIO9ctBFjEGTs0jSKZHie79lqbOw1iiDKLQt9EDFu
         2omYoJoG6p1TeXQGaNtlqqfywIKA8zuqPz4U2b+r2sZepAMRdm+UJIo0GXnI51eZHAIu
         bCHRewtKelLzEBBhvIVEIpHkVOaefYVPAtfUlejG++R38YV1oPzV7lR0oCC1ky1+UojM
         hFgAO5zK9mFjdlUC5B4YcC9QscMdPkFoxvorPIA9jnvRG9Ig6T8bTpbV5FtaXundYkEL
         7uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLynNpCT3aHwFMp9X5o+Fu0+7LET71ajpqSGjxj/VKI=;
        b=rtx9IGF5kfErgq/c7ZsmCvLaKrUlRVvm8dDHg8HNloIqT/OJaOMViNKh5ubnB6c8BC
         BgY02GlbBbBQ0TZrIH/XcBTts6ck2vrDyOrQoaMurlbH1JKZepDvizW6DE2Rfl9v3QCb
         QJYR8GAFwR/IgecMvm2YCMKr51A7cWAQS32yg2xb8JC/cvs9JItxUdfSrEM7p0lYMs5L
         oB65DB24DEdj52AYjXgTL3GLYu1sxPKUG2Cd4O/cYPIZ37bLHcqu2FM9r0M3fu3ozvYT
         fsPoCxXyJaLs9DpdDqkyJrwyo/YOCGv1GyqRviZE36GnJKeBFpngyMup1MPlk7las07v
         FGsQ==
X-Gm-Message-State: AOAM530Kbc94XVNww6VuElQ3a9GX/J9ZPaeWmcmWt67otkKj0xDUu0A3
        Lkfd4Ep2U9f1y3u8qpemdwBgWg==
X-Google-Smtp-Source: ABdhPJzqCiWgHDKk7Wbw62YYaS6BBq8yV0ZPPzWnBmFbpkw3OTjfzMibwAVS5PPLDhCF7SnZwq49vw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr5307426wmd.55.1593112644657;
        Thu, 25 Jun 2020 12:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [RESEND 09/10] regulator: da9063-regulator: Fix .suspend 'initialized field overwritten' warnings
Date:   Thu, 25 Jun 2020 20:17:07 +0100
Message-Id: <20200625191708.4014533-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though 99f75ce666199 ("regulator: da9063: fix suspend") failed
to clean-up all of the existing .suspend variable initialisations.
This has led to some 'initilized field overwritten' issues now present
in W=1 builds.

This patch squashes the following build warnings:

 In file included from drivers/regulator/da9063-regulator.c:17:
 include/linux/regmap.h:1124:37: warning: initialized field overwritten [-Woverride-init]
 1124 | #define REG_FIELD(_reg, _lsb, _msb) { | ^
 drivers/regulator/da9063-regulator.c:27:2: note: in expansion of macro ‘REG_FIELD’
 27 | REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, | ^~~~~~~~~
 drivers/regulator/da9063-regulator.c:515:14: note: in expansion of macro ‘BFIELD’
 515 | .suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 | ^~~~~~
 include/linux/regmap.h:1124:37: note: (near initialization for ‘da9063_regulator_info[11].suspend’)
 1124 | #define REG_FIELD(_reg, _lsb, _msb) { | ^
 drivers/regulator/da9063-regulator.c:27:2: note: in expansion of macro ‘REG_FIELD’
 27 | REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, | ^~~~~~~~~
 drivers/regulator/da9063-regulator.c:515:14: note: in expansion of macro ‘BFIELD’
 515 | .suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 | ^~~~~~

Cc: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/da9063-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index e1d6c8f6d40bb..fe65b5acaf280 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -512,7 +512,6 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 	},
 	{
 		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-- 
2.25.1

