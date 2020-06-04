Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496CE205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtU+u7SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgFDI3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFDI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:29:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D24C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:29:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so5067843wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PKk1J+LKsQnN71HxmGj+GvS1I8q6haqL05yr0+A1nbc=;
        b=WtU+u7SAU/10RONQscOH90M1y5frlrcns0jI0jk4A+ZGLxcINgOAebeV7SVyJoudZ4
         K2IxCfLAEob4lqVbfMdHz1pWGbs1L9RHPpMdfSZGyusCdj6fqOGJEuSw7YETgMCD2b9g
         oxySnMad83p3lROkqgkJzMqyh1nWE5+aZnHO3JLroi+Caob04IEIHdfCM0Sv3nNtN5yy
         Xnsj54Ic6qGuSJoryz6neW86cVs5lZ8BKWpK7uPqNIxzKZ3YHT8NwxpBhhqNSoR2bNGB
         k6r2KuJSh/jDO5Ttz6HUwWcN/4yi0HB2UxQJvlP8HaIAZXOCrXLzbdr0vxK6iaXXGpFQ
         BQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PKk1J+LKsQnN71HxmGj+GvS1I8q6haqL05yr0+A1nbc=;
        b=C9rm0qnmYUgmmEVQeD5Tjmz/OrWdrk8k7cBPtPWghLHph49NRqGUaETvf1JqJ05bqv
         xeH1suTsJmK4hXZyCeul+V5FY0kkv2M7k9PpGT+CNiI7W4eoS4BNiZqUJWyrpx+0vmAQ
         CQj67iPIrdkJ+cXPE+7QFAUw61FtMibXKtY3jYWFxGh3NGV6MBBIwUNgMCtV2GPT7cqy
         pMze1XKGqXbU3u6sghDKEncS2s0dIZNtJ2soMOc4zPkKh7YZ+dnKvChYXHbCUBcr5W0Q
         eE80XqlYqcJGQcKhedmK+EoZzTQ+u+LNxSt+VC0fyu6RY322FhkCLkWWfKzrUf5oFbtT
         aATQ==
X-Gm-Message-State: AOAM532oSlw60c1HIL6TdTWBL41q9zrrEpvQuig3+/KnYBUKafR+w2AL
        ODGiBa53nEGDyreKAu4xMCcWQYObzobo6BfWyJRHNg==
X-Google-Smtp-Source: ABdhPJwxA29S3nQkC+kbqdUWQn8sCRoRz9vl6rWnzYsBIk0CUZ+8HyZP3MLlPEW2KSjuVOgA1J45AHniSsP4EUdx4vk=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr3211795wrq.196.1591259342120;
 Thu, 04 Jun 2020 01:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200603174714.192027-1-glider@google.com> <20200603214633.GF48122@redhat.com>
In-Reply-To: <20200603214633.GF48122@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 4 Jun 2020 10:28:50 +0200
Message-ID: <CAG_fn=UhoY1r59gsqC55PvDR6tydgi9+vaELa_v6cYUoAk0=MA@mail.gmail.com>
Subject: Re: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Roy Yang <royyang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 11:46 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 03, 2020 at 07:47:14PM +0200, glider@google.com wrote:
> > Under certain circumstances (we found this out running Docker on a
> > Clang-built kernel with CONFIG_INIT_STACK_ALL) ovl_copy_xattr() may
> > return uninitialized value of |error| from ovl_copy_xattr().
>
> If we are returning uninitialized value of error, doesn't that mean
> that somewhere in the function we are returning without setting error.
> And that probably means that's a bug and we should fix it?

Could be. My understanding of that code is quite limited, so I'm happy
to change the patch if necessary.

> I am wondering if this is triggered by loop finishing because all
> the xattr on the file are ovl_is_private_xattr().

Yes, that's the case. The loop makes one iteration, then
ovl_is_private_xattr() returns true, then the loop ends.

> In that case, we
> will come out of the loop without setting error. This is in fact
> success and we should return 0 instead of some random error?

Thanks for letting me know. I'll change that to 0 then.

> Thanks
> Vivek
>
>
> > It is then returned by ovl_create() to lookup_open(), which casts it to
> > an invalid dentry pointer, that can be further read or written by the
> > lookup_open() callers.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Roy Yang <royyang@google.com>
> > Cc: <stable@vger.kernel.org> # 4.1
> >
> > ---
> >
> > It's unclear to me whether error should be initially 0 or some error
> > code (both seem to work), but I thought returning an error makes sense,
> > as the situation wasn't anticipated by the code authors.
> >
> > The bug seem to date back to at least v4.1 where the annotation has bee=
n
> > introduced (i.e. the compilers started noticing error could be used
> > before being initialized). I hovever didn't try to prove that the
> > problem is actually reproducible on such ancient kernels. We've seen it
> > on a real machine running v4.4 as well.
> > ---
> >  fs/overlayfs/copy_up.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 9709cf22cab3..428d43e2d016 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -47,7 +47,7 @@ int ovl_copy_xattr(struct dentry *old, struct dentry =
*new)
> >  {
> >       ssize_t list_size, size, value_size =3D 0;
> >       char *buf, *name, *value =3D NULL;
> > -     int uninitialized_var(error);
> > +     int error =3D -EINVAL;
> >       size_t slen;
> >
> >       if (!(old->d_inode->i_opflags & IOP_XATTR) ||
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
