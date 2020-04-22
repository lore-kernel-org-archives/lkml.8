Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D6C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACFB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDVOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:21:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:59462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgDVOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:21:12 -0400
IronPort-SDR: IALa/HM26DhQi05Amo6LsEBg6DcPj86aTWPwGY/OVayfzlEKz48+YPNjef8J52GPPyaTZ+yMTm
 YMf3KGH8xMxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:21:12 -0700
IronPort-SDR: RqFf85vPdG7OhYGX/uy86+jJlceh0IcUTUhO7yDiQIKsg98+tvEIvJiMI2uLuBJYrcwFTN7xEl
 d3czeR6kZXBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="457156383"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.134.45.139]) ([10.134.45.139])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2020 07:21:11 -0700
Subject: Re: [PATCH 3/3] dmaengine: ioat: adding missed issue_pending to
 timeout handler
To:     leonid.ravich@dell.com, dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
References: <1587554529-29839-1-git-send-email-leonid.ravich@dell.com>
 <1587554529-29839-3-git-send-email-leonid.ravich@dell.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <68c65d83-58fe-f2cb-d505-9b216caa1f4b@intel.com>
Date:   Wed, 22 Apr 2020 07:21:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587554529-29839-3-git-send-email-leonid.ravich@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2020 4:22 AM, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> completion timeout might trigger unnesesery DMA engine hw reboot
> in case of missed issue_pending() .

Just curious, are you hitting a use case where this is happening? And 
what's causing the completion timeout?

> 
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
>   drivers/dma/ioat/dma.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index 55a8cf1..2ab07a3 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -955,6 +955,13 @@ void ioat_timer_event(struct timer_list *t)
>   		goto unlock_out;
>   	}
>   
> +	/* handle missed issue pending case */
> +	if (ioat_ring_pending(ioat_chan)) {
> +		spin_lock_bh(&ioat_chan->prep_lock);
> +		__ioat_issue_pending(ioat_chan);
> +		spin_unlock_bh(&ioat_chan->prep_lock);
> +	}
> +
>   	set_bit(IOAT_COMPLETION_ACK, &ioat_chan->state);
>   	mod_timer(&ioat_chan->timer, jiffies + COMPLETION_TIMEOUT);
>   unlock_out:
> 
