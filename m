Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2EDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1EC2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6RO3llg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGULmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgGULmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:42:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ECCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:42:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so11824201pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODrFZoi0zFFLKYjz0VR2FO+MGqKJ12nmTZeF7CR/hmM=;
        b=O6RO3llguA8h8jjv5VLjuBM+LWiBXd6eGOkfP57K1XPSSc73AAXmCdG1l93XZ90zXt
         JFZKopbfVz+PrLCvH4gzhayiwwg0YqAauPbqUNYQlmyP4MaMFSuBIVknSNHfIlsa+E9w
         KszENgcO0gtHuxffz3Jd6XK84WG4BUxZviW7LN9eMvgQcxbTYujIfcxLiz77hQcibi6v
         nHF8j2UAr8kdkZsJk4Ntu/QhwgESt36bw3iV1NKD512vR+x0up5EN30ndplFccQBmcJz
         gZV09/lc4Pi1riDXd5FocsuHjZr4ZEsPiYoSd25y7nG3GP7KCEa4U6P4Z2ITB+LxPkPn
         SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODrFZoi0zFFLKYjz0VR2FO+MGqKJ12nmTZeF7CR/hmM=;
        b=sLe3tyQAAFEySATNdzN2auZj0aDnKDa6kRXwg3GNQd5Ly3tS63cbAcR+hglryCv0zi
         mDArIRmxU1KHZjXmM0bryS13PCT45770yipupQWvWOib9MDdWhNRG541pdYQO4TjsoNK
         xBMKaHZM7n3x4BNdE19ZYf7bpnu04nw/TPzu4AGXROOUHxTa24veU1wGoTDU4qGsQQgj
         d7PpGYn7ZZMr9Bq6uMO2ZzK/mYJRcwu5f0N1cnJW6E0j9iEBAbtqhteMe+wLGJbgSmEU
         C1qbWWgnf4R+W3VanUwonEuColuU3ObYqgAlW8yFw84+ED17wrMKFEl8rXq7wY4H6voN
         Zhvg==
X-Gm-Message-State: AOAM533QaUdRa3rrAyVJwqM/4VqPqadu4w3uVfEugoYq/87OZEHhIxu3
        r7kpT9fAlr++/y/aljBhx6ZvRya0n7hq+1R0c1i1Jg==
X-Google-Smtp-Source: ABdhPJxsQ+dlrxXXy2eRvq3ypEo3C7sMWQXPikA9eLRR1HdUSGdmFUCARy4H9b+IJ81iH8mXZWQ7AJE/LjGLbuSpBF4=
X-Received: by 2002:a63:2241:: with SMTP id t1mr22099372pgm.440.1595331734813;
 Tue, 21 Jul 2020 04:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <14089ca5568d214295b2028b59fcd630c7adb0e2.1595331056.git.andreyknvl@google.com>
 <CANpmjNOTPLzRoODvg7zab-tkOH0B67OiDj61x4J-33zBbBtWgw@mail.gmail.com>
In-Reply-To: <CANpmjNOTPLzRoODvg7zab-tkOH0B67OiDj61x4J-33zBbBtWgw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 21 Jul 2020 13:42:03 +0200
Message-ID: <CAAeHK+zdugOoL2aE9LFjfaX5uLQecLX=8TOM1K0kyRbmaeJ5Hg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add KCOV section
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:38 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 21 Jul 2020 at 13:34, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > To link KCOV to the kasan-dev@ mailing list.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d53db30d1365..eec0b687eb08 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9305,6 +9305,15 @@ F:       Documentation/kbuild/kconfig*
> >  F:     scripts/Kconfig.include
> >  F:     scripts/kconfig/
> >
> > +KCOV
> > +R:     Dmitry Vyukov <dvyukov@google.com>
> > +R:     Andrey Konovalov <andreyknvl@google.com>
> > +L:     kasan-dev@googlegroups.com
> > +S:     Maintained
> > +F:     Documentation/dev-tools/kcov.rst
> > +F:     include/linux/kcov.h
> > +F:     kernel/kcov.c
>
> I think this is missing:
>
> F: include/uapi/linux/kcov.h
> F: scripts/Makefile.kcov

Mailed v2, thanks!
