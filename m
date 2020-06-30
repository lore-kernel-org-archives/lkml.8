Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32999C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F82077D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxMfdOgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbgF3RU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390230AbgF3RU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:20:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:20:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e64so16926428iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77UK+cZyqyw3gLZiPb/FTe0nbUCTBAqAtX9BzSpsWzY=;
        b=WxMfdOgvU4fe+nEqZoVfj1tZLcXZ7JB/FVumxjs6J7pPVVm6YdZQoIUAq3a9uT7n36
         Wo/Khg/Jz2QflUcvY3eEORKKiY8iOVfoJ2pqUilIYAw+3TiEq7RfIzbI4aPHYKs48D5Q
         grg+8KOZ5BqAwgWCGwBcsGROj5WVXB9KrIsK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77UK+cZyqyw3gLZiPb/FTe0nbUCTBAqAtX9BzSpsWzY=;
        b=eQ+Ozqte7qPoBmTx9qqikbfR4VVz+FpupK64msqiIs99+6MOm/MQGikLi9V5Fy6aWM
         2FBUzpk31pfTWlrPwgdlmkwofUlzV2cAFM8Ab2cFXulEiK/AP+VEASVcTJSdBVx69pxs
         W0YD+lIikRewi0ctujzq9zdbMebHoyDpPFmQPqfWeCycdmw2lYtjTEqzGLsLpQiYRegi
         NNYcHudgmgoXYbDK85k78VvHz9WauOssVTFXOjfkynRId5YVSXSC+h9sk2a89AQtdtKm
         VA3RMRN3d2tw+sFGeDimD7lh6prb7msw2xPvO5OG6zdKF5xvgYTSnwo77fnTmhS5o+zS
         iluA==
X-Gm-Message-State: AOAM53074u8e27UT+UkZVNDFoWeT4KQipSkfKXNfO7dQWqLl+E9+MU7K
        N4PfO5em9G7NgcWeFcAV3yl1zGiKFvdNPKs4TwKoTg==
X-Google-Smtp-Source: ABdhPJxRJcqT+JiOtcn8rPCQfvCvhao09rgzqxAO2d6F+Z8L+HWHLBP4c7fjts4NtwPa9WV0hEUtbkpVPxLWWCbrAeI=
X-Received: by 2002:a6b:9042:: with SMTP id s63mr23191402iod.195.1593537655556;
 Tue, 30 Jun 2020 10:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200630143525.13869-1-quentin@isovalent.com> <39ba164ba44be848feac831f2f21effca92bfc96.camel@perches.com>
In-Reply-To: <39ba164ba44be848feac831f2f21effca92bfc96.camel@perches.com>
From:   Vadim Bendebury <vbendeb@chromium.org>
Date:   Tue, 30 Jun 2020 10:20:19 -0700
Message-ID: <CAC3GErHpyyA8eQUyP6s_H6csvbKfHXHi50Ky6A1PhU+A6waCeQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: prevent reporting C99_COMMENTS error for SPDX
 tag in .c file
To:     Joe Perches <joe@perches.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:47 AM Joe Perches <joe@perches.com> wrote:
>
> (adding Vadem Bendebury who added the tolerance test)
>
> On Tue, 2020-06-30 at 15:35 +0100, Quentin Monnet wrote:
> > When checkpatch.pl is invoked with "--ignore C99_COMMENT_TOLERANCE", it
> > reports C99-style comments found in the code, by matching on the
> > double-slash pattern "//". This includes the leading slashes before the
> > SPDX tags that are now used in a majority of C files.
> >
> > Such tags are commented with the double-slash on purpose, and should not
> > trigger errors from checkpatch. Let's ignore them when searching for
> > C99-style comments to report.
> >
> > Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>
> I think this unnecessary as perhaps those that want no
> c99 comments likely _really_ want no c99 comments.
>
> > ---
> >  scripts/checkpatch.pl | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 3cacc122c528..67f350c580ea 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3983,7 +3983,10 @@ sub process {
> >               }
> >
> >  # no C99 // comments
> > -             if ($line =~ m{//}) {
> > +             if ($line =~ m{//} &&
> > +                 !($rawline =~ m{// SPDX-License-Identifier:} &&
> > +                   $realfile =~ /\.c$/ &&
Do I understand this right that with this change in the check would be
applied to .c files only? .h files should be included.
> > +                   $realline == $checklicenseline)) {
What is the purpose of the above check?
> >                       if (ERROR("C99_COMMENTS",
> >                                 "do not use C99 // comments\n" . $herecurr) &&
> >                           $fix) {
>
