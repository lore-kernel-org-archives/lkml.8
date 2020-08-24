Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BAFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2962074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260966;
	bh=2KbnWelSdyZWoAXXJ01/0tkfE7UHjkHKDWxQXJR79Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWJDAsOdqcC7jraZDbQv0bmvl7G+1fIRmflBHVcNsRVkg8IE6QL/yXraQHkbHjq12
	 IO3ehtkb6pk5DxAnnKUWzZyXZQvHl/WWleztkvL5bo3CQXIGzoJR2EItN4xevgUO51
	 RMygu2RhjpiRF4o9tKaicKwKHm7Ml52EHHL/mcEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgHXJWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgHXIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7C5207D3;
        Mon, 24 Aug 2020 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259304;
        bh=2KbnWelSdyZWoAXXJ01/0tkfE7UHjkHKDWxQXJR79Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRGTr6PZ7zQhslpDqp0DetjO6lG8lZW08AV0cbe6kYJ9Lb7NwuZZdnekYxgJU2zok
         LtXBFjed+HeKNlwJ8fJYysgDP2m4piiiqeOaz1GvtSu+9/n5VkUmCJEHhA07u65T+H
         1hRaLSaESxayLyBnZdUFWDcxsVbcXHQ889SL3ujs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/50] ASoC: intel: Fix memleak in sst_media_open
Date:   Mon, 24 Aug 2020 10:31:41 +0200
Message-Id: <20200824082354.083733004@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 062fa09f44f4fb3776a23184d5d296b0c8872eb9 ]

When power_up_sst() fails, stream needs to be freed
just like when try_module_get() fails. However, current
code is returning directly and ends up leaking memory.

Fixes: 0121327c1a68b ("ASoC: Intel: mfld-pcm: add control for powering up/down dsp")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200813084112.26205-1-dinghao.liu@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 4558c8b930363..3a645fc425cd4 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -339,7 +339,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 
 	ret_val = power_up_sst(stream);
 	if (ret_val < 0)
-		return ret_val;
+		goto out_power_up;
 
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
@@ -348,8 +348,9 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	return snd_pcm_hw_constraint_integer(runtime,
 			 SNDRV_PCM_HW_PARAM_PERIODS);
 out_ops:
-	kfree(stream);
 	mutex_unlock(&sst_lock);
+out_power_up:
+	kfree(stream);
 	return ret_val;
 }
 
-- 
2.25.1



