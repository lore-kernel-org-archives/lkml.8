Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027B3C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F272187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578983877;
	bh=d3TptTQMxcOQaiVXM++PdRKb60BDi4ryItpKb/Jtenw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pwlJgfiQIAK7BroSqO1zICFd2HOffPOoLLe4N/1vIw/yZ8+ubKRL4GhIUjYFtF6W9
	 R5meCYxBs7KKrEK98zFYdVeGbk0x6WyWLY/4l1QDG5T5VVHQ/2Lxqjdu2R1lqENerC
	 KcZ+sIWHk1oFgXRX8Egpf9r/0ZRxBmAWabKfC93c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgANGh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgANGh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:37:56 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC477207FD;
        Tue, 14 Jan 2020 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983875;
        bh=d3TptTQMxcOQaiVXM++PdRKb60BDi4ryItpKb/Jtenw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn/9uUIiMRtAUXrO57mkE70lQ2OvA5iO4sUEivrOwSlgOJkFnw1+6Atndni8cjfsQ
         7NSgb5U6ZrVvHUXB5f2ZXVptE71t6dE6czVS0z6TkBqK1VV+c9zQ7mJ/cEf4t6xA02
         kf+1bx6WncHdRfrOxRLJfptBNcUNA+FvoNAOE7UU=
Date:   Tue, 14 Jan 2020 12:07:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: intel: fix factor of two in MCLK handling
Message-ID: <20200114063751.GH2818@vkoul-mobl>
References: <20200113231129.19049-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113231129.19049-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 17:11, Pierre-Louis Bossart wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> Somehow Intel folks were confused, the property is 2x what the mclk
> frequency actually is (checked the actual bus frequency with a scope)

Applied, thanks

-- 
~Vinod
