Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45393C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHJOs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:48:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:11130 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgHJOs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:48:57 -0400
IronPort-SDR: v7nJhobaerfr/GrpB9KW6+UmrcpRjOCoaJhnh5zxRVZH3aoz0v0NwEQ4M4fx9Fe4v+L8t9mY+k
 qDaLvBczt74w==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="154670270"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="154670270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 07:48:57 -0700
IronPort-SDR: sPxhP5EIq10KFl0PorOKef3k1jAAGJ4jpy2IkSFLRG03riif2UVQ1/Ga+OCA7EnIz2IXGhUMIC
 P/8Fz30HBmsA==
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="438717754"
Received: from schen8-mobl.amr.corp.intel.com (HELO [10.212.235.58]) ([10.212.235.58])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 07:48:56 -0700
Subject: Re: [PATCH] ASoC: SOF: delete repeated words in comments
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
References: <20200808012156.10827-1-rdunlap@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <695a40ef-c7e3-d0dd-2604-3f8a1144b0a3@linux.intel.com>
Date:   Mon, 10 Aug 2020 09:28:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200808012156.10827-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/20 8:21 PM, Randy Dunlap wrote:
> Drop the repeated words {that, the} in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Randy.

> ---
>   sound/soc/sof/intel/cnl.c |    2 +-
>   sound/soc/sof/sof-audio.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200807.orig/sound/soc/sof/intel/cnl.c
> +++ linux-next-20200807/sound/soc/sof/intel/cnl.c
> @@ -202,7 +202,7 @@ static int cnl_ipc_send_msg(struct snd_s
>   	 * IPCs are sent at a high-rate. mod_delayed_work()
>   	 * modifies the timer if the work is pending.
>   	 * Also, a new delayed work should not be queued after the
> -	 * the CTX_SAVE IPC, which is sent before the DSP enters D3.
> +	 * CTX_SAVE IPC, which is sent before the DSP enters D3.
>   	 */
>   	if (hdr->cmd != (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_CTX_SAVE))
>   		mod_delayed_work(system_wq, &hdev->d0i3_work,
> --- linux-next-20200807.orig/sound/soc/sof/sof-audio.c
> +++ linux-next-20200807/sound/soc/sof/sof-audio.c
> @@ -29,7 +29,7 @@ bool snd_sof_dsp_only_d0i3_compatible_st
>   				continue;
>   
>   			/*
> -			 * substream->runtime being not NULL indicates that
> +			 * substream->runtime being not NULL indicates
>   			 * that the stream is open. No need to check the
>   			 * stream state.
>   			 */
> 
