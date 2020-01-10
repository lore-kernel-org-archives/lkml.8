Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B94C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293962082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578639824;
	bh=ZnMDBNhMvFkTRDhEtOEWNUKzKsBrxPyLSgZcAstK7P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SWse2+q40eZpdXypZORdTNNXZUs1VqO8GGN6WSowZBgYtihNHf+WT+OBm31dkvIrT
	 ed6Q5oB0ouBhsDED/nVgGsYBNq/iHSheKbukN33xXOIWthgX5N2jNnN5aeQt07jS+Q
	 auTQiqLAd/d+eAseNognyQI+07usRH1nqHl04AdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgAJHDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgAJHDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:03:39 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C1B2080D;
        Fri, 10 Jan 2020 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578639818;
        bh=ZnMDBNhMvFkTRDhEtOEWNUKzKsBrxPyLSgZcAstK7P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtQke1VRM29qVQhxQo8REzyXvGu+GTluOSWfZzT6k+VFPNrFMg3X2bzUHZuQL+X2k
         BjsSJUg8qKqc5qHRh/w9VwVJaMpyPMRHtywDHfsH7NhD4/Kf4lSPJxdNp1Fho/7t+D
         SL74Mz+fmESqn7mF2LFvoOLY42ehtLOHPB3qjw34=
Date:   Fri, 10 Jan 2020 12:33:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 6/6] soundwire: stream: don't program ports for a stream
 that has not been prepared
Message-ID: <20200110070321.GA2818@vkoul-mobl>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108175438.13121-7-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 11:54, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> In the Intel QA multi-pipelines test case, there are two pipelines for
> playback and capture on the same bus. The test fails with an error
> when setting port params:
> 
> [  599.224812] rt711 sdw:0:25d:711:0: invalid dpn_prop direction 1 port_num 0
> [  599.224815] sdw_program_slave_port_params failed -22
> [  599.224819] intel-sdw sdw-master-0: Program transport params failed: -22
> [  599.224822] intel-sdw sdw-master-0: Program params failed: -22

side note, one of these above err logs should be removed :)

> [  599.224828] sdw_enable_stream: SDW0 Pin2-Playback: done
> 
> This problem is root-caused to the programming of the capture stream
> ports while it is not yet prepared, the calling sequence is:
> 
> (1) hw_params for playback. The playback stream provide the port
>     information to Bus.
> (2) stream_prepare for playback, Transport and port parameters
>     are computed for playback.
> (3) hw_params for capture. The capture stream provide the port
>     information to Bus, but it has not been prepared so is not
>     accounted for in the bandwidth allocation.
> (4) stream_enable for playback. Program transport and port parameters
>     for all masters and slaves. Since the transport and port parameters
>     are not computed for capture stream, sdw_program_slave_port_params
>     will generate a error when setting port params for capture.
> 
> in step (4), we should only program the ports for the stream that have
> been prepared. A stream that is only in CONFIGURED state should be
> ignored, its ports will be programmed when it becomes PREPARED.
> 
> Tested on Comet Lake.
> 
> GitHub issue: https://github.com/thesofproject/linux/issues/1637

This is not relevant for kernel, pls remove

> Signed-off-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index da10f38298c0..198372977187 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -604,12 +604,23 @@ static int sdw_notify_config(struct sdw_master_runtime *m_rt)
>   *
>   * @bus: SDW bus instance
>   */
> -static int sdw_program_params(struct sdw_bus *bus)
> +static int sdw_program_params(struct sdw_bus *bus, bool prepare)
>  {
>  	struct sdw_master_runtime *m_rt;
>  	int ret = 0;
>  
>  	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +
> +		/*
> +		 * this loop walks through all master runtimes for a
> +		 * bus, but the ports can only be configured while
> +		 * explicitly preparing a stream or handling an
> +		 * already-prepared stream otherwise.

we can go upto 80 chars, make sure you align the above comment block as
such

> +		 */
> +		if (!prepare &&
> +		    m_rt->stream->state == SDW_STREAM_CONFIGURED)
> +			continue;
> +
>  		ret = sdw_program_port_params(m_rt);
>  		if (ret < 0) {
>  			dev_err(bus->dev,
> @@ -1502,7 +1513,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  
>  program_params:
>  		/* Program params */
> -		ret = sdw_program_params(bus);
> +		ret = sdw_program_params(bus, true);
>  		if (ret < 0) {
>  			dev_err(bus->dev, "Program params failed: %d\n", ret);
>  			goto restore_params;
> @@ -1602,7 +1613,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  		bus = m_rt->bus;
>  
>  		/* Program params */
> -		ret = sdw_program_params(bus);
> +		ret = sdw_program_params(bus, false);
>  		if (ret < 0) {
>  			dev_err(bus->dev, "Program params failed: %d\n", ret);
>  			return ret;
> @@ -1687,7 +1698,7 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>  		struct sdw_bus *bus = m_rt->bus;
>  
>  		/* Program params */
> -		ret = sdw_program_params(bus);
> +		ret = sdw_program_params(bus, false);

Can you do a converse test as well, when the streams are running and
concurrently two stream are stopped, it would be good to get it confirmed...

>  		if (ret < 0) {
>  			dev_err(bus->dev, "Program params failed: %d\n", ret);
>  			return ret;
> @@ -1769,7 +1780,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  			m_rt->ch_count * m_rt->stream->params.bps;
>  
>  		/* Program params */
> -		ret = sdw_program_params(bus);
> +		ret = sdw_program_params(bus, false);
>  		if (ret < 0) {
>  			dev_err(bus->dev, "Program params failed: %d\n", ret);
>  			return ret;
> -- 
> 2.20.1

-- 
~Vinod
