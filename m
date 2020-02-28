Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1ADC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6614B2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVcNIfvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgB1PnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:43:19 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39918 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgB1PnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:43:19 -0500
Received: by mail-io1-f68.google.com with SMTP id h3so3852261ioj.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXF8Vb//sc6W5vJpDUv/CbZRJN8HpMWXFvWuqmU/8RE=;
        b=IVcNIfvBpO3ChRCHiAc3d2I0nlb50wKHRgo2PEkWqHATopM2gmG4aMLuKIWNO2HvXB
         aY1LJM6EhfQBLVEREcYu+CuBOUeffPGRlt36O5MA7HKjeMRNAyepCj4fHIA4HzD7D9i7
         90WGU530ck2Uqy4Q07AIw4RpSKmEYwvRNRmF2fo0Av9ye04884tHGIdkj9BcXn5uPcLn
         ww7gT/FhjX0erAfI4UuAWwFM1UWrIBy9p/q5FYUNrc92QMMMJGY2bDNs+jbpyCQBaYQt
         KHNT3sy6OiDcoGtvL+ltE4qfSbjj4yR2ZMIjkafJdGq/P9s4Aaxbr1qJIBQz9zwCLbKH
         9Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXF8Vb//sc6W5vJpDUv/CbZRJN8HpMWXFvWuqmU/8RE=;
        b=MWYBERnmlb7aHNNOd3W+Rh1na1KcHYJB4pxpDRu0qPCWvaAaZ16r5+iAIYwHMcrLfd
         xEy2K2KjPPyMobX4Z31H3Nhjn4vK63uFgniKbXLq12m6v2BDeA+QF4MVyOWBuRJOIzob
         JI9g92YCzrER6rfbFNciepUAEayMDbiqrzjXfp/260Gra60ueO8xcSkbIDMjkfeUkqSc
         Ikbd5S4/axs0Lc7eUVxP5WOz6NNp1HvJ8o29BaToasKTJb2VewEHmyrL6Mui1w8JQP5N
         mRf0H2dOkRI/KPC/Jxs69gvKEUlA6Jl8KytzZpyGw0mexW7DqJO3VbtaQ4fOwKJtOhle
         TMBA==
X-Gm-Message-State: APjAAAVgNGak2XOdzq4NZS0k2KfuST/PQdkbu+g2UinsxuhQd2tQCg00
        VO1zUZa7tUZKbcMw2k9Qhw5PF5CCwjeAjpbe2GRjB3hF
X-Google-Smtp-Source: APXvYqx8YznOl6pR/Ut42ktNXJzPyH06WHAwvYUK0DHdVC/laITOVbrALziw1z3UvxGC1EH2CRolVs3ohsH3f75rCp8=
X-Received: by 2002:a6b:6205:: with SMTP id f5mr4265135iog.42.1582904597758;
 Fri, 28 Feb 2020 07:43:17 -0800 (PST)
MIME-Version: 1.0
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com> <1582889550-9101-4-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1582889550-9101-4-git-send-email-kernelfans@gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 28 Feb 2020 07:43:06 -0800
Message-ID: <CAKgT0Uc5cqJ5yhdi7HkyFTuiYQiPt9rGFPd42qAGSa7+d9ZQgQ@mail.gmail.com>
Subject: Re: [PATCHv5 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in
 gup fast path
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 3:35 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Introduce a GUP_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
> path.

The title of the patch has a typo in it. There is only one 'e' in "benchmark".

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup_benchmark.c                         | 7 +++++++
>  tools/testing/selftests/vm/gup_benchmark.c | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 8dba38e..bf61e7a 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -8,6 +8,7 @@
>  #define GUP_FAST_BENCHMARK     _IOWR('g', 1, struct gup_benchmark)
>  #define GUP_LONGTERM_BENCHMARK _IOWR('g', 2, struct gup_benchmark)
>  #define GUP_BENCHMARK          _IOWR('g', 3, struct gup_benchmark)
> +#define GUP_FAST_LONGTERM_BENCHMARK    _IOWR('g', 4, struct gup_benchmark)
>
>  struct gup_benchmark {
>         __u64 get_delta_usec;
> @@ -57,6 +58,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>                         nr = get_user_pages_fast(addr, nr, gup->flags,
>                                                  pages + i);
>                         break;
> +               case GUP_FAST_LONGTERM_BENCHMARK:
> +                       nr = get_user_pages_fast(addr, nr,
> +                                       (gup->flags & 1) | FOLL_LONGTERM,
> +                                        pages + i);
> +                       break;

If I am not mistaken the mask of gup->flags is redundant. It is
already masked by FOLL_WRITE several lines before this switch
statement.

>                 case GUP_LONGTERM_BENCHMARK:
>                         nr = get_user_pages(addr, nr,
>                                             gup->flags | FOLL_LONGTERM,
> @@ -103,6 +109,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
>
>         switch (cmd) {
>         case GUP_FAST_BENCHMARK:
> +       case GUP_FAST_LONGTERM_BENCHMARK:
>         case GUP_LONGTERM_BENCHMARK:
>         case GUP_BENCHMARK:
>                 break;
> diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> index 389327e..5a01c538 100644
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
> @@ -17,6 +17,7 @@
>  #define GUP_FAST_BENCHMARK     _IOWR('g', 1, struct gup_benchmark)
>  #define GUP_LONGTERM_BENCHMARK _IOWR('g', 2, struct gup_benchmark)
>  #define GUP_BENCHMARK          _IOWR('g', 3, struct gup_benchmark)
> +#define GUP_FAST_LONGTERM_BENCHMARK    _IOWR('g', 4, struct gup_benchmark)
>
>  /* Just the flags we need, copied from mm.h: */
>  #define FOLL_WRITE     0x01    /* check pte is writable */
> @@ -40,7 +41,7 @@ int main(int argc, char **argv)
>         char *file = "/dev/zero";
>         char *p;
>
> -       while ((opt = getopt(argc, argv, "m:r:n:f:tTLUwSH")) != -1) {
> +       while ((opt = getopt(argc, argv, "m:r:n:f:tTlLUwSH")) != -1) {
>                 switch (opt) {
>                 case 'm':
>                         size = atoi(optarg) * MB;
> @@ -57,6 +58,9 @@ int main(int argc, char **argv)
>                 case 'T':
>                         thp = 0;
>                         break;
> +               case 'l':
> +                       cmd = GUP_FAST_LONGTERM_BENCHMARK;
> +                       break;
>                 case 'L':
>                         cmd = GUP_LONGTERM_BENCHMARK;
>                         break;
> --
> 2.7.5
>
>
