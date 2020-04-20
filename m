Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAADAC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4DA206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387531;
	bh=tcAAzz3EXEsisJM9NOt1ZeTYwQanWfluG2iG9Gwhh/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3n5IiYovH8hjgVDcxJxNtl5UUkFRK2cFK4//yJyG+56CTQm0hJBpT0i9PnrGj7Au
	 E7++UJH4+BtriuSLHxtubOlJ6xyeN8lcJ/+DnN8JbeJSLROgK7nOVhBfBt6yQDcjXd
	 6nN4hltETR1AjEl7PlQ/ZTQY4alF2PHnz1kIFqlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgDTM6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgDTMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:42:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80102070B;
        Mon, 20 Apr 2020 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386553;
        bh=tcAAzz3EXEsisJM9NOt1ZeTYwQanWfluG2iG9Gwhh/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJIagZGKzKI84QyPivPjg37fYAwgB2fbr7DPg9MhWbimpW01zVOaIOJYzP8tRcUBo
         B5+4TQ9yOeEZ2Szsg1irtElGT/xavMUXQn7a9Oc5ZhkV7ZZWeTttnPk6KSK/9pHUyC
         fuURewMGuHqujh2eAK2TONvmfGa97isvUewt0JzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 43/65] ALSA: usb-audio: Dont create jack controls for PCM terminals
Date:   Mon, 20 Apr 2020 14:38:47 +0200
Message-Id: <20200420121515.904545828@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7dc3c5a0172e6c0449502103356c3628d05bc0e0 upstream.

Some funky firmwares set the connector flag even on PCM terminals
although it doesn't make sense (and even actually the firmware doesn't
react properly!).  Let's skip creation of jack controls in such a
case.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206873
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200412081331.4742-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2088,7 +2088,8 @@ static int parse_audio_input_terminal(st
 	check_input_term(state, term_id, &iterm);
 
 	/* Check for jack detection. */
-	if (uac_v2v3_control_is_readable(bmctls, control))
+	if ((iterm.type & 0xff00) != 0x0100 &&
+	    uac_v2v3_control_is_readable(bmctls, control))
 		build_connector_control(state->mixer, &iterm, true);
 
 	return 0;
@@ -3128,7 +3129,8 @@ static int snd_usb_mixer_controls(struct
 			if (err < 0 && err != -EINVAL)
 				return err;
 
-			if (uac_v2v3_control_is_readable(le16_to_cpu(desc->bmControls),
+			if ((state.oterm.type & 0xff00) != 0x0100 &&
+			    uac_v2v3_control_is_readable(le16_to_cpu(desc->bmControls),
 							 UAC2_TE_CONNECTOR)) {
 				build_connector_control(state.mixer, &state.oterm,
 							false);
@@ -3153,7 +3155,8 @@ static int snd_usb_mixer_controls(struct
 			if (err < 0 && err != -EINVAL)
 				return err;
 
-			if (uac_v2v3_control_is_readable(le32_to_cpu(desc->bmControls),
+			if ((state.oterm.type & 0xff00) != 0x0100 &&
+			    uac_v2v3_control_is_readable(le32_to_cpu(desc->bmControls),
 							 UAC3_TE_INSERTION)) {
 				build_connector_control(state.mixer, &state.oterm,
 							false);


