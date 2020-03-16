Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E484C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1130420658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bqhZBq8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgCPIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:33:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37727 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgCPIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:33:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so19990021wre.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Np0PyQ3dN/K0XmXOWBC7J7/OCl/vL8McW1IXy4RBUgE=;
        b=bqhZBq8gCbsRh+Ix9GzmFj7etr9aCj5k2VDWtb9DCZDwiUCQ4xy5s1cpMAc2jIBpCo
         WwxG0+8bynS7HTBvZ+IMWiWgLzWMCoq2Jcy6TDEG7/yEMjhTa16mzIVokPevbP+2vpVz
         /IfRIBrdLITDf1yOGV5zCQasJlEzEhPdG8440=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Np0PyQ3dN/K0XmXOWBC7J7/OCl/vL8McW1IXy4RBUgE=;
        b=i2kV04hwzu6wU7wlusaFk0weGNBoR9Glf4Hl2JY6nyg6y1espzPSTjJsgE6cUiWO/F
         ZGOawDeWXcNvXu1WAy9mqRN+un4OV8U+/gZGMNhiBBzaiFdEZduAhCRJ2GhAolYqUW5z
         XE0qIAeTwVZ0RhCIkCeWxYBy3Nb2k4jmHLjnKXwSAGepKqKBaR1+pFZx86+hGXRrtkVm
         vznTBqG4S3KiZxi8yowpYOq5Jc0lg6IYstPjCtKleZZgtYhI3vh+aVoGYU+XtzC5x6tv
         cjVGXVT1TlP1SqEyYK140tfaa/Ivw0osA1xetbFjDltoNkAzEkryCV/Wh292fI+6mhj+
         s4oA==
X-Gm-Message-State: ANhLgQ0UDc0fTs69En9FEykrZMNKDxu6MPR0XvbpQn7q9JT/lsDejqud
        hYZcezkbQucCU43rVOnz4LjcVQ==
X-Google-Smtp-Source: ADFU+vv5wVdXdcx4EeLmKazJGTmA1SjA1iRGsWULv81fmZZvk3NWZudyD95lysFKRly5AByJQvUxng==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr19250023wru.159.1584347592539;
        Mon, 16 Mar 2020 01:33:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g7sm93502349wrq.21.2020.03.16.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:33:11 -0700 (PDT)
Date:   Mon, 16 Mar 2020 09:33:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/21] drm/tegra: remove checks for debugfs functions
 return value
Message-ID: <20200316083309.GD2363188@phenom.ffwll.local>
Mail-Followup-To: Thierry Reding <thierry.reding@gmail.com>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-11-wambui.karugax@gmail.com>
 <20200311143753.GC494173@ulmo>
 <alpine.LNX.2.21.99999.375.2003111750360.14786@wambui>
 <20200311232446.GA998881@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311232446.GA998881@ulmo>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:24:46AM +0100, Thierry Reding wrote:
> On Wed, Mar 11, 2020 at 05:54:46PM +0300, Wambui Karuga wrote:
> > Hey Thierry,
> > 
> > On Wed, 11 Mar 2020, Thierry Reding wrote:
> > 
> > > On Thu, Feb 27, 2020 at 03:02:21PM +0300, Wambui Karuga wrote:
> > > > Since 987d65d01356 (drm: debugfs: make
> > > > drm_debugfs_create_files() never fail) there is no need to check the
> > > > return value of drm_debugfs_create_files(). Therefore, remove the
> > > > return checks and error handling of the drm_debugfs_create_files()
> > > > function from various debugfs init functions in drm/tegra and have
> > > > them return 0 directly.
> > > > 
> > > > This change also includes removing the use of drm_debugfs_create_files
> > > > as a return value in tegra_debugfs_init() and have the function declared
> > > > as void.
> > > > 
> > > > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/tegra/dc.c   | 11 +----------
> > > >  drivers/gpu/drm/tegra/drm.c  |  8 ++++----
> > > >  drivers/gpu/drm/tegra/dsi.c  | 11 +----------
> > > >  drivers/gpu/drm/tegra/hdmi.c | 11 +----------
> > > >  drivers/gpu/drm/tegra/sor.c  | 11 +----------
> > > >  5 files changed, 8 insertions(+), 44 deletions(-)
> > > 
> > > Applied, thanks.
> > > 
> > There's a newer version[1] of this patch series as this specific patch
> > depends on other work in drm.
> 
> Oh yeah, I just noticed that this patch causes a build failure, so I
> backed it out again.
> 
> If there's dependencies on other work, it's probably best to take this
> through drm-misc, in which case:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Let me know if you'd prefer me to apply this to drm/tegra instead.

Yeah I'm going to pull in the entire series through -misc rsn.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
