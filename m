Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C622073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4eMG/3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbgFXXGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFXXGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:06:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so1807720plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shst53ZJE1d+vIhz2clceIGi2VB/auhmYdgL62EAsJA=;
        b=v4eMG/3rTtJikwtUeVEWC+d0Ch65aCTzn2lI4XytauNvCzrEjxfgA6aO+yV6VxXBx3
         mb6CDo0wNoFZ1v4nkYj+/6EWy37Ni5nLIOMzCNLEZ2dadozowAf9iZnCoXAn7+HLcyE9
         RoOT6e38CrOgiSMwqrLKdO8N7M+/LB2H0MPGEArcqToIp05l+M0z0UH0D4sz1uNsTgmt
         9mmpfTiacr3PdC/F4zU2Yb9SYNEeuuG0ifqnJKaNC2BdOBDaQw26XwaMnJ0wHebahY7x
         fvvlvTbNep+cdAWoA5BqhP7JrVtoCYLEUqHK25wchmImEauPU24++/TQpkcZFXvICfaj
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shst53ZJE1d+vIhz2clceIGi2VB/auhmYdgL62EAsJA=;
        b=BDaEuATUx0rgHbBWWvaJ5kwPSHNEgyzCvqvGUNEGufIpWJJfSfTduAU8N0a/wXKrwN
         V3CeGVdFjxLmMarmICNdDETXhQTaUm0HTg4KDlIwa7M0vOCQotG3wfaqWHiaLCt1GDeo
         s6vWZDaK1zoVss5ghNtXNoYKwNR1wUNJIIOteRNeB3+hMGKTl2+YsMH/j89xa9jOLrou
         xyYQnygA8y6hvnTh0nFQGsiu0cTyhEwjwRWt6D1rYlOGZQug4xqTbF1aqTKHSdn6rQAu
         9jZ9YtDOER76krVJhnFFNMWCTfRVOXyc/AqK58FT8Kx4/WFb4XIOfdaYpF2/DxgPD+vx
         OKhQ==
X-Gm-Message-State: AOAM533nRY+vhbySr48+iiUQaaaK0ucEt8BKj3H5TXKWWHIg5wARFNwJ
        VeZiLQRIDbDY9GqFEd89dhkquwuWCRdpcl+6eA2N5g==
X-Google-Smtp-Source: ABdhPJxZs7Ep0+V5E2sSAX0aVY+ZMKk8PTjnuF9HO3m5vxhQOU6AbFmmPJG+dflauBb0xhpYFgB/b9UTwA/KqW822v8=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr30115455plm.179.1593039960944;
 Wed, 24 Jun 2020 16:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com> <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <20200624215231.GC120457@google.com>
In-Reply-To: <20200624215231.GC120457@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 16:05:48 -0700
Message-ID: <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 2:52 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Filter out CC_FLAGS_LTO for the vDSO.
> >
> > Just curious about this patch (and the following one for x86's vdso),
> > do you happen to recall specifically what the issues with the vdso's
> > are?
>
> I recall the compiler optimizing away functions at some point, but as
> LTO is not really needed in the vDSO, it's just easiest to disable it
> there.

Sounds fishy; with extern linkage then I would think it's not safe to
eliminate functions.  Probably unnecessary for the initial
implementation, and something we can follow up on, but always good to
have an answer to the inevitable question "why?" in the commit
message.
-- 
Thanks,
~Nick Desaulniers
