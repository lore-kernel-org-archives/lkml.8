Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97D3207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgG3Im0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:42:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:22435 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgG3ImZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:42:25 -0400
IronPort-SDR: BzDpNO6gTel4a35VeckUe+t2OG21m8QAe6pkXwk4CB8IPp5h/gCI3/IFn20PQdgUtvjMWqAHnX
 dA8JfFCm9Zhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236425878"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="236425878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:42:24 -0700
IronPort-SDR: gfGnHeCWPOOlv1nD9N0LEMMmXHvH6bSvctZ/dB+RjNTm93upa/7TLq4DBfp/EijlZQjUR0oYEj
 JBE5tQqcRJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="290811088"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2020 01:42:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k148p-004snj-PM; Thu, 30 Jul 2020 11:42:19 +0300
Date:   Thu, 30 Jul 2020 11:42:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Add period size constraint on strago
 board
Message-ID: <20200730084219.GF3703480@smile.fi.intel.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
 <1596096815-32043-3-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596096815-32043-3-git-send-email-brent.lu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:13:35PM +0800, Brent Lu wrote:
> From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> 
> The CRAS server does not set the period size in hw_param so ALSA will
> calculate a value for period size which is based on the buffer size
> and other parameters. The value may not always be aligned with Atom's
> dsp design so a constraint is added to make sure the board always has
> a good value.
> 
> Cyan uses chtmax98090 and others(banon, celes, edgar, kefka...) use
> rt5650.

Actually one more comment here.
Can you split per machine driver?

>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
>  sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-

-- 
With Best Regards,
Andy Shevchenko


