Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B322C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043842087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579176567;
	bh=kYzkOEmCDFe62a7WuBff4raLrGb2r2xPUtR2Sr2MPTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LQBL5ngcoGgndD/ysuX/+3YwvPY5W+E1XdcAiz+DTkDp7pmDtIBXWbU/Qr7BJAXBJ
	 kuZbOLvNBeq6OgwQBuhmDxHclOfn9QNKdG5RDVb8XcNnvwjbfiAzS98HULRdYgsYcx
	 oG8zQ8BUf8sBrKNyv60LlErLcj3Dx44bH76qZmJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAPMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAPMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:09:26 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11A82075B;
        Thu, 16 Jan 2020 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579176565;
        bh=kYzkOEmCDFe62a7WuBff4raLrGb2r2xPUtR2Sr2MPTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyWIfQa78sWdoZCbKCO+81DnbHCnlIUxwC0VvYv6raWoCBzmbApTn6jHKO9It6VwC
         p+vvDgh6e/pP/svKhamE3fkQA0gnbDE7amC3MJHYdX53nL22eCNiUNC2jaGqd3PZco
         +6d776W26zvyKPuB57R26Rq4chYXifN3kBMEQUDc=
Date:   Thu, 16 Jan 2020 17:39:18 +0530
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
Subject: Re: [PATCH] soundwire: cadence: fix kernel-doc parameter descriptions
Message-ID: <20200116120918.GR2818@vkoul-mobl>
References: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
 <20200116120459.GP2818@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116120459.GP2818@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-20, 17:35, Vinod Koul wrote:
> On 14-01-20, 17:31, Pierre-Louis Bossart wrote:
> > Fix previous update, bad git merge likely. oops.
> 
> Applied, thanks

Btw I still have these warns on my next with W=1

drivers/soundwire/intel_init.c:193:7: warning: no previous prototype for ‘sdw_intel_init’ [-Wmissing-prototypes]
 void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
       ^~~~~~~~~~~~~~
drivers/soundwire/cadence_master.c:1022: warning: Function parameter or member 'clock_stop_exit' not described in 'sdw_cdns_init'
  LD [M]  drivers/soundwire/soundwire-cadence.o
drivers/soundwire/intel_init.c:214: warning: Function parameter or member 'ctx' not described in 'sdw_intel_exit'
drivers/soundwire/intel_init.c:214: warning: Excess function parameter 'arg' description in 'sdw_intel_exit'

-- 
~Vinod
