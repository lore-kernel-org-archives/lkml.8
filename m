Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6198206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgF2TYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:22494 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731371AbgF2TYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:11 -0400
IronPort-SDR: vrX4EslMBie7dZAu7oLsWfSLBSx4meYM3BFSP8WQRYnABnuFbqCksEp3vLsHZoySWn9csSevmS
 rfwYJgucNqkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144130202"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="144130202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 03:02:35 -0700
IronPort-SDR: iMh8vArVq5oKcUs1FZ2st6Xi9hqb9Zp7LxQRW3BbWxsw9h9DLQhK2MvqWpzKdyJo8GaJrgTQm+
 +TD8xya/8LSw==
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="424765568"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.138.39]) ([10.249.138.39])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 03:02:32 -0700
Subject: Re: [PATCH v4 1/3] ALSA: compress: document the compress audio state
 machine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20200629075002.11436-1-vkoul@kernel.org>
 <20200629075002.11436-2-vkoul@kernel.org>
 <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
 <20200629093429.GA2599@vkoul-mobl>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <3a43467a-5432-a3ef-2250-2ac1054539d0@linux.intel.com>
Date:   Mon, 29 Jun 2020 12:02:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629093429.GA2599@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2020 11:34 AM, Vinod Koul wrote:
 >
 > Not sure, this is not in the version I posted, arrow is from setup ->
 > prepare. See 
https://lore.kernel.org/alsa-devel/20200629075002.11436-2-vkoul@kernel.org/
 >
 > I don't know how it got reversed in your version, maybe the MUA messed
 > up??
 >
Ah... I must have edited it myself when preparing edited version, sorry 
for noise ;)


 > a compr_write() moves from SETUP -> PREPARE. Fixing that above looks
 > better version of mine..
Yes, I feel it is easier to understand, A redirect confused me for a 
short bit when I first looked at graph and it can be easily avoided.
