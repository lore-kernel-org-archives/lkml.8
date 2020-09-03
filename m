Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151663;
	bh=fgvrvS59jSgN+YToxsj2Nbt2XMbpHPk1z7zm+qtKIT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12dd1fHDsEb3FDCzUZJeLhqfYspQlcBuYDPhdCeNPax+0wiQupAFOGPl6sAyJ/mOH
	 +/+PxcLI+lvNCMgnfFjkxjLT3Pf+lvsg/X/ylx6GQ44FNxWGNw6Bk9Z+qsj9fjAymo
	 lorbHq2gd146iV67rQBhIDFCd4TE0yp4LBAttrEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgICQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:47:42 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38691 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgICQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:47:40 -0400
Received: by mail-il1-f195.google.com with SMTP id w3so3328486ilh.5;
        Thu, 03 Sep 2020 09:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpkYtO3goB70S5Zk4sLb1vXO3uhYcLt8YvepwZ1oACw=;
        b=YhOvgh9GUlJ31ev23FwHMOSkG5sMDgKj173r4dK1BpcU7BlAXM9NZQjEUupL/zfgXT
         Oc0/0NK/6FGUX9Nd/twieRzVjjoMpPREzNLPIZ9cWNXTuozWZJUV7nwE2ZQOxYrD0x2p
         X8LKdjGtZXV1TgknlrJIsxCCPV9hD5d7VY9eMoSRBSUimVx5KoLerDd+wVvuYRu47XWU
         dDrBHF+b0R94CROFFPpMItWmI0laIywY/+DkNKC/V91njpa8q+jkcjFWmjXKmGy5E4to
         4LBwcnbv9ChFR3HS3RpzZTk+79jd1o6X9pXGxhQ5z1ZtK8Lnm3eV/7vkVyJXJQz/FbCq
         BhFw==
X-Gm-Message-State: AOAM533KiD/kqumW8kz2uzDZKFrSfty2M9Mg1eHHqp9he0XZFyXQIssA
        AeqiojjGvR8kywvf7TPRYA==
X-Google-Smtp-Source: ABdhPJzm0dZgqusi1IwGj/t8TXXA2VCoB4/ojBoVS5J1+GJ8RiWXpDpcvKXVi0SJpK3PWvduyYrVUA==
X-Received: by 2002:a92:60b:: with SMTP id x11mr3795331ilg.179.1599151659642;
        Thu, 03 Sep 2020 09:47:39 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h15sm1614283ils.74.2020.09.03.09.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:47:39 -0700 (PDT)
Received: (nullmailer pid 2931399 invoked by uid 1000);
        Thu, 03 Sep 2020 16:47:38 -0000
Date:   Thu, 3 Sep 2020 10:47:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200903164738.GA2929052@bogus>
References: <20200830112633.6732-1-krzk@kernel.org>
 <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:50:05PM +0100, Mark Brown wrote:
> On Sun, 30 Aug 2020 13:26:32 +0200, Krzysztof Kozlowski wrote:
> > The "sound-dai" property has cells therefore phandle-array should be
> > used, even if it is just one phandle.  This fixes dtbs_check warnings
> > like:
> > 
> >   arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0:1: missing phandle tag in 0
> >   arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0: [158, 0] is too long
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/2] ASoC: midas-audio: Correct parsing sound-dai phandles
>       commit: 3e7ba1c0432ef9a792b9c77d36f78037626303b0
> [2/2] ASoC: odroid: Use unevaluatedProperties
>       commit: a57307ca6b661e16f9435a25f376ac277c3de697

This one should be reverted/dropped too. Patch 1 is fine.

