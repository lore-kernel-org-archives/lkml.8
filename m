Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4DAC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1AA20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578639890;
	bh=WVTczZ0WXkHm+kstImFaKjkXem85hCPaurp4wD8rzL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S0RbWspElT4QorU9+UTRA1/pX/G5F9lElUQvXwVKlWEXhXTfQCj5JlPiNIcNS+T2u
	 bdV+u7civYaieZK6MK2ZyI0FYiSiDL7iYt+1GRb+7OiWChpGonyVcjYHEyi+5rG1K9
	 NPV53HClttqLpEg3QctL6VhgvCCEBQE4YHHiB+ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgAJHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgAJHEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:04:48 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F7A2080D;
        Fri, 10 Jan 2020 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578639888;
        bh=WVTczZ0WXkHm+kstImFaKjkXem85hCPaurp4wD8rzL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yk9As+Q4EWsjIV3fwBZy23RxCJEzSDyXHOnc4SyBL6dNAP4CSzgZvHMPUojKbRLL8
         PI+HkndB5PqxCnP0bgHKB6e/67jKrGUpF2FVKipFuBY7jn6zFizRCgaXv5bPIXE68P
         lxmcOJPvFovw8MLO2F9m1UZCUP+9x4LS/vOGNQXQ=
Date:   Fri, 10 Jan 2020 12:34:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/6] soundwire: stream: remove redundant pr_err traces
Message-ID: <20200110070434.GB2818@vkoul-mobl>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108175438.13121-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 11:54, Pierre-Louis Bossart wrote:
> Only keep pr_err to flag critical configuration errors that will
> typically only happen during system integration.
> 
> For errors on prepare/deprepare/enable/disable, the caller can do a
> much better job with more information on the DAI and device that
> caused the issue.

Applied, thanks

-- 
~Vinod
