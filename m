Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB55DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D946206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597833967;
	bh=uKTeOmO5BIgS6NFfyNJx/drnLg2KgD+4wbwapjeCmD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n7DUoeajSebiRWB8lYmwP8qdCdV9apwgI+No26To22KTGJO5bHuAuwA4DtUjOuktZ
	 9lQq7LX6VTh/t7pDmEwtKBNcIvFMTkuueRPMU/QCP9KAhrzGhXXnrcKJ5ju54QoEH4
	 gNd1dzTHlxqpRVwVDBHMPMuTKwSPcN7qJVbWH6Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHSKqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:46:05 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:59694 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHSKqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:46:04 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 07JAjpBt025117
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:45:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 07JAjpBt025117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597833952;
        bh=hQjgpFMl3WcqCwD0/uAha+Np7Le/iD3ezVCyOgswOUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ElLABoxbetT3Q1X5PH/VmC7NeiOZtZtntMpLEWlj0mje7hScaMf8iGhEAS+RY2dx7
         M72w2rrE2E8WKj3kaCj9r4fJONwKxZII2ZE2IjgUT/H23OKVbvZkZ9KmUzMtaz0l31
         ONxv0LYvNw2XbuK4rOCDKItOgJUgavLVx2B9PqilM78ZcBfJnr+MVFnHpjZh1fPCKp
         vVm7ap0OJO1fPh2rCeJYyCr58QuQKVturglA3LDADVDh0JpPav6Ai2+5VsjFfx/I0p
         fMgdRVmZryfK27hsmqsmdjROSRTj2duNO8plrVBmEfbo7Kjr3xj4vcdXtGbc5DXvTq
         s1WATCGdCco3w==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id a1so11690293vsp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:45:51 -0700 (PDT)
X-Gm-Message-State: AOAM532BqOBQv/5kMZ0hnaJ/XS+95ItNq3WzHDCMM692wOMxi1GgMJ+w
        vz6h0UxEMCHRYDrP+zy0hKOPSOjX8GmD21npYvQ=
X-Google-Smtp-Source: ABdhPJxGe9h26jqUUl2ZwldSWPldVtiRgUy+StSBEhY9HZAWL+5uRMP97LLESLSwUybDfuJfpn3Mrz4P+9bcnkQBQms=
X-Received: by 2002:a67:7905:: with SMTP id u5mr14315191vsc.179.1597833950660;
 Wed, 19 Aug 2020 03:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200819094437.GE1891694@smile.fi.intel.com>
In-Reply-To: <20200819094437.GE1891694@smile.fi.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Aug 2020 19:45:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQ1oAQm19-mzCKdMQsiQsYT9BRH5H7zukpFSzJw5WZZQ@mail.gmail.com>
Message-ID: <CAK7LNATQ1oAQm19-mzCKdMQsiQsYT9BRH5H7zukpFSzJw5WZZQ@mail.gmail.com>
Subject: Re: -Werror for `make W=0`
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, X86 ML <x86@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 6:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Hi!
>
> Maybe silly idea, but would it make sense to enable -Werror for default warning
> level, let's say W=0, at some point?
>

Every GCC release adds new warning options.

Enabling -Werror by default means
the kernel build is suddenly broken
with new compilers, correct?

-- 
Best Regards
Masahiro Yamada
