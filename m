Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CA620724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJlRtmq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgGCWrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:47:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8EEC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:47:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so12299379pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRBtbtG1j7Xe51Bh35XbQdV4rjnwLDY23WxNX/FI3wQ=;
        b=mJlRtmq6CpTsfGG8dI6jlPat89G7ZcO9ohU/lVmVrVAf4wiRNMRUbw03oycBMXcYJt
         dRf7KgkxWAa4M7I03cFI2YPOM7PVAyUnaPLFY8zT/mg2iI9nHhheihiwpulSefM3lVOy
         HpKkNmtdhDewZUmMsQ3UrKixCjY3+/o/T2Fd2w8oknSmXd4hqEpMaEAyHUp+rysnKI4l
         D/AibesffdHEZnm7prdjvBFlBT/8DaBTBcqWvNjuFCmphc44G5k73dcUWpxHIrKyjbuI
         6R3WLlxLulKtuzGcGRLVvTUiH+/r/QaJOhICYh3WdF9Dtc4eSwH8HyK6dY/gr0O86s6c
         NC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRBtbtG1j7Xe51Bh35XbQdV4rjnwLDY23WxNX/FI3wQ=;
        b=W5dOfkPXflDdFrvDpad1XXm3rDVW3/x2N1Qh8CWpZNAkcajoebTkzh/WdahhI0Jyry
         MawtaTWjs++cH5hYu3JLNXsAhh5EDKJPSRo+Oxz8T4pnAHaeTSDpnPjLPbl/0TPnWz88
         IU+Fx8Z4nizjDZGQVtdnLPCxOZPx6nurk/MizSk+1jePz/cxU5c7eqLSx5i4SVHfMSX8
         PugETkuwjx+a5ytOHx3oQfpRd4kY636a5tt9YmRT2/yNJCYLUhJUGQLFfkjjSrRPTWNP
         OO6tO//6Yj6e0T5WmN/Czron3GUwGQaur0VGFpxQYcRlVRZiS7WjDCVucg89mckCcf+X
         AWNQ==
X-Gm-Message-State: AOAM530SclnyKqlKgnq9sZZqiYOCPB14MQMzsg1IIPGrKIvj2Pd8+hHj
        n0EcJFR+egFgVRjGoD9Mri3PT4WWfyM=
X-Google-Smtp-Source: ABdhPJzcL3ocgTh9rFr1T1bDjb89oAsQukPkRkoy7Vq4NHGe0lAA0gG7Ha4pAjS96ri2k5zN7cGOwA==
X-Received: by 2002:aa7:868f:: with SMTP id d15mr36997999pfo.166.1593816427129;
        Fri, 03 Jul 2020 15:47:07 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s23sm13281151pfs.157.2020.07.03.15.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 15:47:06 -0700 (PDT)
Date:   Fri, 3 Jul 2020 15:46:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     tiwai@suse.com, festevam@gmail.com, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200703224656.GA16467@Asurada-Nvidia>
References: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
 <159379581381.55795.16716505708033817338.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159379581381.55795.16716505708033817338.b4-ty@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Jul 03, 2020 at 06:03:43PM +0100, Mark Brown wrote:
> On Tue, 30 Jun 2020 16:47:56 +0800, Shengjiu Wang wrote:
> > The ASRC not only supports ideal ratio mode, but also supports
> > internal ratio mode.
> > 
> > For internal rato mode, the rate of clock source should be divided
> > with no remainder by sample rate, otherwise there is sound
> > distortion.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: fsl_asrc: Add an option to select internal ratio mode
>       commit: d0250cf4f2abfbea64ed247230f08f5ae23979f0

You already applied v3 of this change:
https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/169976.html

And it's already in linux-next also. Not sure what's happening...
