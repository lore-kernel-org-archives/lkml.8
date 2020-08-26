Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE98C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F2C20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:08:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:54178 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgHZSII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:08:08 -0400
IronPort-SDR: Zwzt81QREb+pZNOgvSsYClC2sMUpayUutQN6/0yp80hUZjddiC2zRSH5VQFphg9sfeSYF1SVlD
 ApNL/Sp2lC8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136426265"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="136426265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 11:08:07 -0700
IronPort-SDR: WnoKohTSORAaoQWpjm9J7NKJnYjWHGpP4vrufmIGKIqaZtx61Svn02Fg9DHpgwNIe1yK9ZH07L
 lyuxfaYGgsHQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="474865887"
Received: from sjweber-mobl.amr.corp.intel.com (HELO [10.209.187.249]) ([10.209.187.249])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 11:08:05 -0700
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
To:     Mark Brown <broonie@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk> <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk> <s5h8se1u2or.wl-tiwai@suse.de>
 <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
 <20200826172516.GM4965@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9eb82812-436a-e94e-e7d0-28c9300e13f6@linux.intel.com>
Date:   Wed, 26 Aug 2020 13:08:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826172516.GM4965@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> If you want to change this you'd need to change it over the whole
> subsystem (if not other subsystems), including the places where the
> value is used.

ok, I'll drop this patch for now, keep -ENOTSUPP and deal with this 
later. The only thing I really care about for now is SoundWire MBQ 
support, this is the only thing gating SDCA contributions.

