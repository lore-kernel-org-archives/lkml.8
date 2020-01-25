Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6742071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAYQIz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:08:55 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:63269 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgAYQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:08:54 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20007198-1500050 
        for multiple; Sat, 25 Jan 2020 16:08:42 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com
References: <20200122125750.9737-1-wambui.karugax@gmail.com>
In-Reply-To: <20200122125750.9737-1-wambui.karugax@gmail.com>
Message-ID: <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
Subject: Re: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
Date:   Sat, 25 Jan 2020 16:08:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wambui Karuga (2020-01-22 12:57:48)
> This series is a part of the conversion to  the new struct drm_device
> based logging macros in drm/i915.
> This series focuses on the drm/i915/gem directory and converts all
> straightforward instances of the printk based logging macros to the new
> macros.

Overall, I'm not keen on this as it perpetuates the mistake of putting
client debug message in dmesg and now gives them even more an air of
being device driver debug messages. We need a mechanism by which we
report the details of what a client did wrong back to that client
(tracefs + context/client getparam to return an isolated debug fd is my
idea).

> Wambui Karuga (2):
>   drm/i915/gem: initial conversion to new logging macros using
>     coccinelle.
>   drm/i915/gem: manual conversion to struct drm_device logging macros.

Still this is a necessary evil for the current situation,
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
