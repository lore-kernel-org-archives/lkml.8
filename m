Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EEC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2420848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FTZpPoyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:41:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51681 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:41:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id a132so1829561wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1wu7CnjB7LWUSgWKY+oPfgF8Ae17D76/Awvhld15JQ=;
        b=FTZpPoySb6SE3kKbyRE9Qqor+wYAfHak7cRwmcekJSuCp2naplvU8zddhGgy0ZmJJh
         ELzBeWVQR8wxQU/CKCEPWE2XNsXl2fKHM6PeW8CPzF1A10dl/2ga/rRwE6tHOR3V8rMo
         eDxC51Gi0HEO/6tjDSkLi261T45zwOcJ5J64M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=c1wu7CnjB7LWUSgWKY+oPfgF8Ae17D76/Awvhld15JQ=;
        b=I25SYUh80I3UVfeD6c9UgCXldug8pC+uyrq7vZAfe3xfXbYGk3FcNDpkY2BNo7hRfO
         M6NFKvuCqHVbVJUnbemuDwzovGr0GI526utDUvTU3EcjjDmqj7gojbKbCwDFjvPIyf5/
         D0YvSsRvzCen4lojddSVCt/ih3BP/zMdzZi0rbd6VJV2AtiDQe+slTXAOrwQonqXFKNa
         +Y3zDo8xYJnuGVrNvJkvegw3TRL/Z/GhySGN4IaontZrziKOR/uwVggjWXoFTzfgLZt/
         Y8ZW93lqrm/YVsZyAhlYIxEVOptVGrex1UEDv3DfYp94p6hnli3cQIns8R0hgm1tGrwl
         Oogg==
X-Gm-Message-State: ANhLgQ2UJzaGKgJ6jmBKiWiZPcKLINmYzD0RqpUBZ1gEK70OECz1yRcS
        6NzmBWwk6hznmkSbgXRxWmXqcQ==
X-Google-Smtp-Source: ADFU+vvBTIMi9t1dx9pJC/4HMs9ttoNP7F6u7t1F9V0/9Qx4SEFsHfDu62Y7oZtF2ryRxPNB6eQ90A==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr3529887wma.177.1583491280746;
        Fri, 06 Mar 2020 02:41:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w8sm14588716wmm.0.2020.03.06.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:41:20 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:41:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/vboxvideo/vboxvideo.h: Replace zero-length
 array with flexible-array member
Message-ID: <20200306104118.GV2363188@phenom.ffwll.local>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200305105558.GA19124@embeddedor>
 <8e2ab9a2-fb47-1d61-d09c-0510ad5ee5ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2ab9a2-fb47-1d61-d09c-0510ad5ee5ff@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 03:22:38PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/5/20 11:55 AM, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >          int stuff;
> >          struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

You're also going to push this? r-b by maintainers without any hint to
what's going to happen is always rather confusing.
-Daniel

> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >   drivers/gpu/drm/vboxvideo/vboxvideo.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> > index 0592004f71aa..a5de40fe1a76 100644
> > --- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
> > +++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> > @@ -138,7 +138,7 @@ struct vbva_buffer {
> >   	u32 data_len;
> >   	/* variable size for the rest of the vbva_buffer area in VRAM. */
> > -	u8 data[0];
> > +	u8 data[];
> >   } __packed;
> >   #define VBVA_MAX_RECORD_SIZE (128 * 1024 * 1024)
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
