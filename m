Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E67E207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbisGLjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbgERSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgERSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:30:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44465C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:30:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b8so5222419pgi.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66BENZkKJdscrKXw0ODwzFcr1IXdRBxhdFQSFMOWssw=;
        b=BbisGLjf3FNDMjbQcmYHxKKASqShM9Q38fh+ZAm2fNnRRbEZE92f5+zgkfkWsT6lzP
         Y6UYWsK2IzFEBWi0s8uR39LnFO7d6cgo+9iao9K8JC9jHGO0f5tSauFodWvkfSjYOpST
         bff0D8UDAWveJEHNLUFT1N2rh+cvyKIZNzXVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66BENZkKJdscrKXw0ODwzFcr1IXdRBxhdFQSFMOWssw=;
        b=Ye0+2SQ8+n95Yju5FnwufOkjddCK8bOgaE8jBDaiOeaDcbBki0sjXW/fA5+l2PbQRT
         DJZ07jKjTchwjBt0xqzBSgcygZCsk9qy4vcMxLn4Lfw317K5F3n6BylWQDhKUtvcIBuf
         p0RpfrDzfun5XdE6xYONMyjoxMo62yGLNpTPJ5ipJVsRJVZOzZfHQGefdiZgdIpOpwTX
         SJLDwNQ0h3HF8PPdqZWI8ZW8JdJ8f9GKVj06eR9s2L33Q/88cVkfMgZ7WX1kWrMEjIA3
         +C7DXegSUXJXjIAqfr58+EzOFqIQsCTdA1svI5dKdXEDH7Yrjn8Kymri4MDGIwhC6mJl
         nqHQ==
X-Gm-Message-State: AOAM530QvbPbLrv5lBnsvRTUO0Zi56RAo56zr5eOpmRClpmwkseuzZ8T
        rPwngNpoMd2SoV/4nlW5IPzU/RgP/rg=
X-Google-Smtp-Source: ABdhPJzck1NyP/ujlthN1xTgEpPDHl6SqkzLwawIouGGPku0X6jcedoebsr/OYB2YsfNZ8LwxDgm/w==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr15791324pgp.425.1589826606534;
        Mon, 18 May 2020 11:30:06 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id s102sm198758pjb.57.2020.05.18.11.30.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:30:06 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id f15so4580059plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:30:06 -0700 (PDT)
X-Received: by 2002:a67:e952:: with SMTP id p18mr5212098vso.73.1589826235405;
 Mon, 18 May 2020 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200504213225.1.I21646c7c37ff63f52ae6cdccc9bc829fbc3d9424@changeid>
 <CAF6AEGs0qpzgGW8rYdmFqKW=QBbRxxzCWjO0LXsbm6hA0AJNyQ@mail.gmail.com>
In-Reply-To: <CAF6AEGs0qpzgGW8rYdmFqKW=QBbRxxzCWjO0LXsbm6hA0AJNyQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 May 2020 11:23:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQ2HtnWFyhachm9QyhkXVhMzRoiR=rWbmukmVYciL3Gw@mail.gmail.com>
Message-ID: <CAD=FV=WQ2HtnWFyhachm9QyhkXVhMzRoiR=rWbmukmVYciL3Gw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix off-by-one error in clock choice
To:     Rob Clark <robdclark@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

On Fri, May 15, 2020 at 2:49 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, May 4, 2020 at 9:32 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > If the rate in our table is _equal_ to the rate we want then it's OK
> > to pick it.  It doesn't need to be greater than the one we want.
> >
> > Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Rob Clark <robdclark@gmail.com>

...and I think this is the last of the patches I stupidly didn't CC
you on that's ready to go.

-Doug
