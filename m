Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27FAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF4246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB1VqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:46:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:59612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB1VqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:46:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 13:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="411532236"
Received: from spackerm-mobl2.amr.corp.intel.com (HELO [10.255.231.253]) ([10.255.231.253])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 13:45:57 -0800
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
 <20200228073227.GA2898712@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <90417477-c8ba-22e0-de4f-07ef10fc014a@linux.intel.com>
Date:   Fri, 28 Feb 2020 09:53:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228073227.GA2898712@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> As you are adding new sysfs files here, is there a follow-on patch for
> Documentation/ABI/ updates?

Yes that's the plan. The original patches for sysfs were submitted as an 
RFC:

https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/148699.html

Most of the sysfs entries would mirror the value of _DSD properties, but 
that's still very useful to check platform integration issues. Some of 
the DSDT blocks are overwritten at run-time depending on BIOS menu 
selections, so it's impossible to figure out what the firmware exposes 
to the OS just by looking at the DSDT contents extracted with acpica tools.


