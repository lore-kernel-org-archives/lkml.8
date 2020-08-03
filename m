Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F26C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EBD206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596461686;
	bh=lCnx6/lKKN71vDIoGZq4QZBOOZHHDefyQEvwAiDgM2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywPflVZ2sYytwipq0a9JZNnFW65uSlNmuEHxDji4TKlYtWAFVga6pvrEbOZc9b5Ku
	 mZjUZxrNxzEXP55mmUT5N0i0xxH4a6nmTvd3VGawQc8WK2/JVmhmXnOLuZ4JS8hwhY
	 c4CAQCLWEQQFykjIezHJ70ZYvxG/+etC82YH7JOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHCNeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:34:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46877 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHCNep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:34:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id q4so24008628edv.13;
        Mon, 03 Aug 2020 06:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2n3wIwb+hcZxYRuwftBDgqPr+Mdz9q2nSbmotV8e58=;
        b=gC/3QIUoaqK3FGyp1lVRgfHLd3X3hq6r7nS3meJD6wwWElaJCOKqDpxX8+lChbPQzS
         j4cQRYM5g1EztdseoI1OnY17tUavY4XS9YFDpAATKrrRabiG3RJniOcWlFuMqEVbA9Zr
         KSEeha3XR/s0DDzpt3vcrn+AlTmr75oaDq3hQFbK+zf1UyDNCA18ADMkHC4xo+Kdhw62
         CpzBht2LRom6aSSN0dQk/yfPX4+ReL2TKk3fQdMqqqXNI2VPs+P/kCtveZ1MMR1pIAeu
         i7/EnEFKWuz75P9+QAk11k16zq+i7d+82v1UXHhRygP+IxR5cwBI4Jy1ZrZXResZAV0C
         ok/w==
X-Gm-Message-State: AOAM531T47GP7SQmmMeQE2QdrWNAkjbTR70zuZF1Q5PvPcEsymmc96fY
        61Xx8jF76kQyuxk8yC6poew/+61ZDJU=
X-Google-Smtp-Source: ABdhPJzNijIPixZfXIS6XxW0zDL2p3v+qA9MAw0zyiUVWPbpOHV/fLTU8cMpHgpxrwN5HZNA62aBog==
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr16286914edv.271.1596461682835;
        Mon, 03 Aug 2020 06:34:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id m20sm16177431ejk.90.2020.08.03.06.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 06:34:42 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:34:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: exynos: clear L220_AUX_CTRL_NS_LOCKDOWN in
 default l2c_aux_val
Message-ID: <20200803133439.GB476@kozik-lap>
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:47:31PM +0100, Guillaume Tucker wrote:
> The L220_AUX_CTRL_NS_LOCKDOWN flag is set during the L2C enable
> sequence.  There is no need to set it in the default register value,
> this was done before support for it was implemented in the code.  It
> is not set in the hardware initial value either.
> 
> Clean this up by removing this flag from the default l2c_aux_val, and
> add it to the l2c_aux_mask to print an alert message if it was already
> set before the kernel initialisation.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Makes sense. I'll take it after the merge window.

Best regards,
Krzysztof
