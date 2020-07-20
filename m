Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E292C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0412070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263612;
	bh=McmbKFlbqMpo8IxRkVL1jd3r9+7XGe4Z3H7+HxfRZRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aY5dEQsnJXOGgivIyKXHybwNFN3hdu+KRYetL+o0DLR4+ibhwvnMr6myryU2610Yd
	 7+2Hrz7OUI6WxkX3oAY9LrfshQ76qFw7LXKvpm2ZTYyXU9STNi1rmXAIKGfeOjDjKI
	 zvS59NPeveVGW2g+IvD9dfNw2zGgm2DQzYFtwsUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgGTQqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgGTPkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:40:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1835D22CB2;
        Mon, 20 Jul 2020 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259617;
        bh=McmbKFlbqMpo8IxRkVL1jd3r9+7XGe4Z3H7+HxfRZRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4QUZu4G4J16Tjr8frhQ4IbgmxT3VAVpY95OBbXF1ZmVUBNVMOe68aLFfNRa2Cv7a
         x0x7qGX2BDEn1+0HNCuIVeUBpHWB/DBkUBB6fuGe7NAvWDyVgU+gsEPK7V9qgDEDoR
         F3KbW4w+RqTTpjSr2XgQBQ9Z2bIIToecuAS3939M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 17/86] ALSA: hda - let hs_mic be picked ahead of hp_mic
Date:   Mon, 20 Jul 2020 17:36:13 +0200
Message-Id: <20200720152754.004688793@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 6a6ca7881b1ab1c13fe0d70bae29211a65dd90de upstream.

We have a Dell AIO, there is neither internal speaker nor internal
mic, only a multi-function audio jack on it.

Users reported that after freshly installing the OS and plug
a headset to the audio jack, the headset can't output sound. I
reproduced this bug, at that moment, the Input Source is as below:
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Headphone Mic' 'Headset Mic'
  Item0: 'Headphone Mic'

That is because the patch_realtek will set this audio jack as mic_in
mode if Input Source's value is hp_mic.

If it is not fresh installing, this issue will not happen since the
systemd will run alsactl restore -f /var/lib/alsa/asound.state, this
will set the 'Input Source' according to history value.

If there is internal speaker or internal mic, this issue will not
happen since there is valid sink/source in the pulseaudio, the PA will
set the 'Input Source' according to active_port.

To fix this issue, change the parser function to let the hs_mic be
stored ahead of hp_mic.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200625083833.11264-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_auto_parser.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -76,6 +76,12 @@ static int compare_input_type(const void
 	if (a->type != b->type)
 		return (int)(a->type - b->type);
 
+	/* If has both hs_mic and hp_mic, pick the hs_mic ahead of hp_mic. */
+	if (a->is_headset_mic && b->is_headphone_mic)
+		return -1; /* don't swap */
+	else if (a->is_headphone_mic && b->is_headset_mic)
+		return 1; /* swap */
+
 	/* In case one has boost and the other one has not,
 	   pick the one with boost first. */
 	return (int)(b->has_boost_on_pin - a->has_boost_on_pin);


