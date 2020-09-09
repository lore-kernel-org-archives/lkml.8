Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F679C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB8208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599638380;
	bh=3rAE+SPjRZ4i3GefKC27FMyuZcbvx2plcxvfQTsIqXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X8Piu95W8Jitv4q/rMPTkxjGp/EHO5e7t+eDQRtX12H/Qr4ueqdQYXkvvsPbCgtvx
	 8I51kfLiIXXb5G+VYzSsi3RMbLH70wFgEfE0XICZuNyXVYJ45Z4mvWM7xUvQV2vqSE
	 JuhmgBpqUApya3lTQwtws5uR4Q7JOtIhkgzT6OB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgIIH7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgIIH73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:59:29 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2C22087C;
        Wed,  9 Sep 2020 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599638368;
        bh=3rAE+SPjRZ4i3GefKC27FMyuZcbvx2plcxvfQTsIqXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ma/Y0tsgx/97CgY0J2Nm/BIU53y37cgwef+KkNlKsUPxvIXzEdJWs80Biln9Mku8S
         +R5Wim6IxJda9gXOZk2DG617IPPriTIqez1a5G6zxSNyYkSSW60spxDxOxMbXuZs/B
         z0tQRKoB1A/Oq4rNqbyYGHOSY/nvcHBG0x33EnhM=
Date:   Wed, 9 Sep 2020 13:29:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
Message-ID: <20200909075922.GM77521@vkoul-mobl>
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
 <20200821050758.GI2639@vkoul-mobl>
 <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
 <20200828080024.GP2639@vkoul-mobl>
 <77ecb4bc-10d6-8fbd-e97f-923d01a5e555@linux.intel.com>
 <3e4dee4b-1309-2d3e-ae20-e2dcbadb2f40@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e4dee4b-1309-2d3e-ae20-e2dcbadb2f40@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 13:58, Jaroslav Kysela wrote:
> Dne 28. 08. 20 v 17:14 Pierre-Louis Bossart napsal(a):
> > 
> > 
> > 
> >> Is this timeout for suspend or resume? Somehow I was under the
> >> assumption that it is former? Or is the result seen on resume?
> >>
> >> Rereading the race describe above in steps, I think this should be
> >> handled in step c above. Btw is that suspend or runtime suspend which
> >> causes this? Former would be bigger issue as we should not have work
> >> running when we return from suspend call. Latter should be dealt with
> >> anyway as device might be off after suspend.
> > 
> > This happens with a system suspend. Because we disable the interrupts, 
> > the workqueue never completes, and we have a timeout on system resume.
> > 
> > That's why we want to prevent the workqueue from starting, or let it 
> > complete, but not have this zombie state where we suspend but there's 
> > still a wait for completion that times out later. The point here is 
> > really  making sure the workqueue is not used before suspend.
> > 
> 
> Vinod, there is no acceptance progress on this. The patch is really straight
> and for the Intel controller. They know what they're doing. I would apply
> this. The code can be refined at anytime. It's a fix. I tested it and I can
> confirm, that it fixes the issue. It's a vital patch for 5.10 to enable
> finally SoundWire drivers for the Intel hardware.

I do feel that there is something else going on, but not able to pin
point, anyway this fixes the issue so I am applying it now
> 
> Acked-by: Jaroslav Kysela <perex@perex.cz>

Thanks for ack

-- 
~Vinod
