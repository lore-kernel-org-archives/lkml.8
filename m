Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D2220707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgHZPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:11:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:9758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHZPLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:20 -0400
IronPort-SDR: U6i8ww8LjXvmxgl33tJoCbBbEw8aPVKEPtv7KL29laRvUxSYcrko+prR6u9MZHPg44HQ4o+Evt
 Q3guL6oGVY2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153729679"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153729679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:18 -0700
IronPort-SDR: n8Fk4Q9CKxbnEO0LAV3Eh96gjzazs6sn7KtHO5iaKfDhiWwuHYSsPVumYhsKWlAwH/48vu/D9A
 lAiAuUByOwqw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299505077"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:16 -0700
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826101637.GC4965@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e66a9e95-7846-f353-8ebd-e35458c79797@linux.intel.com>
Date:   Wed, 26 Aug 2020 09:54:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826101637.GC4965@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> One possible objection is that this code could have been handled with
>> regmap-sdw.c. However this is a new spec addition not handled by every
>> SoundWire 1.1 and non-SDCA device, so there's no reason to load code
>> that will never be used.
> 
>> Also in practice it's extremely unlikely that CONFIG_REGMAP would not
>> be selected with CONFIG_REGMAP_MBQ selected. However there's no
>> functional dependency between the two modules so they can be selected
>> separately.
> 
> The other thing I'm wondering here is about compatibility - is this
> something we can enumerate at runtime and if so couldn't this be done
> more like how we handle the various I2C and SMBus variants so the driver
> just says it wants a SoundWire regmap and then based on the capabilities
> of the device and the controller the regmap decides if it can use MBQ or
> not on the current system?

An SDCA device will have two regmaps, one for 'regular' registers and 
one for MBQ-based ones. There is no known case where a codec can use 
ONLY an MBQ-based regmap.

It's different from I2C/SMB since the bus is really identical, the 
interface is the same, the difference is really the sequence by which 
you access registers allocated to SDCA and how the address is constructed.

Each SDCA control will be described with a firmware property, and based 
on their range and purpose you would know how if the control is a 
regular one or an MBQ-based one. Alternatively, the driver might 
hard-code things and define addresses for each.

Does this answer to your question?

