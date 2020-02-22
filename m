Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486CEC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C86A206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPhhDO0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBVQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:38:22 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39055 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBVQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:38:21 -0500
Received: by mail-il1-f195.google.com with SMTP id f70so4272017ill.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2lcmTwyMrOPuCOwLWRYUM2f987UesfeSpFXzubq3M0=;
        b=VPhhDO0XyvOXJuHhhyDeMkuLbqYI5Te3zM8LnOL8z1b7LTEJwYCmtBvh1otLek2RPz
         hEdXIdQPvAnqSRxDK8XUv1p+OYhx/6X2oJNJ6sX57BIM/adWC+i9Mcg+Lubch6/dQ8XF
         dj7nljIPBod1kcjm77bWEv+fLG/e9yz62sJxuS5FeFR1U7/twvF4x7zISC2E8HsqP06D
         8iVWeKPMn3hQozjvqvK8jJ+aRURyq/PRXTTiOOW6Ct0L/APNPqYFLI7TbrxQQg9wjRUV
         lGtyU3IQLxIbHZbHbCzE7DaPJCRP5u1KjhfLkZ95BNfdECp/dZ3i0RBvbWH7ns1+Dkc8
         LgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2lcmTwyMrOPuCOwLWRYUM2f987UesfeSpFXzubq3M0=;
        b=myHPkstwbAybzFd5B4wHwedkxfhUV6rFKp6S9xQS/flDDdq2vyumKQowg0hBVx2VPz
         lc6YmoKFly6jQNqFtN3hMCaqlf3952Um95EJ91q1wKIB7le0jsZXqdx85wQB0MwTM1zc
         kEch2Epv25QgkAjXSTQfutXL2+vYwBWvfLnDaKuNM0MFz+Z+w8e6PUwRoIY2IQP/YE8p
         QmaaLIZ1L1b4CjztuNQZqZd53XK0ouYmc5c/w4CMzJieADWdq9XTssG7mnc4RRwkWvtp
         n6JG0HS0BF5ZEvTNcXKmirbgJzQxi8SpEYH5N/XhvhxpOBvkhTUnBg92PqBD3SY2sdnw
         h7TA==
X-Gm-Message-State: APjAAAWBE7EAjMlf7sCKCGMK7xUlNFnX0irdSCKY4f+W4O9dKDcUnEEV
        fwZciAf6CJZ73sphMMuU/sD6EP2+MphpuBHgG8g=
X-Google-Smtp-Source: APXvYqw73cI4FKHSPUknPM5sf5CcIf9Aur4WJiiMVylsuOkLvPPK+MIe5VuxT6HMie7KceerWUGix2PTn7R1lzg/l3Y=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr48316823ill.232.1582389500921;
 Sat, 22 Feb 2020 08:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20200131181123.tmamivhq4b7uqasr@gmail.com> <30752f2a-fe0b-4150-c32d-07690fb43b82@windriver.com>
In-Reply-To: <30752f2a-fe0b-4150-c32d-07690fb43b82@windriver.com>
From:   Sam Lunt <samueljlunt@gmail.com>
Date:   Sat, 22 Feb 2020 10:38:09 -0600
Message-ID: <CAGn10uUFJLh7J5rNcbH-Y6aGGr0vK_YN40gry9PXh_tx3sSXMg@mail.gmail.com>
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
To:     He Zhe <zhe.he@windriver.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@redhat.com>,
        namhyung@kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 8:24 PM He Zhe <zhe.he@windriver.com> wrote:
> On 2/1/20 2:11 AM, Sam Lunt wrote:
> > Python 3.8 changed the output of 'python-config --ldflags' to no longer
> > include the '-lpythonX.Y' flag (this apparently fixed an issue loading
> > modules with a statically linked Python executable).  The libpython
> > feature check in linux/build/feature fails if the Python library is not
> > included in FEATURE_CHECK_LDFLAGS-libpython variable.
> >
> > This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
> > the '--embed' flag and passes that flag alongside '--ldflags' if so.
> >
> > tools/perf is the only place the libpython feature check is used.
> >
> > Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>
> > ---
> >  tools/perf/Makefile.config | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index c90f4146e5a2..ccf99351f058 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))
> >
> >  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
> >
> > +# Python 3.8 changed the output of `python-config --ldflags` to not include the
> > +# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
> > +# libpython fails if that flag is not included in LDFLAGS
> > +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
> > +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
> > +else
> > +  PYTHON_CONFIG_LDFLAGS := --ldflags
> > +endif
> > +
> >  ifdef PYTHON_CONFIG
> > -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> > +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
>
> I met the same problem. Would the following change be more simple and clear?
>
> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)

That change is nearly equivalent to the change I'd suggested, just
squashed into one line. I think it's certainly more terse, but I'm not
sure it's any clearer.

It's also making the implicit assumption that PYTHON_CONFIG_SQ does
not print anything to stdout when it exits with a non-zero return
code. I think that's probably a safe assumption, but it seems more
robust not to make that assumption at all.

Best,
Sam
