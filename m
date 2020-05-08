Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4029C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A874C24959
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942401;
	bh=wIKXzFqMTAINVGKW6QkWm/9DSbQ3VQX2Ny4HMXoVPb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zopPe3Q+QTqMzbpVSrb7Z7DUbFHPf2WGnoqCdD5JoLxuQh/JWmsmkLaapZx/t9Kas
	 9wv+0XGEk1fYb8F2f/4Sv4Rk6v5/5AcfJiwyL18NjjC6f19Swe/W26qiPqrPIK+z0Z
	 QSkAzOi37K4saaJYyGyKZ7baZuC0gpWd8ohXictA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgEHMxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgEHMxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DADDD24959;
        Fri,  8 May 2020 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942394;
        bh=wIKXzFqMTAINVGKW6QkWm/9DSbQ3VQX2Ny4HMXoVPb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKMAEXwTLsBSrm2CwaUh9/bxH6mQxydHwVA1X58pV4Q/EjHsjsitU5jgHzz9QneCX
         lqW4TmyyLu2HciDcM1uOzWM+LEYF983bPdV9iAsCWB5L6G6blbHIKwbGqZs1B2m+sU
         3aYrM5uW9LXjRBlPE8leQv5oD4y9EZqPjFdrrtig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 05/50] ASoC: topology: Check soc_tplg_add_route return value
Date:   Fri,  8 May 2020 14:35:11 +0200
Message-Id: <20200508123044.024830545@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 6856e887eae3efc0fe56899cb3f969fe063171c5 ]

Function soc_tplg_add_route can propagate error code from callback, we
should check its return value and handle fail in correct way.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-5-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index efe6ad3bfcd9b..e0b40d4d8784c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1283,7 +1283,9 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		routes[i]->dobj.index = tplg->index;
 		list_add(&routes[i]->dobj.list, &tplg->comp->dobj_list);
 
-		soc_tplg_add_route(tplg, routes[i]);
+		ret = soc_tplg_add_route(tplg, routes[i]);
+		if (ret < 0)
+			break;
 
 		/* add route, but keep going if some fail */
 		snd_soc_dapm_add_routes(dapm, routes[i], 1);
-- 
2.20.1



