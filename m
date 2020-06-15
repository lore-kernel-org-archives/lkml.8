Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C841EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE720738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAMaUePf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFOGXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgFOGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:23:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996FC03E97C
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:23:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so6348068pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMjD/jZlOfc+fAUGkEXl65YinbY+zUt21mw95ubF/dE=;
        b=xAMaUePfDuF1ThufwZJVKKONMJOKTRJMWdqyRex3kVGyC4Ae+LSjrM5isO8bSYG4RC
         H90sidjDOXbdpTHi+bJcCFM/uOg+r7xBNvV3xd+ZbEbocn7F6U/35rN2V0mUCsXA47By
         Jdj4o82R9Lo6E1/8vlXj2hzNBto0oz6tcKcpPiX9iHpYNFGss4IfNLZVRLlr0/i93SSg
         fZHPRAzUXx8wBs1rQ5jNkFR2/8E8bEeicYGHurL5CvDP60rQncwkVmuSc6f9mtIs1mRA
         bIJIJ/VD3ViU3pSHJZuNRAkSH5ZmAS+Q9xVNNlpXSUMopHnHlq4yszjEgLRsImtd/5rQ
         2wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMjD/jZlOfc+fAUGkEXl65YinbY+zUt21mw95ubF/dE=;
        b=Pe1walA6Lg1NtRDfyORAnaPpms6tqng20Dg5jdIZ4W0PFa1KAWLv21bDpMsjohKG4/
         /17u6sphJfiv+s+KRKL3egnTWBKk7Ti25tcm+iEYqYun07J3XUdbcG+LngnZYx7f5q6Q
         DXTuVGu9S+jqJC2TWZv2S1cspqX9e3xCMehhJ5HR8TDu2rW/Oy7kaVd6kjP4FXzOjjCr
         UFAbZfVBzRmsriarXaSk4TfMERuy2Ieil3edxU/p+hyW+1X+bYKo6hVk0K+uKac8fKJV
         7PbMmt5tqCMx9XGnVan6zkKibsJZr8zm7Mo5KGQU1chFnEsWhgxFZJ3hGzc+FsWALDQp
         hwAg==
X-Gm-Message-State: AOAM532XRX8tchQHliLPglBI6+n1CNkcyP4iIfs3gygR3bPmCWEDkuoZ
        lGjS1NOoLHpJgjarpgM/rgrZQg==
X-Google-Smtp-Source: ABdhPJxwAMo1y8FPHgLT09IPRRljmFY+jBUdhioK1x+wI513O4XnacM1ENl2wrU/w3tubtWxTPXQWw==
X-Received: by 2002:a17:90a:c797:: with SMTP id gn23mr10283076pjb.165.1592202183152;
        Sun, 14 Jun 2020 23:23:03 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id a29sm12389483pfg.201.2020.06.14.23.23.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 23:23:02 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:53:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        mka@chromium.org, sibis@codeaurora.org, saravanak@google.com,
        robdclark@gmail.com
Subject: Re: [PATCH v3 0/6] Add support for GPU DDR BW scaling
Message-ID: <20200615062300.3g6rhcovbe6kssag@vireshk-i7>
References: <1591417551-38051-1-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591417551-38051-1-git-send-email-smasetty@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-20, 09:55, Sharat Masetty wrote:
> This is a respin of [1]. Incorported review feedback and fixed issues observed
> during testing. Picked up the Georgi's series from opp/linux-next [2], and this
> series is also dependent on a helper function needed to set and clear ddr
> bandwidth vote [3]. Patch number 4 in the series adds support for SDM845 as well
> but its not tested yet(WIP), but the SC7180 patches are well tested now.
> 
> [1] https://patchwork.freedesktop.org/series/75291/
> [2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/vireshk/pm/+log/opp/linux-next/
> [3] https://patchwork.kernel.org/patch/11590563/

Had a quick look of the series and looked mostly fine to me.

-- 
viresh
