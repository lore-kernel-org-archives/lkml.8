Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5AE20748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBq0Oh9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCaGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:53:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37933 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgCaGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:53:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so1290360wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIdfTSo/e484Z3PHPHMJ/sokMhYtX+vwmXQLZC2QabA=;
        b=pBq0Oh9Xy6hU00u/+o8eOfRC0LhWSvo83BSzyEEuxoSEVIKKAdARxOWS4TZxH1tM+r
         zRo4mw7gQWkHJZ23Q2NYuGXwArr/uRoMWqSSfWomhaFqyjWd4GbFzqNwI/HljS3ZQh7M
         GOgSlHdzIUGVM03X9wcySplZtR7UhLxDs4GLHwrkE5/xaMdjLZEdtL8sNaSNJNXvcNkO
         UUidKhR9FQFyOL7WabyBBc5KHYBIIBy4Z8+PzrcWzNhm/cvGMjn45Aac5dbDcnrQIRaZ
         GWQJugWgsxGsU3FpKqRkjmUK/ySbzggz35S1KB26n5gQ/jxhBjowFFW2KLTCkJ4f3yIo
         3fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIdfTSo/e484Z3PHPHMJ/sokMhYtX+vwmXQLZC2QabA=;
        b=fNCb/cEnqwOCIRbMisEYSL/L7fzzCJD/zrDJWJ0Sxkboz9hyyWyhP9pRscKf01XV2k
         njtsE8lA4XHpX30RYlpO3DP40oAfajxfi5KuqARzwuUAQHMVieNGGBOIZ/zICDfQlAxi
         aZimPgVKV51pPQRZ5zQ2fyyoqhtSgH8BqPTgqedxRtul/9RDmxWJYmVzlPZZ/TD63qAG
         ypaiiOIqXMpgsUQER4XFRcJnU8R87qo00gUe9Bd3ScQ0Ygut9MlrOyDBKYy1yZdIEIPb
         onlQnz1P0g33M8F2hKUpjTPKIegzLdbHd5I/dWiy0JEsJwp3YmvhCdXFDTyyfJnnFqn0
         TAsw==
X-Gm-Message-State: ANhLgQ31/9rr4E1vVLr+DX2CCqYreDtYqwwLzKMCgNtwuZqE6pchn9WE
        18VnXrOe/h6Yy4k8zBp3DTAQyRTgXS11bXV/xvk=
X-Google-Smtp-Source: ADFU+vs3wLHXuJQLMByTyAYUwEHsLPKn2CFMgsYdlAca+TWGCwpk7wahIsjNVEjB6mfColESYnBMlYXAaPHvHM3JYyw=
X-Received: by 2002:a1c:a982:: with SMTP id s124mr1941458wme.105.1585637635174;
 Mon, 30 Mar 2020 23:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200330220840.21228-1-richard.weiyang@gmail.com>
In-Reply-To: <20200330220840.21228-1-richard.weiyang@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 31 Mar 2020 08:53:44 +0200
Message-ID: <CAM9Jb+i9CMosGb2ZBWABu5h2JbamqD5sb9Pu+9RPZ8mhqgM0Kw@mail.gmail.com>
Subject: Re: [Patch v4] mm/page_alloc.c: use NODE_MASK_NONE in build_zonelists()
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        David Hildenbrand <david@redhat.com>, jhubbard@nvidia.com,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Slightly simplify the code by initializing user_mask with NODE_MASK_NONE,
> instead of later calling nodes_clear(). This saves a line of code.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> ---
> v4: adjust subject/description as suggested by John Hubbard
> v3: adjust the commit log a little
> v2: use NODE_MASK_NONE as suggested by David Hildenbrand
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ef790dfad6aa..dfcf2682ed40 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>  {
>         static int node_order[MAX_NUMNODES];
>         int node, load, nr_nodes = 0;
> -       nodemask_t used_mask;
> +       nodemask_t used_mask = NODE_MASK_NONE;
>         int local_node, prev_node;
>
>         /* NUMA-aware ordering of nodes */
>         local_node = pgdat->node_id;
>         load = nr_online_nodes;
>         prev_node = local_node;
> -       nodes_clear(used_mask);
>
>         memset(node_order, 0, sizeof(node_order));
>         while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
> --
> 2.23.0

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
