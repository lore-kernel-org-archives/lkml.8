Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6672C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6B2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194983;
	bh=fV/V+x+V3P0Xx8321dLNqIHr1V6hB27Z0V+CnOMzFRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RdPoijbN95T9U+uYevpqTKOr4qNTycS0o4/PDLLJ3A64Z32bLfcZfaLSVwF39ayWK
	 fi2UBHN8Fo62whrkxfLBj3YJ05sgAt3WEnsZi+7mJeB7bZ5fc3Tvvu1VVdliUuUpVg
	 HSpB1IoEuoXGqf4eLif2oxRslRnOr15cd9M37D+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbgAPROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbgAPRN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253CA246A7;
        Thu, 16 Jan 2020 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194838;
        bh=fV/V+x+V3P0Xx8321dLNqIHr1V6hB27Z0V+CnOMzFRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XW6SKsVWAjkrxwV9IgTNNDk74Gav/QSJohgUkFIPZDofft6W/D9YqvjhKg45o93oF
         JGJ00bJokos5QMTfTrdgeyW7Lu7ehiSsdgs4AGpIADGMP1wRRo4Ng0qgCGAvnlApHT
         EUVTBSxH5FF8S3ZDUegyxVre1QofO7sXQpNt6aEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 638/671] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
Date:   Thu, 16 Jan 2020 12:04:36 -0500
Message-Id: <20200116170509.12787-375-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 458ea3ad033fc86e291712ce50cbe60c3428cf30 ]

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/regulator/ab8500.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 06978ce01302..d48ab3e66d0b 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -43,8 +43,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 
-- 
2.20.1

