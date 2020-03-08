Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78209C10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D93206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCHDOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 22:14:21 -0500
Received: from mail.manjaro.org ([176.9.38.148]:57726 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCHDOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:14:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 8509C3960EFB;
        Sun,  8 Mar 2020 04:14:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D4ahqBaiLqYL; Sun,  8 Mar 2020 04:14:18 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RFC PATCH 0/1] Use native gpiolib inversion for jack gpios
Date:   Sun,  8 Mar 2020 04:13:54 +0100
Message-Id: <20200308031355.1149173-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the logic used for jack gpio state inversion to
utilize gpiolib inversion.

Previously the gpio active state would not correspond to the plugged-in
state of the jack. Since the active state of a gpio is usually defined by
its purpose in a specific application I'd expect the active state to
represent the jacks plug status.

However, judging by the users [1], [2] of snd_soc_jack_add_gpiods the
ACPI tables of some devices seem to indicate the "wrong" polarity for
their jack detect gpios.
I'm not entirely sure how to deal with those devices. At the moment I'd
vote for inverting the gpio active level again
(via gpiod_toggle_active_low) inside snd_soc_jack_add_gpios if
gpio->gpiod_dev != NULL and gpio->invert is set.

I'm not entirely sure about [3] either. In my opinion removing invert = 1
from ams_delta_hook_switch_gpios and adding GPIO_ACTIVE_LOW to the flags
of hook_switch in [4] would be the right move here.

What are your thoughts on this?


Best regards,

Tobias

[1] /sound/soc/intel/boards/byt-max98090.c
[2] /sound/soc/intel/boards/cht_bsw_max98090_ti.c
[3] /sound/soc/ti/ams-delta.c
[4] /arch/arm/mach-omap1/board-ams-delta.c

Tobias Schramm (1):
  ASoC: jack: use gpiolib inversion flag for inverted gpios

 sound/soc/soc-jack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.24.1

