Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6BA2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456156;
	bh=XHtYOKJSfUA300e/p5ysfFZ8eKeqkxoTiM/IQ6Hezx8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vgeiMZ7r4zab/1POmOP122wUihRfnPcW/yR5wo3FP6d60qEaQD5k57JyS9gWC3+o4
	 TTi7LJ/7bVwoNqsm8fuawU1wKEJyLSLZpf2qVqLbrrrP6eXzmB+evxigSa0KBHFX0u
	 r2wCqC+afGKR6Vwg8y+XBu1o1aIIqLSkB+mTz1EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgF2Sma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgF2Sl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:26 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B3C23D67;
        Mon, 29 Jun 2020 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593438469;
        bh=XHtYOKJSfUA300e/p5ysfFZ8eKeqkxoTiM/IQ6Hezx8=;
        h=From:To:Cc:Subject:Date:From;
        b=oPeNk1jpTRqSnMK+lKozomFejz2j5aQRcZ4EeBGRNig7FvO3D2Q9ZHLKqOtHH4upq
         9gTDalb6sl47L730CJbjlYTLIbUJ3ms6ulS2HEm64suB8CgUqMzhpA3cEJ1wWKckTz
         ZwF6yy5a5Fa2Gpc3DWLn0g21xIcI13O1tC6l6urI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] ALSA: compress: Document stream states and fix gapless SM
Date:   Mon, 29 Jun 2020 19:17:34 +0530
Message-Id: <20200629134737.105993-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srini found issue with gapless implementation which prompted to look deeper
into SM for compressed stream.

So documenting SM was first step, so first two patches add that. Last patch
fixes the issue by keeping track on partial_drain and then moving state to
'running' in snd_compr_drain_notify() for partial_drain case on success.
While at it, noticed snd_compr_drain_notify() is lockless state change, so
fixed that as well.

I have tested this on Dragon board RB3, compressed audio works out of the
box on that platform and Srini will send driver and fcplay patches for
gapless soon.

Changes in v5:
 - Update SM diagram as suggested by Amadeusz

Changes in v4:
 - Add review tag by Charles
 - fix the lock deadlock pointed by Charles

Changes in v3:
 - Add pause->stop->free transition
 - Add setup->free transition
 - remove running->free as that goes thru stop

Changes in v2:
 - Added tested tag by Srini
 - Update compress SM with Free state and compr_stop() transitions

Vinod Koul (3):
  ALSA: compress: document the compress audio state machine
  ALSA: compress: document the compress gapless audio state machine
  ALSA: compress: fix partial_drain completion state

 .../sound/designs/compress-offload.rst        | 83 +++++++++++++++++++
 include/sound/compress_driver.h               | 10 ++-
 sound/core/compress_offload.c                 |  4 +
 3 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.26.2

