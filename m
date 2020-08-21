Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE215207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLVWWjpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgHUQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHUQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:30:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F698C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:30:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j15so1202309lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAH7ibPtLUGHLgcgcRzPKVl9zfbTpcY+nZCs+tE1DXQ=;
        b=fLVWWjpFR/WJTNqtQxTkV/hZGhHLV3nkUFUVQsbouXfBQqoZPlM46XTSIQHJ1UzmoQ
         r85FEGnbcYL0mmeXoZ/zAKKyKQo9Shfz4Q0SHa6+J7tcigLBGCZZGnePAbOnEUR3f3C8
         iFCi574147qFY14i66t3Mfgc1pOmjJqr/+lKoDaLZ2u8Jwm0JNqri9rivqcneitSe6kF
         x3ZObTV5enH329D39sd2GQmaB4IOpeXJUzSOSilIDZCaBcuchI1qb7HWBqwvlSzT6NBg
         eAXDjFY8Y5Sk2t/CwUy4TiS0nVU/dwMwRWqtKKnl7zVqEhQhe1HU2XAaNMDNeJSeqJjG
         ntFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAH7ibPtLUGHLgcgcRzPKVl9zfbTpcY+nZCs+tE1DXQ=;
        b=dTB8zSNIRRxaAZ8UYopAbRpXFaZBT6FOgivIF7UPsNobIdybJqxhxj0+VzFSM67Ncg
         kqFNbg3PNyF9mP1AB3BLkCS3svJ3EQ3sXQL9tcoHjGAJ3rTrHXK63QvZVwmwWv6UKR3e
         0c8Eug1Wy3mOh6To2OnE4IrnZQPkPHwTbCNcJ2okwC7AGgX9OtqQQ4AawEBLllUcEpZ9
         FjPGahqYJj2ZYBV0vnT3XodlD/TZ9/TFleeDIU3AHSYAiA3o2WNEiHe6L3rpfMHpMExq
         uS3Y43+kdC2GbEDl9qxI8cpBg+1FPqNnLtfYeJ4EVJZQKIGvx8mDTNAAM2DxLANaAYEe
         jZag==
X-Gm-Message-State: AOAM5321tUZch7ricNoehX2fq0f+op3qvZT+XSFDTNzZhO7DcZWMDMbP
        ofMafR19o9/hRpLH3qCpwnNKJTXd+2u5qpVh1bjQ1A==
X-Google-Smtp-Source: ABdhPJzYZYfgiTKQBUgvG4C88m6hlJq6g86K/IInaK/YVQrHcxL/vh0WRwMJ1TYegOTt9ep2KYX5shcv+jP3Gbwg5eo=
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr1830261lfo.124.1598027404830;
 Fri, 21 Aug 2020 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-2-guro@fb.com>
In-Reply-To: <20200821150134.2581465-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Aug 2020 09:29:53 -0700
Message-ID: <CALvZod4ou=jrGru6gp658zbkS+G-_eYNA44CwxNk4=Bs1pXxLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/30] mm: support nesting memalloc_use_memcg()
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:01 AM Roman Gushchin <guro@fb.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> Support nesting of memalloc_use_memcg() to be able to use
> from an interrupt context.
>
> Make memalloc_use_memcg() return the old memcg and convert existing
> users to a stacking model. Delete the unused memalloc_unuse_memcg().
>
> Roman: I've rephrased the original commit log, because it was
> focused on the accounting problem related to loop devices. I made
> it less specific, so it can work for bpf too. Also rebased to the
> current state of the mm tree.
>
> The original patch can be found here:
> https://lkml.org/lkml/2020/5/28/806
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
