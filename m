Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D2C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD28214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AJL05RC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgA0JGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:06:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39360 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0JGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:06:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so6147051wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=skD6KsbNTC8YBufTx8994xeXMmd4LfxtNfKHHZSZCCY=;
        b=AJL05RC9RoDfUiHa6C7xxV56b4sdHOTDCYY4TtWFrJFHLyjCxrG3407rseG2rXVPuG
         hKC/qEjXeJQbHLnl3RKWbDwNtmnNS8PVmakd83ftgjoxJhrAeS0CTn7y/UpcHhdIGokv
         MzaFHBxUKO1QwykBt9FZhgOlYtIQL9G1z/csE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=skD6KsbNTC8YBufTx8994xeXMmd4LfxtNfKHHZSZCCY=;
        b=Y9z2y6b05dWJHW5U6MZz9mIj74uua55lKbISOY0x8fepsl809FWT3QsKtm3o6O1ecw
         CcMyJ/HMPc3rF3j5pP84znfHLTGn5t37+T6TAdx77s2/rhLxZhPMd+zVfxOfyBg4Pu8G
         ZCC1I2gbNAcAB0mZ6lqfcoJ3nMNapCtEV3YDt9+Fz1Kx4lO9HwbgBbBphARY1wgJ405J
         jKXNTpBcDdfJaEngQTwn82t0qkZf0hN7e7MO4EE8vi/J2LW8jsfTORUmquZV01Ef/CrU
         xtQ+/n9V264+oAzyZs/ZlsI92AsIanz/LcHuIGfvfkyiVUn0itKwrraWWx4bcE7J6HFw
         czmQ==
X-Gm-Message-State: APjAAAX641Eg70+NJHmaDO4lT2vm5XntPXDt/citFjD4Tdi0J5xJ39tw
        DziKrhKZl1ldd4Oeus9xqf1FFA==
X-Google-Smtp-Source: APXvYqz7HgDc75LeHLHMNJ1pvjtFzSNhVwrleSA9jWJFlTZ+Be7nFmdMno9WF/N8WTsD3Fbz/nVZKw==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr10813787wme.25.1580115960316;
        Mon, 27 Jan 2020 01:06:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c2sm19726310wrp.46.2020.01.27.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:05:59 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:05:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com
Subject: Re: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
Message-ID: <20200127090557.GU43062@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com
References: <20200122125750.9737-1-wambui.karugax@gmail.com>
 <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 04:08:39PM +0000, Chris Wilson wrote:
> Quoting Wambui Karuga (2020-01-22 12:57:48)
> > This series is a part of the conversion to  the new struct drm_device
> > based logging macros in drm/i915.
> > This series focuses on the drm/i915/gem directory and converts all
> > straightforward instances of the printk based logging macros to the new
> > macros.
> 
> Overall, I'm not keen on this as it perpetuates the mistake of putting
> client debug message in dmesg and now gives them even more an air of
> being device driver debug messages. We need a mechanism by which we
> report the details of what a client did wrong back to that client
> (tracefs + context/client getparam to return an isolated debug fd is my
> idea).

Sean is working on that, but it's a global thing still. Well since it's
tracefs should be easy to filter for a given process at least. We've had
long discussion about how to expose that, big fear (especially with
atomic) is that clients/compositors will start to look at random debug
strings and make them uapi.

But I think for stuff like igt we should be able to wire it up easily and
get it dumped when things go wrong. Maybe similar when mesa gets an
unexpected errno.
-Daniel

> > Wambui Karuga (2):
> >   drm/i915/gem: initial conversion to new logging macros using
> >     coccinelle.
> >   drm/i915/gem: manual conversion to struct drm_device logging macros.
> 
> Still this is a necessary evil for the current situation,
> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> -Chris

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
