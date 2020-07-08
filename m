Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC0AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEEE2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX27Ohwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGHUhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:37:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF2C061A0B;
        Wed,  8 Jul 2020 13:37:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so5000783plr.2;
        Wed, 08 Jul 2020 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0NVbZDhjlBz7Bz/rREiap5i+ELfKwqgcjVz9t4TTWc=;
        b=WX27OhwhfF1KO+Ze6CViHQ8qJvqRJbMGHiVeDjQ3KN4OdaIGhwEotGDNgJpxfOpo34
         P7sVZT9G4J2rU18HGZ9XwWGeEyfz8qbrMKyw0Nc6f/lWq3tlczK5p7rkBk3OTmtUhZoC
         0XX39qoyDkkF3H2PsAtmqIJ1fzfPRz5Qje3jlaZ7+gLNE/QfarSQH53j4dtxSLJ+Dotd
         fRP7a+3urPj3LslktzHbQ6Uk8V285v2+y7rPWTNxF1OEka3uHqU31CIC9l3jO4gdSFeC
         iHOt/XUgOrv96AlaCkTNtSqxYwyUlJtXhVsSIBbNa1y8VBWbKJHDtCtqTPgjWs1TXazC
         jE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0NVbZDhjlBz7Bz/rREiap5i+ELfKwqgcjVz9t4TTWc=;
        b=hq0tbcDZjZtY6t6kE1EPStKpytbI8/fxENH89+rvmNsYVWjvox3oXmi4qxCGlIcK0o
         PkIQINm3wrm35p0+9DRdQurguP70Syqp8tGTGnLIQw0b643k8lfLd0+oJLA6IeEENpit
         n/d9cm+r8gGli7AQIEvLBK3W0+AbyZ1vzj2loxLvMGxx6D5NYM7uujdCQ+LXi4s/kqPT
         JqC31pgvmC3kaQ/aBUYmM9CIneYf9I5z4jZ4iOcVwv43rJeJbIyCdxAsLLwShBL9SOzI
         kdPvxeiIvT3onj6vjQOr4GoGUErhk04VkRMR3FmXUyhwymiImf3FRo35T96iExFKHGJk
         T4KQ==
X-Gm-Message-State: AOAM5306xVGKULPRjw4D72+vp27SinC6SKn4UMCCEyYj+F5xct/GbJZ7
        GBdJ2Z+M5dOmIRB3yqEC5Hs=
X-Google-Smtp-Source: ABdhPJyiTorvYGWMmyw6VBYhC7TYxyusceeTAkVhfb9NoC7jwAGTNw/fEoGLr1V8Fvfo0WhkIgS09w==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr44905580pll.79.1594240650250;
        Wed, 08 Jul 2020 13:37:30 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id g5sm365707pjl.31.2020.07.08.13.37.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 13:37:29 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:37:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com
Subject: Re: [PATCH v10 1/5] iommu/arm-smmu: move TLB timeout and spin count
 macros
Message-ID: <20200708203716.GC28080@Asurada-Nvidia>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-2-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:13PM -0700, Krishna Reddy wrote:
> Move TLB timeout and spin count macros to header file to
> allow using the same from vendor specific implementations.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
