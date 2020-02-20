Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2102CC11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C20206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582235090;
	bh=1By3D340Xj5laiaEOMoieVFH4UjEm3FJLDCJSovq1Nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RXXT6Fv8siiT3u9hXcCEg2i4vosEtaDNwITgNmJJm0jEojPh7o3Sx91k1iplYlA09
	 RRR9FvLH0Zag7LEw4OTWwJeoeDgXWFpXRWvWBtqoss1DIswWvvC4Pu+hroIRmbhZam
	 cXhPo2sOcP/6v9SKq4secnkvwLOXjpCfIjwqmjIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgBTVos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:44:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35322 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBTVos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:44:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so156141otd.2;
        Thu, 20 Feb 2020 13:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVNMXV+GYwL7O+PpLd4msfz5vj4MvTvgQc/WifjGAvM=;
        b=fBoH3Gx7Mrpaj+cKypiJGEfmTKi4kqI9V3/DqhT6WV71meh72wMzvQQm7ZLtRqhZzz
         pIhtQ/f/6I5UDZAwHZDZxVIRdUSqSNhHaTRnpKRyxC96dkpZcfbaPNIqar2JLB1p0wTn
         k54MYlnH9SKha0ApUEMN4ycESiB+eKVkO4XufHUpecjI5ThJ6ZtOdS7WbvJ3IYLmBX9o
         NzwPpoVjMsjlBoo/J9sKRkfwn+P4uYZo6fwUZYT4pTD1FicKLQ50Qd+VCVEZokqazHlW
         7GV1Qd5cbO5GpW6V5sMUYrW+dcTvQIUU2HdWk6JqearmxnLbTUPGdknZ6zsqHYVyLR/E
         3ULw==
X-Gm-Message-State: APjAAAWD6HiV8U4QWJ5XWYaf26Q9wxwg35OVPLmxceicqMpidCAz5rNw
        N5D/Hw0o26U/g21Z8Kky4ZZ2fF4/TGou8FPEZnw=
X-Google-Smtp-Source: APXvYqzXrW8tTLCrt5fn19taPhUJKI/pQVbfsUINFlYguhoDqbfR/4Vi6SciKAUGdzIl7AgirjHDY6trZyHsrsTZKLw=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr3712558otd.266.1582235087639;
 Thu, 20 Feb 2020 13:44:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0he=WQ6159fyaYYffdi66y596rVo7z1yLyGFcH45PXNUg@mail.gmail.com>
 <202002201158.2911CE2388@keescook>
In-Reply-To: <202002201158.2911CE2388@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 22:44:35 +0100
Message-ID: <CAJZ5v0hkKUi7FUOneEy2nO-=RM8ZbcoG1uHRYNWzrjONEhKYxQ@mail.gmail.com>
Subject: Re: [Regression] Docs build broken by commit 51e46c7a4007
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 9:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 20, 2020 at 07:50:47PM +0100, Rafael J. Wysocki wrote:
> > On two of my systems the docs build has been broken by commit
> > 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations
> > are made").
> >
> > The symptom is that the build system complains about the "output"
> > directory not being there and returns with an error.
> >
> > Reverting the problematic commit makes the problem go away.
>
> How strange! This must be some race in the parallel build.

I don't think so, I didn't use -j with htmldocs builds.

And you know what, adding "-j 2" to the command line actually makes it work. :-)

> AFAICT, "output" is made in the first sub-target (Documentation/media). This
> doesn't look entirely stable (there's no ordering implied by the "all"
> target in there)...
>
> Does this work for you?

No, it doesn't.

>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d77bb607aea4..5654e087ae1e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -62,7 +62,8 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
>  #    e.g. "media" for the linux-tv book-set at ./Documentation/media
>
>  quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
> -      cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
> +      cmd_sphinx = mkdir -p $(abspath $(BUILDDIR)) && \
> +       $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
>         PYTHONDONTWRITEBYTECODE=1 \
>         BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
>         $(PYTHON) $(srctree)/scripts/jobserver-exec \
>
> --
