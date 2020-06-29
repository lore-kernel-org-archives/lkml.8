Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A95206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467177;
	bh=bsVnmFnwHQX1Iq9XkTHGGqBJy3pS/LOLzkSfDILiQOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oLfjskLccht/xcOF2fPiorWNsIKnRpmMR05xRUnuzwXPptu4ut+EuoRiYoRCIYwTS
	 piuXNhnqb3LHepZgRipLHnLcnAhmsGVc64Zhmp9zsO6H0P0uAOTJiHY/aqmd5Uxsvw
	 1XS08kaz0ysMhIsZbYM/5JqbRjQJEa8To3i/UKIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgF2VqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbgF2Sfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB9E246A0;
        Mon, 29 Jun 2020 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443997;
        bh=bsVnmFnwHQX1Iq9XkTHGGqBJy3pS/LOLzkSfDILiQOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUNBc7/gXtY5vLNKN9uaDm0ZamYFoLENq+MOhkv426Yd2fdjCt8TPnBd7vrGdfrAM
         GAcpIDf4BSoXQl2DdR5uI7Q0df55XZGCF0dntPn+wn4/K1CsoMziImr/4jOq6tOM6k
         ruQ7M9oSM9+SO1HeCxP4Wf0E6fwPoEZXgtNbQfi0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 102/265] regulator: da9063: fix LDO9 suspend and warning.
Date:   Mon, 29 Jun 2020 11:15:35 -0400
Message-Id: <20200629151818.2493727-103-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

[ Upstream commit d7442ba13d62de9afc4e57344a676f9f4623dcaa ]

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
Link: https://lore.kernel.org/r/1591959073-16792-1-git-send-email-martin.fuzzey@flowbird.group
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

