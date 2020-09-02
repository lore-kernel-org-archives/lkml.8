Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D80C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04638208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599079739;
	bh=t/8BcFdSorWnivrsoG38nd1y314QH2po1FsRQi2lhnU=;
	h=From:To:Subject:Date:List-ID:From;
	b=PSTDnnEVJtPUQXDbQE2PCU2K6lzfG/mWYpBR/mNd4ilHqeeV8UqCNcDYAHi6s2wXO
	 Xa5cn+sQ+F71YANt/TbMR9gGfKumBydlYJ2Eqrc+AmBg97RhbTxmwim7ll6vsO1raF
	 arDancyPt3JIhO4/+AXvtLWcCEkkorocA3/8V9EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBUs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBUs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:48:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22435207EA;
        Wed,  2 Sep 2020 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599079736;
        bh=t/8BcFdSorWnivrsoG38nd1y314QH2po1FsRQi2lhnU=;
        h=From:To:Subject:Date:From;
        b=cep2yre4au+2ROtrnWF4L3OjIjRecdkmIKyTCjCm308tuR14rW+RQ8bA+Cy4vkVTj
         5/ty7o2J/UNblaLlVPOFF29MvytJ2z9w8RC7lLjQJg0VZSt8U2gfIwQS8Kjzif4YN5
         JWdk9wyDqqs4VpsEQkYozAJ4zUpvzf4mXFN8NyrI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] mmc: davinci: Fix -Wpointer-to-int-cast on compile test
Date:   Wed,  2 Sep 2020 22:48:45 +0200
Message-Id: <20200902204847.2764-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store in interrupt service routine always '1' in end_command, not the
value of host->cmd to fix compile test warnings on RISC-V:

  drivers/mmc/host/davinci_mmc.c:999:17: warning:
    cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Follow up to:
https://lore.kernel.org/linux-arm-kernel/20200902193658.20539-1-krzk@kernel.org/T/#t

 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index fad1010fb52b..66d740ee7d45 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -996,7 +996,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 
 	if (qstatus & MMCST0_RSPDNE) {
 		/* End of command phase */
-		end_command = (int) host->cmd;
+		end_command = host->cmd ? 1 : 0;
 	}
 
 	if (end_command)
-- 
2.17.1

