Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C003EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEE221D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wg8Mr9U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbgFRC3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgFRC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:29:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A71C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:29:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 97so3354732otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIAbtmytWe4P0OjbpKgv5Ryn3X/VFHTsnPvYshe2qyk=;
        b=Wg8Mr9U92fXHjjgnQ/HWv2MSYJV2hSDYM+VyVpA2AMG0EsZcBN1bdFwNfjKNqodVbv
         kNDjVOAWSQ0NKnAc20FYVKiJZL6v6jDJJUvFq3C3faAk5bKYuypR+Z3YUAfDacTOidpw
         WniKCkYahRbocMs47i4i25oGg3it2IBHQnSd2MyJndgpOKJw0iu4sEungNZ/wqFlN7y3
         CzXlSo6jFNSp/+/zqO4SR6Q/1bO0PsQ+/bAntiRmnhgtt0nXbSIK5jfsWwtxNiW4ObWy
         IwBatQVHAi+vh74ftWl8K6CnesDY9uLqfpg6SPq5tg8BX+4YutfcabW2Up+ozDPah6BX
         7IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIAbtmytWe4P0OjbpKgv5Ryn3X/VFHTsnPvYshe2qyk=;
        b=c0DzPTGTgx///ohuCvtpyhV9/Hz3REkwtrBiWJPAn0CWXPs3VOeprPkc2XctiBEv6e
         w/xy8yuODe/grABXkt79ernmbRNcRZS5srPNxXFv++XBoxQKRfvS3zDzcmb4HNzaxkH3
         QIHF5+mkNghMFI0t2zML/eKUa4MyL0ZzTyVq3R6HMui4GUXnMaYieJyZn+ZkWy0e1HUp
         KjPLv2dTnHa9jAL+oGp8A0uk39jPK4OdFnwS/2P/IKcVZFGPrEhf/THHrOBEj7sKp7ao
         zEIfA2iODhBPZaQwXKE/WelLBzHwjYe6v2y5oqnBqd07BzjCpPTaAzVYbnolVv5rZJ15
         ybbw==
X-Gm-Message-State: AOAM531AtCWo/HR5GtfoqlFNTpBVPg6mSWLr6MEOuZG/LJAN03gIFwmV
        L0tXidHdKRGFcuLWPEKsTWTxAawH7DAyP7DSiO7L7A==
X-Google-Smtp-Source: ABdhPJxDU1T28hAUkIcsmtrPI61nqUdQj6WFuskWwrVZFHaavRqvF0p9NTr7W4KrYrc7/rh6ZC8XiccaiFa2hgoVZBA=
X-Received: by 2002:a05:6830:1e59:: with SMTP id e25mr1768564otj.127.1592447355825;
 Wed, 17 Jun 2020 19:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200617203732.2076611-1-atish.patra@wdc.com> <CANN689EXQsH3C92fe=QHVEZasWmBiMXPoOB=bRLhK2CP-hdKqQ@mail.gmail.com>
In-Reply-To: <CANN689EXQsH3C92fe=QHVEZasWmBiMXPoOB=bRLhK2CP-hdKqQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 18 Jun 2020 10:29:04 +0800
Message-ID: <CANXhq0qtxyx0+4+dVy3c3R2v5DSWaJsFwc7BcwSRGcufoL6eHA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Acquire mmap lock before invoking walk_page_range
To:     Michel Lespinasse <walken@google.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 8:01 AM Michel Lespinasse <walken@google.com> wrote:
>
> On Wed, Jun 17, 2020 at 1:38 PM Atish Patra <atish.patra@wdc.com> wrote:
> > As per walk_page_range documentation, mmap lock should be acquired by the
> > caller before invoking walk_page_range. mmap_assert_locked gets triggered
> > without that. The details can be found here.
> >
> > http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html
> >
> > Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> Thanks for the fix.
>
> Reviewed-by: Michel Lespinasse <walken@google.com>

It also looks good to me. Thanks for the fix.

Reviewed-by: Zong Li <zong.li@sifive.com>
