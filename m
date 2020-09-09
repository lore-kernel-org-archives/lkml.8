Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF17C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A280821919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgIIRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:16:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:28962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgIIP2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:22 -0400
IronPort-SDR: u/qbi1gTMXwhiA5qBdPXMMgfTHw567dAAkns7X+4bDhXx6pe5JNKHXH9U6JyrwTQHFbDQq5NKi
 i/s9iXQLJPug==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155728553"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155728553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 06:49:26 -0700
IronPort-SDR: y782X0eff+IGeTeKdlXJWyejH8ArzkbdbpXRdce83ifEs2ysMjfkaoanYmSAds9BB+zVYm7HDX
 nG4T8f6lNeww==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505456868"
Received: from rsetyawa-mobl1.amr.corp.intel.com (HELO [10.212.20.145]) ([10.212.20.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 06:49:25 -0700
Subject: Re: [PATCH -next] soundwire: intel: Remove ununsed function
To:     YueHaibing <yuehaibing@huawei.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200909131531.31380-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <14a09132-d0ed-7129-73df-cbeb3154429b@linux.intel.com>
Date:   Wed, 9 Sep 2020 08:46:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909131531.31380-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/20 8:15 AM, YueHaibing wrote:
> If CONFIG_PM is not set, build warns:
> 
> drivers/soundwire/intel.c:488:12: warning: 'intel_link_power_down' defined but not used [-Wunused-function]
> 
> Move this to #ifdef block.

Yes, thanks for the report, it's a valid issue, but maybe the fix is to 
add __maybe_unused more consistently and remove the CONFIG_PM dependency.

Vinod, what would you prefer?

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e047910d73f5..7640308174ab 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1540,8 +1540,6 @@ int intel_master_process_wakeen_event(struct 
platform_device *pdev)
   * PM calls
   */

-#ifdef CONFIG_PM
-
  static int __maybe_unused intel_suspend(struct device *dev)
  {
         struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1596,7 +1594,7 @@ static int __maybe_unused intel_suspend(struct 
device *dev)
         return 0;
  }

-static int intel_suspend_runtime(struct device *dev)
+static int __maybe_unused intel_suspend_runtime(struct device *dev)
  {
         struct sdw_cdns *cdns = dev_get_drvdata(dev);
         struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1751,7 +1749,7 @@ static int __maybe_unused intel_resume(struct 
device *dev)
         return ret;
  }

-static int intel_resume_runtime(struct device *dev)
+static int __maybe_unused intel_resume_runtime(struct device *dev)
  {
         struct sdw_cdns *cdns = dev_get_drvdata(dev);
         struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1924,8 +1922,6 @@ static int intel_resume_runtime(struct device *dev)
         return ret;
  }

-#endif
-
  static const struct dev_pm_ops intel_pm = {
         SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
         SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, 
NULL)


