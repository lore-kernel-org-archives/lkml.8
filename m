Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504FA2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948260;
	bh=YeSMzpUEVd/Ea1T4A5u8LcMSo/luwXHnf3TWTA7I/8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aoxyvBVUt0nd4JKNVRwPkLmHAYgiUmtaxGCC/7+A/hNZMXBTmyNr3HG1NYqR0mYrr
	 encn8tmH17SErgqV0mEiOPgbI8u8WNDF8FaVufEHFntVZALIKi4v6Sk4FL+5eWRKQJ
	 9iKBVKwoEmLYhweegOBCaaD2wCWiCuqZ51OvkPp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgFWVhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbgFWUIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63F32082F;
        Tue, 23 Jun 2020 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942930;
        bh=YeSMzpUEVd/Ea1T4A5u8LcMSo/luwXHnf3TWTA7I/8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QThCtETvl+VfIPv3P4KRwezuS9BVwjsZgrGj8IOaMFH5oapmS8ybgVzsjE/Xe7cAC
         u4Uk0X+g369QH/juq/rD+gEpK5bqEAXLFwmkOEfWrXj8/Pn6tUOc49mU6OyM4DgRtn
         hpmAg5NHftPbM0HEzdTXiVzvo2FtLPP2V+KrKWGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 191/477] ASoC: ux500: mop500: Fix some refcounted resources issues
Date:   Tue, 23 Jun 2020 21:53:08 +0200
Message-Id: <20200623195416.613650010@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 4e8748fcaeec073e3ba794871ce86c545e4f961f ]

There are 2 issues here:
   - if one of the 'of_parse_phandle' fails, calling 'mop500_of_node_put()'
     is a no-op because the 'mop500_dai_links' structure has not been
     initialized yet, so the referenced are not decremented
   - The reference stored in 'mop500_dai_links[i].codecs' is refcounted
     only once in the probe and must be decremented only once.

Fixes: 39013bd60e79 ("ASoC: Ux500: Dispose of device nodes correctly")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20200512100705.246349-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ux500/mop500.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 2873e8e6f02be..cdae1190b930b 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -63,10 +63,11 @@ static void mop500_of_node_put(void)
 {
 	int i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 2; i++)
 		of_node_put(mop500_dai_links[i].cpus->of_node);
-		of_node_put(mop500_dai_links[i].codecs->of_node);
-	}
+
+	/* Both links use the same codec, which is refcounted only once */
+	of_node_put(mop500_dai_links[0].codecs->of_node);
 }
 
 static int mop500_of_probe(struct platform_device *pdev,
@@ -81,7 +82,9 @@ static int mop500_of_probe(struct platform_device *pdev,
 
 	if (!(msp_np[0] && msp_np[1] && codec_np)) {
 		dev_err(&pdev->dev, "Phandle missing or invalid\n");
-		mop500_of_node_put();
+		for (i = 0; i < 2; i++)
+			of_node_put(msp_np[i]);
+		of_node_put(codec_np);
 		return -EINVAL;
 	}
 
-- 
2.25.1



