Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC6C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925FF2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBuiYpmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgH3HyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgH3HyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:54:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1378C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:54:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h4so2910194ejj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohDVHll9uNXquWg/6LUDMQsitXnSxjQWS4MTv84+k88=;
        b=QBuiYpmuSQYBHZAZ/Jw90PmwEpkYyjbmSDHyKKMSCvR+m5CDksZFiIlevVBV9sWL/4
         MP+Zax0lFrV/IHMEUdh4dUAHlzjeDQLkUkR0u8Y6sXFQoIN0VHVZpdYdUheaDZJGlpjm
         8sE0aB9CECoGkPE1b9MzbVkl73XJMvYbOt22NsLUUBjIH6kT/BMME1GgzWWMPT04oeiu
         rhx2ANl/3qjBrRw4uNoq3y99SNpOpEC3qFSnEIqdb+Uagao8KnmQa0BqiJ9SQbRmi1Zf
         JTNC+24bWm5BM2tzrhdSnVJCVbod5V5faiEJefafnudd/v0OvTrreWIBk/CcEc28UhQG
         PXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohDVHll9uNXquWg/6LUDMQsitXnSxjQWS4MTv84+k88=;
        b=lA6Wq55YlWJnC0PTS5fanYJHlzChrRglOXR65gfz4ksBzlGQiAiC/TN7/rK4J2hfS1
         8IUhyrH64n/tIm2T4OuDiUz4c673xGTOhnoTW1Wy94yASgY90qPnSkjmKM1UuK1Lpb/L
         qwWRVqMwP1uREpt9Mvllwfu7sW8CA9lvKAmyqnXRahtk5w8xEvOicDp5krFtj9Fu9Jqg
         yVKpGFjLEN/wDf319k0DnVZ1buQzEQ7L7PqIYzO75HpV3oq/t+4ynRtbfP2jrezlc/Pq
         FyEM2E9ebhDaiS47rHAUjN0fjYGHQ/Y1ERmRBCFhIg50p5jGBgB6UEbezyLlEHFm885I
         8n6w==
X-Gm-Message-State: AOAM533XUTC+WfdlaN5B2FNzwQnLrQ3Qd7qyuj9c2JC9z4T+7fa0ij9J
        ImFQ35+R/IwzsU9VgZi8WGJjJrwEl8Z1o8UBuZClS3iX7EqbsA==
X-Google-Smtp-Source: ABdhPJxJOKBGQIwl5zr92GkAxuJ/JNXh2osmS0VcZOhDmNUCHlcHZq1jn722dLnsh0dgRyK7pglsCsJpCWAKFf/1r+A=
X-Received: by 2002:a17:906:bb06:: with SMTP id jz6mr6991256ejb.248.1598774042143;
 Sun, 30 Aug 2020 00:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598598459.git.zong.li@sifive.com>
In-Reply-To: <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598598459.git.zong.li@sifive.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Sun, 30 Aug 2020 10:53:43 +0300
Message-ID: <CAOJsxLHOvvt8WGQUynGkLxZCA4OQQ+KgxxJJD7s_iP8Pxf-Omg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Set more data to cacheinfo
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 10:09 AM Zong Li <zong.li@sifive.com> wrote:
>
> Set cacheinfo.{size,sets,line_size} for each cache node, then we can
> get these information from userland through auxiliary vector.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 59 ++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index bd0f122965c3..8b85abfbd77a 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -25,12 +25,46 @@ cache_get_priv_group(struct cacheinfo *this_leaf)
>         return NULL;
>  }
>
> -static void ci_leaf_init(struct cacheinfo *this_leaf,
> -                        struct device_node *node,
> -                        enum cache_type type, unsigned int level)
> +static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> +                        unsigned int level, unsigned int size,
> +                        unsigned int sets, unsigned int line_size)
>  {
>         this_leaf->level = level;
>         this_leaf->type = type;
> +       this_leaf->size = size;
> +       this_leaf->number_of_sets = sets;
> +       this_leaf->coherency_line_size = line_size;
> +
> +       /*
> +        * If the cache is fully associative, there is no need to
> +        * check the other properties.
> +        */
> +       if (!(sets == 1) && (sets > 0 && size > 0 && line_size > 0))

Can you explain what this is attempting to do? AFAICT, the if
expression can be reduced to "sets > 1 && size > 0 && size > 0", but
what do you mean with the comment about fully associative caches?

> +               this_leaf->ways_of_associativity = (size / sets) / line_size;
> +}
