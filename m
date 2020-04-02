Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C8BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFD020757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="on3MeeRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgDBRZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:25:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45410 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:25:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id o18so2026222qko.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6WBUfQ/+fIDsHhEOpEGrPSe1wUkAcmhPnGh7PNBMqZ8=;
        b=on3MeeRBhIDQJd/lSuhVMxACzWiXfKKQMAM6+lmyOwhg/wOrDShohL/5MhJduAAf/i
         pZ+Ksw1Zqgqnn9cMugsZVhB0GUEsYZiyV16qdkwxpABuIQLVfzT/wW5bPNhEK37WOcvU
         fnwKQ61nKKCmOVsOiYVXRoVmErJ2QI55vHw+AgMxEvKbGVlu7vKneAy9nmjTe3ZGVdOy
         EOl72Kfy8i7Qd1hL2Z8EWXS+vorQrD7BfHmtYTQ8XOLAh1nwsD/Y+KCbYJp/3tBOQcP1
         ulyEa1E4OwXN4YasvaOUhold/pvhIP6cYpt0HAJCQ5I/rNe+k9+sJRe2NEtZNQn3jycf
         emWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WBUfQ/+fIDsHhEOpEGrPSe1wUkAcmhPnGh7PNBMqZ8=;
        b=pNGXi/oTvch5VLH5kH9eXclIeBh7mct23qKAWDkeitt73J6M3UyAh1lkcxG6VRWl6I
         5DEYPRvbyDUnDVP0B2ETq0uzhhKNC0FrStyivvz5PdUS29ZoLA1rW/8+vnELi+PmsSoN
         XYxig54cYWPpRKTp2v7TxGQguEoR9ToLu50FDlx37C2YbjAeUFnowr1tFIm0zBJ/iWj9
         c49jrA2qFtVoM10wDbQq2EOPWTjULEnjhZWU0Xmw9jh32zi7v/lSeBJh2DhpQ7H8y29O
         VESrs0ZD6aEJ4YALEsSbwpLczp+ssN/4tQ2v8xTty8+PjCTJXylSB0LnBNzM7ASneoku
         pulQ==
X-Gm-Message-State: AGi0PuakZT4yMI50IQpS01sGCdGZBG0LBUSuTG5+aXYRWJXR5rV35OrF
        FvICdYZ/DywO//SYzQ5UTbQ=
X-Google-Smtp-Source: APiQypJyqVBwEyz5ZpPSJoB7TsgMB2KmVdfjh9o+es+bpJO6E/HvYk9OKPlbkaTzgPZOxuHBtMii+Q==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr4180762qkh.181.1585848313784;
        Thu, 02 Apr 2020 10:25:13 -0700 (PDT)
Received: from smtp.gmail.com (179-193-254-9.user3g.veloxzone.com.br. [179.193.254.9])
        by smtp.gmail.com with ESMTPSA id u15sm4224971qte.91.2020.04.02.10.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:25:13 -0700 (PDT)
Date:   Thu, 2 Apr 2020 14:25:10 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC] genirq: prevent allocated_irqs from being smaller than
 NR_IRQS
Message-ID: <20200402172510.GA8242@smtp.gmail.com>
References: <20200402150820.GB5886@smtp.gmail.com>
 <66fabdd6-7815-1ede-9a45-45fdb2b6d5b2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fabdd6-7815-1ede-9a45-45fdb2b6d5b2@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Lars-Peter Clausen wrote:
> On 4/2/20 5:08 PM, Marcelo Schmitt wrote:
> > Hi,
> > 
> > I was trying to understand IRQ initialization when suddenly got
> > intrigued about the declaration of the "allocated_irqs" bitmap at
> > kernel/irq/irqdesc.c. The size of allocated_irqs is defined by
> > IRQ_BITMAP_BITS, which in turn is passed to BITS_TO_LONGS to calculate
> > the actual number of IRQs the system may have. If I got it right, there
> > should be one entry at allocated_irqs for each possible IRQ line. At
> > kernel/irq/internals.h, IRQ_BITMAP_BITS is defined to be NR_IRQS (or
> > NR_IRQS plus a high constant in the case of sparse IRQs), which most
> > architectures seem to define as being the actual number of IRQs a board
> > has.
> > 
> > #ifdef CONFIG_SPARSE_IRQ
> > # define IRQ_BITMAP_BITS (NR_IRQS + 8196)
> > #else
> > # define IRQ_BITMAP_BITS NR_IRQS
> > #endif
> > 
> > The thing I'm troubled about is that BITS_TO_LONGS divides
> > IRQ_BITMAP_BITS by sizeof(long) * 8, which makes it possible for the
> > size of allocated_irqs to be smaller than NR_IRQS.
> > 
> > For instance, if !CONFIG_SPARSE_IRQ, sizeof(long) == 8, and NR_IRQS is
> > defined as 16, then IRQ_BITMAP_BITS would be equal to
> > (16 + 64 - 1)/64 = 1. Even if CONFIG_SPARSE_IRQ is defined, a device
> > with a large number of IRQ lines would end up with a small bitmap for
> > allocated_irqs.
> > 
> > I thought NR_IRQS would be multiplied by the number of bits it uses.
> > Something like:
> > 
> > #ifdef CONFIG_SPARSE_IRQ
> > # define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long) + 8196)
> > #else
> > # define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long))
> > #endif
> > 
> > Anyhow, IRQ_BITMAP_BITS is also used to limit the maximum number of IRQs
> > at irqdesc.c. If my understanding of nr_irqs is correct, it would make
> > sense to change some sanity checks at early_irq_init() too.
> > 
> > Does anyone mind giving me some advice on how allocated_irqs is
> > initialized with a suitable size to support the number of interrupt
> > lines a board may have?
> 
> Maybe I'm missing something, but allocated_irqs is a bitmap. This means each
> bit corresponds to one IRQ. if sizeof(long) is 8 and allocated_irqs is sized
> to be one long that means it is large enough for 64 IRQs.

Probably that's what I was missing about the allocated_irqs use.
This explains a lot.

Many thanks,

Marcelo

> 
> - Lars
> 
