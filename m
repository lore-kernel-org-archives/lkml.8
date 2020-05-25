Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39884207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jy+KUYg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbgEYJ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389630AbgEYJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:56:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E080C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:56:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z80so17062169qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3OPQj+6MaWJ3brcNW2aa4WZVKniXvFNcmel059rH8E=;
        b=Jy+KUYg4h6yqEgXZCmyC1r7hZaPjIJ5NbD8kOSB7ANDSGTcv/cxI7IqondbwUcYIx4
         YDawj4yAqtGCTp0JhlLeUar5y5gF5ERMxMtMxT9kSvZxxMG4qNqP+DMsADzyMxnVKbjp
         Qp5JMPqDS0aZAK6jAL+ldHNC8V3WS0Ap82mFULselou6eQNZR6sUCTVknKoKe+7skkSe
         dQeDlVCIHtIQn2PZEtJqdGm5TlcgmE0EGSNqzldorS8mctTWozaYEL/goXdYZEUy6XHq
         b1ZewotnWXEtHoJ8G6kTfaYc7CdNtQvcQjiQnRuegORWPKpgBsNANNWjDA7f82Y4NWg5
         MWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3OPQj+6MaWJ3brcNW2aa4WZVKniXvFNcmel059rH8E=;
        b=J/mZMJwBhFkrYX+qqHth2RDIqlDUlqxaG2wh7uwFnzX9WljqbcBbGeZikr5BJEcKiO
         /Wp26boTbQNPCZCZsIZzvRFT16HCfrP1/YbJXx9P0nN1p7DsFynx3QoXopO5YNwFnLAm
         Cm/djY7Mo3wXqv4GGTL+yVOoRPearCrNFko8cZQkw443nyiMGuzanfTn57pVoPeqyVly
         AI056N6nmNsEJ1CsNqjdQMEc07vBmqRjfJ6OUL9gHSeG44FEj5QjwWoF/V0yqWrGZRtT
         7gcBFGq74oCC7XV5ebmWWycdAT52C4Dz22rXDmATPBKjkygMPOKwjvkoUj2j1bZr0sKN
         mSbQ==
X-Gm-Message-State: AOAM532+FE8gmgxnMyNMmMgR6KbdnXixt1zaWmnWy2ISlPUHj43tFOpz
        Ax+8LxrNQV4+Qd3Y/wYcg0+7YOq7SDYpqhvUTNYtXw==
X-Google-Smtp-Source: ABdhPJxqSbuF0F9MjNbi/qpdSowpX/KR1shgHH8LS5OI24MEwe9xv7ADZ1UvXqDFHd6kocEjU/m+KLakA52EHSzuhyQ=
X-Received: by 2002:a05:620a:786:: with SMTP id 6mr1210763qka.407.1590400613522;
 Mon, 25 May 2020 02:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200522020151.23405-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200522020151.23405-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 May 2020 11:56:42 +0200
Message-ID: <CACT4Y+axrVeCwdEg_yWH57jF7gcKT429J4wVwsNGPuARcPMiLg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] kasan: add tests for call_rcu stack recording
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 4:02 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Test call_rcu() call stack recording and verify whether it correctly
> is printed in KASAN report.

Reviewed-and-tested-by: Dmitry Vyukov <dvyukov@google.com>

> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  lib/test_kasan.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index e3087d90e00d..6e5fb05d42d8 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -792,6 +792,35 @@ static noinline void __init vmalloc_oob(void)
>  static void __init vmalloc_oob(void) {}
>  #endif
>
> +static struct kasan_rcu_info {
> +       int i;
> +       struct rcu_head rcu;
> +} *global_ptr;
> +
> +static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
> +{
> +       struct kasan_rcu_info *fp = container_of(rp,
> +                                               struct kasan_rcu_info, rcu);
> +
> +       kfree(fp);
> +       fp->i = 1;
> +}
> +
> +static noinline void __init kasan_rcu_uaf(void)
> +{
> +       struct kasan_rcu_info *ptr;
> +
> +       pr_info("use-after-free in kasan_rcu_reclaim\n");
> +       ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       global_ptr = rcu_dereference_protected(ptr, NULL);
> +       call_rcu(&global_ptr->rcu, kasan_rcu_reclaim);
> +}
> +
>  static int __init kmalloc_tests_init(void)
>  {
>         /*
> @@ -839,6 +868,7 @@ static int __init kmalloc_tests_init(void)
>         kasan_bitops();
>         kmalloc_double_kzfree();
>         vmalloc_oob();
> +       kasan_rcu_uaf();
>
>         kasan_restore_multi_shot(multishot);
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200522020151.23405-1-walter-zh.wu%40mediatek.com.
