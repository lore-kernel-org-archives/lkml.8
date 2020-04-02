Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4012074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/HeoAn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbgDBPI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:08:28 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41558 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbgDBPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:08:26 -0400
Received: by mail-qk1-f173.google.com with SMTP id q188so4229842qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=p6v1NGSLA0PcDPkN85wWf1jk4tHTXKyx5rqTOGZFiLE=;
        b=R/HeoAn5NaaCH/VEpAXudoI+Z02atXUxMO8mJUsScxr9gNLPpS8r8gmzaU5hhQZw7f
         14X5sYr6UJoNG98KsD+1aGTtZIPJ+bpWrpdYec4n/3mnwd5NNjglF3tR/fILUBN0c54v
         /i2Q2uCTnSX7279mjkwVSfMu5LBXN6tG7huRIFVASipBXzarSitjUH4BjASQGBgFLEzW
         2c7TXW36/jMAS7dhfXHqSihUPykxrnFOuARyqAVAJ7mMjGPeG1YDYC2kLL6wI6e4EfX0
         v7X8vtocNsfx/g/kvFyYcZUjjyZRYZpW8+oMztW0pHozwZwoWHUxQr0Twer+8EmvAFM5
         m9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p6v1NGSLA0PcDPkN85wWf1jk4tHTXKyx5rqTOGZFiLE=;
        b=aAYK/VryePlej63DWmRMYjJtLgJJhy+YLKPhEcukBdBQZhCN1c/klwBc7sgeaquEQ+
         EByPvB9CnmlygaXzoWQbI5RuWRUJlpjOGCCDQvUa1b873bvBazjvQEwu7l3UvqRzOiwM
         BzVrY0FYsfzbXSpA4ajp78hTKmYGv/phHvU3ihf3hohxK0VkyRdfIr+Tquaw3MxY0tYl
         rdQ9HzCABeHoRWBwYuMnNGRP1Eqyq3OA8j/SK57ckasjjV2UXzkysSKj1dN9i0m4Ju0Y
         msc4hawvwRjvIv+GnJMfhCX7z2q8dJFu4PjesioVOVUni9tdTndUPc4P1HGkSdnmC/Nb
         OqOg==
X-Gm-Message-State: AGi0Pua/gx9ngNzNgpEw92Yjw7Abw7LZ+wc/xuAHPWSeAUahWX8p7hT0
        xi8KyotJNYrQ9jRhQGxVEp1BCwYE
X-Google-Smtp-Source: APiQypJ5N5toAyvKxJ9H4hieCcCkKc8RVnLhOCcUssEz3+xlPcr2pKlcNOspC1t9lY0+9Jz1I8Ez4w==
X-Received: by 2002:a37:2794:: with SMTP id n142mr3879101qkn.336.1585840105075;
        Thu, 02 Apr 2020 08:08:25 -0700 (PDT)
Received: from smtp.gmail.com ([2804:d43:421:8154:3432:d8a4:5c65:6674])
        by smtp.gmail.com with ESMTPSA id c19sm3711463qkk.81.2020.04.02.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:08:24 -0700 (PDT)
Date:   Thu, 2 Apr 2020 12:08:20 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, lars@metafoo.de
Subject: [RFC] genirq: prevent allocated_irqs from being smaller than NR_IRQS
Message-ID: <20200402150820.GB5886@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to understand IRQ initialization when suddenly got
intrigued about the declaration of the "allocated_irqs" bitmap at
kernel/irq/irqdesc.c. The size of allocated_irqs is defined by
IRQ_BITMAP_BITS, which in turn is passed to BITS_TO_LONGS to calculate
the actual number of IRQs the system may have. If I got it right, there
should be one entry at allocated_irqs for each possible IRQ line. At
kernel/irq/internals.h, IRQ_BITMAP_BITS is defined to be NR_IRQS (or
NR_IRQS plus a high constant in the case of sparse IRQs), which most
architectures seem to define as being the actual number of IRQs a board
has.

#ifdef CONFIG_SPARSE_IRQ
# define IRQ_BITMAP_BITS (NR_IRQS + 8196)
#else
# define IRQ_BITMAP_BITS NR_IRQS
#endif

The thing I'm troubled about is that BITS_TO_LONGS divides
IRQ_BITMAP_BITS by sizeof(long) * 8, which makes it possible for the
size of allocated_irqs to be smaller than NR_IRQS.

For instance, if !CONFIG_SPARSE_IRQ, sizeof(long) == 8, and NR_IRQS is
defined as 16, then IRQ_BITMAP_BITS would be equal to 
(16 + 64 - 1)/64 = 1. Even if CONFIG_SPARSE_IRQ is defined, a device
with a large number of IRQ lines would end up with a small bitmap for
allocated_irqs.

I thought NR_IRQS would be multiplied by the number of bits it uses.
Something like:

#ifdef CONFIG_SPARSE_IRQ
# define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long) + 8196)
#else
# define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long))
#endif

Anyhow, IRQ_BITMAP_BITS is also used to limit the maximum number of IRQs
at irqdesc.c. If my understanding of nr_irqs is correct, it would make
sense to change some sanity checks at early_irq_init() too.

Does anyone mind giving me some advice on how allocated_irqs is
initialized with a suitable size to support the number of interrupt
lines a board may have?

By the way, is there any mailing list for IRQ related discussions?
I couldn't find one at vger.kernel.org.


Thanks,

Marcelo
