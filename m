Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ADEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0FF207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599761517;
	bh=+0kW6y6eIVbyH07Kmbn2O1HBfCtw/IaGgJ8BEPeDfi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GqhpZI7OT7nw391vzYtdtepf8njpuv/8lASAJmMURF7laUvJZGXFo1p6aT0csV/Cj
	 4TBgyXn6pCErekaSVqydhP0npJ3/jrYQJHl2Mx0ZdsL1LzjnNZ0XOMnFHnj8rT5YW2
	 79/QduyESsijd1aZci2q17LWhW3CZkrsOiyJh5UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIJSLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:11:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44720 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgIJSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:09:41 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 08AI8SYc026504
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:08:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 08AI8SYc026504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599761308;
        bh=vpW3QPcHXr6bjmCLt74cvbbZngeiHu+cInhD9vnp9CU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k4cPC+75bD8QxOzFwBtlF22o1MuucYq8hG2qjpMbr4Uaozob3CpxHw5T2tFu1u2iV
         SIs80qHbEE1rz0wRG8Hh9sN9qFeXw95OgbNTJzmZvd2biIPBr+AcdfkeUusW/lAvSW
         WR+VkkHG9xTbmkqJHNEEoacJF0H86hnpk89y1u8CZqfU8czQ0PXiqwPaLLoToK6idZ
         n4DdRnlqIn3dX8wSJdup4l6nGPrtkRWfio2a/IHQD+7a4fIQMD9zMyE/BxL4mpGmh7
         80NtwpEOv5FjzQxB24h+ao5TUvyfgHX+alYS6GvPwn8lhA8pOo2Pn4KfRJavdSl4FN
         dDfERf0VooX/w==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id u3so409768pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:08:28 -0700 (PDT)
X-Gm-Message-State: AOAM533F/BZlVpgJUNu3O6QI1qPaXCiwi5x/C9SToAV3bwk4o5QJhOTN
        LKLLt0oKxNmuk/Z16gkjPWnM4X0oWt3osb1OuEM=
X-Google-Smtp-Source: ABdhPJxCn359oZVq73QCn35/MyIufOYyLNeY6iVxRtS9FRAUrGy1w8LE6tH2u/r8M4SN6ydviNHbQfeb4pb6SoVext8=
X-Received: by 2002:a17:902:ac8b:b029:d0:89f4:6220 with SMTP id
 h11-20020a170902ac8bb02900d089f46220mr6888021plr.8.1599761307850; Thu, 10 Sep
 2020 11:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <CAKwvOdkbkvXdfXLzTNOj8m8_YWjL6=bSn4-AbRyd-5oYGJVNSw@mail.gmail.com>
In-Reply-To: <CAKwvOdkbkvXdfXLzTNOj8m8_YWjL6=bSn4-AbRyd-5oYGJVNSw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Sep 2020 03:07:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfoNg1wFi8oGar3bhzUXtNRMyuz0ksSh2hhzG_PdAMVg@mail.gmail.com>
Message-ID: <CAK7LNARfoNg1wFi8oGar3bhzUXtNRMyuz0ksSh2hhzG_PdAMVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     ian.bearman@microsoft.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 2:46 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Hey Ian,
> It was nice to meet you at Linux plumbers.  You might want to take a
> look at this series.  It implements builds of the Linux kernel with
> LTO.  It would be good to get eyes on it and help review it from folks
> working on this from the GCC angle.  The series has some configs that
> split where Clang specific changes need to be made; it might be of
> interest to think about what would the similar changes be needed for
> GCC.  Also, congrats on your LWN article!
> https://lwn.net/Articles/830300/


FYI.

Some people may remember GCC LTO was posted in 2014
(and rejected by Linus).

https://lore.kernel.org/linux-kbuild/20140407201919.GA15838@sepie.suse.cz/


In my understanding, GCC LTO does not work for relocatable objects
because GNU linker is agnostic about LTO.

GCC LTO was implemented in the final link stage (i.e. vmlinux)
by using $(CC) as a linker driver.


On the other hand, Clang LTO, in this series implementation,
works in the pre-mospost stage (i.e. vmlinux.o).




--
Best Regards
Masahiro Yamada
