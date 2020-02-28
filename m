Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA5C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2AF246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582875261;
	bh=VxhOUV4pA9AaEruX7Y6IhDlmmebnGl5PUqDvas/qmZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hOBNubIKXXevgssocRtxcEBxw8QpAOv7GXZSizAFwA4cPiukRXMEvlMT8mnCGNtNC
	 in1oMyD0RPxEoFmcHHhPOtpmqxig7ZyQSIENLrZ5li0a6VzRHg1I/TjSgMFpnWmFoq
	 Zo40DzODhvU6B+/pMcDj52dGoE2ByZi/cnufW8vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgB1HeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgB1HeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:34:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED47246A3;
        Fri, 28 Feb 2020 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582875259;
        bh=VxhOUV4pA9AaEruX7Y6IhDlmmebnGl5PUqDvas/qmZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jq/PNgCMxxOxE34PwmTGzMu28g8FAefm+DyzCaywoHD6fbW+ShGyXKqDD6uYYiUB
         OFvidF0swYwnGV7E6A2etbDXyjYv1LO9NLngRW+bTlt1OrwyTxgYkRX/Uf8yZU8FXq
         wyx10XNp4G9APItSUOCjjdK3e3KI7C0ywOWSp7UY=
Date:   Fri, 28 Feb 2020 08:34:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/8] soundwire: intel: transition to
 sdw_master_device/driver support
Message-ID: <20200228073416.GC2898712@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:32:00PM -0600, Pierre-Louis Bossart wrote:
> +static struct sdw_master_driver intel_sdw_driver = {
> +	.driver = {
> +		.name = "intel-master",
> +		.owner = THIS_MODULE,

Nit, setting .owner isn't needed anymore, as the core code handles this
for you, right?

thanks,

greg k-h
