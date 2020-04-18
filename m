Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90208C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C6C21BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221156;
	bh=lZBe1B8/vSrbP/thKqyTgRcqM7WApwxLjvJjsVC6XBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZuviUklYtikz0+rHZP07s9qwBMnnBg9RR0SvmwUg+R8GazMwCnWZwp3m/DZeVTeK
	 hUCU6vhX0QBAf0Y6NNbugWb6GbF9DwJhkHRH+qRlWoS+5ohuMwg5BEh8inzwmVo9td
	 YsRQMpfNWC2S7AA2uqSDXpv8zjWkU6Z7heEsQEz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDROpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgDROoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A292220A;
        Sat, 18 Apr 2020 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221086;
        bh=lZBe1B8/vSrbP/thKqyTgRcqM7WApwxLjvJjsVC6XBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15ZOakI1TZnAdfTyusrj9+QzwBIulFClFQ4cQeWDMj/fqjod9F1t8EsF6zCBClOvj
         yO01ce8GDbT6IXOMNpvnyGzdsT1vJDRZTRPSjhoJg2fPbADXUCjeG9D3j1EZdJsz8u
         F5wKXCcAlKgI5X4J8zAp9Tr7jiVMG1igui5+sItg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.4 08/19] ASoC: Intel: atom: Take the drv->lock mutex before calling sst_send_slot_map()
Date:   Sat, 18 Apr 2020 10:44:25 -0400
Message-Id: <20200418144436.10818-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144436.10818-1-sashal@kernel.org>
References: <20200418144436.10818-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 81630dc042af998b9f58cd8e2c29dab9777ea176 ]

sst_send_slot_map() uses sst_fill_and_send_cmd_unlocked() because in some
places it is called with the drv->lock mutex already held.

So it must always be called with the mutex locked. This commit adds missing
locking in the sst_set_be_modules() code-path.

Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200402185359.3424-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index d55388e082e18..43c960bb4b211 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -963,7 +963,9 @@ static int sst_set_be_modules(struct snd_soc_dapm_widget *w,
 	dev_dbg(c->dev, "Enter: widget=%s\n", w->name);
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		mutex_lock(&drv->lock);
 		ret = sst_send_slot_map(drv);
+		mutex_unlock(&drv->lock);
 		if (ret)
 			return ret;
 		ret = sst_send_pipe_module_params(w, k);
-- 
2.20.1

