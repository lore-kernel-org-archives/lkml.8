Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE52074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0gMkuRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgH0BgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0BgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:36:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B810C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:36:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so1767146pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlC/+/SpJq/gEyHfo2diqDILfgKApvrsh0PsGIBMc+4=;
        b=F0gMkuReGQbSx65xtT4sb74tnxPGH/0BVFg2AZf4lSQVrysQhb1IX88Ox9HHzy4tBf
         PFYJ2DW28gRPElrbOcE4g//XLmWtK6gGaalvAo3K1CWnNtBIeGGw4coAC3oY5AmkMckb
         bnmNnFG7nsa7f42mS97qvSR4FVSQOZcT7V8gDAGPlE9x4JeyZLa/RsU1auMgLRHZWqbj
         /aAg974ovm9pSzybKIQZtGW15F9Z55Ehq/fjKCiEq8BIjskA/3Ddv6EWoG6JreHwWrdz
         OglXYPqScrzp11EQL5zHLMLO+W7rT0pJccaNIkK6gH+y8GKkPSuroLqR0Q5nfWElKoxM
         Nkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlC/+/SpJq/gEyHfo2diqDILfgKApvrsh0PsGIBMc+4=;
        b=jDpaMB90w9v6MRzh/nnYjfuABiR7LT63jSZUxD1V5z5w+31Qjn8Ov/4u3Q19jsoY7L
         l/CvYyJR8Fpnhw9WYuaB4Gc8zUe96Igz1cSuTcncBkAU8sptgGEDZxYnMcbawTdXjWgf
         GC4DxFzQlJXSzUFXdGxIp4dTYK4BaaOBiAh44EpdlC0zS2NuXWDfkjAJVXHXy7haBgn1
         uR1Y6bK9PdZGQ6V5AhsLHdLF2a5yVozseC7FFleDWHz4X8OnUUCee3qmup1KOEeY26+F
         inf8Jp1bM7uP9xctenrsOVt20Ui8aj0hoFObDtKHPtNAYV97503O9gQQAHg+9MwSSRYw
         uiOg==
X-Gm-Message-State: AOAM532ujYUwZ3n4Jn7CrkiHPRDtzbw5wp717SgrJGbamstv2f+/z+pB
        ucbTdW9ClcIeqGFDb7Fw1UEEhg8BdmNjqw==
X-Google-Smtp-Source: ABdhPJwmfF/+ExDZk3eCccDn5bgvikjAKZRja9OXGsCPSa+dT2D347I5xZsEHHg5+cYvZZxqC5mxXQ==
X-Received: by 2002:a17:90a:a883:: with SMTP id h3mr8446079pjq.127.1598492160519;
        Wed, 26 Aug 2020 18:36:00 -0700 (PDT)
Received: from realwakka ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id x9sm259043pgi.87.2020.08.26.18.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 18:35:59 -0700 (PDT)
Date:   Thu, 27 Aug 2020 01:35:49 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: fix warning in vkms_get_vblank_timestamp
Message-ID: <20200827013549.GA7953@realwakka>
References: <20200825144248.1751-1-realwakka@gmail.com>
 <20200826204954.u6aqwcmwpsudrkh4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826204954.u6aqwcmwpsudrkh4@smtp.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 05:49:54PM -0300, Melissa Wen wrote:

Hi Melissa!
Thanks for review.

> Hi Sidong,
> 
> Thanks for this patch.
> 
> The code looks good to me; however, I see some issues in the patch
> format and commit message. Please, see inline comments.
> 
> On 08/25, Sidong Yang wrote:
> > From: Sidong Yang <realwakka@gmail.com>, Haneen Mohammed <hamohammed.sa@gmail.com>
> 
> You need to fix the Author name.

Oops. 

> > 
> > When vkms_get_vblank_timestamp() is called very first time without
> > enabling vblank before, vblank time has just intial value and it makes
> > warning message. this patch prevents warning message by setting vblank
> > time to current time.
> 
> I consider *fix* a somewhat strong term to this change. In my opinion,
> it would be better to choose another term in the commit message like
> *avoid* timestamp warning when vblanks aren't enabled.

It's good to me. Next patch need to be more explicit.

> 
> In the body of the commit message, I think interesting to include the
> exactly warning message that this patch addresses. You could also
> describe the initial values that triggers this warning and why this
> approach is reasonable, as VKMS has fake clocks.

Yeah, It will be more comprehensive patch if there is description in detail.
I'll work for next patch!

Thanks.
-Sidong

> 
> > 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > Cc: Melissa Wen <melissa.srw@gmail.com>
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index ac85e17428f8..09c012d54d58 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
> >  	struct vkms_output *output = &vkmsdev->output;
> >  	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> >  
> > +	if (!READ_ONCE(vblank->enabled)) {
> > +		*vblank_time = ktime_get();
> > +		return true;
> > +	}
> > +
> 
> Apart from issues in commit message and format, I checked the code and it
> works fine.
> 
> Reviewed-by: Melissa Wen <melissa.srw@gmail.com>
> 
> >  	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
> >  
> >  	if (WARN_ON(*vblank_time == vblank->time))
> > -- 
> > 2.17.1
> > 
