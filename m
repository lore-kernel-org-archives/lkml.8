Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B601FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805BF20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946494;
	bh=pC3hyyQkxUMnEIbm46tMZ4mv5JdI1vuRJK1PTOlTq9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lw96duawheLzug9ModsGbEp0TB2ggPQIRDC4hPRwHtZfkaysW6K4gxUx4/ngA/d6a
	 4zsc8HpCADNJR2ov/LVn5zuvX0l+ZT97hG7YyVa/ZuognAgBLDxLKaPNhmPtEASN81
	 gUDH57Oo7q4UtZRvfhNmMtJ2kLHS9XhS01T4IPmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbgFWVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387840AbgFWUe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E812064B;
        Tue, 23 Jun 2020 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944496;
        bh=pC3hyyQkxUMnEIbm46tMZ4mv5JdI1vuRJK1PTOlTq9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsmAFdZST6fSk8y4EuhCHAwOY11/59uTY3K4javzbMKVzCLlGYQzF6iQktXCgW67J
         +jwuzcmehpeFz37gIMRfXqfNvqAbatcWgIwpDIdp7PIWBraCRixsTUIDJjBkfolYzC
         408uZ4479AW1/7PLFyBZTAcuaUK07CjNZn18OxrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/206] ALSA: isa/wavefront: prevent out of bounds write in ioctl
Date:   Tue, 23 Jun 2020 21:55:41 +0200
Message-Id: <20200623195317.611614336@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0b1e4b34b2996..13c8e6542a2fc 100644
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



