Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0AFC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A938D2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338576;
	bh=Yy6UWJQu8MySBSM/VdGtaMO5OFD9fUR1Tqy1Y26egAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4xn2mYQxNnXTFjVNQ57G3ycKaZlBKl+ziohl/dR6vF+hv2mVxypbmINYDrJ3i2WI
	 Xig5b48tNvn7y+biXyFyrsa+9lWCSG9sn9+aJgyzslqfmiwjtl6axAx4mcW5rLnUkh
	 zR8qRfZV4vLN0N7kWDST0oar0Qa1QatWaw0iiOHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgBJMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgBJMjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:37 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F7620842;
        Mon, 10 Feb 2020 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338377;
        bh=Yy6UWJQu8MySBSM/VdGtaMO5OFD9fUR1Tqy1Y26egAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+GPFqkndHm/WOGOCDNUjOIsRNsDANpk7cEyl4OZnmg6UeNJOfUFBpAVuSAfB8/5W
         H4C99F4kbBx/CGbDsjvFQ4SQNNPPlHrZ8H/SHMZpQZt1Xdac4YgdrLp/KdR2EGg0O+
         FjQYCz7mT4je1H/TwhTc8xJ/vrtNqbNusugitXUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 053/367] ALSA: dummy: Fix PCM format loop in proc output
Date:   Mon, 10 Feb 2020 04:29:26 -0800
Message-Id: <20200210122428.946899287@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 2acf25f13ebe8beb40e97a1bbe76f36277c64f1e upstream.

The loop termination for iterating over all formats should contain
SNDRV_PCM_FORMAT_LAST, not less than it.

Fixes: 9b151fec139d ("ALSA: dummy - Add debug proc file")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200201080530.22390-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/dummy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -915,7 +915,7 @@ static void print_formats(struct snd_dum
 {
 	int i;
 
-	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (dummy->pcm_hw.formats & (1ULL << i))
 			snd_iprintf(buffer, " %s", snd_pcm_format_name(i));
 	}


