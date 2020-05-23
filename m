Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC30C20757
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZRgirog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgEWJMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgEWJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 05:12:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC4C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 02:12:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so10140311otr.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPw5LvQcTEsfBp2CGXcAmOXUYeI1dGSO14K+bI7ak8k=;
        b=rZRgirogsNM6nMDwMP/7OayllV+zJ98jynoE2/DjqysbNwfpa+z5jnCVPBRMKqDiu5
         wK52NFsgx4nXLH+wIMlOFWdW+FetHnVbmLJRNVwoZ9LY1JC6sjWeAvHZvgAtMgvkIly3
         70EXxxOfTT5ZLuFbviDWxbBsxinydqlIh6RiermYe+haGyTJB3CK+0FOzDJJj/KJWCkp
         IvDb6g0wChehZgfXCUiY1gKLemcsvJN2c1d04wBRgPvGcyw8UKcis6xEV91jCqESqZ5R
         VNyvU3e1NwClat8UrchcFYLmgFhkNIS2q5dZb6vn33w/8MNVLk+91mLnL6AEfP3K2IAF
         Kusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPw5LvQcTEsfBp2CGXcAmOXUYeI1dGSO14K+bI7ak8k=;
        b=nLDRicNd4wxiMBPClHERNXCrRu0drpM54yRN/sDOHZDZaZUvhyPi8pnD8k5qru/aXN
         oaUHXnB01kho184mJB/HdYTxfErdWpg7u2Esxk5PO6UFJ+pZ5tv1B7JLU4kAztIo70E4
         Kax9tXFMvTlJngg7a0P32qmqlg7fTjnkYD7QUy9qYM2hawTBnpqCRFqbBm+md2CQnst0
         lHd/FW7/eQmbJ/KY/QrUgGsuXNgL3gmVNVIeuaBhOzJtz4ggilU2L29u2N0MJOls3Dzl
         bmnHHtnbiykHDOGoKLmtVcsPz3F+aKj7aFdSizPACQx1DKpgKj/kf3Z2PrWN7PNQOccp
         uTgg==
X-Gm-Message-State: AOAM530WZLloXGABlBfbCVXoqxO51RDZZSEoBIK77IoPJPgV8c3Hv7bV
        tQOyXm25xqwPMCWFMn4M2DXMFrwnGAfMUki5IQa4uQ==
X-Google-Smtp-Source: ABdhPJxuByUH5C2Kz4iEiY8KgHki0c1PoQxwS7DwYqIeLQgYdrlAyVT8VA4YGKX1WHIfKjXem0nsktX3AnOMWBqFrVo=
X-Received: by 2002:a9d:518a:: with SMTP id y10mr14870284otg.17.1590225142785;
 Sat, 23 May 2020 02:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200522075207.157349-1-elver@google.com> <20200522164247.4a88aed496f0feb458d8bca0@linux-foundation.org>
In-Reply-To: <20200522164247.4a88aed496f0feb458d8bca0@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 23 May 2020 11:12:09 +0200
Message-ID: <CANpmjNPVp0Orzm_MT4pjX_U_JwqskWbnXERRwFebFfnCbhJXLw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Disable branch tracing for core runtime
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Qian Cai <cai@lca.pw>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 at 01:42, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 22 May 2020 09:52:07 +0200 Marco Elver <elver@google.com> wrote:
>
> > During early boot, while KASAN is not yet initialized, it is possible to
> > enter reporting code-path and end up in kasan_report(). While
> > uninitialized, the branch there prevents generating any reports,
> > however, under certain circumstances when branches are being traced
> > (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> > reboots without warning.
> >
> > To prevent similar issues in future, we should disable branch tracing
> > for the core runtime.
> >
> > Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> I assume this affects 5.6 and perhaps earlier kernels?
>
> I also assume that a cc:stable is appropriate for this fix?

Yes, it does. On the other hand, the workaround is simple enough
(disable any kind of branch profiling).

Note, the patch won't cleanly apply to 5.6 and early without this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a16c09edc58982d56c49ab577fdcdf830fbc3a5

Thanks,
-- Marco
