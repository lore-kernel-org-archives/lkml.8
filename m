Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E79C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343D52073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoU875qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgDBXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:23:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43491 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDBXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:23:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id a5so4996431qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8k/QwTw4qQdBRVrKpDUgP0f41wvfICsPC6bQdhcbWo=;
        b=QoU875qhDMl9qp0w3pLF62oq653U/4KhAb0KfGbYQ3KdGHHY1iO8uOpyzg8dSlTo+c
         9Z6wwvkoh+s9Yhesije1YntqBwO9WgubgycfwRaJ+LMlEKtI8YAb+562E9xCOddPANiX
         7LRjXkiMekGtUtcoaxvBmiPhADc+RcfvHF0/exU3KNQT6q6zvunq3ZCLHfuych7Hp2nT
         XAKqmRLamtJPmMRAOcnhOn5h/sJ7kOHhytJKx+V92Ln69jlxoU+vn56zWUdn5Hfy80lg
         sPLdty2NFPJ1zvMa6Gt/nxw5Jr4HoGCD1LnhEM3WoNLv70pq8I/kdtOQhiWoTf0KOLBG
         lLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8k/QwTw4qQdBRVrKpDUgP0f41wvfICsPC6bQdhcbWo=;
        b=OwG2qqmroJwzjo/GR80hhH0i0NFOPFGVNXg7T8X4e9eUtIaaVw1zr1R3QRDhihZKZW
         QDzRFWz4RkqATkciFE/o7skjX0zCk89vhgSouvEB7l0gLXYnO8Y0yOD+1WgbwPB2/vWb
         L6PnLCxx7gHli8XozdsJlGGFJaNUjU8HGRojNpwWuoa5zJga6SCv9fyvBezb3c5HoNYn
         tmN4AOr/3TuMPw4Fn7xttkOwLcqbNdknoSX3Kpq0ifr4HydM1NxietXGrr9pAy8q9jPY
         /UQ/06D1n0O87zny0uCQEydgTe1MXlOFueYyarzKqSzRUln6Q35XUjyCFSWnIargQs4i
         edAQ==
X-Gm-Message-State: AGi0PuZphmaNvNAO4Ro/CzFipHGXsQCAyYfp/SxKRvQ/4Pml1Nexfqgg
        2uoPqUHuwr+Jwlcbd9L44Ck3LC4u
X-Google-Smtp-Source: APiQypJaGjaj1VYkgkqwz9TEAfrlhCai6Us3wC+ExP12xikmN0Duq6g/x0PfXO0ytTRdILZrpGyItg==
X-Received: by 2002:ac8:16e7:: with SMTP id y36mr5609518qtk.225.1585869834473;
        Thu, 02 Apr 2020 16:23:54 -0700 (PDT)
Received: from smtp.gmail.com (179-193-220-245.user3g.veloxzone.com.br. [179.193.220.245])
        by smtp.gmail.com with ESMTPSA id g6sm5187961qtc.31.2020.04.02.16.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 16:23:54 -0700 (PDT)
Date:   Thu, 2 Apr 2020 20:23:50 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [RFC] genirq: prevent allocated_irqs from being smaller than
 NR_IRQS
Message-ID: <20200402232350.GA1644@smtp.gmail.com>
References: <20200402150820.GB5886@smtp.gmail.com>
 <87k12xn1d7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k12xn1d7.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Thomas Gleixner wrote:
> Marcelo,
> 
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> writes:
> > #ifdef CONFIG_SPARSE_IRQ
> > # define IRQ_BITMAP_BITS (NR_IRQS + 8196)
> > #else
> > # define IRQ_BITMAP_BITS NR_IRQS
> > #endif
> >
> > The thing I'm troubled about is that BITS_TO_LONGS divides
> > IRQ_BITMAP_BITS by sizeof(long) * 8, which makes it possible for the
> > size of allocated_irqs to be smaller than NR_IRQS.
> 
> No. It calculates the number of longs which are required to store
> IRQ_BITMAP_BITS bits. And it does not only divide, it also takes the
> reminder into account.
> 
> One byte fits 8 bits. Multiplied with sizeof(long) tells you how many
> bits fit into a long: Unsurprisingly that 32 on 32bit and 64 on 64bit
> systems.

I see. Given that a single bit is enough to mark whether interrupts were
allocated for an IRQ line, the allocated_irqs needs only IRQ_BITMAP_BITS
bits to track how many IRQs have been allocated.

Since BITS_TO_LONGS will calculate the number of longs required to store
at least IRQ_BITMAP_BIT bits, the bitmap will have enough room for the
tracking bits.

Naturally, the number of longs needed to store N bits will depend on the
sizeof(long) in each system. Probably this is why BITS_PER_TYPE(long) is
taken into account to find out how many longs are needed to house
IRQ_BITMAP_BIT bits. Therefore, the initialization of allocated_irqs
shall generalize well for systems with different word sizes. A clever
implementation.

> 
> > By the way, is there any mailing list for IRQ related discussions?
> > I couldn't find one at vger.kernel.org.
> 
> The MAINTAINERS file tells you:
> 
> IRQ SUBSYSTEM
> L:      linux-kernel@vger.kernel.org
> 
> So you picked the right one.
> 
> Thanks,
> 
>         tglx

Thanks,

Marcelo
