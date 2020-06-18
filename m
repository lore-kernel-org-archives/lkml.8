Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A2FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB51120FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgFRO4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:56:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:8231 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbgFRO4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:56:31 -0400
IronPort-SDR: /GteYJRBRoJQ8ntY1U7Xgq0XOMv2CHznKoN7+sjgNUCVaY2Eeo5LdzXqWNJPXfzyVu7h6jCGZs
 xVGTIGCJxqCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="204091029"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="204091029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:56:30 -0700
IronPort-SDR: WRstlpxjt1sMiABU5OkC+WJgszXlBw0nMBk48hg8Q7MDBFZqPvdQEIFlqjkyo1iJjLy/U5lIEu
 9HqF1/d3cd7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="477268245"
Received: from richard2-mobl.amr.corp.intel.com (HELO [10.254.109.110]) ([10.254.109.110])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 07:56:29 -0700
Subject: Re: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-55-sashal@kernel.org>
 <20200618110126.GC5789@sirena.org.uk>
 <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c966e694-9ec8-3401-7d7c-fae5ca5fcce4@linux.intel.com>
Date:   Thu, 18 Jun 2020 08:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/20 6:44 AM, Daniel Baluta wrote:
> On 6/18/20 2:01 PM, Mark Brown wrote:
>> On Wed, Jun 17, 2020 at 09:02:32PM -0400, Sasha Levin wrote:
>>> From: Daniel Baluta <daniel.baluta@nxp.com>
>>>
>>> [ Upstream commit c26fde3b15ed41f5f452f1da727795f787833287 ]
>>>
>>> This provides a better separation between runtime and PM sleep
>>> callbacks.
>>>
>>> Only do nothing if given runtime flag is set and calback is not set.
>>>
>>> With the current implementation, if PM sleep callback is set but runtime
>>> callback is not set then at runtime resume we reload the firmware even
>>> if we do not support runtime resume callback.
>> This doesn't look like a bugfix, just an optimization?
> 
> Indeed can be seen as an optimization, but it does unexpected things 
> which can cause trouble
> 
> and weird behavior for people not familiar with the matter.
> 
> For example, as explained in the commit message if you only provide
> 
> System PM handler but not runtime PM handler, then the DSP will be resetted
> 
> even if this is not the intention.

I think it's a bug fix for Intel legacy platforms (Baytrail, Broadwell) 
where runtime_pm isn't supported. However the additional fixes for 
system suspend/resume were only provided for 5.8, so this patch in 
isolation will not do much for those platforms. Put differently, even if 
this patch is applied to 5.7 suspend/resume would still not work for 
Baytrail/Broadwell.
Daniel, your call if you need this for i.MX?
