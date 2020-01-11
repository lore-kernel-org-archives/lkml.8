Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20A0206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737737;
	bh=0ef4R91hDWE4O4cgP2m+U+Frfl8u+9MVu8EB+owp2iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRbxviPA1cIqKG1WB5G1ACscYIG5S1RbAcf0uiFT+oEqPo0+T1CkpBrs4p619xp+x
	 v6PkZswqBHza8TaEgYjtHE+D79OnfSeFA3xDtwPgzsJfEtFegfJfwhF+9Ih7F+ll7d
	 k8tqjRLTaHvKzp9dB3aYRtua4u04zXteL3jjLihc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgAKKPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgAKKPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:15:30 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7B220673;
        Sat, 11 Jan 2020 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737730;
        bh=0ef4R91hDWE4O4cgP2m+U+Frfl8u+9MVu8EB+owp2iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuCFW329xTKFi4ku6UwXE+zZ24DXsAJhy74NgP3ZLKmq7pAB02dw9VDvlWs9IpqX6
         Ny4lChu3UAAHnKlrULkqhxBO7BtBrg2JeF2unCCkmyiuYzClTjgRkhpJyhJVSp8jpI
         WI82kdcs2LN2llH05hOHo9y1t1/X91P5hyd6tWrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/84] ASoC: topology: Check return value for soc_tplg_pcm_create()
Date:   Sat, 11 Jan 2020 10:50:02 +0100
Message-Id: <20200111094855.180554414@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

[ Upstream commit a3039aef52d9ffeb67e9211899cd3e8a2953a01f ]

The return value of soc_tplg_pcm_create() is currently not checked
in soc_tplg_pcm_elems_load(). If an error is to occur there, the
topology ignores it and continues loading.

Fix that by checking the status and rejecting the topology on error.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210003939.15752-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 88a7e860b175..069f38fbf07b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1890,6 +1890,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	int count = hdr->count;
 	int i;
 	bool abi_match;
+	int ret;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
@@ -1926,7 +1927,12 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		}
 
 		/* create the FE DAIs and DAI links */
-		soc_tplg_pcm_create(tplg, _pcm);
+		ret = soc_tplg_pcm_create(tplg, _pcm);
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_pcm);
+			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size
-- 
2.20.1



