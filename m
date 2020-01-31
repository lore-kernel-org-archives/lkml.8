Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98660C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FD220663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiOtszZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAaSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:06:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45812 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:06:30 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so9080967ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9gT78DXj9lUKiwdz5+FUTcpN79EvHIQGA6QTOWZSrY=;
        b=kiOtszZCR3CgdcYOCulAhdr4eipNduhZ49hU9T+cC+FVtbF0EUmWn1qHwB2Dn+9GMJ
         XaWTVYLQ8hnLNtZxN5wlSdAhIyH87cLsb6UaSR14FAI0ScwyEsMFGdM0CUr31HpqIi/o
         T43CwuLs0Jt2DSn6xdqbQop14F+/Ug7pPPk82eAfy7yw6CoKTZJJORwpMSe2xkaisU1p
         3HQMQUm7XzltPI3urmPk43ekmLUNfZJVG46TiT3savq989B0UrJps5jgyA+YyuIsWiH6
         oI4YD8qqySnnMHPfsXmgc6+n/4Tg7kloBBRSl2P13876meRYCKtbAXV+HVcS1BFMz7Bu
         vIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9gT78DXj9lUKiwdz5+FUTcpN79EvHIQGA6QTOWZSrY=;
        b=P3VnDV2Uz8mBZ5afI0R0HMrzFMHo2dWdtKDWBgTpjB+7at59G9s30HAM1G7eNiFfkj
         TAfMbMdHhsHQ/qQnIFBQaQV8ONez6A8t89TLamgRsX6Q4VgMOH8rsJwCHsZ3QLXDhp0i
         PGLpadMmwmECqdl1tMr1EdbnR8bawqEUnhqf7Jn6OEmGcvMT2yvWBzhx3PT+06uwAwE9
         rEvsvg0qfEK0hUTrfsIDHa+BLOdaTnb+Yi3dAD16CJe9su7l9oDzV08SP7e1WVaJ/c1G
         TVC3XA4Ah3GtBY4n9QN49R9Ce0AYyK1cLKClyZ2Lytu3IaiqBKF5gV51cOkmzSZ65n4s
         1YTA==
X-Gm-Message-State: APjAAAVRn7XuLuQ90lhVzSkuG3JpV+uZhtSMqI1GxmfOSkXETcY36B9b
        6LvLiL7bRqoYXKYmM4VTsUuqQfvJHT1OdL+90WY=
X-Google-Smtp-Source: APXvYqwdCDsl72Gl++25hxqvRNODqKB0TTvRCh5IrTACltp0PHIQ6T1GPVl0z1qr/OqA0V1uvyCMw3p6i2YGKp1LaA8=
X-Received: by 2002:a02:9f06:: with SMTP id z6mr9133185jal.2.1580493989694;
 Fri, 31 Jan 2020 10:06:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGn10uXOj3n2u01bzhCkUVi-n5dDMVV+Mze3_uLV1K6RC6ebJQ@mail.gmail.com>
 <20200129075459.GA1256499@krava>
In-Reply-To: <20200129075459.GA1256499@krava>
From:   Sam Lunt <samueljlunt@gmail.com>
Date:   Fri, 31 Jan 2020 12:06:18 -0600
Message-ID: <CAGn10uXmpDHFz=cQey2OvBuqQqnozvNmvKhg1z08Tct_Ys1Xsw@mail.gmail.com>
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that, Gmail's web client reflowed the text of the patch.
I'll try again with mutt.

On Wed, Jan 29, 2020 at 1:55 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Jan 25, 2020 at 08:56:12AM -0600, Sam Lunt wrote:
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
>
> seems ok to me, but your patch came malformed, check below
>
> jirka
>
>
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
> > +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null;
> > echo $$?), 0)
>
> patching file tools/perf/Makefile.config
> patch: **** malformed patch at line 108: echo $$?), 0)
>
>
> > +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
> > +else
> > +  PYTHON_CONFIG_LDFLAGS := --ldflags
> > +endif
> > +
> >  ifdef PYTHON_CONFIG
> > -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> > +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ)
> > $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
>
> patching file tools/perf/Makefile.config
> patch: **** malformed patch at line 116: $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
>
> >    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
> >    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
> >    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
> >
> > base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6
> > --
> > 2.25.0
> >
>
