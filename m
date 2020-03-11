Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC593C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8F9206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgCKS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:58:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:61898 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbgCKS6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="353946803"
Received: from fjan-mobl.amr.corp.intel.com (HELO [10.251.25.157]) ([10.251.25.157])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2020 11:58:44 -0700
Subject: Re: [PATCH 2/2] ASoC: wsa881x: mark read_only_wordlength flag
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
 <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2c56d592-719f-bd87-25cb-c5028bde729b@linux.intel.com>
Date:   Wed, 11 Mar 2020 13:58:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/20 6:35 AM, Srinivas Kandagatla wrote:
> WSA881x works in PDM mode so the wordlength is fixed, which also makes
> the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
> Writing to this register will throw up errors with Qualcomm Controller.

it'd be good to clarify the nature of these errors, i.e.

a) is this the Slave device responding with a NAK?
b) is this the Slave device responding with COMMAND_IGNORED, and those 
responses not handled by the controller?
c) something else?

Thanks!

> So use ro_blockctrl1_reg flag to mark this field as read-only so that
> core will not write to this register.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/codecs/wsa881x.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index b59f1d0e7f84..35b44b297f9e 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -394,6 +394,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>   		.min_ch = 1,
>   		.max_ch = 1,
>   		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>   	}, {
>   		/* COMP */
>   		.num = 2,
> @@ -401,6 +402,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>   		.min_ch = 1,
>   		.max_ch = 1,
>   		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>   	}, {
>   		/* BOOST */
>   		.num = 3,
> @@ -408,6 +410,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>   		.min_ch = 1,
>   		.max_ch = 1,
>   		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>   	}, {
>   		/* VISENSE */
>   		.num = 4,
> @@ -415,6 +418,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>   		.min_ch = 1,
>   		.max_ch = 1,
>   		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>   	}
>   };
>   
> 
