Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F026C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989920CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ep9UKTxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgCaIB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:01:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgCaIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:01:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so24639579wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NP7RN6gDze0UfJ8t7IIvwLkl0F8QdLj5fqt2LMXUxbY=;
        b=Ep9UKTxoYhSEudWlGvEXKt3K7JAmOqoB4BJ2hTrbsmBIbp10oYGBfmvzcQkdI0HODH
         kPkBYd3A83rKErAAx8VEjuLBVmy4o6niPOrVVosAHK4jZcl76PrvtJgY9bAv+MwTNTP/
         mZdJOvVcPB92CkZ/F6CZZQgtzHWasemEjsYq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NP7RN6gDze0UfJ8t7IIvwLkl0F8QdLj5fqt2LMXUxbY=;
        b=TW66YX3Cflhjdce9UC5wXaxxxYWIp4zLxRJXMlBlbnakvc0WdGfBuBcueYgWsKOy48
         Z34RvBtAoZyphUTfbLAC5+AnQ3yiBHLUqLAvoe9r1FvSN1YKZQs66EjJoSOTsTK+7T9A
         uvo/7FwFwORtc9+lh8mCtAa0C6dhU+bPFd3Ej161qNd+EiiJ7HWZ34P1sGU3RyxfQktd
         0y8e1nrpWfVXVF3OLbNuPCQfnSjixYa7u/loFBeKS/6W/wp/Q00gtZ3jk9flgGSZD/js
         /0AN4mrkTdEqD79tuNrZnWzUBnamFKOynkaSFpdkx5c8MMiSnge0VXU+/XfuuLNqiVlD
         UQuw==
X-Gm-Message-State: ANhLgQ1T7b7kfl48tmzkYTiwVd+PFFfzgKu5zfmTeo2fNOC0fWYAyiQx
        mh/MfpnOTRKNAa74vrXgY2atgw==
X-Google-Smtp-Source: ADFU+vtz+p6vgrdf/PdwcY1Polm8UQcM+44sWG/RRvi5FdtnsFgNsXI5ZpfuKOcIvc7wLaV/6dTDTA==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr19211505wro.68.1585641685851;
        Tue, 31 Mar 2020 01:01:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t6sm2267999wma.30.2020.03.31.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:01:24 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:01:23 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        daniel.vetter@ffwll.ch, maarten.lankhorst@linux.intel.com,
        daniel.thompson@linaro.org, ghalat@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbcon: fix null-ptr-deref in fbcon_switch
Message-ID: <20200331080123.GI2363188@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        maarten.lankhorst@linux.intel.com, daniel.thompson@linaro.org,
        ghalat@redhat.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200329085647.25133-1-hqjagain@gmail.com>
 <20200330191619.GF7594@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330191619.GF7594@ravnborg.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 09:16:19PM +0200, Sam Ravnborg wrote:
> Hi Qiujun
> 
> On Sun, Mar 29, 2020 at 04:56:47PM +0800, Qiujun Huang wrote:
> > Set logo_shown to FBCON_LOGO_CANSHOW when the vc was deallocated.
> > 
> > syzkaller report: https://lkml.org/lkml/2020/3/27/403
> > general protection fault, probably for non-canonical address
> > 0xdffffc000000006c: 0000 [#1] SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
> > RIP: 0010:fbcon_switch+0x28f/0x1740
> > drivers/video/fbdev/core/fbcon.c:2260
> > 
> > Call Trace:
> > redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
> > vc_do_resize+0xfe7/0x1360 drivers/tty/vt/vt.c:1295
> > fbcon_init+0x1221/0x1ab0 drivers/video/fbdev/core/fbcon.c:1219
> > visual_init+0x305/0x5c0 drivers/tty/vt/vt.c:1062
> > do_bind_con_driver+0x536/0x890 drivers/tty/vt/vt.c:3542
> > do_take_over_console+0x453/0x5b0 drivers/tty/vt/vt.c:4122
> > do_fbcon_takeover+0x10b/0x210 drivers/video/fbdev/core/fbcon.c:588
> > fbcon_fb_registered+0x26b/0x340 drivers/video/fbdev/core/fbcon.c:3259
> > do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1664 [inline]
> > register_framebuffer+0x56e/0x980 drivers/video/fbdev/core/fbmem.c:1832
> > dlfb_usb_probe.cold+0x1743/0x1ba3 drivers/video/fbdev/udlfb.c:1735
> > usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
> > 
> > accessing vc_cons[logo_shown].d->vc_top causes the bug.
> > 
> > Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index bb6ae995c2e5..5eb3fc90f9f6 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -1283,6 +1283,9 @@ static void fbcon_deinit(struct vc_data *vc)
> >  	if (!con_is_bound(&fb_con))
> >  		fbcon_exit();
> >  
> > +	if (vc->vc_num == logo_shown)
> > +		logo_shown = FBCON_LOGO_CANSHOW;
> > +
> >  	return;
> >  }
> 
> Looks much better than the previous version.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I expect Bartlomiej to review/apply.

Especially for bugfixes I think better to push quicker than wait for
others to ... the point with drm-misc is real group maintainership and
benefitting from the flexibility, not reflecting the same strict hierarchy
but in a flat tree to make it look like it doesn't exist :-)

Applied to drm-misc-next-fixes with a cc: stable.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
