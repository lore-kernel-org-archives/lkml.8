Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A726C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1182920809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584683;
	bh=5Ut5zBJxFdeupz17PvXk6YqK5JbTYK/gIlg5llAYHOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKBdir1COxRKu/tvucWxeWzRgfO9wJInwN0dVgHAVkYLt3uhOKIUYsiti240UXp4g
	 mw5kuXBqUJ1u+obaT0IVBsK7JRqF10lYcU6HEFz6dHSzaR0Qu4Jeyoz1EaYZ5kSiJr
	 tmYV12i0V1wuAnBrOFW3rcCik/gLPBwZce4yIgSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbgFSOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388957AbgFSOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618FE217BA;
        Fri, 19 Jun 2020 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578057;
        bh=5Ut5zBJxFdeupz17PvXk6YqK5JbTYK/gIlg5llAYHOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ModIzWWXEwxgQ+lBRTU0fBFBzn38oqGnSRP57zebncnZy7uUloHF5IbBX3MqbUY//
         Yobn/sR5+DRst82xeaTN8zvKy7JfzU7EDG5sE4dUmx0uYfL642uQIkdwwsq6VbPxN4
         rqCO7wO8KRmOayPKiVlfLAkpCOJvgFUzvxxNziRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 035/190] ALSA: pcm: disallow linking stream to itself
Date:   Fri, 19 Jun 2020 16:31:20 +0200
Message-Id: <20200619141635.329616038@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit 951e2736f4b11b58dc44d41964fa17c3527d882a upstream.

Prevent SNDRV_PCM_IOCTL_LINK linking stream to itself - the code
can't handle it. Fixed commit is not where bug was introduced, but
changes the context significantly.

Cc: stable@vger.kernel.org
Fixes: 0888c321de70 ("pcm_native: switch to fdget()/fdput()")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/89c4a2487609a0ed6af3ecf01cc972bdc59a7a2d.1591634956.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 sound/core/pcm_native.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1950,6 +1950,11 @@ static int snd_pcm_link(struct snd_pcm_s
 	}
 	pcm_file = f.file->private_data;
 	substream1 = pcm_file->substream;
+	if (substream == substream1) {
+		res = -EINVAL;
+		goto _badf;
+	}
+
 	group = kmalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
 		res = -ENOMEM;


