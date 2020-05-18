Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1661EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29A02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3b7ywlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERFqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERFqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:46:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:46:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so6912489lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygsoJcQzy2g2jI/Taob7j4UIGHvK7ly0RJpFdbU+Cb4=;
        b=G3b7ywljZcZCAX7nJXBHWye89fgIXWV1Y/Zi9/UIsGwtIZiAQx6o0HUfhuMVoDPo1w
         hLvGWKlDX+XuIqbe3zySiJ9YKptYVBEz7TNH6oKzYopJNoJY37POYt3GcdMgO8U647BS
         sEBMh9Qv3TmZ7Mps0cLu+9qi/HJniKyoE5IT/B1tEfEs9oKHXXAwf2KIN+WWwJwUQyRZ
         KCZakvpO8oHau4eSIUGwLM09uWOlVosi5UtGk/WAqYqOlqII3hyHZRvOFDzXPNdNX+nd
         UoEdzxlsRe9mhcxNjNtn81gNC8rPkwKMYMiPW5cMIMMQ2wdPlVYVDDZ+R7OvN0P2uE7f
         hqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygsoJcQzy2g2jI/Taob7j4UIGHvK7ly0RJpFdbU+Cb4=;
        b=l7lIPZ0mWoh6U156raOzyn6AteJxW8bn7zZJSJosdH7sPQnCsW4vL5Ad8u6UQB1Etm
         TUUJRQPkp3zTsIRCW+COSxjSXIjkWzPFBRdCsxaDy61YNnmzPHIYHqr5JtWEl7KYSMCv
         3EUfNI4da8F/zpUrwYC/R8xxaJ3AbNme5x0zgrcj+EyJe+GaG6n1fsIWufT7oeVrlC+U
         HwYHp+hvEDgJhxfWPffAd+pHgyT4MK69bl5v2/Ny6ffksjEvcoQPmoaeIhqqK1TMVSzy
         mJrLi+/5n+JRKXgvIe9nAIKRijXW/189PYAqLxg1onXtgGI4tNVNzLeZXXp+QLMHOsPV
         bZlA==
X-Gm-Message-State: AOAM531uetNv12+szXNW+CPKk7sc6gQ9kSq6SH5IojSykMpi6CeQGAO3
        rVnYP5Wt/8GZqCorOz6k2F11gAc8RSO5aHTiFgoAXw==
X-Google-Smtp-Source: ABdhPJyPLjwCY26rBdZ5XvQW0icPtULGRTn1trgI95j9zoosQIx4alkuPwcX0KcurhfvhDLJGNfimNIRIR5n3hOAMXM=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr10444777lfh.204.1589780791774;
 Sun, 17 May 2020 22:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200516124857.75004-1-lecopzer@gmail.com>
In-Reply-To: <20200516124857.75004-1-lecopzer@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 18 May 2020 11:16:20 +0530
Message-ID: <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
To:     Lecopzer Chen <lecopzer@gmail.com>, julien.thierry.kdev@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        lecopzer.chen@mediatek.com, alexander.shishkin@linux.intel.com,
        Catalin Marinas <catalin.marinas@arm.com>, jolsa@redhat.com,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, namhyung@kernel.org,
        Will Deacon <will@kernel.org>, yj.chiang@mediatek.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Julien

Hi Lecopzer,

On Sat, 16 May 2020 at 18:20, Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> These series implement Perf NMI funxtionality and depends on
> Pseudo NMI [1] which has been upstreamed.
>
> In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interruts.
> That can be extended to Perf NMI which is the prerequisite for hard-lockup
> detector which had already a standard interface inside Linux.
>
> Thus the first step we need to implement perf NMI interface and make sure
> it works fine.
>

This is something that is already implemented via Julien's patch-set
[1]. Its v4 has been floating since July, 2019 and I couldn't find any
major blocking comments but not sure why things haven't progressed
further.

Maybe Julien or Arm maintainers can provide updates on existing
patch-set [1] and how we should proceed further with this interesting
feature.

And regarding hard-lockup detection, I have been able to enable it
based on perf NMI events using Julien's perf patch-set [1]. Have a
look at the patch here [2].

[1] https://patchwork.kernel.org/cover/11047407/
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html

-Sumit

> Perf NMI has been test by dd if=/dev/urandom of=/dev/null like the link [2]
> did.
>
> [1] https://lkml.org/lkml/2019/1/31/535
> [2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq
>
>
> Lecopzer Chen (3):
>   arm_pmu: Add support for perf NMI interrupts registration
>   arm64: perf: Support NMI context for perf event ISR
>   arm64: Kconfig: Add support for the Perf NMI
>
>  arch/arm64/Kconfig             | 10 +++++++
>  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
>  drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++----
>  include/linux/perf/arm_pmu.h   |  6 ++++
>  4 files changed, 88 insertions(+), 15 deletions(-)
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
