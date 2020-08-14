Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EAAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A42074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnr4mLvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHNIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgHNIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:30:53 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582CC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:53 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id i10so4773030ybt.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnDVAQh+31C0t6VNGwQb4SjTxgNgsH3VtTdOtKZQqwA=;
        b=dnr4mLvlqaTviMNIb+lJPY5U9aWlRKE8rBtF9/XEX9gNmzomc3qYCO99SFNJMqBShI
         ID7CBkceR981pX1/9kqesB9Bqrrq5f2cFzFhV/5G2tyTb89F0zUk7JSbKaSZOw3HbQxf
         Zhq0gHvWTQCikK3g4ur3M4TmpQw/a0u37kQEwnJw81wKmuuqaGmI6H+HbLINFx15X0H+
         hOIxcXOllEOoPSzsZ0DKha77TGNiwyDY0h2iYQVxky7dQScxW7AX4U4wH+U/RcYsDB4c
         4QTpivy51hJ8Xe0EnMzKIsjUXatzwM8w9PRIj3RFXCY7hXh0uWmamBOgCcOWMtRYHo/u
         l8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnDVAQh+31C0t6VNGwQb4SjTxgNgsH3VtTdOtKZQqwA=;
        b=WKShxSK8L+04skPrRcAkvsHTi2TbqeMTMN+Sklg64NdnZIJQRT1j99UzXgeqXFNFqC
         lrcQvBiYfswkcbMEtwwHVSXy3ARBK9MHsjVuCrTB5Sr6mfAPOgJC0oXiQXC8Wp/wgg8k
         L+hSDrVRehQDwfJhrtXwRcUzMwKlk4hS+VapZZV8JyrkkBICSHZtSP2fd7gtcCu2f8Jr
         iX3oxT8WaD/2niu85dnCWYGk6UnrLv5luzyxsuUrQkZr7dqKVeZexrg4l6QFJlydSlmp
         RsIw8w2ElnjADTBbDYKnw3N++uiIlO3HYGdPr+L/VoTKX633XfIOe9lrGtt4FRlUF5vx
         V/6g==
X-Gm-Message-State: AOAM5323kzexVEeyX47UAqMBEBFHlyzdxUzFtqeGUoKp+OK1tV74tNH1
        lq2NzwHAzh8/AmH7zJ68BQESR0VVpPE+qZzWmlXfhg==
X-Google-Smtp-Source: ABdhPJzFmN0idTb9mEjomYn0+86nKEa4RjZkPMilkwJ+OKxZWvgt6E6RuaAMSfAO02qLD8cIHXduF0Tu4Ob3gT084Vg=
X-Received: by 2002:a25:ab0f:: with SMTP id u15mr2246861ybi.7.1597393852250;
 Fri, 14 Aug 2020 01:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com> <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 14 Aug 2020 01:30:39 -0700
Message-ID: <CANN689FtXN-6tGkyGc9ja7rrZTTUEoW5omfEJ=PmOaft4YkaaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmap locking API: add mmap_lock_is_contended()
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:14 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
>
> Add new API to query if someone wants to acquire mmap_lock
> for write attempts.
>
> Using this instead of rwsem_is_contended makes it more tolerant
> of future changes to the lock type.
>
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>

Acked-by: Michel Lespinasse <walken@google.com>
