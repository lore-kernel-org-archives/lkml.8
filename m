Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2277620735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386992;
	bh=SlExHaIgXferkf1udhtzIFSsULLAhcki2TYu07FUUoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KqNo3g/cB4A1CryExFq4jAJFF2eKiiiCg69uO/z8z0KPKhFhFeddtlp5zpjR/sf/
	 HsUrEDBJEdHJXlPIVcNypjGImrVoO1gYzUClK55QsWsVQONd2XROq8BWov/on/9Tzn
	 /9T32gX/PHEyDMNoKzvSoiqi0QbPeaUoriwDU8ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgDTMtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgDTMtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9143720736;
        Mon, 20 Apr 2020 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386982;
        bh=SlExHaIgXferkf1udhtzIFSsULLAhcki2TYu07FUUoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1JIMYzPbLJiHWcFwu/tfc1omkmlgn8VOj8071uge6lrXU7PhnjNMqJmKNgqKlTV1
         OckGlXm73KTbiUgnF5Fs+zhLi1ebRDN1dgw61gLm7mKcTW4V7ihl9wrw9Uh9ECttZL
         i0uAWmI+zuUwkfQD6rWR8o6o2bWNWKbMcjsvq3+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 18/40] ALSA: usb-audio: Dont override ignore_ctl_error value from the map
Date:   Mon, 20 Apr 2020 14:39:28 +0200
Message-Id: <20200420121459.493428044@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3507245b82b4362dc9721cbc328644905a3efa22 upstream.

The mapping table may contain also ignore_ctl_error flag for devices
that are known to behave wild.  Since this flag always writes the
card's own ignore_ctl_error flag, it overrides the value already set
by the module option, so it doesn't follow user's expectation.
Let's fix the code not to clear the flag that has been set by user.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206873
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200412081331.4742-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3104,7 +3104,7 @@ static int snd_usb_mixer_controls(struct
 		if (map->id == state.chip->usb_id) {
 			state.map = map->map;
 			state.selector_map = map->selector_map;
-			mixer->ignore_ctl_error = map->ignore_ctl_error;
+			mixer->ignore_ctl_error |= map->ignore_ctl_error;
 			break;
 		}
 	}


