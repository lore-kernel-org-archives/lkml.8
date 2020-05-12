Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA3CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A8620722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589306685;
	bh=yc6CNqoYkvluvBeb9WQbgl44Xk4YuO/iW2Z1m/hzklE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SiTFD4zRVU4R6z03dp9nAAnF5h19UMVMVHiYkj66SAQIKfBLp7YzcKpD0pxUZtLcL
	 +MWy8EE0Ij6EQSu3j32W2LbaKHbX6pGz1L7PlK3sVTccOiPvVtq1IK1cot2teA7T+b
	 KoU3jlHe+L96aYXq/g8xqmzZqo9NbqdtrFLhzqJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgELSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:04:44 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5F120673;
        Tue, 12 May 2020 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306684;
        bh=yc6CNqoYkvluvBeb9WQbgl44Xk4YuO/iW2Z1m/hzklE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNpXKNUEIE5dTnGo7j/WYOPw9ts4Hy4qorJF73kuDy5KaME/ONw/6KEAKx6T5GI96
         Tru/3jCFPgUUstfBELSRe1dKKjcpXXZ/QXX/YINyeNntLAevi8kAit6ZbmDmJebN5r
         pPODNn38dzmbRXbjGrUsrPbWiNu5j1U6kenTEueU=
Date:   Tue, 12 May 2020 13:09:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ASoC: Intel: Skylake: Replace zero-length array
 with flexible-array
Message-ID: <20200512180918.GF4897@embeddedor>
References: <20200511174647.GA17318@embeddedor>
 <158930188455.55827.14390851374340231617.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158930188455.55827.14390851374340231617.b4-ty@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:44:50PM +0100, Mark Brown wrote:
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8
> 

Thanks, Mark.

--
Gustavo
