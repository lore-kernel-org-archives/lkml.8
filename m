Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AADA2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zi64Kg7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgAPIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:53:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39838 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAPIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:53:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so18252691qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lq1lgQepAiLQTChN85kcSpVDrR+IKCYkY9dHTqAQDcM=;
        b=Zi64Kg7KK+B5haudW5HjEa7F3ZDfapczeiCEACOCF6FEfhyd1F04IlvUIvbckZfhqB
         m5sHC5SL4LAcnuxn/vVVOmQbYFMcO4SWSHhUcMEuRzAnOOusbAnVNsgIWB7Y3nVEfQNS
         KIg3Kf+jJxzjnO2LkgXozRl0F6jtbORpL73RvFHzW1BlE9ckNdoKGPncI2reSsC9WUFR
         6xM2TZVBsILLq/bDpXavek7w2D6/94aBUKCp0qA0fPFplpitW+w8PFFlO4R6eCnezkue
         3CEAXw8uufTK7n7vhhlTsl2SLfQJQAGmfYU04sa7vVYg3cwBxenTCklXZTmfkuCPHWGY
         UZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lq1lgQepAiLQTChN85kcSpVDrR+IKCYkY9dHTqAQDcM=;
        b=MULJl9fb4b6vuGuD5gss+/x2uYfPraQCQNe+V64/8Ycgv1lhH3btlzGZLqHVB0PC2C
         tMap7zT7XWzlsTXHTnoyiVK5KWGVUj4BFkbJG2rLCpugg7MlR9sFGo22a/GNznOtplPt
         qRTSzir4lzC7UBABGNlVlbpdJ8A2T01GTcSQLKLx8ceE8+O7BbZP7YO8h0ISv67rNLM3
         8/FUZDtGLT7WWYBpBrzhqK+rkvma9pMOR/4I43xK4ATLNJpAgJOeFUiJNHi4a4afNqL8
         DfyNIjTgBHFfPaPbDAkhF7C8w5veeuiq74P/JbAFISxdnfemL6N+Gu1RYRDGJKKXuLb2
         0u5g==
X-Gm-Message-State: APjAAAVzSAjkwHIPyAmCFyeKBTP75djKqflUymP6McSpaQMlh/c+8MLW
        ESJxFlqrvzAn4ykl6d+Ia696IW5NzEMabsJVqfZjqg==
X-Google-Smtp-Source: APXvYqx668LJA8dc9pebV2KDB+FmOaBoMSj6224mh7wamsZGH884hR6PWoaTatkVg9XYy1EbjSRjVtKcg9fuQdTluQM=
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr1305434qtt.257.1579164783430;
 Thu, 16 Jan 2020 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:52:52 +0100
Message-ID: <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void kasan_init(void)
> +{
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +
> +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> +
> +       // unpoison the vmalloc region, which is start_vm -> end_vm
> +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> +
> +       init_task.kasan_depth = 0;
> +       pr_info("KernelAddressSanitizer initialized\n");
> +}

Was this tested with stack instrumentation? Stack instrumentation
changes what shadow is being read/written and when. We don't need to
get it working right now, but if it does not work it would be nice to
restrict the setting and leave some comment traces for future
generations.
