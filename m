Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F39B22209
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443761;
	bh=pZAaIKjkv2LG4+I0TntsRr+1UM8Ya3d3av/5lBBnhV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXmAkvI5tlRpp3iBdHAXiWcINsi28yWmKUNJhc8BUVAuTwqJNV1PzRUACQXqOfvAp
	 iO2Scv2OKfH3fp2paVMxabrX39zs2vyPJVarCb954//xshnoA353sk4D0JSIXTDO1m
	 1nBb0XXVQHT1EZtVsiEyKvWNXTrhavhustyksBPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgFRB3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbgFRB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0B520897;
        Thu, 18 Jun 2020 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443576;
        bh=pZAaIKjkv2LG4+I0TntsRr+1UM8Ya3d3av/5lBBnhV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASdKdd9cx26LnoEG4aPuxs5cMerlPYPfl43RTWjHD0JwEBfvJDK3s4bk7JPAbYe0M
         U/bQTr0aWDVKCxYENEgzK1XPLeVGwuE5S1jTm/L6zdRvGpehzpxnl0lrzpVcOhX15O
         /r9+mgFm+03b8XWOjttEKT4IazPXBLRBXXgQXv9M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 012/108] ALSA: isa/wavefront: prevent out of bounds write in ioctl
Date:   Wed, 17 Jun 2020 21:24:24 -0400
Message-Id: <20200618012600.608744-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7f0d5053c5a9d23fe5c2d337495a9d79038d267b ]

The "header->number" comes from the ioctl and it needs to be clamped to
prevent out of bounds writes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200501094011.GA960082@mwanda
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_synth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 0b1e4b34b299..13c8e6542a2f 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -1175,7 +1175,10 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
 				      "alias for %d\n",
 				      header->number,
 				      header->hdr.a.OriginalSample);
-    
+
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	munge_int32 (header->number, &alias_hdr[0], 2);
 	munge_int32 (header->hdr.a.OriginalSample, &alias_hdr[2], 2);
 	munge_int32 (*((unsigned int *)&header->hdr.a.sampleStartOffset),
@@ -1206,6 +1209,9 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
 	int num_samples;
 	unsigned char *msample_hdr;
 
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	msample_hdr = kmalloc(WF_MSAMPLE_BYTES, GFP_KERNEL);
 	if (! msample_hdr)
 		return -ENOMEM;
-- 
2.25.1

