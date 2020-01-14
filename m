Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2167C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8FA207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgANPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:44:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:44:17 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1irOMW-0004SH-W0; Tue, 14 Jan 2020 15:44:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda - fix out of bounds read on spec->smux_paths
Date:   Tue, 14 Jan 2020 15:44:12 +0000
Message-Id: <20200114154412.365395-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is possible for the call to snd_hda_get_num_conns to fail and return
a negative error code that gets assigned to num_conns. In that specific
case, the check of very large values of val against num_conns will not
fail the -EINVAL check and later on an out of bounds array read on
spec->smux_paths will occur.  Fix this by sanity checking for an error
return from the call to snd_hda_get_num_conns.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 272f3ea31776 ("ALSA: hda - Add SPDIF mux control to AD codec auto-parser")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_analog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 88c46b051d14..399561369495 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -756,9 +756,11 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	struct nid_path *path;
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = snd_hda_get_num_conns(codec, 0x0b);
 
-	if (val >= num_conns)
+	if (num_conns < 0)
+		return num_conns;
+	if (val >= num_conns + 1)
 		return -EINVAL;
 	if (spec->cur_smux == val)
 		return 0;
-- 
2.24.0

