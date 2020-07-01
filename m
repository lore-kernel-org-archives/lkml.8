Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CEA20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNRiKjGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgGARDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbgGARDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:03:01 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1719C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:03:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g20so20479758edm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXLocZuYa5LyRW+7c8dY9wi1ppvduxYFU7Sa4aAHUQ0=;
        b=FNRiKjGOLujr2GHcouB/onGnSBkqERG4/SfGtF+Ui+ASREDVq0YOFGgipw9Hvu1XeC
         q8heD9a6c0iKic1AFiHslIDWRsk3kJuygMm66NNQI3CKH+rjWm7qheoPxrMSMqJirLId
         u0O6QB0nEFLdDv+1vKCf2hb9UR/WD5bow+KZtf+Yai71jqQEIysBGBLVTL5bXK91wveb
         aW19JVd27lMuXuDtDqanawo4WQLJ1PS+jkTc68VMGHm6mJimVzgSBzRTHIDNYK5Wuy8e
         MdEyachNYELHOsU4Av3kBkd99S9yklbFxhFQ6+0bJLfrFOw8CzsQH0eP8+R4xf2mYRJs
         VJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXLocZuYa5LyRW+7c8dY9wi1ppvduxYFU7Sa4aAHUQ0=;
        b=KU3YbJwO2OlJ8F5TLmfcsau2Jo3Pkn/FsKfhAES51Bl0pqxeJIitmtZ0xFGv3oXe8L
         ewNvpQ2QzhDd5/MDsN6UnyOCTr+q7q4Dy+oY5P9+4l3qElorx3OCaGGN6tBCXcYFRowL
         02P84Qugxv+mtJByu9hbmKZEczQBbcBhXt9iNQahx09FPWdt/7X0K4u+MpfJgHygjyJT
         sZYrjs2XEGGE8wLlaaATgmAP1B6nKaEIFErhCLLMqaRdfQcRsTBDPBiZRxFMbAMn0+wm
         JSApzhwVAUwAWJuZeD53IkR3PWW+mEp4Pd17V94UwwjhOmoWpAzTrjhzoa7PgSuNQeic
         Df6w==
X-Gm-Message-State: AOAM533YKq+6pQh9xASO0rttFLa0zCw58RJrPraiZY6ILt3DylAyUDYB
        oS3fQnd4qxnxzLj+e/2HBi5VvJE8WrJj3iuzRo3MCw==
X-Google-Smtp-Source: ABdhPJx8LUrrdnwmBIDiSNRuGB4f6C/45FYDSPt9e8ZYnDUngrST9sVe5bZuefihx+MmlBauk2XZmDEsc574ZFY6EU0=
X-Received: by 2002:a50:c355:: with SMTP id q21mr27751649edb.121.1593622979559;
 Wed, 01 Jul 2020 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200630184922.455439-1-haoluo@google.com> <49df8306-ecc7-b979-d887-b023275e4842@fb.com>
 <CA+khW7iJu2tzcz36XzL6gBq4poq+5Qt0vbrmPRdYuvC-c5U4_A@mail.gmail.com>
 <CA+khW7jNqVMqq2dzf6Dy0pWCZYjHrG7Vm_sUEKKLS-L-ptzEtQ@mail.gmail.com> <46fc8e13-fb3e-6464-b794-60cf90d16543@fb.com>
In-Reply-To: <46fc8e13-fb3e-6464-b794-60cf90d16543@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 1 Jul 2020 10:02:48 -0700
Message-ID: <CA+khW7hLL+=sZwCT_6gHHjHTZnmbNk5Pju9vsLOJF4VjyHY-iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Switch test_vmlinux to use hrtimer_range_start_ns.
To:     Yonghong Song <yhs@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:26 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/30/20 5:10 PM, Hao Luo wrote:
> > Ok, with the help of my colleague Ian Rogers, I think we solved the
> > mystery. Clang actually inlined hrtimer_nanosleep() inside
> > SyS_nanosleep(), so there is no call to that function throughout the
> > path of the nanosleep syscall. I've been looking at the function body
> > of hrtimer_nanosleep for quite some time, but clearly overlooked the
> > caller of hrtimer_nanosleep. hrtimer_nanosleep is pretty short and
> > there are many constants, inlining would not be too surprising.
>
> Oh thanks for explanation. inlining makes sense. We have many other
> instances like this in the past where kprobe won't work properly.
>
> Could you reword your commit message then?
>
>  > causing fentry and kprobe to not hook on this function properly on a
>  > Clang build kernel.
>
> The above is a little vague on what happens. What really happens is
> fentry/kprobe does hook on this function but has no effect since
> its caller has inlined the function.

Sure, sending a v2 with a more accurate description of the issue.

Hao
