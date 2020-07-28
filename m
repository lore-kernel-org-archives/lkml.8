Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE6DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8961206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGdMuCgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgG1MuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgG1MuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:50:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:50:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so659064qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GgtMyjeO4HLpQBw/exS2AHiDSiKY8Aj2c/cuRUlzRaM=;
        b=tGdMuCgbBf+xUH44MOqwqObI23V3rvUFzUFZI/QjbU42CBRhT+wgaqwZjd+kldED/Q
         ki01CNPPE0cfaK1npzMluvdLLHCpwL7fueCxjK8z/Q5T/ADUxgNVkIE4jQGGxlZBkSyC
         rgNVakvPQRiTg3RM3l2UKUnlO+SZ21CLUor6vXSKVYvp21NE2OFHAhjboShkXKLD/aGH
         WLz9W94j70D1ynUHaVzpHD9eX2ZrJR2Zx/glrW3ICbYTos8ZHd0nJwTWLiZtOOK0vjGH
         rVAEGR7jE1neaho/frDgI5cLckZWRrb4jgz28e9aRtTGaSKlPRlz/nleXZGC9cgSpenP
         Q6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GgtMyjeO4HLpQBw/exS2AHiDSiKY8Aj2c/cuRUlzRaM=;
        b=VDGgeXV2rMNktnUKSgTT3Y8kmIilUEW3cIzbFcbciX1L0eE4hSBTlNqmf+4n3+xuRh
         nqC3r78NfTxjCfz+bjCMkQe50E6CCZp5oD8l4JoO2/kCc1uUuJsEKoAZh09zV/XsSGRg
         Aym+QctmhxKL5VGSUym4Eu+91UyIW3jleTZCeyRdmEF1ZnKEeDR0LBvRfR0CcNIifk+6
         TWKpbPdPjrMO472EZmCeK9YaI032EuzPx+qnfGlGwJTGpt2ewcfdtJXvRmurmaZinQWq
         DDTZsIBB6TBbPOTj7r6xqb+tIm+LetvpDK2zXCqD2CSjZo47xXzvGrOj1Yn7CDZ2PHpV
         dCSA==
X-Gm-Message-State: AOAM533Q1DKJxquzTA+x9Oq6Q4ZUJk3riBtCoULNzzRy2VuVC5o2Kfgt
        l2uWTH5UTF++ShVbXUJqVA==
X-Google-Smtp-Source: ABdhPJxtmQcEAy5Fs04CmF0q3XaPWDqDwnhC4OEWLtN3cKQJP31ESmu5OAHSU7gHukiYE7G/FcVVeQ==
X-Received: by 2002:ac8:73d9:: with SMTP id v25mr13958369qtp.82.1595940623774;
        Tue, 28 Jul 2020 05:50:23 -0700 (PDT)
Received: from PWN (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id c70sm20373613qke.109.2020.07.28.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 05:50:23 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:50:21 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v2] drm/bufs: Prevent
 kernel-infoleak in copy_one_buf()
Message-ID: <20200728125021.GA409978@PWN>
References: <20200728014343.341303-1-yepeilin.cs@gmail.com>
 <20200728115210.408486-1-yepeilin.cs@gmail.com>
 <3058d741282b463d8aa7c8aff62e4326@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3058d741282b463d8aa7c8aff62e4326@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:35:17PM +0000, David Laight wrote:
> From: Peilin Ye
> > Sent: 28 July 2020 12:52
> > Currently `struct drm_buf_desc` is defined as follows:
> > 
> > struct drm_buf_desc {
> > 	int count;
> > 	int size;
> > 	int low_mark;
> > 	int high_mark;
> > 	enum {
> > 		_DRM_PAGE_ALIGN = 0x01,
> > 		_DRM_AGP_BUFFER = 0x02,
> > 		_DRM_SG_BUFFER = 0x04,
> > 		_DRM_FB_BUFFER = 0x08,
> > 		_DRM_PCI_BUFFER_RO = 0x10
> > 	} flags;
> > 	unsigned long agp_start;
> > };
> > 
> > copy_one_buf() is potentially copying uninitialized kernel stack memory
> > to userspace, since the compiler may leave such "holes" (around `.flags`
> > and `.agp_start` fields) in this statically allocated structure. Prevent
> > it by initializing `v` with memset().
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 5c7640ab6258 ("switch compat_drm_infobufs() to drm_ioctl_kernel()")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> > Change in v2:
> >     - Improve commit description. (Suggested by Arnd Bergmann
> >       <arnd@arndb.de>)
> > 
> >  drivers/gpu/drm/drm_bufs.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> > index a0735fbc144b..f99cd4a3f951 100644
> > --- a/drivers/gpu/drm/drm_bufs.c
> > +++ b/drivers/gpu/drm/drm_bufs.c
> > @@ -1349,10 +1349,14 @@ static int copy_one_buf(void *data, int count, struct drm_buf_entry *from)
> >  {
> >  	struct drm_buf_info *request = data;
> >  	struct drm_buf_desc __user *to = &request->list[count];
> > -	struct drm_buf_desc v = {.count = from->buf_count,
> > -				 .size = from->buf_size,
> > -				 .low_mark = from->low_mark,
> > -				 .high_mark = from->high_mark};
> > +	struct drm_buf_desc v;
> > +
> > +	memset(&v, 0, sizeof(v));
> > +
> > +	v.count = from->buf_count;
> > +	v.size = from->buf_size;
> > +	v.low_mark = from->low_mark;
> > +	v.high_mark = from->high_mark;
> > 
> >  	if (copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags)))
> >  		return -EFAULT;
> 
> The memset() isn't needed.
> The copy_to_user() stops after the 4 'int' values so no 'random'
> kernel stack can get copied.

You are right, I overlooked that. Thank you for pointing this out!

Peilin Ye

> Quite why it is 'right' to leave the remaining part of each
> userspace structure unchanged is another matter.
> 
> 	David.
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
