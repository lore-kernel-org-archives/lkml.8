Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A01C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536DB2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBJQHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:07:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:17749 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgBJQHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:07:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 08:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226237939"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95]) ([10.251.140.95])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 08:07:48 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>, Brent Lu <brent.lu@intel.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <00ed82c4-404a-ec70-970e-56ddce9285ae@linux.intel.com>
 <CAOReqxhHfTuj6mxeX2e_ejMY8N4u+BFLfzKDgn=y5EbWLL_joA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a0aa0705-8d74-3316-13f8-8661d31e928b@linux.intel.com>
Date:   Mon, 10 Feb 2020 10:07:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOReqxhHfTuj6mxeX2e_ejMY8N4u+BFLfzKDgn=y5EbWLL_joA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 9:44 AM, Curtis Malainey wrote:
> +Jimmy Cheng-Yi Chiang <cychiang@google.com>
> 
> This error is causing pcm_open commands to fail timing requirements,
> sometimes taking +500ms to open the PCM as a result. This work around is
> required so we can meet the timing requirements. The bug is explained in
> detail here https://github.com/thesofproject/sof/issues/2124

Ah, thanks for the pointer, but this still does not tell me if it's a 
GLK-only issue or not. And if yes, there are alternate proposals 
discussed in that issue #2124, which has been idle since November 25.

What I am really worried is side effects on unrelated platforms.
