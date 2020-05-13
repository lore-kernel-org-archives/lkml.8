Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF583C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55A1206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjfoER6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgEMKgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEMKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:36:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BFC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:36:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so10935366pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHAK9rmg4ihryn7dWy8ERefZSMD9WKN9yuq0hlEY9T0=;
        b=XjfoER6qp1iV1JqqLmfkTcI3Z7RDnvj/2ICf1lwSpxxHDE5FddSKtVM17vQO18ZZaN
         jnRbjSVlMNLVPTMuaIbpvO2MOp+Aq+wkqwMxJe5JSBicRPZ4dqx7sfodGdE8zHNVqAVz
         qGKaqSLtkKfJijyD5uPmde3oOXy/of90NOpokyBJbH1+8gfB1pVMRMPvAXepCPPhSni7
         M7subFU0CaX2HRWZT40mTwE5iXPwEWzeZupNafcYvP7tuN3xZnccEHpZDRUOu5V90uLo
         rRuqTZMAJzX4ToxZwFCJecpPJZhh0ULlTEigXSoYO23N/rMpuxAvu9XsePAUZQmtLLwd
         d81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHAK9rmg4ihryn7dWy8ERefZSMD9WKN9yuq0hlEY9T0=;
        b=boVPGVcy/9XV6Jw2EwAw07iPttXw8Z7PT7bQBzeXoRdv7LaaPrQiWxPTnfjE4ZZNT1
         ZIIegZKttDF3i+9RMEZVReYcEXd1hMdL5UE6urc9e1V/rc71GDXDnpc68LMekwwW4gNH
         HZaMiqutb68xl3Zo21WExd612Dds0KkTc3ehkv4UMHJAlKvCec6Nd8dtBQEl5MJ/iKe4
         7nP/ssz1wvoJy4lc81zmnFvMc2l2UsmQq25ZXSKeS3ZuBzsPag6sEt4EwYcgB2jNp//s
         xlFm8zuqlZjDdQ8jpIy6bC65xI8Z6nclfW31DWr74XFpz7JSpKtMWSHd7kVvI/6uj7Kj
         voEQ==
X-Gm-Message-State: AGi0Pub/RGzEVcs7bE4Wri46VTlGB2R+JofUkgzLqJDS2tJbvFRV1NwU
        UJbJDgBvMckiyiE8pu1RSjfIOQ2REF3o
X-Google-Smtp-Source: APiQypK3ZXYzJtX6IQyIn7TmvsTPLK4dq5VNn8Vas2uExOsTkKPen59d4IMG1DlB4FFPZW8xoS1NEQ==
X-Received: by 2002:a17:902:eb43:: with SMTP id i3mr22140341pli.299.1589366166527;
        Wed, 13 May 2020 03:36:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:3d5a:d8ce:4edd:4c38:4a1b])
        by smtp.gmail.com with ESMTPSA id q21sm14208349pfg.131.2020.05.13.03.36.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 03:36:05 -0700 (PDT)
Date:   Wed, 13 May 2020 16:05:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 0/5] MHI Misc Fixes
Message-ID: <20200513103559.GB26866@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:04PM -0700, Hemant Kumar wrote:
> Patches are addressing MHI core driver bug fixes. Patches tested on
> arm64 and x86 platforms.
> 

Applied to mhi-next!

Thanks,
Mani

> Hemant Kumar (5):
>   bus: mhi: core: Remove the system error worker thread
>   bus: mhi: core: Handle disable transitions in state worker
>   bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
>   bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
>   bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition
> 
>  drivers/bus/mhi/core/init.c     |  3 ++-
>  drivers/bus/mhi/core/internal.h |  4 +++-
>  drivers/bus/mhi/core/main.c     | 38 +++++++++++++++++++----------
>  drivers/bus/mhi/core/pm.c       | 53 ++++++++++++++++++++++++-----------------
>  include/linux/mhi.h             |  2 --
>  5 files changed, 61 insertions(+), 39 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
