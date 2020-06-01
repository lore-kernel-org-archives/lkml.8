Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8529F2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va83dYTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFAWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:19:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A035C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 15:19:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so4129022pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IqLU2DCduGFuGkJYk7IH1ysNp9fExFbJIun8lKl0NY=;
        b=Va83dYTqvaNl5qiheSXCYhTaywOS/5I7nBvJ60RbmcbffczHTFnTdy5w3Cu9/InZIZ
         L3p9iZvAep9FZAzDYnYpoVIwaS96ru06JOjvqqhKVhdThLDW+exQ28MEi8KSfWD8prhL
         SsVoR+CV+vcAnRTeB2HjvMO3ZDw1m6FPL4D+rW4Q4WgOcFRHRqBjlVAsC4TWVgCkcBNA
         khC67QMX2BiAvNcy6z3T+LXut4iJSHRvAp7W1rDWfzEY9XZ8ZEvZYdgkTisC9DDb2CmA
         Z9uMwt0/7keUrv2M4CtCr7QCFMzmt2vX/iaO7/Lk3KNrL36QGMeAs+5ZsI+mrMHJhW4n
         6WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IqLU2DCduGFuGkJYk7IH1ysNp9fExFbJIun8lKl0NY=;
        b=NEKY8w74+mpfmcQL2dL8u4LdgHFtRNwaH83B6n6r3rtNZzjeA2RLrY/QWxCc/xWkSb
         LFWMchz56Lukw1eRfkEL6xP+wbOXTMq/xe/5hV3OK4Sv+O0vTZA4Gc/rrSk5+zPlz2p0
         pC5Lfk8nyk0HLa/pWCwTvz8lFtsAY3AEnDOCL4hyDBGd1ClKuwNMqVap7I0jeDhYx4Gq
         QUQKgztkJf4eMUhix7t5eL8a7CTYiHpoFSN6yVs+cJYRf/4uBoQKdhzNmqJO0PMz51Qd
         S/SGNgRmFzY5WGq1JxUwp2yNvQp/zGU90bv0ZRLHRoGjeU5luUY2W/BckLh0KAmea24M
         P0rg==
X-Gm-Message-State: AOAM530EVfA5VhiW3jN/l+dkhOpREKNmCEkFn7IH1mW8bu9bSlQq8zlB
        rN0VLNA77zn8C5hXckJIXWldqVdx+fbMIXvp7Jq44Q==
X-Google-Smtp-Source: ABdhPJwuOswGjiRvrNC6PZ0sVDYvurnOvic6nYlnyLftU16CyrywOCBP8ZooUgIAi0ibz3FJ6jwGMEZb8nLG9sK8jVg=
X-Received: by 2002:a63:5644:: with SMTP id g4mr20317628pgm.381.1591049975387;
 Mon, 01 Jun 2020 15:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200521100952.GA5360@willie-the-truck> <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
 <20200526202157.GE2206@willie-the-truck> <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
 <20200601070459.GB8601@willie-the-truck> <CAKwvOdmXmxOdW_TJQmYBYDY8gDOacjDTcpSWQGATb2p_85tFAQ@mail.gmail.com>
 <CAMj1kXFQzBaZO+RGKs2iJOzW6rdEiAjdVc8PJ4U+KMWgCD9a6w@mail.gmail.com>
In-Reply-To: <CAMj1kXFQzBaZO+RGKs2iJOzW6rdEiAjdVc8PJ4U+KMWgCD9a6w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 15:19:23 -0700
Message-ID: <CAKwvOdnz-=GD9-taLQt6LDhs2Q-xgWmywCUA6skB0NJhubB+nw@mail.gmail.com>
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 2:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 1 Jun 2020 at 23:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Anyways, it looks like the address of member from NULL subexpression
> > looks problematic.  I wonder if offsetof can be used here?
> >
> > #define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (offsetof(d, f), (void *) 0)
> >
> > Seems to work in my basic test case.  Untested in the kernel.
> >
> > IIUC, ACPI_OFFSET is trying to calculate the difference between the
> > offset of a member of a struct and 0?  Isn't that the tautology `x - 0
> > == x`?
>
> No. ACPI_OFFSET() is just a poor person's version of offsetof().
>
> (Note that it calculates the difference between &(((d *) 0)->f) and
> (void *)0x0, so the 0x0 term is there on both sides)

Got it. So we're trying to avoid including stddef.h?  Can
__builtin_offsetof be used here?
#define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (__builtin_offsetof(d, f), (void *) 0)
The oldest version of GCC in godbolt.org (4.1) supports this builtin.
-- 
Thanks,
~Nick Desaulniers
