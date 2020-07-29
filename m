Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4A220809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="Sdzx2Sqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgG2URN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgG2URN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:17:13 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90DC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:17:13 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 133so13216384ybu.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsAi/yM0dYoTsEAduerPAEeoeBRABFVM36ZfoeomatY=;
        b=Sdzx2SqpXH3YztrrLNOADE5QjX5DPMw9qzcr7aHGCh/zp+I48O4kqqRZpqulQK7b2A
         C0RuSwWADNheZUXSP4rEN1wGIvAHpzoqMuGaY9bfPEyvF7S943eq2s4cUgghOcvSf/gF
         pgSXR0NUIxtUVLHek5C2iWFuwwFK1cYRX3ViHbez65SiI4fPMcJckFrPEMykGyiQCS78
         qAbpP8IMzkK2emxhZ0eXkv50SN/md9uBSLITI1PlvPb8m7/drlC3Ebg9l9hlt1cSmd1U
         zk+/6KjyjmyFpbWHSa1K7nCrIHFc4aSgPROhI0PTheyPL6km/Re6ghueTxNzyrTKrFW1
         WtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsAi/yM0dYoTsEAduerPAEeoeBRABFVM36ZfoeomatY=;
        b=ofGV9s/FddqKB32S8n1WDEq4YEXV4NO31f+S2ajKGuutyAAcr2wp1qAgWaUXydjVAJ
         pk99b0RufFYlTQODyI+0qvr2X6gtpwMG3wVdqTjIvgfutuLVanBcu+PSHW4N/nd+5YnP
         IH0D1qzx5E1C8en5d473eRpL2oZIqZpGsfASv6Qqtbw8DZW9RQrsGUgqRpA2FRCfVGSY
         thbt+vdnhEWB7hT3I7z3IAhJ04jI1XUBJ4bS1Hz49CKgtufYiNyHdA8lN0ZMv/aWE+hv
         m8HzDuYqTC34j6njLRKX8XEZgFsszNcffu4SgojWWbACP4OewbQw4rQh8LMXWIDMLWNX
         gm7Q==
X-Gm-Message-State: AOAM532YMrokaO9j7YBlkzVIIiwd4IFn/ZmZM0lPaG1Qi/IwdLIoS8A6
        POkP0AjwoLDskedPuxfcogwHLcm3uDZm5gYdqCFTXA==
X-Google-Smtp-Source: ABdhPJyPk3kjiGNYFFk4yzHPEbfFcoZIfz0gAfhNJ3Fsk1YWxiMbGPNT80Yqs2GsCLymQyrnK2dqTUc8spmJdwVOFPE=
X-Received: by 2002:a25:bb0d:: with SMTP id z13mr229226ybg.488.1596053832271;
 Wed, 29 Jul 2020 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200729191151.476368-1-vitor@massaru.org> <20200729191948.GZ3703480@smile.fi.intel.com>
In-Reply-To: <20200729191948.GZ3703480@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 29 Jul 2020 17:16:29 -0300
Message-ID: <CADQ6JjU1wg_mrhuGkgiNWmJLCvNcOVwS0Hysda+OXuDcCj8y=Q@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, fkostenzer@live.at, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 4:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 29, 2020 at 04:11:51PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the test_sort.c to KUnit test.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Looks like you mixed up commit message and changelog / comments.
>
> > Code Style Documentation: [0]
> >
> > Fix these warnings Reported-by lkp@intel.com
> >
> > WARNING: modpost: vmlinux.o(.data+0x4fc70): Section mismatch in reference from the variable sort_test_cases to the variable .init.text:sort_test
> >    The variable sort_test_cases references
> >    the variable __init sort_test
> >    If the reference is valid then annotate the
> >    variable with or __refdata (see linux/init.h) or name the variable
> >
> > WARNING: modpost: lib/sort_kunit.o(.data+0x11c): Section mismatch in reference from the variable sort_test_cases to the function .init.text:sort_test()
> >    The variable sort_test_cases references
> >    the function __init sort_test()
>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
>
> This should be in different order: Link, Reported-by, SoB.
> Also [0] is unnecessary

Sure, thanks!

>
> >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
>
> Still opened question why kunit is a suffix? Can't we leave same name? Can't we
> do it rather prefix?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
