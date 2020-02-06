Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7AF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFNkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:40:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:18067 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbgBFNkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:40:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 05:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="311694170"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2020 05:40:17 -0800
Date:   Thu, 6 Feb 2020 15:40:17 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     kbuild test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.de>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: sound/pci/hda/patch_hdmi.c:1086: undefined reference to
 `snd_hda_get_num_devices'
In-Reply-To: <202002061809.r3UYBZGx%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.2002061531350.2957@eliteleevi.tm.intel.com>
References: <202002061809.r3UYBZGx%lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thu, 6 Feb 2020, kbuild test robot wrote:

>    ld: sound/pci/hda/patch_hdmi.o: in function `intel_not_share_assigned_cvt':
> >> sound/pci/hda/patch_hdmi.c:1086: undefined reference to `snd_hda_get_num_devices'
> >> ld: sound/pci/hda/patch_hdmi.c:1098: undefined reference to `snd_hda_get_dev_select'
> >> ld: sound/pci/hda/patch_hdmi.c:1099: undefined reference to `snd_hda_set_dev_select'

hmm, this seems similar case as the previous one today w.r.t 
hda_dsp_common.c:76. Patch_hdmi.c is built-in while snd-hda is a module. 
Maybe we need to just drop the dependency from the ASoC board files to 
SND_HDA_CODEC_HDMI. We don't have one for SND_HDA_CODEC either.

Br, Kai
