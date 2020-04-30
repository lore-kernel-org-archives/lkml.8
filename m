Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16316C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC5021775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254666;
	bh=+oeNiTYPadaKg8OL8/VAEVfJ9NdIfn3+Zuj8RJ/QEGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emuvY+HEgom4l7zvMfMJqnqg5S5IAbTQMNduEfhPvEuNHYA/MftuCd4XZsQgIRY3l
	 1cU/+/co6jPg7ZawR5vvH+H3ubahxb2xF1Qy/XCk70mE6qhMQ81JUBEMr1vfs3EI90
	 3zTG6rRu3LzogimpDZvQFtSDDgz1vwEgM3pm6Mws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgD3NvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgD3Nu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:50:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA8B24958;
        Thu, 30 Apr 2020 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254656;
        bh=+oeNiTYPadaKg8OL8/VAEVfJ9NdIfn3+Zuj8RJ/QEGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5Gif/X2QmG6SEVaUa4p3N7fXgkcERnhBeOSLBBy2QAjV1NUQ2r3CWPgr2CQoHi1m
         Kqb++2yyJFBqz4McLR0ntzdtHYYXzyFt8uoSSuL0g1nRoVPnTdMhGx5cn6cBOtdG+M
         u3LRMs3Mok36FWXC3lmQhJ1XM6PJdQUsuWNMssYc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 10/79] ASoC: topology: Check soc_tplg_add_route return value
Date:   Thu, 30 Apr 2020 09:49:34 -0400
Message-Id: <20200430135043.19851-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index c86c3ea533f68..aa7714f2b78fd 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1284,7 +1284,9 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
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

