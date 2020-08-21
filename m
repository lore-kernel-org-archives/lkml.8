Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C227C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B70220748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGXz8e3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHUSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908E9C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:52:29 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so2384167oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+6DnWkoLk+ZcWADUSKaqJDpW6JCuqaTSy9tUwMI9O2w=;
        b=aGXz8e3KswugP5GdR0vdCXXDw44nXVvDw3Ox2WWqUC8VUshHuyEKVgZh3+p5PZ9tH0
         XRUihzqm5+K18Y/ujqwjzvvE25NlcmmFxb1yGwvyHuKvBiLn4xvCKuz2skfjsffDjf5n
         pQaLiU4UAGCjuK85egVXwzbs7afm+X4kcOO1/K2V+naWNWrDa6kFBbx/hqFmmXTA2DlS
         kFdk2RyoKj0VJ6O92iuVTjhyiGoIan5IhS1tQLY4Zw9mW9itF7cvZgsdPncy2bRXrZPD
         /kldhNj6iIXsWOi/F0V2coq5RPTgSk5PwXH65pruE4H2Ejnb4Xr9oSgG/rh2D/eQOR//
         nSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+6DnWkoLk+ZcWADUSKaqJDpW6JCuqaTSy9tUwMI9O2w=;
        b=BaFLx+rz4U710TYLpG4LLSFVU0Yl+eUP1w1IdaG0teJqN6TC1eO9vMAjnv9YSPAFAO
         TH9GUV7DG+c9Hxf4IcEqBiAHtdftDQVpk9XlbbgRaKWb4GNNNWLUZ+JFzW9hWBAghCOV
         No0yWmLnfeugVIc5kfkVyJBKXCFWuQ/I3NueUF6SuBF5GmCFO/jTreF0Rog0ht4+RtMC
         B3i7dpjN7USWsADFQA5TL6tyXXcA011MtTdIvj/Vkj1cupk6MFkmPy69SZzIrqsc4QTC
         lmzGiPfrwpxNDI1u/ArRiR5MIp5J7MnUZT3fe0AHLHjHP+q0Llt7xrcG6zYKEPmGl47V
         adsw==
X-Gm-Message-State: AOAM533XwE6zIWGzL4g8ul4q1n3Krvlu2LSVUVPHmfL5q7k6ORdXz1hD
        sdNoZyVGEWWnhOT6zoHRyU3xEaUP1+t8dR5OFdY=
X-Google-Smtp-Source: ABdhPJxz1goSG/agIc35K1V3KcbWbBqRtUPAMhrp/iiqWFHnbZjeeL6K0GICAlpBcnapbikRpo7WnKRkYkbuCv/snVk=
X-Received: by 2002:aca:724f:: with SMTP id p76mr2621088oic.35.1598035948316;
 Fri, 21 Aug 2020 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200820212940.Kq1ky-JHH%akpm@linux-foundation.org>
 <20200821172231.GA1444408@localhost.localdomain> <dc2fbc95-8c8a-5613-f4bd-f29328bb695c@infradead.org>
In-Reply-To: <dc2fbc95-8c8a-5613-f4bd-f29328bb695c@infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 21 Aug 2020 20:52:17 +0200
Message-ID: <CA+icZUVPjw_JMXFA9Y=wUewq6Bi0ATFOX-4dce3mOpVbv9SHXw@mail.gmail.com>
Subject: Re: make defconfig (Re: + x86-defconfigs-explicitly-unset-config_64bit-in-i386_defconfig.patch
 added to -mm tree)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, daniel.diaz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 7:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/21/20 10:22 AM, Alexey Dobriyan wrote:
> > On Thu, Aug 20, 2020 at 02:29:40PM -0700, akpm@linux-foundation.org wrote:
> >> Subject: x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig
> >>
> >> A recent refresh of the defconfigs got rid of the following (unset)
> >> config:
> >>
> >>   # CONFIG_64BIT is not set
> >>
> >> Innocuous as it seems, when the config file is saved again the
> >> behavior is changed so that CONFIG_64BIT=y.
> >>
> >> Currently,
> >>
> >>   $ make i386_defconfig
> >>   $ grep CONFIG_64BIT .config
> >>   CONFIG_64BIT=y
> >>
> >> whereas previously (and with this patch):
> >>
> >>   $ make i386_defconfig
> >>   $ grep CONFIG_64BIT .config
> >>   # CONFIG_64BIT is not set
> >
> > It is highly, highly, highly advisable to always pass ARCH when dealing
> > with 32/64-bit archs:
> >
> >       +---------------------------------------+
> >       |       make ARCH=x86_64 defconfig      |
> >       |       make ARCH=i386 defconfig        |
> >       +---------------------------------------+
>
> I certainly always do that and I also avoid
> ARCH=x86
> although it is supported/allowed.
>

Unsure, if this already documented - if not - might be good to document it.

While playing with ClangBuiltLinux issue #194 this was not clear to me.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/194
[2] https://github.com/ClangBuiltLinux/linux/issues/194#issuecomment-662433916
[3] https://github.com/ClangBuiltLinux/linux/issues/194#issuecomment-662613396
[4] https://github.com/ClangBuiltLinux/linux/issues/194#issuecomment-662620461
