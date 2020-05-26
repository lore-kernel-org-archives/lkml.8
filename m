Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE21206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8wznlSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgEZPxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgEZPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:53:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06102C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:53:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so13763pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFGDaxo4qDPqer5LUFoEQ6KIGoB8fRDPFyAGftHJwMM=;
        b=G8wznlSmGX/azkuZBpzODxbojEIv3IpHpPLGHcIrn+/GPZ+gGSY/0XwJxejz+JqQaA
         FUsL/xi6U8cXPw54V9mb3iUEhPw7S5zjvrKrfAcnsoYSny8swg8MPYcD15IdXVH202VG
         dXef/Nh4CyPYNshsQKfY0/0fCJYJbrvXDVxq6ymgUFsC83n3NurZB5OMrzqVXxFfva0o
         F61aNukJJwhtpABmfE0xITfCeSpD36Ge4FsycW1wVT3fZ9j94Rb0s4tvvICJcYPF7oWk
         5StHwBS58sGhwT2M5D4rrBFL30cQVJjGFONqzQm81RpltAVeoEtW3DGHVf6b7v9PCMKm
         DFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFGDaxo4qDPqer5LUFoEQ6KIGoB8fRDPFyAGftHJwMM=;
        b=TyNmMR38qiSZuDCANPAbP4ywFuXeAhMLikNfwpBS+VspnXhflvFuDDLzXYNaiMV8qj
         I57ilqx3sGsOIJ/tFar9yDGnl6LByK+wpDajN1CsW1DRcMxpmc/f220gCGPOSu2maw2g
         pEzmxUNe40PafYwWYIu5TMFSROZjbZWIXjsRRuoOZPPus1KV0qmHdhQUPiMQHCUFgnt2
         l+PqNU8PyIS5yWr9076y9gXE7h9R2VGJBznMXGbkYFKj64lqRoxnYRL/iu02a8Y860YU
         RQMeWz9Qf9YRH/vypNw2G5ZMv/riZIBP4+f2v++lUONa2pU1e3tbDFLPo4bSwNZSP9Vv
         Drwg==
X-Gm-Message-State: AOAM533Vr05ndMijPtuAJJiSJeS3l2541d7NQbCPKQTgjWLXPsSlZrDm
        aOvvo5OdVitXH4ksyWzl8c8eIsl5LAJgy2ok30wC+g==
X-Google-Smtp-Source: ABdhPJxAr38Hn1MJlczKT3KRjfXx0cnuUugvdo85cj77gjf6BdHQ29lyu4vxXpbmZXyqrrwrD1Sfik4PLyVSYIDh7ME=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr27893380pjb.101.1590508403144;
 Tue, 26 May 2020 08:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=jOr4ZaLx-dSNTqZnGRATY1PZktUfu4JGWKRwRH=Ujnw@mail.gmail.com>
 <20200521220041.87368-1-ndesaulniers@google.com> <CAK7LNARtO5Pr2nxpoORSHDFWHbjP0waOmrn_TZ+rXhmYm+TORw@mail.gmail.com>
In-Reply-To: <CAK7LNARtO5Pr2nxpoORSHDFWHbjP0waOmrn_TZ+rXhmYm+TORw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 08:53:12 -0700
Message-ID: <CAKwvOd=qNa4fLY7ymVwvC3TwCH4DNLyEfygoTfBJ2y19xffQUg@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: support compressed debug info
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Nick Clifton <nickc@redhat.com>,
        David Blaikie <blaikie@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 3:28 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > Suggested-by: David Blaikie <blaikie@google.com>
> > Suggested-by: Nick Clifton <nickc@redhat.com>
> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
>
> Suggested-by seems strange to me, but
> I decided to not be worried too much.

Ah, sorry, Monday was a holiday.  I unplugged for the long weekend.
https://en.wikipedia.org/wiki/Memorial_Day

I like the suggestion to simply say "thanks to ..." in the commit
message and will use that next time.  I was ok to send a v4 with it.

>
> Applied to linux-kbuild.

Appreciated.  I will have a dwarf-5 patch set, too.  I'm not thrilled
with how I wired up Kconfig; maybe posting it for feedback is better
than me worrying about it too much.  Hopefully will send this week,
assuming there's not too many bugs that require my immediate attention
(there never is...).

-- 
Thanks,
~Nick Desaulniers
