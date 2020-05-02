Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C7821582
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U9FDisrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEBJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgEBJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 05:49:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631DCC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 02:49:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so4539947otk.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoBzoBQB4BVIuqFQUVFVcE1WM4gIMhxIJSSV4i2CqWs=;
        b=U9FDisrUMhsDhFo44hGWbKStvuHwnO7Ntpk9HnRp28d+d6A0g7J+T0Ot8hMaxegKcI
         zTMb4gClyG7Fl+FyOvTUNXH83lgnSUX1BNVa3mMWrISD/7N/goU7SgK72Gi4IuqpPaQk
         lrlaGqbu6wWBFcwWFONxzEg/HWO/sHW8xSV4R9kW7XlJy/N3LPPSr9mrVzge7yuosNEH
         xsPYJknKxdO4zjRB9elXwFs0kRHmfCHJINLqRAKg1MMVY/P2ahe5YmBT8k2K3uuTRKZ9
         kTqflJoP+MAflNexI0ijWBACdd/Z+0dGEySL6AfPcJBJSLSeKJVuAi33w4W9EgddNG8x
         wPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoBzoBQB4BVIuqFQUVFVcE1WM4gIMhxIJSSV4i2CqWs=;
        b=JUwlxB0HSJIDmTIL1tts5QlswFx9aCWJRWZ/D648TiU9Cs4kiYcxZDRnTB5GNSe9Wv
         ihyE9c2mfjjh4iXXCrh/4huSfYHa5TcUvWNRTUzigR57DLqe+dc5xze9E0IG7jzA+2oz
         O440eawW9F30hOK0ZDdnIg28N6EIIMVRuC1p37WiTAZLFTmdQY7KK/ZOD8zWnbQAHAPO
         R4XHcgEuAnE+H5PKQ1VG7gkXC1PDK7dcGCjPyq4/4j0OENm/S/SS8ixKbBb+dYpGHlFC
         5zwDOYenMTZgP6GQmuVcTtSXjO9elfGaP1MxZCf1mGtFlaIF9WjbgwWqEWYLANx6tc5g
         SJhw==
X-Gm-Message-State: AGi0PubrC6o3bnjW5rKbWOxOe5MGVY3xAtP0GMNoRpZ5B+JwjQYenGZ7
        WFXfy0H9KKqfTiZmR7j158umqX2PXbX8c1PKWBLBOYxK
X-Google-Smtp-Source: APiQypLgmqa/AuOjC7ZVGpbIbQ53B2ED7l1oGRMbzMwyoxJiFpp0SrZzdBEULNhA0bIUnlMdP9ImYADH8YgIDL5ZEDU=
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr6910351otn.33.1588412980814;
 Sat, 02 May 2020 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095325.111441-1-zong.li@sifive.com> <CAOnJCUJBJ3wrY-KY3YgD-qJfr7dsWzdA83fxFYmOTmjsrYgOfA@mail.gmail.com>
 <CANXhq0qk_GQubgWB9=2uMVDSLSCWaiLtPkBcHQCPLCHyVrtdnA@mail.gmail.com> <CAAhSdy0QRMCm0jWe2azQ-6_D3KPRO60YEX+Wk-+HMrJfwYn_sA@mail.gmail.com>
In-Reply-To: <CAAhSdy0QRMCm0jWe2azQ-6_D3KPRO60YEX+Wk-+HMrJfwYn_sA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 2 May 2020 17:49:30 +0800
Message-ID: <CANXhq0oyPxDzXjU7s-XDUn0OGMkA0JvKeGs6Ac=JJErWE5rVnA@mail.gmail.com>
Subject: Re: [PATCH] riscv: force __cpu_up_ variables to put in data section
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:13 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, May 2, 2020 at 11:30 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Fri, May 1, 2020 at 2:23 AM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Thu, Apr 30, 2020 at 2:53 AM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> > > > Currently, these two variables are put in bss section, there is a
> > > > potential risk that secondary harts get the uninitialized value before
> > > > main hart finishing the bss clearing. In this case, all secondary
> > > > harts would go through the waiting loop and enable the MMU before
> > > > main hart set up the page table.
> > > >
> > >
> > > That would be only true if you are using random booting protocol with
> > > SBI v0.1 implementation.
> > > With HSM extension in place, all the secondary cores are waiting in
> > > firmware. The booting core
> > > will bring them up one by one from cpu_up method.
> > >
> > > The HSM extension is already available in OpenSBI v0.7 and Linux
> > > kernel 5.7-rc1 onwards.
> >
> > If I understand correctly, the newest kernel still works with earlier
> > OpenSBI than v0.7 or BBL. It seems to me that we need to consider the
> > use cases if we don't limit it to up to OpenSBI v0.7.
>
> I think the commit description should clearly state that the issue will
> manifest only for random booting of multiple HARTs which means it
> will manifest only for BBL and OpenSBI v0.6 (or older).
>

OK. Let me modify the description. Thanks.

> Regards,
> Anup
