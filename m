Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F45520786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHRLq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:46:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:58488 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgHRLq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:46:28 -0400
IronPort-SDR: aMCHrtT7mIGUSXnqPHP7oXl9uWwXPKBkUx0aVH2MJjz7m6ow2wbY7EwZQC4BavZaE9Ft60pdnl
 8QeSJSwjMMcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142711297"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="142711297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 04:46:27 -0700
IronPort-SDR: j87VtALN7VSQc97EPgjRULRXw0y2yHJyT8gk7363BfV7YVOW5Fq/nlRvuUBILX0Rcgi5NKLmi0
 7Hd9QSeTXagA==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471777754"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 04:46:25 -0700
Date:   Tue, 18 Aug 2020 14:45:22 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Brent Lu <brent.lu@intel.com>
cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?ISO-8859-2?Q?Amadeusz_S=B3awi=F1ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: hdac_hdmi: support 'ELD' mixer
In-Reply-To: <20200818004413.12852-1-brent.lu@intel.com>
Message-ID: <alpine.DEB.2.22.394.2008181311430.3186@eliteleevi.tm.intel.com>
References: <20200814083436.19845-1-brent.lu@intel.com> <20200818004413.12852-1-brent.lu@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

a general comment first. We are trying to move development to patch_hdmi, 
but given we still have platforms using hdac_hdmi, this patch seems like a 
useful addition.

On Tue, 18 Aug 2020, Brent Lu wrote:

> Add an binary mixer 'ELD' to each HDMI PCM device so user space
> could read the ELD data of external HDMI display.

Minor spelling fixes:
"Add a binary mixer"
"so user space can read"

> +static int hdac_hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
[...]
> +	list_for_each_entry(port, &pcm->port_list, head) {
> +		eld = &port->eld;
> +
[...]
> +		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
> +		       eld->eld_size);
> +		break;
> +	}

This is a bit iffy part. If same PCM is connected to multiple receivers, 
you return ELD data for the first one and ignore the rest. OTOH, this is 
inline with comment in hdac_hdmi_get_port_from_cvt() in that this 
pcm-to-many routing is not really supported by the driver now. But
jack status reporting is done a port basis, not per PCM/CVTs, so this is 
not fully aligned.

Hmm. Given the proposed patch is aligned with the user-space interface 
exposed by patch_hdmi.c, I'm ok to go with this. Can you add an explicit 
comment to explain what is happening above?

Br, Kai
