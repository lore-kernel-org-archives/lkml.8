Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96ABC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F35220774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCRP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:28:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:57410 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgCRP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:28:21 -0400
IronPort-SDR: Z+OfYx5ruojyuP59E5vMSymw1PS8+LgVfFZSrz5VZYU7hgL21zTbHmHJkslQuF0enWE5G0Q8PD
 vBoI1nvzH0lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:28:20 -0700
IronPort-SDR: g95JJKA7+7TG6WKZl/SiDDh/sHxUBdTx6vEJqHelvUjXtuVFfJIGubIXgY3vru0vjeqq0pZ4xU
 JHQ6NHbONJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="417985182"
Received: from nali1-mobl3.amr.corp.intel.com (HELO [10.255.33.194]) ([10.255.33.194])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 08:28:19 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Keyon Jie <yang.jie@linux.intel.com>
Cc:     cezary.rojewski@intel.com, alsa-devel@alsa-project.org,
        curtis@malainey.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
Date:   Wed, 18 Mar 2020 10:13:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318123930.GA2433@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
>>> some sound-related trouble: after boot, the sound works fine -- but once I
>>> suspend and resume my broadwell-based XPS13, I need to switch to headphone
>>> and back to speaker to hear something. But what I hear isn't music but
>>> garbled output.

It's my understanding that the use of the haswell driver is opt-in for 
Dell XPS13 9343. When we run the SOF driver on this device, we have to 
explicitly bypass an ACPI quirk that forces HDAudio to be used:

https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd

Have you tried to run in plain vanilla HDAudio mode?

