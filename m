Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976FC43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F3320777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584712970;
	bh=dRU3m+00mM/qn+r/7DmddOrNxDCjsWb2CGdhg6vzeFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EasYSJS4daJI2fYQLelGMhsvC+LiAZG+saftJsCSNDVv8wfgREnv1rj7CddWfRTb5
	 7QX/WcSH4w9/8oJVy6z9y9nyaEcw5eM8CETnOQZ5FtsYM/n9yuxRDUCE6bcCIkSiHp
	 seYiHLDplBfXoP7hSL513/TsrLkwkezB55jGVcyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgCTOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:02:48 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A8320754;
        Fri, 20 Mar 2020 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584712968;
        bh=dRU3m+00mM/qn+r/7DmddOrNxDCjsWb2CGdhg6vzeFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnzPTbu1jeHcUFu2Fd0MKrkt+pOutqg0GkJw0/c2dsotJN2IcNxyL4rcnhxyPq/wo
         +iaUgupnmVaXEp4bRDes7uC3x5WsgHj2+85zFxYppJG5rPSa6/6euur1eFc49JmE5v
         T5g5zPVh33AH9guBvk7xcMbLJWYij5bebUO7ngxk=
Date:   Fri, 20 Mar 2020 19:32:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: wsa881x: mark read_only_wordlength flag
Message-ID: <20200320140243.GG4885@vkoul-mobl>
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
 <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 11-03-20, 11:35, Srinivas Kandagatla wrote:
> WSA881x works in PDM mode so the wordlength is fixed, which also makes
> the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
> Writing to this register will throw up errors with Qualcomm Controller.
> So use ro_blockctrl1_reg flag to mark this field as read-only so that
> core will not write to this register.

I have applied the sdw patch. Since this depends on sdw patch, feel free
to pull the below tag before you apply this

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/ro_wordlength

for you to fetch changes up to a9107de4b03604ce0d279315c91b31b8065ee4ea:

  soundwire: stream: Add read_only_wordlength flag to port properties (2020-03-20 19:24:59 +0530)

----------------------------------------------------------------
Srinivas Kandagatla (1):
      soundwire: stream: Add read_only_wordlength flag to port properties

 drivers/soundwire/stream.c    | 16 +++++++++-------
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/wsa881x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index b59f1d0e7f84..35b44b297f9e 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -394,6 +394,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* COMP */
>  		.num = 2,
> @@ -401,6 +402,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* BOOST */
>  		.num = 3,
> @@ -408,6 +410,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* VISENSE */
>  		.num = 4,
> @@ -415,6 +418,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}
>  };
>  
> -- 
> 2.21.0

-- 
~Vinod
