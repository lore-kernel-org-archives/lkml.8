Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E8C5ED2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C218520801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813201;
	bh=zF8WyHHyNDWJs5RpuKJQzBGkfwEfo+xK6Oui84XK6xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2WssiEAk9wxOSp4jhAl5AyKJsCMZRl7Guz6r70QWMZk7ho4Kl/ZWHlxDzufFea3w
	 /Ku5XQiULWNdUaaCdtZ5tnhVPs70X5nqUT/z5ACij2YrnmIfz3Kc79kUNFzU9gxWzS
	 olQpbjWnrPkJ8gjPhNCm611PbhGonvMkqOnlfitM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgB0OSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389861AbgB0OSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:18:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F21F20801;
        Thu, 27 Feb 2020 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813103;
        bh=zF8WyHHyNDWJs5RpuKJQzBGkfwEfo+xK6Oui84XK6xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiF3QRhnUvYZaYV+Wqb8p/KO2gfVtbwRCEW3rb092KZRzNM/3AkK1uHUx70sBqBUi
         UAISOJvRgJaL1wu9UckQmTV9xpMrNQ0/TIcefjIU6mFS/7TfuUoknnQSPEdxzKVoCR
         gk6A3qPQwWzA2olmLrrTnfywWZSm30ch8RzOFwYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+576cc007eb9f2c968200@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 137/150] ALSA: rawmidi: Avoid bit fields for state flags
Date:   Thu, 27 Feb 2020 14:37:54 +0100
Message-Id: <20200227132252.547255332@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit dfa9a5efe8b932a84b3b319250aa3ac60c20f876 upstream.

The rawmidi state flags (opened, append, active_sensing) are stored in
bit fields that can be potentially racy when concurrently accessed
without any locks.  Although the current code should be fine, there is
also no any real benefit by keeping the bitfields for this kind of
short number of members.

This patch changes those bit fields flags to the simple bool fields.
There should be no size increase of the snd_rawmidi_substream by this
change.

Reported-by: syzbot+576cc007eb9f2c968200@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20200214111316.26939-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/rawmidi.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -77,9 +77,9 @@ struct snd_rawmidi_substream {
 	struct list_head list;		/* list of all substream for given stream */
 	int stream;			/* direction */
 	int number;			/* substream number */
-	unsigned int opened: 1,		/* open flag */
-		     append: 1,		/* append flag (merge more streams) */
-		     active_sensing: 1; /* send active sensing when close */
+	bool opened;			/* open flag */
+	bool append;			/* append flag (merge more streams) */
+	bool active_sensing;		/* send active sensing when close */
 	int use_count;			/* use counter (for output) */
 	size_t bytes;
 	struct snd_rawmidi *rmidi;


