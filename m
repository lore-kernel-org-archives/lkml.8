Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01571C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128C2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgBMLVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:21:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMLVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:21:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70159B18D;
        Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ALSA: usb-audio: UAC2 effect unit parsing
Date:   Thu, 13 Feb 2020 12:20:57 +0100
Message-Id: <20200213112059.18745-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

UAC2 Effect Unit needs different parsing from Processing Unit and co,
and this patch set implements the partial support for that.

As it's the fix on top of the latest USB-audio fix, I'd like to apply
through sound git tree.  So please review and ack if USB header change
is OK.


thanks,

Takashi

===

Takashi Iwai (2):
  usb: audio-v2: Add uac2_effect_unit_descriptor definition
  ALSA: usb-audio: Parse source ID of UAC2 effect unit

 include/linux/usb/audio-v2.h | 12 ++++++++++++
 sound/usb/mixer.c            |  6 ++++++
 2 files changed, 18 insertions(+)

-- 
2.16.4

