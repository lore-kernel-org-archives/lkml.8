Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4645C2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="FviN4T+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgFHKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:06:36 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31416 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgFHKGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:06:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gTRr5KF3zBn;
        Mon,  8 Jun 2020 12:06:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591610792; bh=ToQ1Q88h9KXOgWqvqinbc9ShsgjvDBLo4uhp3BUbUok=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=FviN4T+s+yA3w3snpTxygawbBpqGW9kQuai95bbFPZtF/V3SwxE8KUQ4aFlTUTN57
         MgFwOs674/5wWjejhCK43e7pfnq2KTu/5DwuKqpaQwKN1IVb1+J8lM+z0Bh/rnndMT
         GYPYF/3zwWrdTYXh60e2w3MhrCmn+uK4dvL1oJI10MB2g9KrQJsx8QT819d81oYSXX
         5hfB2d2qrq+hthA1N3n2hiD6mscCAKXbTV7IXrGBBBDNHB39iZbXu0WFsXwiste72/
         gKGsfUR4X55jYIRBPgPqnxXPauRp58xCTu5rf6zL5E9RaLVAqaN+Jnlf82YHb3C7Tn
         PMOZjLI8j5w5Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 08 Jun 2020 12:06:32 +0200
Message-Id: <dc38ec162b8c83e53cf48cc8dc4dbac78667e394.1591610330.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
References: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] ALSA: pcm: disallow linking stream to itself
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 sound/core/pcm_native.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index aef860256278..3ad399cb6f30 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2166,6 +2166,12 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	}
 	pcm_file = f.file->private_data;
 	substream1 = pcm_file->substream;
+
+	if (substream == substream1) {
+		res = -EDEADLK;
+		goto _badf;
+	}
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
 		res = -ENOMEM;
-- 
2.20.1

