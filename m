Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE638C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578638933;
	bh=Of4w1wJ91a4RMgBuLQs9vGiM+W0czF9OyBSxcneVhAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mn2CMA2d25te1AsEVFKanzGNjvBdHlLkJNv5MFRZUjRVXDwTUp8RyQyP2br71waB9
	 bdVowY5gB7gtgwW0PKWrfsUlbilBCbVjqDqFTRGgUjXftR8hY00+f/224NdCCATn6B
	 v3Tr+Jst43i4LPmMZCXGz7zt9IpdwkZjBSmxt37E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgAJGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbgAJGsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:48:51 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1692077B;
        Fri, 10 Jan 2020 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578638931;
        bh=Of4w1wJ91a4RMgBuLQs9vGiM+W0czF9OyBSxcneVhAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5nW5cI7HboFrg2xaURWGqpR8RQQzUzaL4W5ZfJK40sZxDPCoA++vKSkTedumETrG
         2U9piP1eJ9Gq7kx3Co3OmRYXxCsMAC4vlzj5LTPuJEMHJvjZ6mis6Pdn3Q7HDD8lSH
         W+oDfYFjZcKrjNSBRqFFN+JzYPZMRmMZMkpWkBb8=
Date:   Fri, 10 Jan 2020 12:18:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/6] soundwire: stream: update state machine and add
 state checks
Message-ID: <20200110064838.GY2818@vkoul-mobl>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 11:54, Pierre-Louis Bossart wrote:

>  Stream State Operations
>  -----------------------
> @@ -246,6 +251,9 @@ SDW_STREAM_PREPARED
>  
>  Prepare state of stream. Operations performed before entering in this state:
>  
> +  (0) Steps 1 and 2 are omitted in the case of a resume operation,
> +      where the bus bandwidth is known.
> +
>    (1) Bus parameters such as bandwidth, frame shape, clock frequency,
>        are computed based on current stream as well as already active
>        stream(s) on Bus. Re-computation is required to accommodate current
> @@ -270,13 +278,15 @@ Prepare state of stream. Operations performed before entering in this state:
>  After all above operations are successful, stream state is set to
>  ``SDW_STREAM_PREPARED``.
>  
> -Bus implements below API for PREPARE state which needs to be called once per
> -stream. From ASoC DPCM framework, this stream state is linked to
> -.prepare() operation.
> +Bus implements below API for PREPARE state which needs to be called
> +once per stream. From ASoC DPCM framework, this stream state is linked
> +to .prepare() operation. Since the .trigger() operations may not
> +follow the .prepare(), a direct transitions from
> +``SDW_STREAM_PREPARED`` to ``SDW_STREAM_DEPREPARED`` is allowed.
>  
>  .. code-block:: c
>  
> -  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
> +  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool resume);

so what does the additional argument of resume do..?

> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 178ae92b8cc1..6aa0b5d370c0 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)

and it is not modified here, so is the doc correct or this..?

-- 
~Vinod
