Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F50EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56196214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y4KGEArL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgA0JK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:10:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39754 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgA0JK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:10:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so10187118wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LaExmELKeqqN/VB6j8bOztxrjP/aSDG7/ka9tQvY4fk=;
        b=Y4KGEArLtLfFcYkM9T4qdX7a4awMuADTxyYdbXot2rxEuRXX1gBc7Cn9UdFb4j2+Db
         PHEjg+hhO3omHBCyaugLheiimIIawORmcYaTZJMcT8oMwvYapHdpNnlVvtfUK4m0EIFq
         u2zC7KQFOUJtSE/CunL00ayk6O79zlLEctr58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LaExmELKeqqN/VB6j8bOztxrjP/aSDG7/ka9tQvY4fk=;
        b=JR3t0oJDR2xo+zFsQstWknH0jStzx8VXD0iCKqH4oy1CVbvYVVQ8HtC+SuvE/g+Uwh
         rNBNo+TD+envVgj8GVuj8NeqtttRfpZ0rYb4w9IGPgto/pAU0gpWuoRRgekiwgm0XtDj
         t7TB/sOX7SWjUVX795UZvmqCt1j1W4b8TwL/h+DgbS9K2xZIZD13FKiea5b0ML6w942V
         zUs5G9zGRUp5C3wBsb9eLo/68GXmQIJtuudOlk406z5ru+4w9MbiVz1sbMDi2eiD66Vm
         OB/1yj699wsXr5E86uM/xqPR0W0tVNfAye9eEczof+3feqCCwxDpzASWAw0GWmqNEOW2
         V6dQ==
X-Gm-Message-State: APjAAAW1X2CGEDt7Pae6PDsIzJNpyXv2cbPUpPqzLobepj24VnJlyaDi
        494t2nPP2RDPOSRx5idB0bmNnA==
X-Google-Smtp-Source: APXvYqzC7sZ1/B3iVrM8iap5z9JWj2XjpCoYx7tnLotFwm+KVlGuUscVIplTRWzZkjlxGnyMoAMcFQ==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr20948867wrn.280.1580116256070;
        Mon, 27 Jan 2020 01:10:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t12sm19150488wrs.96.2020.01.27.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:10:55 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:10:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
Message-ID: <20200127091053.GV43062@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com
References: <20200122125750.9737-1-wambui.karugax@gmail.com>
 <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
 <20200127090557.GU43062@phenom.ffwll.local>
 <158011608131.25356.4337758241793042878@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158011608131.25356.4337758241793042878@skylake-alporthouse-com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:08:01AM +0000, Chris Wilson wrote:
> Quoting Daniel Vetter (2020-01-27 09:05:57)
> > On Sat, Jan 25, 2020 at 04:08:39PM +0000, Chris Wilson wrote:
> > > Quoting Wambui Karuga (2020-01-22 12:57:48)
> > > > This series is a part of the conversion to  the new struct drm_device
> > > > based logging macros in drm/i915.
> > > > This series focuses on the drm/i915/gem directory and converts all
> > > > straightforward instances of the printk based logging macros to the new
> > > > macros.
> > > 
> > > Overall, I'm not keen on this as it perpetuates the mistake of putting
> > > client debug message in dmesg and now gives them even more an air of
> > > being device driver debug messages. We need a mechanism by which we
> > > report the details of what a client did wrong back to that client
> > > (tracefs + context/client getparam to return an isolated debug fd is my
> > > idea).
> > 
> > Sean is working on that, but it's a global thing still.
> 
> Go look at how I suggest we can use tracefs in that thread :)

Hm I think we're a few threads further already? Steven Rostedt has jumped
in now too ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
