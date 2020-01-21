Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795142253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAURbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:31:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:24893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAURbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:31:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 09:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="307265038"
Received: from kfang1-mobl.amr.corp.intel.com (HELO [10.251.147.146]) ([10.251.147.146])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 09:31:32 -0800
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
 <20200118071257.GY2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73907607-0763-576d-b24e-4773dfb15f0b@linux.intel.com>
Date:   Tue, 21 Jan 2020 11:31:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200118071257.GY2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> A rename away from probe will certainly be very helpful as
> you would also agree that terms 'probe' and 'remove' have a very
> special meaning in kernel, so let us avoid these

ok, so would the following be ok with you?

/**
  * struct sdw_md_driver - SoundWire 'Master Device' driver
  *
  * @init: allocations and initializations (hardware may not be enabled yet)
  * @startup: initialization handled after the hardware is enabled, all
  * clock/power dependencies are available
  * @shutdown: cleanups before hardware is disabled (optional)
  * @exit: free all remaining resources
  * @autonomous_clock_stop_enable: enable/disable driver control while
  * in clock-stop mode, typically in always-on/D0ix modes. When the driver
  * yields control, another entity in the system (typically firmware
  * running on an always-on microprocessor) is responsible to tracking
  * Slave-initiated wakes
  */
struct sdw_md_driver {
	int (*init)(struct sdw_master_device *md, void *link_ctx);
	int (*startup)(struct sdw_master_device *md);
	int (*shutdown)(struct sdw_master_device *md);
	int (*exit)(struct sdw_master_device *md);
	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
					    bool state);
};
