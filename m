Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2083BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F7F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgGGPoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:44:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:24134 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:44:05 -0400
IronPort-SDR: qNRLH52Q7CIYMZlwlrY6kNU4izptDP1Xu0DWjHxow5x4wlCoqxEFOeJHrmk7IrDjI76NHz3Ckb
 Ea+fTxi6A5ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127715191"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="127715191"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 08:44:04 -0700
IronPort-SDR: lVEFuGGebMOIIhryZWswJgUhO6QPYgQQKNHQ6D1CQNLR5J9ErFLjYPQgXVNCvIqG4PsUYgfDjV
 TEQMFl+6Er/Q==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="305704711"
Received: from stortizs-mobl1.amr.corp.intel.com (HELO [10.254.109.228]) ([10.254.109.228])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 08:44:03 -0700
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101915.GC4870@sirena.org.uk> <20200707103735.GG3500@dell>
 <20200707104017.GG4870@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <91692dac-1723-bec8-a6cb-88dadb9bf424@linux.intel.com>
Date:   Tue, 7 Jul 2020 10:44:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707104017.GG4870@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 5:40 AM, Mark Brown wrote:
> On Tue, Jul 07, 2020 at 11:37:35AM +0100, Lee Jones wrote:
> 
>> Some of these issues have been present for years.  It's quite the
>> coincidence that we both submitted these this week!
> 
> I'm guessing you've both been inspired by the 0day bot turning W=1
> warnings on without having first done a cleanup run :/

Yep, I was tired of seeing my email polluted with trivial problems last 
week, as well as seeing dead code that reviewers miss but tools don't.

Lee, do you mind if I merge your v2 series and my own v2, and then 
resubmit what hasn't been merged by Mark?
