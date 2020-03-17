Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5269C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9396520724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsH2EWdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCQW3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:29:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37645 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:29:14 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so2922269iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bEIoiMS77J8OafdTSe8ka9CicGNma8msO19PpTMGGU=;
        b=XsH2EWdlmo2FWYBvtVzOdR0HVND74GUX1SiRcRc2SzJBbtTrGbjYewhWERHT/9VuYy
         A4XNY27GZ1DVtb9WRskC+VR05HY0eczzAetwxDGll+aZksKxI+TWbg9aX1VWhkpqpfsH
         m6gidwY8k1vpxeamp1ZZcJD6NUuk+8sCIUkRDPu+r3RemGAoJZjuHSKST3v730/AWWFC
         K9x+A4dB7auiUS6/lQtdr7jg4wboz4ax4v7qxCuFcf9ipmsLLV4+KaQjSzEpcLPohI7h
         LUFX+r7dRDYMBqgdgxgz4P7DCg3piPX685dY1iSXONS0d7/Jr+NOTax5HoUTvl0lqIWo
         nsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bEIoiMS77J8OafdTSe8ka9CicGNma8msO19PpTMGGU=;
        b=b5j0C0GigMBRanKyg03eOmG4pCkBggb8oLtIfgrtRsvifF48RdImtdseBtLLvPKGlf
         PktDIOfK4A11xQ5m6lOYUS6Ubxg21VfmcBZwwZe/vHgc+E/mLQcGa6TCDLHkd1UXdzvz
         kPKQU9e6rHmyMmFi1B7SKPoMRf++yPng4/SbinUkj95kR4/YZHR04arZun0TD3GMD+CL
         eK/xJp81rOnRUAFUMXbsBhqtigoYSQUn+utQkUQusuxTqz3Bi5hrLEMJqYeVtcjKV7cg
         QltHYxMRisehLNr3yJZVXpoqL05Cy9CUoNZKB+2a5JPuBvGh8tR3kSJhUD8YlebDtQU9
         hnKQ==
X-Gm-Message-State: ANhLgQ3LidetTuW9Sralsq20ilyY4r6bk4gFOKDzs0GaO+1LgTiyAYl+
        puSukwoWyMsUfQ7xDTS0MB6EHBJxh0KIYYcBIQA=
X-Google-Smtp-Source: ADFU+vtNbNfEr3+QnFalp8JMjl/uIHuqwXCiBCpCEK2xYevFvN/okNzd5s4kPzmvSxDuzzEFr+gjCKEqyEH7G34pjaA=
X-Received: by 2002:a02:9f90:: with SMTP id a16mr1501965jam.61.1584484152847;
 Tue, 17 Mar 2020 15:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <1584329768-16119-1-git-send-email-hqjagain@gmail.com> <20200317165729.GQ2363188@phenom.ffwll.local>
In-Reply-To: <20200317165729.GQ2363188@phenom.ffwll.local>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Wed, 18 Mar 2020 06:29:02 +0800
Message-ID: <CAJRQjod6JD8AGtBRxpsGJV3ACd0QLO_UvNDeM1rMuZPioAqB4A@mail.gmail.com>
Subject: Re: [PATCH] drm/lease: fix WARNING in idr_destroy
To:     Qiujun Huang <hqjagain@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Mar 16, 2020 at 11:36:08AM +0800, Qiujun Huang wrote:
> > leases has been destroyed:
> > drm_master_put
> >     ->drm_master_destroy
> >             ->idr_destroy
> >
> > so the "out_lessee" needn't to call idr_destroy again.
> >
> > Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_lease.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> > index b481caf..54506c2 100644
> > --- a/drivers/gpu/drm/drm_lease.c
> > +++ b/drivers/gpu/drm/drm_lease.c
> > @@ -577,11 +577,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
> >
> >  out_lessee:
> >       drm_master_put(&lessee);
> > +     goto err_exit;
>
> I think this is correct, but also confusioning and inconsistent with the
> existing style. Most error cases before drm_lease_create explicit destroy
> the idr, except the one for drm_lease_create.
Yeah, it is.

>
> Instead of your patch I'd
> - remove the idr_destry from the error unrolling here
> - add it the to drm_lease_create error case
> - add a comment above the call to drm_lease_crete that it takes ownership
>   of the lease idr
>
> Can you pls respin and retest to make sure that patch is still correct?
I get that, thanks.

>
> Thanks, Daniel
>
> >
> >  out_leases:
> > -     put_unused_fd(fd);
> >       idr_destroy(&leases);
> >
> > +err_exit:
> > +     put_unused_fd(fd);
> > +
> >       DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
> >       return ret;
> >  }
> > --
> > 1.8.3.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
