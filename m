Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE72C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B8020838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747094;
	bh=+Bnp/PEjYgWugTCK5CbHdsK5GEnec/R5q6lbcnrZi3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8g/CoVcPUXOFN3p5FOlW/YoAx28x0QZdY6tWuAf7RUBZE9RoS7TR/1Vy6EGS0swi
	 Q4cgMxJTwAj5/TiaScnFkwvGLoWYP3lFyzTf3bYWAzUXtdQ7h1km2swAiiE5RB/61W
	 YqgIaz7u1efttqlaQtwsHvANCg8eSeUdDW8/czrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBCQYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:24:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgBCQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:24:53 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7077C2080C;
        Mon,  3 Feb 2020 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747092;
        bh=+Bnp/PEjYgWugTCK5CbHdsK5GEnec/R5q6lbcnrZi3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6lKbpqbyGEJ+Oy4R9QLxlqNJZ+XfEZag3VbGXPaedOW+kXn2g0FFksfeR6Kus7GC
         2SO0nHq5iu1NVoKVJ29I44HdXzC0kIm/5JUZf97AX8EQwbqsR2JcYuuzkY+DyiT9/q
         VVVBHyhVRzT8SneMF5t8oAYMFBLqqPlDGH8fWMdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 4.9 01/68] ALSA: pcm: Add missing copy ops check before clearing buffer
Date:   Mon,  3 Feb 2020 16:18:57 +0000
Message-Id: <20200203161904.914178529@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ this is a fix specific to 4.4.y and 4.9.y stable trees;
  4.14.y and older already contain the right fix ]

The stable 4.4.y and 4.9.y backports of the upstream commit
add9d56d7b37 ("ALSA: pcm: Avoid possible info leaks from PCM stream
buffers") dropped the check of substream->ops->copy_user as copy_user
is a new member that isn't present in the older kernels.
Although upstream drivers should work without this NULL check, it may
cause a regression with a downstream driver that sets some
inaccessible address to runtime->dma_area, leading to a crash at
worst.

Since such drivers must have ops->copy member on older kernels instead
of ops->copy_user, this patch adds the missing check of ops->copy for
fixing the regression.

Reported-and-tested-by: Andreas Schneider <asn@cryptomilk.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_native.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -588,7 +588,7 @@ static int snd_pcm_hw_params(struct snd_
 		runtime->boundary *= 2;
 
 	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area)
+	if (runtime->dma_area && !substream->ops->copy)
 		memset(runtime->dma_area, 0, runtime->dma_bytes);
 
 	snd_pcm_timer_resolution_change(substream);


