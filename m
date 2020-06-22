Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B74C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06412073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkWyxttt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgFVSmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:42:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A2C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:42:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so20502754ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aX2e0KRVgCu7iM/YzQ9kW8CY4++NvSyG3ZKNDs8dBA=;
        b=PkWyxtttxziJ7sl0J3cRRVqapHbtXt4kdu65zklL3qMNyj/kjW1Ul758pFfOfq7bc6
         vIq4C4PwC6Rlt93ZeCqqhOxf9pF6Rgwm3KfctMtfhrPhEunuiOYxoQIodSkAGBAjfR8q
         xzyUIeOenWufKMgp6iggI7PqKYqK1589MvKHc4dpa40qgOEfP0EvG9bdKk8YWo8Ob6He
         FsMNnr04wAZwfZLSOPoNm3SjxtkYkPzfpdrxz13T+dinoILo/fLnB+dQRAE64Un2byUt
         pHgq7o/3EyZRFF07xl3YG6cAcHeypZ4n5d37OtAYejFZr3KkIzRPD3Jv4UyRTNA6Yf3C
         P43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aX2e0KRVgCu7iM/YzQ9kW8CY4++NvSyG3ZKNDs8dBA=;
        b=qQgDhjXitktf4ijwWRK+5pqxXKQ9b4X0ZBxRkoKB5xnzNTkj9lsDkP3MaUkB4I9ppP
         8nSsU3TVLavQFPq12+RZwR3ztmAW9QrQ5qEZNVdbMts+HYpFdyLDHvBLqQnB0GaHoL5u
         Jnar8oWflwuh1UcIkcWXbUxuQSVFrszDDpHj9cPQmQPpXCKnfWtb+3Auf6nElkAp2Oje
         jKGkHAiR+bbIbb/0bbhlUfBUKFPGBL0Bzp/hCG/g2yIKCT0F6L0IPpt8K+ao6EstRw32
         ZthDMcwRdhk8tg9PMDDztzD8B7Z1pA+ESqVAIKVgLleW5NacN+/7ly91d6EKSRG+9EYz
         HZIQ==
X-Gm-Message-State: AOAM533RO3JLKB1+Vm3JHMLG2NhyHlfotw6D8LlBDKikI/hfuRf/bSyF
        Z87REGS7DK+o33CitlMNJoQNeirjVf2pTAjpY7Rm7Q==
X-Google-Smtp-Source: ABdhPJwRCFcJmK2mEPD2AfdCfvBCKYaTqaRO4KPnzwM344nnPLVu6HlrS309q7QQ41IdOgsCzHLKXZ2bpzLAvYJB3zg=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr9389585ljh.77.1592851336994;
 Mon, 22 Jun 2020 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-15-guro@fb.com>
In-Reply-To: <20200608230654.828134-15-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 11:42:05 -0700
Message-ID: <CALvZod6Y5sfLQSpZov8TXx9Ybndq_vuNproG-2vM8trztFzk8A@mail.gmail.com>
Subject: Re: [PATCH v6 14/19] mm: memcg/slab: remove memcg_kmem_get_cache()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> The memcg_kmem_get_cache() function became really trivial,
> so let's just inline it into the single call point:
> memcg_slab_pre_alloc_hook().
>
> It will make the code less bulky and can also help the compiler
> to generate a better code.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
