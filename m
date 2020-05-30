Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F24C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63BA2076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiPz3GnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgE3V4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3V4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:56:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C92C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:56:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so155352pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Q/62SLj+ZhKCBBeH3KOcxljLVc7oDJKgIMz667CV8Y=;
        b=UiPz3GnFhxQqwWmQHi1p73o0a/ata4PU/VN6BsLjZI8opUKdcpvPwkLdEXSLwXCFwt
         lZI5OHWGqUiTkT+PkAY349SzFAKHYMuOeAcPHoIEjMYNUtiSqsgfPn4FnmuoMt70EitM
         +kvo4V8Xxtk9k3RsNxFbUzoSRx2zRidhy/r9Q0l7IRjit7JURpRLvT0pMMALbNJl6mFh
         804ph1JS/FeHk3d9PAdy74TtliBUwFmqSwbK9bJ4w02RHIbSWzpqN90doIbwA/gAMLHC
         qyv+m68X2W6aoBxwr7qK8vxHCB10Wdwo3LR+MC6cnTUSvaBV2AcIReoaOyHhKU5OkGD3
         vKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Q/62SLj+ZhKCBBeH3KOcxljLVc7oDJKgIMz667CV8Y=;
        b=Q+tdkxvHek8E7/2kkvlMybNyitUXJEg7H2fARuhBdcOvDyXXAqQBGsD8vNMdQbx7/D
         hbCdadxICQXivyyY//LDQOzh7CBseq5x1ZF60cKvZjjo5FLfcYcn3OaU8NV4++pPp5Hm
         /9dJhDnTSnvJOYR8IfoLpK5kMHRqNph6IdhNOoQSULc+sl94sS8ns/G3dMFgsBeRliBI
         ELtLwhh+XeBLLp22fq9lvXcWqDB5b47YRODCcm3wyrjaBk4WTMYkJLzn7eSvtTIMe/QF
         t472coxZLKIsKwAqNIRUgGjVZpHNNzIBS0S2kmmMMw0Y2wSTao3siZFa7xdsE6RL5sPU
         pg9A==
X-Gm-Message-State: AOAM531Qv+wmdrLyKZ1HepUCIkwaewvHrkgVRErwT7SOSB+L4FShTOa2
        mWA5Dx1RpP3zaLGOnP6Z4/t0DHpBj5ZXGNgG7GM=
X-Google-Smtp-Source: ABdhPJwdfrsHjuyMwXgw9eFh7VyCpx0khCYBRnPTkdMQ/TUYNTzdLToLYXBK/enDD2nG3iYM+sFPBvouJBXbqGkqUF8=
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr14412358plb.255.1590875806865;
 Sat, 30 May 2020 14:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200530004328.30530-1-richard.weiyang@gmail.com>
 <20200530102531.GA1634618@smile.fi.intel.com> <20200530211940.yninqlngnzfvsvki@master>
In-Reply-To: <20200530211940.yninqlngnzfvsvki@master>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 May 2020 00:56:29 +0300
Message-ID: <CAHp75Vev_a_VrjoLUxfNo3AZybSteuV28t2EChaqydeFjCq=PQ@mail.gmail.com>
Subject: Re: [PATCH] lib: make a test module with get_count_order/long
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:23 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> On Sat, May 30, 2020 at 01:25:31PM +0300, Andy Shevchenko wrote:
> >On Sat, May 30, 2020 at 12:43:28AM +0000, Wei Yang wrote:
> >> A test module to make sure get_count_order/long returns the correct result.
> >
> >>  lib/Kconfig.debug                  | 13 ++++++
> >>  lib/Makefile                       |  2 +
> >>  lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++
> >
> >I didn't get why it's not a part of test_bitops?
> >
>
> I see the document of test_bitops says it does exercise on clear_bit and
> set_bit. So not sure it is proper to put them together.

It's not a problem to amend a documentation as well :-)

-- 
With Best Regards,
Andy Shevchenko
