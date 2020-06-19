Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494920773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="TnyG/qjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgFSBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFSBeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:34:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A4C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:34:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g21so3144508wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnyBIrnucXjD5JasGEDGQEAckoj03t5PdbNPiajQJmM=;
        b=TnyG/qjo0RAHRQjUcx6Gty6PDkFh59iqCgsaAgn/9KAcWhyHVEV+EQfqif2tN1tFsi
         le4LCUxAD0eC8bOVQvHEflfKUFqAoba7Ma/G02zOfpIkr6sSEQXQcw/rj5LXUZOdAXdB
         qMbOTwa52sVtmHzNdXJtWZlkz/HFY2/aYEnsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnyBIrnucXjD5JasGEDGQEAckoj03t5PdbNPiajQJmM=;
        b=LZKH3zQNJiF8O466h7X/9x+zUf61Bda1V7z+Z3VJnD8xbUcBmiHvVH6NC2QhBN0QKp
         ebWLuwBY8BTEwxV4iNkz1D75l4D9UzSU+B9c3HfxVqybRHVpe7liQSjOpMbm8aZNbjf9
         hveSNWKS+5GpTxBX2S8hjfoZOIkLZZ4RvyXtv6OOmTRVPlC2DjLuFTqSTNe7VTicKpMa
         u6YJiAnXuC95TDErB6TL5WfjfgvxyhyGJLKEkH6A2386UGYRNTQmffxBbo0GdVPkT61R
         k6mq5xn2vio1r3B6cn0l1J9O0YEgdlXh9XHkVrmr6XPp9vT1cGU1Fr8mG1yzgAxdDyU2
         f86Q==
X-Gm-Message-State: AOAM531AbUZSD6gwCKpEwedNxuQ+bZU2xKEkQboDLUVk94RjveA99wY0
        icl9TEgcJenL7Oht6+/U8puvzQF9HXxY6iGRFt+c
X-Google-Smtp-Source: ABdhPJxTPXhqtjt8u5MTrCXhwxcBgV31ivclBpQBVptXJwmVSyw8Kt7CC5gjKA2Pz49o1pAfAE/pWIPOVzBIQ84fFeg=
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr1074278wmu.55.1592530450229;
 Thu, 18 Jun 2020 18:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200617203732.2076611-1-atish.patra@wdc.com> <CANN689EXQsH3C92fe=QHVEZasWmBiMXPoOB=bRLhK2CP-hdKqQ@mail.gmail.com>
 <CANXhq0qtxyx0+4+dVy3c3R2v5DSWaJsFwc7BcwSRGcufoL6eHA@mail.gmail.com>
In-Reply-To: <CANXhq0qtxyx0+4+dVy3c3R2v5DSWaJsFwc7BcwSRGcufoL6eHA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 18 Jun 2020 18:33:59 -0700
Message-ID: <CAOnJCUJm9YBK1FtY1YuYLgsJhOYzEwmn7386msW9=HddXptMQw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Acquire mmap lock before invoking walk_page_range
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 7:29 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jun 18, 2020 at 8:01 AM Michel Lespinasse <walken@google.com> wrote:
> >
> > On Wed, Jun 17, 2020 at 1:38 PM Atish Patra <atish.patra@wdc.com> wrote:
> > > As per walk_page_range documentation, mmap lock should be acquired by the
> > > caller before invoking walk_page_range. mmap_assert_locked gets triggered
> > > without that. The details can be found here.
> > >
> > > http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html
> > >
> > > Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >
> > Thanks for the fix.
> >
> > Reviewed-by: Michel Lespinasse <walken@google.com>
>
> It also looks good to me. Thanks for the fix.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
>

Hi Palmer,
Can you include this one in rc2 PR as well ?
Anybody who gets this issue with their rootfs can't use rc1 without
turning off DEBUG_VM.

-- 
Regards,
Atish
