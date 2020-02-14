Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9406AC47409
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B424650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701427;
	bh=BMSj3i+Zs6AHfdEoKpkr+5pJSuTkEp65CL/I5pXfE30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1KR4QzPh8dIurnGoHgj2Vyfp+C8naxtpwbKzKfDaN7wq6Km9pk+T3IWcJQOxXw4R8
	 ukK3bPQ2N/f81PJ4+YdVEnK2zaf3ecFgV2npu0qbMtMjh47Y7CRie3ukqpi2g8pLFr
	 KoOQw+GEd6CEVv6B2T4oyLNTOm3ei23BbNEZ1gew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbgBNQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390144AbgBNQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:06:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E766222C2;
        Fri, 14 Feb 2020 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696400;
        bh=BMSj3i+Zs6AHfdEoKpkr+5pJSuTkEp65CL/I5pXfE30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL5syfccITRa7zVVmoA+jIjQ4Qb/72Wg4mOxCOMNNxfFzuRSmIX0hJWxJUThO5dI8
         BKLsJlJhU0g1veilL4c52EhrRv1cbHWyPp8R8Qcjr5hklLdqlqlLogsCFEdUsF+rvE
         LKxqUDOl3PbHQXiciy5m7z+CS7A2Eatrm2gwINto=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 225/459] ASoC: Intel: kbl_da7219_max98357a: remove unused variable 'constraints_16000' and 'ch_mono'
Date:   Fri, 14 Feb 2020 10:57:55 -0500
Message-Id: <20200214160149.11681-225-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c5614fb8e3d13be7bba79f71b798468a3a6224f7 ]

sound/soc/intel/boards/kbl_da7219_max98357a.c:343:48:
 warning: constraints_16000 defined but not used [-Wunused-const-variable=]
sound/soc/intel/boards/kbl_da7219_max98357a.c:348:27:
 warning: ch_mono defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191224140237.36732-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 537a88932bb69..0d55319a0773c 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -336,19 +336,6 @@ static struct snd_soc_ops kabylake_dmic_ops = {
 	.startup = kabylake_dmic_startup,
 };
 
-static const unsigned int rates_16000[] = {
-	16000,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_16000 = {
-	.count = ARRAY_SIZE(rates_16000),
-	.list  = rates_16000,
-};
-
-static const unsigned int ch_mono[] = {
-	1,
-};
-
 SND_SOC_DAILINK_DEF(dummy,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
 
-- 
2.20.1

