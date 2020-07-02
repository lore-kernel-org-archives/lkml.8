Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A532C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3DF207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGBTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:03:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:13302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgGBTDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:03:24 -0400
IronPort-SDR: AW6Bes3x7083rEVeAZVyLpYb6XnQnVhP9paxJMAm1htH+7s7neeUWVO73+agqPwa4iUAaRJp6J
 hlqupXwpelaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="165054792"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="165054792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:03:23 -0700
IronPort-SDR: ITwhDjjC2EW5TkDGnDY5YhDJPnao/dKwEHsS0zhlA07dwxJxe7RUuCj3idyidbNsnHlTLiFRvr
 Qic3MYf842Mg==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="295989015"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO [10.254.75.219]) ([10.254.75.219])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:03:22 -0700
Subject: Re: [PATCH 3/6] ASoC: fsl: fsl-asoc-card: fix kernel-doc
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:FREESCALE SOC SOUND DRIVERS" 
        <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-4-pierre-louis.bossart@linux.intel.com>
 <20200702184727.GD23935@Asurada-Nvidia>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7c6fac59-562c-d3b5-8eea-3e0f450cee6b@linux.intel.com>
Date:   Thu, 2 Jul 2020 14:03:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702184727.GD23935@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/20 1:47 PM, Nicolin Chen wrote:
> On Thu, Jul 02, 2020 at 12:22:24PM -0500, Pierre-Louis Bossart wrote:
>> Fix W=1 warnings. Kernel-doc syntax was not properly used.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/fsl/fsl-asoc-card.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> 
>>   /**
>> - * Freescale Generic ASOC card private data
>> + * struct fsl_asoc_card_priv - struct Freescale Generic ASOC card private data
> 
> Just a nit, can you drop the "struct" before "Freescale"?
> Other parts of your changes don't really add this word.

will do, thanks for spotting this.

> Otherwise,
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
