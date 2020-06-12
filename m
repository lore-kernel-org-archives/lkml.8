Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93371C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767CD2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFLMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:24:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:23212 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLMY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:24:28 -0400
IronPort-SDR: v+jp0xi13MbRaSj7evNFcoCNK1OTY+lkL2v3GLQmEWr0HfTH8isk3E0iwm+6KQxoOpBfaIpkl+
 KLDotSibqMhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 05:24:28 -0700
IronPort-SDR: edLFrEi3NxAR9f/XA/1Zqf2TSrMrqLLxGG9+oW3Pj01oUUVl1GpOl4VEm+mPHVW72NRVd1LsNk
 +Q7rY9jBsIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="448284655"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2020 05:24:24 -0700
Date:   Fri, 12 Jun 2020 15:24:16 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Takashi Iwai <tiwai@suse.de>
cc:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: SOF: Intel: hda: Clear RIRB status before
 reading WP
In-Reply-To: <s5h5zbwczuk.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2006121522440.3186@eliteleevi.tm.intel.com>
References: <1591959048-15813-1-git-send-email-brent.lu@intel.com> <s5h5zbwczuk.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Brent,

On Fri, 12 Jun 2020, Takashi Iwai wrote:

> On Fri, 12 Jun 2020 12:50:48 +0200, Brent Lu wrote:
> > 
> > Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> > WP") from legacy HDA driver to fix the get response timeout issue.
> > Current SOF driver does not suffer from this issue because sync write
> > is enabled in hda_init. The issue will come back if the sync write is
> > disabled for some reason.
> > 
> > Signed-off-by: Brent Lu <brent.lu@intel.com>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

thanks, looks good now:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
