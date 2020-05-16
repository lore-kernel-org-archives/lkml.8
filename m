Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D64207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P54OzxSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgEPX7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEPX7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:59:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ACBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:59:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so6027906ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDEHZY/PsMR8qXioVOkwgQjNCpyRlOPlYpF92vL83Bo=;
        b=P54OzxSpbB00QNa1Vl9WFApqmqJ/4B0rUpbBMDMmPsI/C8A9uvrD4Ks0sH03/n/Ea8
         TthdS9fKbtNSBKevVXQXJ0hQwN1Cr21r0DS9ympS50RYBG6qN73K0ac9Z2luaU+W0UJb
         Ib5zltG1UqMylh0kpknA01DYSc+lcNyz7Vo8L7ukwpSfgXHUT/ABT/xtEvzvHa6ZPO7f
         hVftgDHyQS+Qwumq/NzRXEypHe6LQAniqULJKgLzOb5VrJTE7ftIzqSwCXiVzZWL99Zg
         ckBhnhbDgCDabIapMZtrwe2jd11elo2NxMB1KnXMCzE2KXPlETdMkQs44AO7W4+LaHzv
         y5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDEHZY/PsMR8qXioVOkwgQjNCpyRlOPlYpF92vL83Bo=;
        b=uB1RLB9IwQxCU7q4mpZkbM+mYPVUNaArQcbu1cNEm9hyPRXauYyAyeT0XTG1Ct0/lE
         jtjleLKiWmu9fT77BgRhBF0KGeytq0Ad00dxUuuJK0DTYOpn3LZ7kdEj1dae53u1ywWP
         FCcMcUY/kxDednF5dh8y5joLTfrTT2gyAvswwMo7dJjEzqYz9f+mFVoRZZLwBwN67mig
         wNCMZuUov9o2owNxyGE5RqjJMbaFprIrue95ptnwU7oLhdZpgp6CJK5X0lGTPxEngURN
         DJI0zBFRirjz1pgRlArgS/hn5toKeJeQ7TQUxq180qe194ZTVKN2t0KYXmit2RRaUhKQ
         fRGg==
X-Gm-Message-State: AOAM531i4AATEDvd6OQU+qcb/Luuz4gdrZ/wrFAubky0XaSTTXBx76sa
        nhwIylbIzpBS3n3XArbs7WRBXEIgSftRpQlUY8DHSg==
X-Google-Smtp-Source: ABdhPJw0ZfYrSkQBOU7HtlJ+qMtghoYxNb4Yi76ISuBNl6ETii85WUeEH5eTH7QX7VYFW8gzbaKKijv4ok8EvnEZF+c=
X-Received: by 2002:a2e:9d5:: with SMTP id 204mr5185058ljj.168.1589673572976;
 Sat, 16 May 2020 16:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200516021736.226222-1-shakeelb@google.com> <20200516.134018.1760282800329273820.davem@davemloft.net>
 <CALvZod7euq10j6k9Z_dej4BvGXDjqbND05oM-u6tQrLjosX31A@mail.gmail.com> <20200516.163927.1112911965183377217.davem@davemloft.net>
In-Reply-To: <20200516.163927.1112911965183377217.davem@davemloft.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 16 May 2020 16:59:21 -0700
Message-ID: <CALvZod4cqCNHVLVMsoHKtQxWdY3YUqJBuqwFwE8MLeVh-jbdUw@mail.gmail.com>
Subject: Re: [PATCH] net/packet: simply allocations in alloc_one_pg_vec_page
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 4:39 PM David Miller <davem@davemloft.net> wrote:
>
> From: Shakeel Butt <shakeelb@google.com>
> Date: Sat, 16 May 2020 15:35:46 -0700
>
> > So, my argument is if non-zero order vzalloc has failed (allocations
> > internal to vzalloc, including virtual mapping allocation and page
> > table allocations, are order 0 and use GFP_KERNEL i.e. triggering
> > reclaim and oom-killer) then the next non-zero order page allocation
> > has very low chance of succeeding.
>
> Also not true.
>
> Page table allocation strategies and limits vary by architecture, they
> may even need virtual mappings themselves.  So they can fail in situations
> where a non-zero GFP_KERNEL page allocator allocation would succeed.

Thanks for the explanation. Do you think calling vzalloc only for
non-zero order here has any value?
