Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A599C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43E92072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Xik35GAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHYCnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgHYCni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:43:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:43:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so457435pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXXvfJjv+PfyYEP8RerkMouFzdtCWZ46cy+YpsBryXM=;
        b=Xik35GAUruB2YLQx720bmys7UuUJGGrYPGuEWgm4bPqBkTXHUDAkLWkGaggEzipwWv
         AO56TZIgMYaCIqml9oATDFk1HJx0zki2DTurK1g3tetjO3zxIj9xZX6PUaY0kO1NN7iJ
         P2ujzWCdfsHgZykDkWcT9h9qBjq+OEiH6URRIRnV857aBeXNpEifOJ9ls7EpWEPq2Uq6
         ZiTuauFw9sGVSMnlxJcWm+nu/ERr+0zYUJRmq3KhEc5BcyoXUFjbOsq0rrS8jINzvFjY
         o+79Cg6qYv2B0CfhkwFXCroS4zXtL3/8PmR60S407BuJI5DwNjh0wKh/BAeGgUNiGOs1
         SKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXXvfJjv+PfyYEP8RerkMouFzdtCWZ46cy+YpsBryXM=;
        b=ld7UM5C+XMw9TRgTFnTBnE1QTesComeNkqPM9gqQIegNSoz058DTSCqkG7VtHbEX2I
         hlgtrsFSzYcSSMkKb3Dh4yazSItulMfRZMmKjjIxkML0FGK79uK26vX/Omgcm8juF3Nn
         2ufKR5W6JLEnp8sXQ7URM4LYUI4w5t8YuXIlPvblvq5SBmoQx2mlUS0/TkShaG5NnuXF
         UnKdzaWCmgn5o4Zrgwax6jnOXf8fc0qRv9u9fF5ZOweRuxNNI25qdwyslYToy2CJhgyk
         5EaoureUz9lhF5KgN3cLlhlQEVg81B6TZBk04SrxGDs1EHkWYC7M2kl9QZVUEJ0zRtPi
         O/UQ==
X-Gm-Message-State: AOAM530vR/dWE66CX1+oz2jKDHzzQH1pD3DgyA7Z7f1aR/GtWGORC7WG
        DEGeWUAWh1TlTtS8kTW5hqwjq/dq48xgrU3mtS4z+g==
X-Google-Smtp-Source: ABdhPJxbM2UTrkjNNbuYhIYu/UiCbPfU46l9LiniAtioxQL1QQTA6YdZMibG5etJIacAOqOjPvawN2MFfmH81tyM/6w=
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr1828365pjr.13.1598323417348;
 Mon, 24 Aug 2020 19:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200822095328.61306-1-songmuchun@bytedance.com>
In-Reply-To: <20200822095328.61306-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Aug 2020 10:42:58 +0800
Message-ID: <CAMZfGtUCeD_zLr+VY--3fcCuB+_P14tSPPeeSR6aG5KnBU36Gg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix a race between hugetlb sysctl handlers
To:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     ak@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Mike,

On Sat, Aug 22, 2020 at 5:53 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> There is a race between the assignment of `table->data` and write value
> to the pointer of `table->data` in the __do_proc_doulongvec_minmax().
> Fix this by duplicating the `table`, and only update the duplicate of
> it. And introduce a helper of proc_hugetlb_doulongvec_minmax() to
> simplify the code.

I am sorry, I didn't expose more details about how the race happened.

CPU0:                                     CPU1:
                                          proc_sys_write
hugetlb_sysctl_handler                      proc_sys_call_handler
hugetlb_sysctl_handler_common                 hugetlb_sysctl_handler
  table->data = &tmp;                           hugetlb_sysctl_handler_common
                                                  table->data = &tmp;
    proc_doulongvec_minmax
      do_proc_doulongvec_minmax             sysctl_head_finish
        __do_proc_doulongvec_minmax
          i = table->data;
          *i = val;     // corrupt CPU1 stack

>
> The following oops was seen:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     Code: Bad RIP value.

Here we can see the "Bad RIP value", so the stack frame is corrupted by
others.

>     ...
>     Call Trace:
>      ? set_max_huge_pages+0x3da/0x4f0
>      ? alloc_pool_huge_page+0x150/0x150
>      ? proc_doulongvec_minmax+0x46/0x60
>      ? hugetlb_sysctl_handler_common+0x1c7/0x200
>      ? nr_hugepages_store+0x20/0x20
>      ? copy_fd_bitmaps+0x170/0x170
>      ? hugetlb_sysctl_handler+0x1e/0x20
>      ? proc_sys_call_handler+0x2f1/0x300
>      ? unregister_sysctl_table+0xb0/0xb0
>      ? __fd_install+0x78/0x100
>      ? proc_sys_write+0x14/0x20
>      ? __vfs_write+0x4d/0x90
>      ? vfs_write+0xef/0x240
>      ? ksys_write+0xc0/0x160
>      ? __ia32_sys_read+0x50/0x50
>      ? __close_fd+0x129/0x150
>      ? __x64_sys_write+0x43/0x50
>      ? do_syscall_64+0x6c/0x200
>      ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a301c2d672bf..818d6125af49 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3454,6 +3454,23 @@ static unsigned int allowed_mems_nr(struct hstate *h)
>  }
>
>  #ifdef CONFIG_SYSCTL
> +static int proc_hugetlb_doulongvec_minmax(struct ctl_table *table, int write,
> +                                         void *buffer, size_t *length,
> +                                         loff_t *ppos, unsigned long *out)
> +{
> +       struct ctl_table dup_table;
> +
> +       /*
> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> +        * can duplicate the @table and alter the duplicate of it.
> +        */
> +       dup_table = *table;
> +       dup_table.data = out;
> +       dup_table.maxlen = sizeof(unsigned long);
> +
> +       return proc_doulongvec_minmax(&dup_table, write, buffer, length, ppos);
> +}
> +
>  static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
>                          struct ctl_table *table, int write,
>                          void *buffer, size_t *length, loff_t *ppos)
> @@ -3465,9 +3482,8 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
>         if (!hugepages_supported())
>                 return -EOPNOTSUPP;
>
> -       table->data = &tmp;
> -       table->maxlen = sizeof(unsigned long);
> -       ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
> +       ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
> +                                            &tmp);
>         if (ret)
>                 goto out;
>
> @@ -3510,9 +3526,8 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
>         if (write && hstate_is_gigantic(h))
>                 return -EINVAL;
>
> -       table->data = &tmp;
> -       table->maxlen = sizeof(unsigned long);
> -       ret = proc_doulongvec_minmax(table, write, buffer, length, ppos);
> +       ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
> +                                            &tmp);
>         if (ret)
>                 goto out;
>
> --
> 2.11.0
>


-- 
Yours,
Muchun
