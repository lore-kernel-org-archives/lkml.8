Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AD52173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEHOuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:50:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:54546 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEHOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:50:18 -0400
IronPort-SDR: qHXIFd5na43IW3Wt8mTzKyOpucPbM1rDWcYz0L/11DuoVT5o5iJBsP9k9HLlhgd+DONgrNq7I8
 EikTUwWZ20lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 07:50:17 -0700
IronPort-SDR: XN15M4RZFAHyjTWmo7AtUbiSDyZx81DyK5bKtQiRsCXpzx/sNnNOgIdU1OG0jfg4rvR24YVvk2
 JtBq1K2Ceo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="462307831"
Received: from cstrong-mobl6.amr.corp.intel.com (HELO [10.254.74.61]) ([10.254.74.61])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2020 07:50:16 -0700
Subject: Re: [PATCH] ASoC: Intel: Boards: Support headset button function for
 nau88l25max and nau88l25ssm
To:     Radoslaw Biernacki <rad@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Chinyue Chen <chinyue@chromium.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Benson Leung <bleung@chromium.org>,
        Alex Levin <levinale@google.com>
References: <20200507220332.24686-1-rad@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <39aed974-ee2c-a0e7-9228-304cce275289@linux.intel.com>
Date:   Fri, 8 May 2020 09:45:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507220332.24686-1-rad@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 5:03 PM, Radoslaw Biernacki wrote:
> Map the buttons from the Android reference headset to
> KEY_PLAYPAUSE, KEY_VOICECOMMAND, KEY_VOLUMEUP, and KEY_VOLUMEDOWN.
> KEY_PLAYPAUSE is used instead of KEY_MEDIA for BTN_0 as it is more
> logical and have much broader userspace support. Like Chrome OS
> use it to play/pause of video and audio. KEY_PLAYPAUSE is also
> supported by Android (USB headset spec requires KEY_PLAYPAUSE
> for BTN_0.)
> https://source.android.com/devices/accessories/headset/usb-headset-spec
> 
> Signed-off-by: Chinyue Chen <chinyue@chromium.org>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
