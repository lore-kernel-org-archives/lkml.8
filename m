Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885512067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGUgZrA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgAaOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:42:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39418 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgAaOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:42:43 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so4881065ywc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U30xAUhq9GlK3veoTCP1Aa46ad7I+mdTGkPtxq4XRnk=;
        b=GGUgZrA4CFAgGuGv42tlyLlpH9IVKcQwtU7RjJl1VclBDO6ElU65zqp/hIUpKJaIhD
         dFXD8WdLYIh42rN2FhkHIovIP/OWMEanVnYmJNNWIfiWDTeBa8AXbSDel1Wf4GhmvCE2
         LcCD2WNF9vW2rhjUTO7xZpLuvoDZo2oVJkez/Mvsj3hmTb8DFPbfXcGzzCX1aHgYV30g
         GJ+lfYiKlckfJLKJSH5icsrzbscCy39iY5OMgWKCsHr98kHVdwnL6DtEPYmIXK50euox
         ABAjrK8hUjSrmt/d3fZ36F2vnLLtQi97JvThAppnSoJZI1Q6RxZljDCqpgoNTBTzjSkS
         FxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U30xAUhq9GlK3veoTCP1Aa46ad7I+mdTGkPtxq4XRnk=;
        b=ROymyLZI0IerXIxxCBWeFBA5jX4fcBsgUK246DFhs4MPcJJGTtRhGcjoFGrTdAnJwb
         Vh2Kycljo3JqQ6MMwKmkCjaEDTi4qNZ69sGXWht/WKPeKShJqWtqjxnCw/d7Q5RePa4S
         Bhiq4GilebqteS2wl32TBFmmCVmioKnYLcaj/XBThJ9k5J6vAQeO5dk0kmNRowqHmBrb
         3h2Hpu7NPZ4QsyK/jDLJLiE39bZR/8v9gaExmIYdvCIJUPjkKaP2Q9qst0TqzliDHbfd
         /pVKcMwY+M1Od8zalsyW+MUtCGZah2BE8Bxj1QiK7KBhouTXdtH9r4+nfnaF+MYv1PBK
         2wlg==
X-Gm-Message-State: APjAAAXhNj5cuEz3B1/X2jjORQOAD58/XLN+O1fD/SeI9fEBiIbOoseP
        pizFtHYSGyJkN5j1M4xGCEgQh/si3cuisGQimi1HKw==
X-Google-Smtp-Source: APXvYqwVjlTzsTOkRDlxl6dsFym7bSPIOlDXZpEuWzoJQFEezSQLJssyXCbviCKGqUM+Fsi1PaYEN726epNCjfGBPmI=
X-Received: by 2002:a81:7cd7:: with SMTP id x206mr7960111ywc.466.1580481760596;
 Fri, 31 Jan 2020 06:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20200130191049.190569-1-edumazet@google.com> <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com> <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
In-Reply-To: <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 06:42:28 -0800
Message-ID: <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 4:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> ...and when that represents ~5% of the total system RAM it is a *lot*
> less reasonable than even 12KB. As I said, it's great to make a debug
> option more efficient such that what it observes is more representative
> of the non-debug behaviour, but it mustn't come at the cost of making
> the entire option unworkable for other users.
>

Then I suggest you send a patch to reduce PREALLOC_DMA_DEBUG_ENTRIES
because having 65536 preallocated entries consume 4 MB of memory.

Actually this whole attempt to re-implement slab allocations in this
file is suspect.

Do not get me wrong, but if you really want to run linux on a 16MB host,
I guess you need to add CONFIG_BASE_SMALL all over the places,
not only in this kernel/dma/debug.c file.
