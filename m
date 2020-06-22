Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C60C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EC420767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592848238;
	bh=qjtp1/KH/WMZbRfbpQzHVmAu5e9VAzUBeh+srNPb4Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HrWQsHli3qW2VVsvSCHCWZ/Gl1FXWZkyL8zhVqWEncRZh+Ry/KDA3G867eW/37UtU
	 gYPfUyspplKA1g5o5FvtT9f/BV5OpHagRqInfMPcVWgWyOD4jxCkWWyr4q+qO8yoGv
	 uqm/X69HdHs2rlyY9i+UCYr8mzSZE5MCIO8AGbI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgFVRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:50:37 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33973 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgFVRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:50:36 -0400
Received: by mail-ej1-f68.google.com with SMTP id y10so4501832eje.1;
        Mon, 22 Jun 2020 10:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOTnjMjsu7xKDVdNqVPUTaQv3pQPCvDqx33cGwyLPp8=;
        b=SjbLwWFuJcdI9AzqCeHfRZT8iIDIcnPoGnl59o4XKNBcHmg3azNd0osaEn/TKN5VSV
         NwSPt/dHMeNpev9wrlx/F8m6TKlhuxioBHu5iEbrHDbtivH09Qlx+9pXO4POBN6fcGzJ
         WFu5BqzbqIa7fNsNKzbB8Omu0aEZOZPBPXpZb4koW8EqoP971a96FKTmEFeGAXkJpakS
         AHopcjZkVAVGSxMsU9Fm7jpyoAwLAHBSp9muhYpVC82c03xYtqaIVCMuVWy5SkW70n/e
         dyY25/6KEWvtwV0pNgxI6HQinRB3GTrwDsXWBh8xtPk95SU4d22Tdo7NhwIqgz57ZbXS
         HBNQ==
X-Gm-Message-State: AOAM533w79MrjNwhQ0iRccr+FCgzAsnBRqqqd3nZgATVOTHqOniMShM5
        p6MLfeOhFTYAH5U8wQzL/ok=
X-Google-Smtp-Source: ABdhPJwqCv6kCCLUnC8zvrY8jFVgGacYWcI+rhbYCVMJlmSQeTmHKLBbvMdE28EVRur5t8b44IybxQ==
X-Received: by 2002:a17:906:6d4b:: with SMTP id a11mr17477631ejt.108.1592848234574;
        Mon, 22 Jun 2020 10:50:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id rv14sm11814489ejb.110.2020.06.22.10.50.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 10:50:33 -0700 (PDT)
Date:   Mon, 22 Jun 2020 19:50:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in
 default l2c_aux_val
Message-ID: <20200622175031.GA29235@kozik-lap>
References: <c6d979c0050502cd1bca8619cb5ff95db239db12.1591969825.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6d979c0050502cd1bca8619cb5ff95db239db12.1591969825.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 02:58:37PM +0100, Guillaume Tucker wrote:
> This "alert" error message can be seen on exynos4412-odroidx2:
> 
>     L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
>     L2C: platform provided aux values permit register corruption.
> 
> Followed by this plain error message:
> 
>     L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> 
> To fix it, don't set the L310_AUX_CTRL_FULL_LINE_ZERO flag (bit 0) in
> the default value of l2c_aux_val.  It may instead be enabled when
> applicable by the logic in l2c310_enable() if the attribute
> "arm,full-line-zero-disable" was set in the device tree.
> 
> The initial commit that introduced this default value was in v2.6.38:
> 
>   1cf0eb799759 "ARM: S5PV310: Add L2 cache init function in cpu.c"
> 
> However, the code to set the L310_AUX_CTRL_FULL_LINE_ZERO flag and
> manage that feature was added much later and the default value was not
> updated then.  So this seems to have been a subtle oversight
> especially since enabling it only in the cache and not in the A9 core
> doesn't actually prevent the platform from running.  According to the
> TRM, the opposite would be a real issue, if the feature was enabled in
> the A9 core but not in the cache controller.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 2 +-

Thanks, applied.

Best regards,
Krzysztof

