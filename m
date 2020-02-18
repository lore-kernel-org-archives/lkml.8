Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96820C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706ED2465D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056114;
	bh=m5DX8gbNn2LYAQ6ON+TrHhlZmgkiUPrhN0fjPaqhjnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1gvw0ccw9Zl4z+CeKFxNnqUZmjgFlbfbxs8c3h+Kmx1Ig4dVr4BkRMaVsWMtmwT6
	 ycCCLiVBMkC4E1Pio5Ff5KR+HpTcxlu62vwDzZlv1zWZekCvYKlxHRlK9KpBsMYmX/
	 cTyfef8MyICrvf3XIVamr32XeMCLnuB09L6gJpf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgBRUBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgBRUBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4292465D;
        Tue, 18 Feb 2020 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056107;
        bh=m5DX8gbNn2LYAQ6ON+TrHhlZmgkiUPrhN0fjPaqhjnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEbjcPTVE50za0/5+NAI9a8VjFbP7mf0saXGPTBpzdYi0JBsHUWHAvJ1kr2GwFVcq
         h9bxLDaYoqJUlvcjWd73aqEC3luXBHFJOL4FV8FZgBwITPPwWDCjKb2gnY67GDnYaR
         p4HevF/84bKyCNEW2qFZ50jYr12Tt2waabvu9cqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 08/80] ALSA: pcm: Fix double hw_free calls
Date:   Tue, 18 Feb 2020 20:54:29 +0100
Message-Id: <20200218190432.872521894@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 0fbb027b44e79700da80e4b8bd1c1914d4796af6 upstream.

The commit 66f2d19f8116 ("ALSA: pcm: Fix memory leak at closing a
stream without hw_free") tried to fix the regression wrt the missing
hw_free call at closing without SNDRV_PCM_IOCTL_HW_FREE ioctl.
However, the code change dropped mistakenly the state check, resulting
in calling hw_free twice when SNDRV_PCM_IOCTL_HW_FRE got called
beforehand.  For most drivers, this is almost harmless, but the
drivers like SOF show another regression now.

This patch adds the state condition check before calling do_hw_free()
at releasing the stream for avoiding the double hw_free calls.

Fixes: 66f2d19f8116 ("ALSA: pcm: Fix memory leak at closing a stream without hw_free")
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/s5hd0ajyprg.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2474,7 +2474,8 @@ void snd_pcm_release_substream(struct sn
 
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
-		do_hw_free(substream);
+		if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+			do_hw_free(substream);
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
 	}


