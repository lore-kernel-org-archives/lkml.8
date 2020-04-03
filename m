Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BFAC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1339206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyKtecke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404085AbgDCRLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:11:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44806 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:11:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so3774681pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do8qIdF6vQT1e9Pt11DpfMfF7NFSyvJ9YAoinVPJ4B0=;
        b=DyKteckeKbLQOHNxRvjiNlOfjdsr1jQqgBETM8ffw0t5LACA/f7nbtTlfVqAU361A8
         TlhaFiJ62NeeuXaXLHZ22PCfK5Na6gFRwfsFj3geWBmfSR6IcUDb04e9bmoJ3GU0DfmI
         FFadDtjoTTt/2L2Fk/QMV7ygzbBXCmepfSUGHdywPKQgCzg+01p8LqL4yb8DTyq6RnNJ
         grjPD3zunmVFy8bwFXFqR/qFoBCdaJbK8gOk65d+iOVPDODB+N7IJxBXBqUhlbSvZ96T
         vzzDATVU1QI0gcBgjfciFIGSJdyeKX8s42+L9gvQkEuvIg7/B0/LB8InfQDg630DiPtG
         358Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do8qIdF6vQT1e9Pt11DpfMfF7NFSyvJ9YAoinVPJ4B0=;
        b=hbOhY5Q/hlIwytewsLOUN+NVeoCGa/aJuGQvBHGXxJLfionn3InT+JzWHyUYvGNfW/
         Z54BtkGFGao8svHVqSbgeOeOdhTlpXVBTE9oQQ0rSFWzjuxriJtRs4wz33XUKbA72VZs
         QTdbbKW0br9MGjmovOi51lG/pw2BbCvm54zY+zz4ZFidfpxGVCh8SBqGV3bvdCPSlVTa
         ikssr3Y2Jc9Hoifuhbyrjt9s+IeTHwjSvo/s4nvF8HzyiuNyK7n6F0OZ+M2HP/lXgHxA
         wsTpoSoZrD9C0zdHJlm2h+R7zwDsKSTydU1mB+gEPI9/OLoA19ON9jDya/YItnA1J3J3
         Yfvw==
X-Gm-Message-State: AGi0PuY/HFsNFL7m0+4imIIujG5v65GR4dLyomC4e78S74l5hDpVXQm3
        g52W3Gsra7U3pJ5k34tiR5opuHZOl0bLJgU378lkZg==
X-Google-Smtp-Source: APiQypI7UauSw1zmt3GWDSv0euHCVWL7ySGTXKz+bk1VaTUXvcO5W9wbt8hwUVo/DiAbuh0tRYCoyUszY50nCC6+t00=
X-Received: by 2002:a63:d049:: with SMTP id s9mr8754031pgi.384.1585933881177;
 Fri, 03 Apr 2020 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com> <20200402204639.161637-4-trishalfonso@google.com>
In-Reply-To: <20200402204639.161637-4-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 3 Apr 2020 10:11:10 -0700
Message-ID: <CAFd5g45owC+D+K4RuppmyTJ+d+NGRL1CpuciXwXYvmtBfXnXYg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Add KUnit Struct to Current Task
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 1:46 PM 'Patricia Alfonso' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
