Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571BC2BD11
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6A420722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbrg7jCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgICTby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:31:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C424FC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 12:31:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so5492249ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ju/sydS5Q9IaBUhC6NOUzji212D6APi15kEY10l2jM=;
        b=lbrg7jCc44YPYHlwiPPcORp12NA43Sx5aUGnQyPqjAZQ5Q1+z1RgPw+CGG0dUOPJEj
         kJGDDjgam1jWTW3bD6eQLxH3xOpG/BbB/aI6TuYBbYOK2ufE5kZLYsGVcwI8E76JMncU
         1qMvJ0kvpTY6aJ2Xdtm32ZmteixI8ThusUxRh5s6VPVymfaGtdGYMNUWAL9DZVm/NXQi
         1cGBTEWExtOQDHGxdV8X7JrgCcJOFDgRA9Bubiog5xFkI384UOsEB29j9ha2PplRjHec
         hYTYbOHrDZgXRGwZTildKLwFfV/T2hngSupVSuZxPAeEmyq8zw+HnSntGFc4Yrr+ndAw
         wTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ju/sydS5Q9IaBUhC6NOUzji212D6APi15kEY10l2jM=;
        b=g/Dsbveq9fCH0phZYSNdUq1e3+SvPdN6Eup4ptJD8HaH5IKjyUAMitcHHQKQEU2wO6
         +pbTJYAQcBi4PR0STZSdkhQooIR/Qw1vezQX6s5zk4xR4Axf9YiCYJ6rGCp2umIcTi2y
         VxEgkb+Ym8gXlhQd2WX2pdNiNpm41oNs15cZlmEo7O6oMoEkj2nLCAavHceI1do0G2HD
         4koI4O9C+4p3fEwsi6npgoku8fapv4OoB838t6iku70ZFPMY73hffrLi7NRRiyTGL7nY
         xoILICFKHu3bR6DaAFMFTRruwV5BtlvwiNMk8ZiarLWhPqf6N5zqX9CTe2Os2hbBrMGl
         Tung==
X-Gm-Message-State: AOAM533dI3F604OsE9yb/ssTFUk/lAKa/ncikcB24dw9IVWFVXrmHhE2
        kgv8qtyHP/QUJUPCZWV7WdV7JNHyoDgVlI7eKmyk3w==
X-Google-Smtp-Source: ABdhPJykXItJHXfSEX+xWXdv9YgktkqyXhkFXzwTurtiCZASYxKs6/icUg7CX5hCLBz4dib5+dOrOGiccCfbzXdfQ5A=
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr3684224ejn.113.1599161508226;
 Thu, 03 Sep 2020 12:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200903180121.662887-1-haoluo@google.com> <CAEf4BzYtr6Tki8viGt0KBAwH5FF0don+j3Td86m0Kg95kUEAhw@mail.gmail.com>
In-Reply-To: <CAEf4BzYtr6Tki8viGt0KBAwH5FF0don+j3Td86m0Kg95kUEAhw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Sep 2020 12:31:36 -0700
Message-ID: <CA+khW7hG4FFToxDcXHS29Gu3pz5tN-93sf90YyE6PqNDosjNdQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix check in global_data_init.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem! Let me update and resend.

On Thu, Sep 3, 2020 at 11:50 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 11:02 AM Hao Luo <haoluo@google.com> wrote:
> >
> > The returned value of bpf_object__open_file() should be checked with
> > IS_ERR() rather than NULL. This fix makes test_progs not crash when
> > test_global_data.o is not present.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > index 3bdaa5a40744..1ece86d5c519 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > @@ -12,7 +12,7 @@ void test_global_data_init(void)
> >         size_t sz;
> >
> >         obj = bpf_object__open_file(file, NULL);
> > -       if (CHECK_FAIL(!obj))
> > +       if (CHECK_FAIL(IS_ERR(obj)))
>
> Can you please use libbpf_get_error(obj) instead to set a good example
> or not relying on kernel internal macros?
>
> >                 return;
> >
> >         map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
> >
