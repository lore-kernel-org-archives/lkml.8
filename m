Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF64C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC3214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgA0JIO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:08:14 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:50768 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728253AbgA0JIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:08:13 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20018998-1500050 
        for multiple; Mon, 27 Jan 2020 09:08:04 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200127090557.GU43062@phenom.ffwll.local>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com
References: <20200122125750.9737-1-wambui.karugax@gmail.com>
 <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
 <20200127090557.GU43062@phenom.ffwll.local>
Message-ID: <158011608131.25356.4337758241793042878@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
Date:   Mon, 27 Jan 2020 09:08:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2020-01-27 09:05:57)
> On Sat, Jan 25, 2020 at 04:08:39PM +0000, Chris Wilson wrote:
> > Quoting Wambui Karuga (2020-01-22 12:57:48)
> > > This series is a part of the conversion to  the new struct drm_device
> > > based logging macros in drm/i915.
> > > This series focuses on the drm/i915/gem directory and converts all
> > > straightforward instances of the printk based logging macros to the new
> > > macros.
> > 
> > Overall, I'm not keen on this as it perpetuates the mistake of putting
> > client debug message in dmesg and now gives them even more an air of
> > being device driver debug messages. We need a mechanism by which we
> > report the details of what a client did wrong back to that client
> > (tracefs + context/client getparam to return an isolated debug fd is my
> > idea).
> 
> Sean is working on that, but it's a global thing still.

Go look at how I suggest we can use tracefs in that thread :)
-Chris
