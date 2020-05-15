Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAD0206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncWP6c8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgEOAkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgEOAkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:40:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4AC05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:39:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 9so175179pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MxFx2v3CXXJI2uqpzJc0nTIbU803tm+QFkEcg6RoGME=;
        b=ncWP6c8T/qeB5mTi8dmQ/2f++LBk5CizP09+SlPJnyCzgNs/XM3OV3LABFolMAuaaE
         UYHUIc3yE2lEXImqHTT1olFACAUL2RuRf0qtmuTLimsMw3ZEFjzxm4slAwvUIDb2cFT/
         wcJNyV8sDtE3sXgsivVXiTYvixU3wl/p0/67k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxFx2v3CXXJI2uqpzJc0nTIbU803tm+QFkEcg6RoGME=;
        b=PreedwJEp/RJ+G1LpSDXdKuxcb4vs0+O25I/gGZbTiWpt/iwf5CeqZqdHZ/vUA35Gm
         YE8M35JDEckVdt6IHW6ZDIY9nVz51i7BEjdarzyZOW6eQSEV9O3dPFNC0G6LjDyrQhuz
         eq6ZiFlAwb4wmJqxna8ETz90672Zgq0eXrcCpA4eU6hO26YMfDuDAxVDwoIKn1puSYCm
         xMdq4OHTooQkPLihxDpy/F8mOek5CBtR/Yrn8xKgMi1wMpl2KvdapbCew6qeEfCMowD3
         bG93fcTFtXBLVGufYU3RYyJ5N1VTkz2QsZz6g6yjzqPzgwZsEhaXEqFg6D/y28nP8++C
         egkA==
X-Gm-Message-State: AOAM5339AIZBQDSvWBDEnGtNWfhOtuiWsJczNhzy9kQFVYQF3x7FK8UT
        6SlhqzeXNnqCvfAE6xoSuYSyuw==
X-Google-Smtp-Source: ABdhPJyyWhg/HZloV77tc/5SwAYHguc5UciRxuk4OrFHLyBPk1weM70XMcLYipySphGQrca0OnCZSQ==
X-Received: by 2002:a62:3343:: with SMTP id z64mr1187982pfz.55.1589503199243;
        Thu, 14 May 2020 17:39:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 138sm334556pfz.31.2020.05.14.17.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 17:39:58 -0700 (PDT)
Date:   Thu, 14 May 2020 17:39:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org
Subject: Re: [PATCH 4/6] drm: msm: a6xx: send opp instead of a frequency
Message-ID: <20200515003957.GV4525@google.com>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-5-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589453659-27581-5-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:24:17PM +0530, Sharat Masetty wrote:
> This patch changes the plumbing to send the devfreq recommended opp rather
> than the frequency. Also consolidate and rearrange the code in a6xx to set
> the GPU frequency and the icc vote in preparation for the upcoming
> changes for GPU->DDR scaling votes.

Could this be relatively easily split in two patches, one passing the OPP
instead of the frequency, and another doing the consolidation? It typically
makes reviewing easier when logically unrelated changes are done in separate
patches.
