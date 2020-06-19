Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7667C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D24B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394480AbgFSQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:19:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:53537 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394574AbgFSQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:18:31 -0400
IronPort-SDR: QNsbZ/8fn86ak55tSoYVALtiqnr1YH7gkIgh99M9CvjYcvE6N9dkkU0LHqPWdHbwpmuJONmAye
 /Jk1kn2DS6rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="141277876"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="141277876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:18:30 -0700
IronPort-SDR: ZPn+sQrS3xQi+iXrTB+gfnRA8AalPx+1noM0YyA21HwCgONXv/WnAFbVTiOcscGTLkwMixmGsV
 PJG4MhCd6/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="318155770"
Received: from lewest-mobl1.amr.corp.intel.com (HELO [10.255.230.148]) ([10.255.230.148])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:18:30 -0700
Subject: Re: [PATCH 1/3] ALSA: compress: document the compress audio state
 machine
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-2-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8e322574-14bc-aaaa-5fdb-751cb8b97fff@linux.intel.com>
Date:   Fri, 19 Jun 2020 09:22:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619045449.3966868-2-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +                                        +----------+
> +                                        |          |
> +                                        |   OPEN   |
> +                                        |          |
> +                                        +----------+
> +                                             |
> +                                             |
> +                                             | compr_set_params()
> +                                             |
> +                                             V
> +                                        +----------+
> +                compr_drain_notify()    |          |
> +              +------------------------>|   SETUP  |
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_write()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |                         |          |
> +              |                         |  PREPARE |
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_start()
> +              |                              |
> +              |                              V
> +        +----------+                    +----------+     compr_pause()      +----------+
> +        |          |                    |          |----------------------->|          |
> +        |  DRAIN   |<-------------------|  RUNNING |                        |  PAUSE   |
> +        |          |                    |          |<-----------------------|          |
> +        +----------+                    +----------+     compr_resume()     +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_free()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |     compr_free()        |          |
> +              +------------------------>|          |
> +                                        |   STOP   |
> +                                        |          |
> +                                        +----------+


The STOP state doesn't seem quite right to me, sorry.

the direction of the DRAIN-STOP comp_free() arrow seems wrong? Of if it 
is correct, then something's missing to exit the STOP state so that the 
stream can be opened again.

