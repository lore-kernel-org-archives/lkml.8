Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CCBC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A12063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CLNLKg0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgD3OE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgD3OEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:04:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BC0C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:04:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so7089640wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nR/4l2ev7gj1d0NQKfg0sKi3r/8R1EfLq6ZSdokkti0=;
        b=CLNLKg0o0uOpdjN9IbzQj/op7l2SGyu1cc9+t8YOcCk1v915ZlhWA/CqJ5FrIOiG9r
         x6iCMk9QkUl0bbJXAotNzObLcKX0Xb3ptTEm9gq12jm1aK0xWqkRGR8AIgQ5zkHR/b8E
         aBXt2CmDzyqI5yyv3UTaMogkUZixMnLM0gWzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nR/4l2ev7gj1d0NQKfg0sKi3r/8R1EfLq6ZSdokkti0=;
        b=gyG58QqVj/r1yCquzZeoEDNRy8qvWdIZ8l1z57UxAVVE1dcttl2opYdK2Cm/D9pki1
         seYVGZx51OxXkxBGvon7JMcVQ/W2Wx2vC935s90RcsnxrBcqYEzuzK730VxrgK/Md222
         9nK3JcnhjsiulT8ztyzaBXuafrg22YHibMr4Nvh1Y9RpBnpnS/OOT05fditzEoHinyoy
         3/157D9lZ/uqNPHyN7Xb/G47lmXlw2hxAAmJpSnYcfuRPfsMvWWRnuLL+cyFBKpgGoYB
         C3tgpjSspOdEs4wmHwU257PqHiFCmCDhDaKLudtpAQXaqf0JQvS9u3LI001hy8Cvkb4v
         lH7w==
X-Gm-Message-State: AGi0PuZMt7xl6thszA75Zo96Kn/sfuGEpySCbikDn/NsBg6VEDkgE0EI
        fZ46Fpy/1fMu+2d9K3HEdMV3pw==
X-Google-Smtp-Source: APiQypL0M5PkdpQFdPq72B3lypEZHvVXpjNaTNIr5PylaMj7pL4X2pMbQKG6KnwJtFVUx+06kk8Dvg==
X-Received: by 2002:adf:fc11:: with SMTP id i17mr4613274wrr.152.1588255459228;
        Thu, 30 Apr 2020 07:04:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 17sm12146575wmo.2.2020.04.30.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:04:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 16:04:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     kl@kl.wtf
Cc:     Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: make drm_file use keyed wakeups
Message-ID: <20200430140416.GG10381@phenom.ffwll.local>
Mail-Followup-To: kl@kl.wtf, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org
References: <20200428151410.GU3456981@phenom.ffwll.local>
 <20200424162615.10461-1-kl@kl.wtf>
 <e8d385dbfbbb09acfe58d716c588722c@kl.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d385dbfbbb09acfe58d716c588722c@kl.wtf>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:19:07AM +0000, kl@kl.wtf wrote:
> April 28, 2020 5:14 PM, "Daniel Vetter" <daniel@ffwll.ch> wrote:
> 
> > On Fri, Apr 24, 2020 at 06:26:15PM +0200, Kenny Levinsen wrote:
> > 
> >> Some processes, such as systemd, are only polling for EPOLLERR|EPOLLHUP.
> >> As drm_file uses unkeyed wakeups, such a poll can receive many spurious
> >> wakeups from uninteresting events if, for example, the file description
> >> is subscribed to vblank events. This is the case with systemd, as it
> >> polls a file description from logind that is shared with the users'
> >> compositor.
> >> 
> >> Use keyed wakeups to allow the wakeup target to more efficiently discard
> >> these uninteresting events.
> >> 
> >> Signed-off-by: Kenny Levinsen <kl@kl.wtf>
> > 
> > Hm I applied v1 and I'm not spotting what's different here, and there's no
> > changelog explaining what changed ...
> > 
> > Please send a fixup if there's anything important missing.
> > -Daniel
> >
> 
> It's only the summary that differed as you and sravn requested in #dri-devel, so it's probably fine.
> 
> I should have explained the change. I'm still trying to get the hang of the email-based workflow. :)

Oops sorry, I generally run as a stateless maintainer so forgot :-/

And yes email based workflow is full of warts, it's a pain.
-Daniel

> 
> Best regards,
> Kenny Levinsen
> 
> >> ---
> >> drivers/gpu/drm/drm_file.c | 6 ++++--
> >> 1 file changed, 4 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> >> index c4c704e01961..ec25b3d979d9 100644
> >> --- a/drivers/gpu/drm/drm_file.c
> >> +++ b/drivers/gpu/drm/drm_file.c
> >> @@ -608,7 +608,8 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
> >> file_priv->event_space -= length;
> >> list_add(&e->link, &file_priv->event_list);
> >> spin_unlock_irq(&dev->event_lock);
> >> - wake_up_interruptible(&file_priv->event_wait);
> >> + wake_up_interruptible_poll(&file_priv->event_wait,
> >> + EPOLLIN | EPOLLRDNORM);
> >> break;
> >> }
> >> 
> >> @@ -804,7 +805,8 @@ void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e)
> >> list_del(&e->pending_link);
> >> list_add_tail(&e->link,
> >> &e->file_priv->event_list);
> >> - wake_up_interruptible(&e->file_priv->event_wait);
> >> + wake_up_interruptible_poll(&e->file_priv->event_wait,
> >> + EPOLLIN | EPOLLRDNORM);
> >> }
> >> EXPORT_SYMBOL(drm_send_event_locked);
> >> 
> >> --
> >> 2.26.1
> > 
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
