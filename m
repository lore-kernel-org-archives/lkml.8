Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8236FC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608BC208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgD3XY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:24:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:45823 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD3XY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 19:24:56 -0400
IronPort-SDR: wTVBduigOOVB0pZDrPe1jz28U8SmLa7yqs+lMt7ZCu/SEqEDQ+M00F5BYUkCJCJOjSFROKlQFS
 KA+J+kJ2Usyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 16:24:55 -0700
IronPort-SDR: 8Ndi1Xo18oo7OwAtPFeXY5jAmHkUsD+Bs9gHkDbjURuHQLpaIR8F8ZBuEH+qdjEGnoe4vQu16o
 JlihN8EVxJwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="283029943"
Received: from cctang1x-win8.gar.corp.intel.com ([10.251.149.196])
  by fmsmga004.fm.intel.com with ESMTP; 30 Apr 2020 16:24:55 -0700
Message-ID: <a557561fef13e030c3b64eec62e3fd5c2e86e6d5.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Update correct LED status at the first time
 usage of update_mute_led()
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Apr 2020 16:24:55 -0700
In-Reply-To: <20200430091139.7003-1-kai.heng.feng@canonical.com>
References: <20200430091139.7003-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-30 at 17:11 +0800, Kai-Heng Feng wrote:
> At the first time update_mute_led() gets called, if channels are
> already
> muted, the temp value equals to led_value as 0, skipping the
> following
> LED setting.
> 
> So set led_value to -1 as an uninitialized state, to update the
> correct
> LED status at first time usage.
> 
> Fixes: 5d43001ae436 ("ASoC: SOF: acpi led support for switch
> controls")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

LGTM, thanks!

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

