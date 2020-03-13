Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EF72074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584102290;
	bh=z5d9KfOkzEwQXAeUrQxuObXz1fWFWbNDkRA2EB3E6wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cxw3/RCXRMBu4JH7jLGzryWP9UNW0dzmXfBZAjN+fUtlRDrvtJMwQDMtXwe/D6U99
	 NnvynqK078VLQOkIlibfEQcW14cylxGTJmwNhEu9PrTrhS2kH0FpDKfZfxvqdhfq0W
	 cTlNtdtlCbPtv4Dj7wm+WKKAhdVnLpICgNTV7NGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCMMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgCMMYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:24:49 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40B120724;
        Fri, 13 Mar 2020 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584102288;
        bh=z5d9KfOkzEwQXAeUrQxuObXz1fWFWbNDkRA2EB3E6wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQ7+qLr19uqvmNmDEYZOwnu2r+KeNW39kNjj15vIS9QJO1TZLBAwg/xdBF8nbRH0j
         v80nSXeTv7Sb0eUDEfo50h3jTnSwKZ3JljBUAmiHCuvVEB1oW2E64hM3CKEinZkzpN
         h1ifmrzk6kkCJY2VHIMhrz0l47Vxx2xR5UxSOtR0=
Date:   Fri, 13 Mar 2020 17:54:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 07/16] soundwire: cadence: mask Slave interrupt before
 stopping clock
Message-ID: <20200313122444.GH4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311184128.4212-8-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
> Intel QA reported a very rare case, possibly hardware-dependent, where
> a Slave can become UNATTACHED during a clock stop sequence, which
> leads to timeouts and failed suspend sequences.
> 
> This patch suppresses the handling of all Slave events while this
> transition happens. The two cases that matter are:
> 
> a) alerts: if the Slave wants to signal an alert condition, it can do
> so using the in-band wake, so there's almost no impact with this
> patch.
> 
> b) sync loss or imp-def reset: in those cases, bringing back the Slave
> to functional state requires a complete re-enumeration. It's better to
> just ignore this case and restart cleanly, rather than attempt a
> 'clean' suspend.
> 
> Validation results show the timeouts no longer visible with this patch.
> 
> GitHub issue: https://github.com/thesofproject/linux/issues/1678
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 02f18ce6b7e7..a4ba57f44c1f 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -865,6 +865,24 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
>  }
>  EXPORT_SYMBOL(sdw_cdns_exit_reset);
>  
> +/**
> + * sdw_cdns_enable_slave_interrupt() - Enable SDW slave interrupts
> + * @cdns: Cadence instance
> + * @state: boolean for true/false
> + */
> +static void cdns_enable_slave_interrupts(struct sdw_cdns *cdns, bool state)

Do you want to rename this as cdns_configure_slave_interrupts, with
argument as enable/disable... ? 

-- 
~Vinod
