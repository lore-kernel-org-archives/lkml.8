Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A80C3F35B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0214246B8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811606;
	bh=7uaQ+xB7wlH3uFDsLYIQcjhaLBnRLr4J8dzDV5/9yM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZtQRDZNI8obkg00VuVqYvkYMLtKwtxtTx+5zVx//lF3ppLcAV6AKLT6AdZ+mSqYE8
	 PfSFF+KZgtqsHpOAT5mDINKh96sjU4EgEOEvawoUSNNGZ0KyKWMUuxLDkrdqxnOKXs
	 p3gOTBr63gmHexWAjn8DDzGgI7+A4XDxSDtxyrR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgB0NxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbgB0NxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:53:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2504924656;
        Thu, 27 Feb 2020 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811600;
        bh=7uaQ+xB7wlH3uFDsLYIQcjhaLBnRLr4J8dzDV5/9yM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf6qIQUXtPzuNddZj+jhwHSVNe3b89C3jTXmL3SulmkXMx6iC61aYDk1n1THU/PKW
         AX6rQ/uqmrRD7HFKYB2ZWhyvF/knACYn7E9gkbx6bZ5pGJpdAH3d8zUjjPhoDOQgZz
         D9/LG1dbXtG/VUhXlG5uqUh4w3uODOoEJ/HDFoeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 003/237] ALSA: hda: Use scnprintf() for printing texts for sysfs/procfs
Date:   Thu, 27 Feb 2020 14:33:37 +0100
Message-Id: <20200227132255.778177428@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 44eeb081b8630bb3ad3cd381d1ae1831463e48bb upstream.

Some code in HD-audio driver calls snprintf() in a loop and still
expects that the return value were actually written size, while
snprintf() returns the expected would-be length instead.  When the
given buffer limit were small, this leads to a buffer overflow.

Use scnprintf() for addressing those issues.  It returns the actually
written size unlike snprintf().

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200218091409.27162-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/hda/hdmi_chmap.c    |    2 +-
 sound/pci/hda/hda_codec.c |    2 +-
 sound/pci/hda/hda_eld.c   |    2 +-
 sound/pci/hda/hda_sysfs.c |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -249,7 +249,7 @@ void snd_hdac_print_channel_allocation(i
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(cea_speaker_allocation_names); i++) {
 		if (spk_alloc & (1 << i))
-			j += snprintf(buf + j, buflen - j,  " %s",
+			j += scnprintf(buf + j, buflen - j,  " %s",
 					cea_speaker_allocation_names[i]);
 	}
 	buf[j] = '\0';	/* necessary when j == 0 */
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4002,7 +4002,7 @@ void snd_print_pcm_bits(int pcm, char *b
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(bits); i++)
 		if (pcm & (AC_SUPPCM_BITS_8 << i))
-			j += snprintf(buf + j, buflen - j,  " %d", bits[i]);
+			j += scnprintf(buf + j, buflen - j,  " %d", bits[i]);
 
 	buf[j] = '\0'; /* necessary when j == 0 */
 }
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -373,7 +373,7 @@ static void hdmi_print_pcm_rates(int pcm
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(alsa_rates); i++)
 		if (pcm & (1 << i))
-			j += snprintf(buf + j, buflen - j,  " %d",
+			j += scnprintf(buf + j, buflen - j,  " %d",
 				alsa_rates[i]);
 
 	buf[j] = '\0'; /* necessary when j == 0 */
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -221,7 +221,7 @@ static ssize_t init_verbs_show(struct de
 	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->init_verbs.used; i++) {
 		struct hda_verb *v = snd_array_elem(&codec->init_verbs, i);
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"0x%02x 0x%03x 0x%04x\n",
 				v->nid, v->verb, v->param);
 	}
@@ -271,7 +271,7 @@ static ssize_t hints_show(struct device
 	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->hints.used; i++) {
 		struct hda_hint *hint = snd_array_elem(&codec->hints, i);
-		len += snprintf(buf + len, PAGE_SIZE - len,
+		len += scnprintf(buf + len, PAGE_SIZE - len,
 				"%s = %s\n", hint->key, hint->val);
 	}
 	mutex_unlock(&codec->user_mutex);


