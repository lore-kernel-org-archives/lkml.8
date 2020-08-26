Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ABEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396C92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598435068;
	bh=rEb2MjfXopgqQeFyttJe5xNt6mctXJvZcBIyl2JNJFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NatywIRMomAl6M6Gh2vCeMCCKtOFqLm9IRg0zQqRF+PvRdZ/89Mp3lewXrIGpIagB
	 Pc/WhvzQHgJXxaO7bi7dvMxFq3+9CDD5iJZ574bswC8edSmNKR3fsBJpYAVa1o0haQ
	 0Cw32nkbGUnpIu0FOd4iWxrAeBB9Ljlwoh+wd98o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgHZJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgHZJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:44:25 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8102071E;
        Wed, 26 Aug 2020 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598435065;
        bh=rEb2MjfXopgqQeFyttJe5xNt6mctXJvZcBIyl2JNJFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnbo60x+x4RKK8IUE3UDFFHizRC5B1LAzK+MU9u5cUbaPc5HZLc43w2cIeBiOU6Nn
         MAl8LV3NHMddNmyG179zjvTCJbp8LT+b15OcWBqzh1k22QTP/1C4YZboaEu839QvYq
         UN0Z4qfDKPTiHjK9w7l8jTrBVYInbXcVlz7fBzXo=
Date:   Wed, 26 Aug 2020 15:14:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 05/11] soundwire: bus: update multi-link definition with
 hw sync details
Message-ID: <20200826094420.GA2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 10:41, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Hardware-based synchronization is typically required when the
> bus->multi_link flag is set.
> 
> On Intel platforms, when the Cadence IP is configured in 'Multi Master
> Mode', the hardware synchronization is required even when a stream
> only uses a single segment. The existing code only deal with hardware
> synchronization when a stream uses more than one segment so to remain
> backwards compatible we add a configuration threshold. For Intel cases
> this threshold will be set to one, other platforms may be able to use
> the SSP-based sync in those cases.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 76052f12c9f7..9adbe4fd7980 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -827,6 +827,11 @@ struct sdw_master_ops {
>   * @multi_link: Store bus property that indicates if multi links
>   * are supported. This flag is populated by drivers after reading
>   * appropriate firmware (ACPI/DT).
> + * @hw_sync_min_links: Number of links used by a stream above which
> + * hardware-based synchronization is required. This value is only
> + * meaningful if multi_link is set. If set to 1, hardware-based
> + * synchronization will be used even if a stream only uses a single
> + * SoundWire segment.

Soundwire spec does not say anything about multi-link so this is left to
implementer. Assuming that value of 1 would mean hw based sync will
be used even for single stream does not make sense in generic terms.
Maybe yes for Intel but may not be true for everyone?

We already use m_rt_count in code for this, so the question is why is
that not sufficient?

>   */
>  struct sdw_bus {
>  	struct device *dev;
> @@ -850,6 +855,7 @@ struct sdw_bus {
>  	unsigned int clk_stop_timeout;
>  	u32 bank_switch_timeout;
>  	bool multi_link;
> +	int hw_sync_min_links;
>  };
>  
>  int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
> -- 
> 2.17.1

-- 
~Vinod
