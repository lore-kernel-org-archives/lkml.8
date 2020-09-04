Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596E620791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599211202;
	bh=5muqg1n4qr0H2eZLDk1igsJ/uAMP9XgjBEFMVW5EZ4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZWzq7InwDH1BSL8k0/S7kTKcN+mJYgnWx5GYxiPlKm+2Exl+EzRpVPir4ssckxZ/
	 MJPHcCEWbH/96X7WGxc5OT4bEicXjs88mzMsD9PO8Px1lHQwmdDo0/lvVC7O1Q7urW
	 ggGGprE89yk5Bg7wmK5A7EL+JkLi9Mua5jjwt3SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIDJT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgIDJT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:19:57 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A132320770;
        Fri,  4 Sep 2020 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599211196;
        bh=5muqg1n4qr0H2eZLDk1igsJ/uAMP9XgjBEFMVW5EZ4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBnRSDSwieNlZQTu40xloN/GNkLzOciw6Rmdan7tWghiOtF1uoLXUE8efnLYzWHwu
         /LN+87kCXL+q6WNYyZr7ma0OVvt2xDdR0hS63cUvqm/LeXVD7i7bNkuix5NBsFfQzA
         1ZZbw8SMbgLWMUJb/WPcPAHRZVWAhWr6PUPFMlT8=
Date:   Fri, 4 Sep 2020 14:49:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/3] ASoC: Add sdw stream operations to dailink ops.
Message-ID: <20200904091950.GX2639@vkoul-mobl>
References: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-20, 04:46, Bard Liao wrote:
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "soundwire: Remove sdw
> stream operations from Intel soundwire dai".
> 
> Pierre-Louis Bossart (3):
>   ASoC: soc-dai: clarify return value for get_sdw_stream()
>   ASOC: Intel: sof_sdw: add dailink .trigger callback
>   ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback

s/ASOC/ASoC

with that:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
>  include/sound/soc-dai.h          |  3 +-
>  sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
