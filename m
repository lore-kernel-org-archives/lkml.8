Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D18CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF04206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZ9Fss7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgGGSiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgGGSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:37:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17757C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:37:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so139789wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLoc7XcLQBFweGrIZl963QXxR/Kuf/uGSt/aRtsqQXA=;
        b=RZ9Fss7DKBKwILhHXMQiVLBHaDpNXqgCERg4Ug14fAdONP0G6MQJBBJfrZe6h39rjo
         CEW9YkDp3qC7EIbbZ962ghmcUF7tOqtSTEqUp4XkhvbFkbzlQIRO9pnsC7xKDctd0G8q
         H+0lcYyOiMcg0DgIRLsOgtJyxqsy/1QqUA0u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLoc7XcLQBFweGrIZl963QXxR/Kuf/uGSt/aRtsqQXA=;
        b=eD+mXCJvDYScKFKwoHakePWiG3AFiEtpQ1+K3ko3Yp4F4I7Uj8JUx/s7YM0sSV6vJp
         qbSK9em++goXdSQd6LCHD0azKwgb4LpWAQb2v6wHO+cxC36e6gXqCsJzCWp17IVeDmRs
         ML5q3+MvC37NWOp16DYcx3Te6uiG9fKOrsvaLTE1m48D7Gpf2lU/Q0z5hSlOQNNCWYDH
         SlTUY42CH2G91NsuEy5kwba6zg47VXwNBWbN/cmX8i65Yz98isQ0wabLtxzY7+9Zxveu
         RG4vM+mXNXGoNG55f78yCXg185EWtVZ6KZ/xG5Z1uhiCa4l1OvY8DVdFMxJa+yUQS/ny
         AdRQ==
X-Gm-Message-State: AOAM532bCXeVkQzJY+BlNVTgOn/JX0vult1XTQhc13zgEzCFzRIIMTUg
        8/UoZk12G6HSSiqy2rW59Irybw==
X-Google-Smtp-Source: ABdhPJwTp5c+4PKMXHNlBDs5EyJmIu3hyAcO4wuFz0Eh5JtNDlZ7x+t1jLcMZPwjhFhde9Jltdhn5A==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr5582199wme.69.1594147077882;
        Tue, 07 Jul 2020 11:37:57 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id f17sm2461364wme.14.2020.07.07.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:37:57 -0700 (PDT)
Date:   Tue, 7 Jul 2020 18:37:56 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] media: exynos4-is: Remove inh_sensor_ctrls
Message-ID: <20200707183756.GH2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB0660F4263807BBE9EF1DA26BA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660F4263807BBE9EF1DA26BA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:26:47PM -0700, Jonathan Bakker wrote:
> This is a no-op as it is never set and is a remnant from non-DT days
> that can be safely removed.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/fimc-capture.c | 13 +------------
>  drivers/media/platform/exynos4-is/fimc-core.h    |  3 ---
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
