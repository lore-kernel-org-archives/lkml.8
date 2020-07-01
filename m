Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881BC20748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbgGAQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:52:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:64226 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732602AbgGAQw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:52:29 -0400
IronPort-SDR: MPCO6wj7AqpGjq9svl24aA2Z98jFYmT39QKtMNnFfkjnc3ogEeQH2g4GhFiW6iU7zZQhmFrj94
 SC2Hfa47L3WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144812988"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144812988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:52:29 -0700
IronPort-SDR: qnLvnsx2iJjrrhrOL7t6HmOYc7ESPbyuG2xMXcBX4XmJe3r0tK9UCyP7bO5GxtEKT0zGAN9/Xw
 grdrK6OdSf3g==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="455168915"
Received: from dsapozni-mobl1.amr.corp.intel.com (HELO [10.251.16.243]) ([10.251.16.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:52:27 -0700
Subject: Re: [PATCH v2] ASoC: Intel: bxt-da7219-max98357a: support MAX98390
 speaker amp
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Amery Song <chao.song@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Naveen Manohar <naveen.m@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
References: <1593596211-28344-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <75943b1d-4f63-7532-205a-1c0d6379c7d5@linux.intel.com>
Date:   Wed, 1 Jul 2020 10:49:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593596211-28344-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/20 4:36 AM, Brent Lu wrote:
> Support MAX98390 speaker amplifier on cometlake platform. Driver now
> detects amplifier type in the probe function and installs corresponding
> controls and DAPM widgets/routes in the late_probe function.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Looks good to me know, thanks Brent

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

