Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59422C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F92053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="WIBIrIjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgFHQur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:50:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:65270 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgFHQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:50:43 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gfQ936Zrz9Y;
        Mon,  8 Jun 2020 18:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591635041; bh=jarQlXIMyEgpDzCHnwhZ/Ic2auBBKSklH+JwJ3xa7B4=;
        h=Date:From:Subject:In-Reply-To:To:Cc:From;
        b=WIBIrIjAnzgKDgG6E50IKD77VgKzVIV8iGsIicqtwyayhblgJCDpssMGVGb/e9f3Q
         /L/Rm/NAJETHnUPdke3Ps44VsduuhUW/Fzta2QM5AvGLrDnxMlmdIR74cMlgZwyfKh
         nCo7zoOqxB1MVIpBbDgs2gyc6DTwyF/ZsO+yKF8k5dJXovvNPnk9tQAuqChINds6S9
         NUc+zFDdLdRknF8msc3kZfihqczV5tR+yJL+wwU3wqtg/asdXvuc02vC9g7PFDv95F
         R1kJBfR40X1Hx98FG5ajsIp5DR1bHue0BBA0lsVFkxKQLW4mCD1w+frrNl7NyOnTxu
         5MHfL6Api4IGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 08 Jun 2020 18:50:39 +0200
Message-Id: <89c4a2487609a0ed6af3ecf01cc972bdc59a7a2d.1591634956.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] ALSA: pcm: disallow linking stream to itself
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h4krl67vb.wl-tiwai@suse.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent SNDRV_PCM_IOCTL_LINK linking stream to itself - the code
can't handle it. Fixed commit is not where bug was introduced, but
changes the context significantly.

Cc: stable@vger.kernel.org
Fixes: 0888c321de70 ("pcm_native: switch to fdget()/fdput()")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: EDEADLK -> EINVAL
---
 sound/core/pcm_native.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index aef860256278..434e7b604bad 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2166,6 +2166,12 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	}
 	pcm_file = f.file->private_data;
 	substream1 = pcm_file->substream;
+
+	if (substream == substream1) {
+		res = -EINVAL;
+		goto _badf;
+	}
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
 		res = -ENOMEM;
-- 
2.20.1

