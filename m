Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22761C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C162068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8KpbfQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFOXNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:13:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:13:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so4574256pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCN6TnTiCi8K0gBGCrSWRSdQxoTqdDw82hOjy8EbDD4=;
        b=Z8KpbfQz2lb+n+zm+c8pXwrgXG+ypStjQfRPk5R72bJVqDqaBh55FpRZlx8RX2b4C0
         uqZyiqoiYD8X1Sf+qCjasry8UVlhsEZ9KnLNtqCmzrBi8RA1KkK1lZ2j9I09OXpemvwI
         /U2Be+AeGmDW5+xNbU/79+/OsT5aCNXx0xQYxSFcMjqpmk8cGHiuh9QYCW341zqFe1zY
         4AXWxfOKeNF3DV4mOqErPSQIiBQXc/7QS6QwWzAZZqALF/SmaFgM/XZsIU28jRiwZaRx
         akVyy2zrWI7UHcTSbfRlD7hYOhDI+jlP5mau0PvDUb6WatsBEeyJa1BJoD71ZVF2X/6b
         wJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCN6TnTiCi8K0gBGCrSWRSdQxoTqdDw82hOjy8EbDD4=;
        b=TGxwulqQs1UUIsv2cqGmd/CDNO4DHYs+gNulH+3L9FgrAzQXyKwRsvw2tPGzjF9N8M
         xfErbsHESDwnZN0ENJu+V0tb58pOPKjcMdSzzXq1Ur+Aow6xCcnLGp+FpLaPS1YH22Tj
         aWdrvKVUkX8ujp7VeC4Zg4102FelqyEXGPofemyTinZtxjqSejEsLyoyDrQnWfk34mU5
         0Fo2NjbQEAbaIIFR5rKZk7Y/wPCFmoe3QmoiDRNLSW/UY+5o4umMwv4wWmDp4Jrrjijy
         GP574WUy8HkIMBG2Ye1qahXYSXeELaaJYkFySUl7j29vpwB8yB0VGRMj3p77G48W5g2D
         kJwg==
X-Gm-Message-State: AOAM530MYVv8ISad5nLkUYt1hQxKArhlYucjQ3qxn6R8VKha+ocWx5vc
        JCI5FxHmubKuzfI2cSgYuhYKBydRetuisw4AdQ0=
X-Google-Smtp-Source: ABdhPJzRKk2HjvNyBI7fVWuqOXrE1rxaTm/7+1ZDhLgwPpEvjVzcdKcg5b6dnnvptoOfIf2kolRLemepl1Cnyw9LRVk=
X-Received: by 2002:a63:d501:: with SMTP id c1mr8848877pgg.159.1592262796111;
 Mon, 15 Jun 2020 16:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615222328.8745-1-peterx@redhat.com>
In-Reply-To: <20200615222328.8745-1-peterx@redhat.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 15 Jun 2020 16:13:04 -0700
Message-ID: <CAMo8BfLPRF5BZV3CS5JKPo3+bDZm3ihXu4bX9b90XNMcYx+SLQ@mail.gmail.com>
Subject: Re: [PATCH 25/25] mm/xtensa: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:23 PM Peter Xu <peterx@redhat.com> wrote:
>
> Use the new mm_fault_accounting() helper for page fault accounting.
>
> Avoid doing page fault accounting multiple times if the page fault is retried.
>
> CC: Chris Zankel <chris@zankel.net>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: linux-xtensa@linux-xtensa.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/xtensa/mm/fault.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
