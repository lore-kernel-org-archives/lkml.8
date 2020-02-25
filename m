Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E1AC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC45218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582626461;
	bh=c11I1+aXz7I861UYGuPVDLiwVXB6TbdIH+RT/RHaxf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RMsoUsQu9c0uTA9FeFEQlv+C55Tv4mHoiW2oq5VTvSYXLj7HX6vLLf1AAEi1D+Qx7
	 /Dr03Hdy97oJeyTa/wtAJ6EENp6sJCl43vrRM3fblOuscHYumPNHw6nlIbHjUV4UiP
	 glEws461GjDuxKg8/Uxms0uQStjqN5tQhLogtcbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgBYK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbgBYK1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:27:39 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2A1220714;
        Tue, 25 Feb 2020 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582626458;
        bh=c11I1+aXz7I861UYGuPVDLiwVXB6TbdIH+RT/RHaxf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UszBqyn5y1O3RMhXxzYd9ILQv5H/sSSXmlq0iAC6KbeivREBvpzR4imZ4qfAjx9/I
         Z++3G+BqHAeKqaBSQ/FSXW2eHESMmfYQbOL4I20TyEVWi+7Q/o42N1ugel1BeMxFXm
         AThdATN3CaDXnYWB72W8o8sFgQFDalyzLX+lPbk0=
Date:   Tue, 25 Feb 2020 15:57:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 00/10] soundwire: bus: fix race conditions, add
 suspend-resume
Message-ID: <20200225102734.GO2618@vkoul-mobl>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 18:08, Pierre-Louis Bossart wrote:
> The existing mainline code for SoundWire does not handle critical race
> conditions, and does not have any support for pm_runtime suspend or
> clock-stop modes needed for e.g. jack detection or external VAD.
> 
> As suggested by Vinod, these patches for the bus are shared first -
> with the risk that they are separated from their actual use in Intel
> drivers, so reviewers might wonder why they are needed in the first
> place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692
> 
> These patches are not Intel-specific and are likely required for
> e.g. Qualcomm-based implementations.
> 
> All the patches in this series were generated during the joint
> Intel-Realtek validation effort on Intel reference designs and
> form-factor devices. The support for the initialization_complete
> signaling is already available in the Realtek codecs drivers merged in
> the ASoC tree (rt700, rt711, rt1308, rt715)

Applied all, thanks

-- 
~Vinod
