Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE8C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D24E20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD3Rkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:40:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:26491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD3Rkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:40:36 -0400
IronPort-SDR: dGGOomkoSm0VZuTSRd39dh7s2BxmE9pM32WvXU5lmh35U5TmOrC5e9867OUMP+C1T/+SrNtogb
 6GrQzzkvGc8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 10:40:35 -0700
IronPort-SDR: eFPFtYx6+uB6NHAuxSoYK+WLEfrFkFcl2Zkv6ijG9Nmiygl5G67VPd/g9YBvB6oF+6M0gb43lQ
 +n5anvaS4Xqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="276592844"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2020 10:40:33 -0700
Date:   Thu, 30 Apr 2020 20:40:32 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Update correct LED status at the first time
 usage of update_mute_led()
In-Reply-To: <20200430091139.7003-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.21.2004302038390.2957@eliteleevi.tm.intel.com>
References: <20200430091139.7003-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 30 Apr 2020, Kai-Heng Feng wrote:

> At the first time update_mute_led() gets called, if channels are already
> muted, the temp value equals to led_value as 0, skipping the following
> LED setting.

thanks, looks good! 

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
