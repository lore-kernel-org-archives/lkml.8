Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B862073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgBMLVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:21:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:46688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbgBMLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:21:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D908B198;
        Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: usb-audio: Parse source ID of UAC2 effect unit
Date:   Thu, 13 Feb 2020 12:20:59 +0100
Message-Id: <20200213112059.18745-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213112059.18745-1-tiwai@suse.de>
References: <20200213112059.18745-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During parsing the input source, we currently cut off at the Effect
Unit node without parsing further its source id.  It's no big problem,
so far, but it should be more consistent to parse it properly.

This patch adds the recursive parsing in parse_term_effect_unit().
It doesn't add anything in the audio unit parser itself, and the
effect unit itself is still skipped, though.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206147
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 81b2db0edd5f..56d0878e4999 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -901,6 +901,12 @@ static int parse_term_effect_unit(struct mixer_build *state,
 				  struct usb_audio_term *term,
 				  void *p1, int id)
 {
+	struct uac2_effect_unit_descriptor *d = p1;
+	int err;
+
+	err = __check_input_term(state, d->bSourceID, term);
+	if (err < 0)
+		return err;
 	term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
 	term->id = id;
 	return 0;
-- 
2.16.4

