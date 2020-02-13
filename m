Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FBC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2448206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pOLKBGFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgBMVkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:40:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46426 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgBMVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:40:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so7083522otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTv9gN6I6yzih5qKCBcYKwo2e18uwbHe8iXC38+9hd0=;
        b=pOLKBGFdDmsjxxfsFb1e7iJQtMQ7g+GGM3cpiCIvN06JvANWBupzho8YYBSAAbeKaY
         Zla3c948sXHK4kc/W0U68fIEojXwyz/BhRmi0DHOh7I/TrksghWSyuAfEqqILp7fTJkc
         aiisRybHg46rfa447mtqBqwCp6mBjdbMwcSXEw1oe8ki4SBgbMPUyDMlyVlImCGC+Q1W
         cnDG83FfPU5WEldM8Od9jZauR50FdGvRpB6FFFutJtRLguIojSNyJ5mzr1o7nQ2AYNbX
         tLz7cet7HxsV1Fj7UFt8lZOYf4ibR9GrjIXtTipstk+tMM13uqbl3qugjZvJi1TE/Dn1
         42Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTv9gN6I6yzih5qKCBcYKwo2e18uwbHe8iXC38+9hd0=;
        b=IKFWdcopYiOa88fAtOrkc7gzEct3DatmhWhCQzY2otj+XW4fFKgK8yQtd/+I1OK/PS
         NO6St40as6BNtCT72b3BwR8FI0JzN9hvWypzf0BbSFSHsK/cgjCilLQGXxAQessZK4N3
         9TfF+UPo3cX/6I8L3j1MQZHj0mx7Kjo8YGiOutQnbKrdGkyIOHuDFIBUbBIZOcdYhlXD
         JSXWVzjiGrMUIRDlVD8VtTKCvsZ9Qrmp35Kv02W29s2dPn/Bin1me2z2aDHtUUzmfOSj
         mjKX7LxzLLHPMilBuZsz+y/x2GYAlf7GNjCk2pRaaw6FLcT209t0Ik7AxNgeCrj+fEa8
         U8vg==
X-Gm-Message-State: APjAAAWRLkqbwU1yrDf96dxQOJef7+sQd3lBbVQPUMBG2AG0PI1A8eQE
        AxTUH2hXmh8j83ukws+r6faTo8D1klm+sNHdDMuLiw==
X-Google-Smtp-Source: APXvYqw5aEfUpyFTQZazSkVeOJDzHTwzm+wOG5KP2AGcBjkKirUZiP9tAackQuvwRLWXumQcnRB+P+mYdWGMw5tsiJg=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr8569240oti.207.1581630022932;
 Thu, 13 Feb 2020 13:40:22 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
 <874kvu3egp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kvu3egp.fsf@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 13:40:12 -0800
Message-ID: <CAPcyv4gDnbTss7cAph4vyiO2R5cJeACOReTgzafoT6iHxsR6Ew@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup facility
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > +/**
> > + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> > + * @dst: numa_meminfo to move block to
> > + * @idx: Index of memblk to remove
> > + * @src: numa_meminfo to remove memblk from
> > + *
> > + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> > + * @dst->nr_blks, then remove it from @src.
>
> This is not correct. It's suggesting that these operations are only
> happening when @dst is non-NULL. Remove is unconditional though.
>
> Also this is called with &numa_reserved_meminfo as @dst argument, which is:
>
> > +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
>
> So how would @dst ever be NULL?

Ugh, something I should have caught. An earlier version of this patch
optionally defined numa_reserved_meminfo [1], but I later switched to
the current / cleaner __initdata_or_meminfo scheme. Will clean this
up.

[1]: https://lore.kernel.org/linux-mm/157309907296.1582359.7986676987778026949.stgit@dwillia2-desk3.amr.corp.intel.com/
