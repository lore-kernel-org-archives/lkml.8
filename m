Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D2A207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZhqiEQB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHKI6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHKI6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:58:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F04C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:58:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so1877681wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kI5qakFErIhAtlSahv1ie780vLsnJZJzRH85CVk9xkc=;
        b=ZhqiEQB0gxx0HMNGdIud33HXbwCcUGzAFvTEZOcnfrRehwjb8pJce47DxCS3Vpe/hO
         0W/c/dlmjtWDghDUtpf+BYA89HTOVxVctUrjarY7zXxYNXIwVqSUqn6u4n2MAPyGdHzH
         dPBRBhHUwVzJsYQnp6o2LC1HI/cO4MqsXyKNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kI5qakFErIhAtlSahv1ie780vLsnJZJzRH85CVk9xkc=;
        b=jMm1dv7Lzref0o1vPOyvtWiZay5JRG9aMR5Qswf5b8Rn8Guooc6jHVO2s41IWETsi7
         n2pEoNKZZqT8XWtMAbNHEes7XAJXoRlFqVszFqGpcOKyNhwn+DU22wxtLXCDnxIerd6B
         q9/BS+ZYT3yeuK7AwEs0czj1obO/r2nq90TGeytl8ROAl583b2OVWQRXwSTk9uHBvo6n
         YJN84InIekKjck0BKGJeIWWcWJo290nrkBERAlWCWUF/PvcOXmBBz+U1uYW5BnT5vjnQ
         HBhfR44YFmv1A4TNlnH9/YSUJYn1I+t1gXMx4KZ9eRob4t4GeI7t7xhQ8gF4wKRkOQ0f
         VmJQ==
X-Gm-Message-State: AOAM531bbnkTQp/P+6AgIovH836nbaM3weF8oSZmz9v0oqxTRv2NLqB/
        Hi8Hm+3gHBd3Nmf2BWInBxfFfg==
X-Google-Smtp-Source: ABdhPJySHjTR0UHPleGabdZv7zNIZM+F28Kgk+liHl+qFW7HhY9BvenSYNBJUkXh68zLkce7tt7d0g==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr3067068wmg.34.1597136312570;
        Tue, 11 Aug 2020 01:58:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g25sm3735876wmh.35.2020.08.11.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 01:58:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:58:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zwane Mwaikambo <zwanem@gmail.com>
Cc:     tcamuso@redhat.com, dkwon@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
Message-ID: <20200811085830.GZ2352366@phenom.ffwll.local>
Mail-Followup-To: Zwane Mwaikambo <zwanem@gmail.com>, tcamuso@redhat.com,
        dkwon@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> Hi Folks,
> 	I know this thread eventually dropped off due to not identifying 
> the underlying issue. It's still occuring on 5.8 and in my case it 
> happened because the udev device nodes for the DP aux devices were not 
> cleaned up whereas the kernel had no association with them. I can 
> reproduce the bug just by creating a device node for a non-existent minor 
> device and calling open().

Hm I don't have that thread anymore, but generally these bugs are solved
by not registering the device before it's ready for use. We do have
drm_connector->late_register for that stuff. Just a guess since I'm not
seeing full details here.
-Daniel

> 
> To me it still makes sense to just check aux_dev because the chardev has 
> no way to check before calling.
> 
> (gdb) list *drm_dp_aux_dev_get_by_minor+0x29
> 0x17b39 is in drm_dp_aux_dev_get_by_minor (drivers/gpu/drm/drm_dp_aux_dev.c:65).
> 60      static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
> 61      {
> 62              struct drm_dp_aux_dev *aux_dev = NULL;
> 63
> 64              mutex_lock(&aux_idr_mutex);
> 65              aux_dev = idr_find(&aux_idr, index);
> 66              if (!kref_get_unless_zero(&aux_dev->refcount))
> 67                      aux_dev = NULL;
> 68              mutex_unlock(&aux_idr_mutex);
> 69
> (gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
> $8 = 0x18
> 
> static int auxdev_open(struct inode *inode, struct file *file)
> {
>     unsigned int minor = iminor(inode);
>     struct drm_dp_aux_dev *aux_dev;
> 
>     aux_dev = drm_dp_aux_dev_get_by_minor(minor);
>     if (!aux_dev)
>         return -ENODEV;
> 
>     file->private_data = aux_dev;
>     return 0;
> }
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
