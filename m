Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22208C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01D7206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="BOrhAO2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFKR3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:29:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE5C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:29:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so6989512wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gv2kS6G3o83f2mBPnYmMpo8TuJCcISodnEkPwPcYQnE=;
        b=BOrhAO2vWpMDso2mx5GwRjXpyvGIn++k+1R00OaP5mChKpAlscrEZsqwuF1TYhbAV4
         OoIqjEtayPMVIGwtgDZHlAL8y/gc6CxGKQ2kGcL89SMHnAN4XqG8pAJsoYHrARWHFs76
         Y0j6HMJIuKh8GQpVOZQagPjv2rsu1J4B6uD6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gv2kS6G3o83f2mBPnYmMpo8TuJCcISodnEkPwPcYQnE=;
        b=cU2X0V+L9Uaqsi9GDdL7hS7Z8J2ViZ1QzDr2rQhPfJkDg8FZvb3KPLDEb97Od/JlX/
         NJLq1Bp9rZIaYu4Yp3nEYD0iszizAikLwkNh8zk0XFFbXl5zP4WKPNzTe66gS175ohlV
         5k7ATY7oOcF+gK8YDrZKgWaWpCRUlpnoo1tbbomXpLu63+0uufZm0g3K74WtDr+8OLyQ
         dyXAIOqXDBTeOnF8JFp8W7+Fz4JHv4mL1QLUbSzrbuo1xKz9iDO5+DSS3xGclo2kWfBf
         HPpl7LHK4guapTwxz21M3cttRzPVmslZlvUgAsCR4dAFx5OscdqfFVxXaB2+wM9wKqYm
         So8A==
X-Gm-Message-State: AOAM530SU0iTbCarfG8Eh83g+PHY4snT20+S6vtMkiPbMSLJgN562KSq
        uITQVUTNu37RFNk0TXo9zuyUqJz7gbfZe8KqajEW
X-Google-Smtp-Source: ABdhPJyWWL+hUtM4a2VwYzffSh78HZlncIF/3sL9ZnNp2EfXeeeH93J0EfETtmyORukse0dSa18u+e3xo+ODmWtN0MI=
X-Received: by 2002:adf:edc8:: with SMTP id v8mr10227082wro.176.1591896563205;
 Thu, 11 Jun 2020 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr> <CAOnJCUJSKvLDsXC8+wyO1xsZDzLJmjY2kwMKhjz0t+uS8h0pDw@mail.gmail.com>
 <7ad7057e-fdab-14ef-9bdb-c77ccefd208a@ghiti.fr>
In-Reply-To: <7ad7057e-fdab-14ef-9bdb-c77ccefd208a@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 11 Jun 2020 10:29:12 -0700
Message-ID: <CAOnJCUKcMmchxgeHNx997EH5JM_OAJFUDCNT6Ca2B-xHE4YT5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] PUD/PGDIR entries for linear mapping
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:51 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Atish,
>
> Le 6/10/20 =C3=A0 2:32 PM, Atish Patra a =C3=A9crit :
> > On Wed, Jun 3, 2020 at 8:36 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> >> This small patchset intends to use PUD/PGDIR entries for linear mappin=
g
> >> in order to better utilize TLB.
> >>
> >> At the moment, only PMD entries can be used since on common platforms
> >> (qemu/unleashed), the kernel is loaded at DRAM + 2MB which dealigns vi=
rtual
> >> and physical addresses and then prevents the use of PUD/PGDIR entries.
> >> So the kernel must be able to get those 2MB for PAGE_OFFSET to map the
> >> beginning of the DRAM: this is achieved in patch 1.
> >>
> > I don't have in depth knowledge of how mm code works so this question
> > may be a completely
> > stupid one :). Just for my understanding,
> > As per my understanding, kernel will map those 2MB of memory but never =
use it.
> > How does the kernel ensure that it doesn't allocate any memory from tho=
se 2MB
> > memory if it is not marked as reserved?
>
> Yes, a 1GB hugepage will cover those 2MB: I rely on the previous boot
> stage to mark this region
> as reserved if there is something there (like opensbi). Otherwise, the
> kernel will indeed try to
> allocate memory from there :)
>
In that case, this patch mandates that the firmware region has to be
mark "reserved"
the device tree so that the Linux kernel doesn't try to allocate
memory from there.
OpenSBI is already doing it from v0.7. Thus, any user using latest
OpenSBI can leverage
this patch for a better TLB utilization.
However, legacy previous boot stages(BBL) do not reserve this area via
DT which may
result in an unexpected crash. I am not sure how many developers still
use BBL though.

Few general suggestions to tackle this problem:
1. This mandatory requirement should be added to the booting document
so that any other
SBI implementation is also aware of it.
2. You may have to move the patch1 to a separate config so that any
users of legacy boot stages
can disable this feature.

> Alex
>
>
> >> But furthermore, at the moment, the firmware (opensbi) explicitly asks=
 the
> >> kernel not to map the region it occupies, which is on those common
> >> platforms at the very beginning of the DRAM and then it also dealigns
> >> virtual and physical addresses. I proposed a patch here:
> >>
> >> https://github.com/riscv/opensbi/pull/167
> >>
> >> that removes this 'constraint' but *not* all the time as it offers som=
e
> >> kind of protection in case PMP is not available. So sometimes, we may
> >> have a part of the memory below the kernel that is removed creating a
> >> misalignment between virtual and physical addresses. So for performanc=
e
> >> reasons, we must at least make sure that PMD entries can be used: that
> >> is guaranteed by patch 1 too.
> >>
> >> Finally the second patch simply improves best_map_size so that wheneve=
r
> >> possible, PUD/PGDIR entries are used.
> >>
> >> Below is the kernel page table without this patch on a 6G platform:
> >>
> >> ---[ Linear mapping ]---
> >> 0xffffc00000000000-0xffffc00176e00000    0x0000000080200000 5998M PMD =
    D A . . . W R V
> >>
> >> And with this patchset + opensbi patch:
> >>
> >> ---[ Linear mapping ]---
> >> 0xffffc00000000000-0xffffc00140000000 0x0000000080000000         5G PU=
D     D A . . . W R V
> >> 0xffffc00140000000-0xffffc00177000000    0x00000001c0000000 880M PMD  =
   D A . . . W R V
> >>
> >> Alexandre Ghiti (2):
> >>    riscv: Get memory below load_pa while ensuring linear mapping is PM=
D
> >>      aligned
> >>    riscv: Use PUD/PGDIR entries for linear mapping when possible
> >>
> >>   arch/riscv/include/asm/page.h |  8 ++++
> >>   arch/riscv/mm/init.c          | 69 +++++++++++++++++++++++++++++----=
--
> >>   2 files changed, 65 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
> >>
> >



--=20
Regards,
Atish
