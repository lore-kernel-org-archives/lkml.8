Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF8620679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjvdkIGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgFCRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:42:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC3C08C5D1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:42:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so2055675pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11EqLqigawu5AuEW1gFIrsexclHL8DCzdN7DBjvUYqA=;
        b=FjvdkIGnkijqmFETxqkZf5cAQNGKa8CDBDXF341jBrf8KsuUMNBzJ29u/nR6jxPLo4
         NiRWSZCxY3INhSncwcwGBs6uJcXk3VO2LUAjvY+bypo+TwXm5kjCMoUmsMcNefMAopvf
         y2hkLrMDXaiYxZE4t+TNnzG75E8fNRxWptRgs6pYZhmQCbfGFpXXa0TU/yMAF9g/pU30
         WatGmVvuokLk4Pn6dw4TACOawdbu7wjZWRpOAhOhiFS+OTMDm+/I6XkxHh8iTPqzed4N
         3lNZzWqg7uuRHCAnNwAO359O9bioWtq2WciiPOqUNQm3sPq2KvFC4ZsB8QA3qOR3tRzQ
         hlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11EqLqigawu5AuEW1gFIrsexclHL8DCzdN7DBjvUYqA=;
        b=fGM5mSciZ2wiqFG1NTNHrE863LeyK+i6liI4KqWRyvjd1oHrABSbY15ckPR67UbDsN
         YwLJ+gw/16KuEyp+ieAdOQQdwpsBD/VwcA7OBm4Ex8ZWEa8OXkYNtzPPFOY9s/cRy+D9
         hyR/u7XZQ46YOzYGgsldBTBYtO88yQTeBjR1QZyQydcFnLX4IwRPvALeje2nPgPI1R3/
         /s5v7tQ/Es70elZRFq2fMds/c6PZ5OE4hcLRTRZD5ZiEITe/xQ3z5pM6PEpboy/ye8VH
         y6d+IpqApEBHPfHkkL0Z/kDFQ0PzbiHC/YIpk8TFT/1aMmgRlXDoxeoRiDbvr0rmYIu8
         /2ww==
X-Gm-Message-State: AOAM532x05bmjt5ZWz+ZmosLedNY9+F8r1aNhQscMb6QLCRm9WihD6vp
        Qd7kaTRJCPV37YOBHpiliyc=
X-Google-Smtp-Source: ABdhPJzyIQBGa1ntOKSqo1SvAnBFrCrm6S7cNpV+bs4hx8uQCJMs5mKCao88L4qsI/tdDw36VJZWCA==
X-Received: by 2002:aa7:9431:: with SMTP id y17mr238635pfo.33.1591206154354;
        Wed, 03 Jun 2020 10:42:34 -0700 (PDT)
Received: from gmail.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id nl8sm3772210pjb.13.2020.06.03.10.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:42:33 -0700 (PDT)
Date:   Wed, 3 Jun 2020 23:12:25 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [RESEND PATCH v1 6/6] staging: greybus: audio: Enable GB codec,
 audio module compilation.
Message-ID: <20200603174222.GB21465@gmail.com>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
 <77cfc355b87ee21636430f787764700de1983f38.1591040859.git.vaibhav.sr@gmail.com>
 <20200602125715.GI30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602125715.GI30374@kadam>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:57:15PM +0300, Dan Carpenter wrote:
> On Tue, Jun 02, 2020 at 10:51:15AM +0530, Vaibhav Agarwal wrote:
> > Currently, GB codec and audio module is conditionally compiled based on
> > GREYBUS_AUDIO_MSM8994. However, audio module is not dependent on MSM8994
> > platform and can be used generically with any platform that follows
> > GB Audio class specification.
> > 
> > Also, GB codec driver corresponds to dummy codec represented by I2S port
> > available on Toshiba AP Bridge. Added config option for the same in
> > kconfig file and accordingly updated Makefile.
> > 
> 
> This commit message was a bit confusing to me.  Just say:
> 
> "Currently you can't enable the Grey Bus Audio Codec because there is no
> entry for it in the Kconfig file.  Originally the config name was going
> to be AUDIO_MSM8994 but that's not correct because other types of
> hardware are supported now.  I have chosen the name AUDIO_APB_CODEC
> instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
> make the compile work."
> 
> Otherwise this looks fine.

Thanks Dan for sharing your valuable feedback. I'll make the suggested 
changes for the complete series in v2 patchset.

regards,
vaibhav

> 
> regards,
> dan carpenter
> 
