Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBB52082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409884;
	bh=D9R14nx92DgiSI7HrKBJtY8GmlzoUhNOx/S3N6SKvzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIRi8He7wMBhIDmzGlIiC8ocE3wycE+XRu+XaWbm73pwkNYhbx0YGrRk2Brqp54Jp
	 +y6Uuyaa9P2gSjcS5Plja9vyFB0b8zWtaOSVcwz0HkFRf2R1tOztAlEqDdNfqKlfsL
	 W7aLJ3nLjBLSqc/wx9bxdCrIRQNpjZXiQURdw7yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgA3Son (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgA3Sok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5C0205F4;
        Thu, 30 Jan 2020 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409879;
        bh=D9R14nx92DgiSI7HrKBJtY8GmlzoUhNOx/S3N6SKvzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJgS8pS6sbVnaFvCKkc7wprMvPwp0827jcG6tjkdis64dwH/8gRCIV9ClgZAhpOMa
         jh+WvliZpa+W+HyjHldndeXf4+u6ky5R66ou8hWFotVlzJZfm8zq73Dh8jzZFlIkbv
         FNywdN5tZHMynD74W1StVrBW/m6Kgs8jKu3TtLyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/110] ASoC: SOF: fix fault at driver unload after failed probe
Date:   Thu, 30 Jan 2020 19:38:28 +0100
Message-Id: <20200130183621.303656639@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit b06e46427f987bf83dcb6a69516b57276eb8ec0c ]

If sof_machine_check() fails during driver probe, the IPC
state is not initialized and this will lead to a NULL
dereference at driver unload. Example log is as follows:

[ 1535.980630] sof-audio-pci 0000:00:1f.3: error: no matching ASoC machine driver found - aborting probe
[ 1535.980631] sof-audio-pci 0000:00:1f.3: error: failed to get machine info -19
[ 1535.980632] sof-audio-pci 0000:00:1f.3: error: sof_probe_work failed err: -19
[ 1550.798373] BUG: kernel NULL pointer dereference, address: 0000000000000008
...
[ 1550.798393] Call Trace:
[ 1550.798397]  snd_sof_ipc_free+0x15/0x30 [snd_sof]
[ 1550.798399]  snd_sof_device_remove+0x29/0xa0 [snd_sof]
[ 1550.798400]  sof_pci_remove+0x10/0x30 [snd_sof_pci]

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191218000518.5830-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 086eeeab86795..7b6d69783e16a 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -834,6 +834,9 @@ void snd_sof_ipc_free(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc *ipc = sdev->ipc;
 
+	if (!ipc)
+		return;
+
 	/* disable sending of ipc's */
 	mutex_lock(&ipc->tx_mutex);
 	ipc->disable_ipc_tx = true;
-- 
2.20.1



