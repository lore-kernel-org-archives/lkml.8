Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E969E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RflVgsvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgEVLvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgEVLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:51:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1CC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:51:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so12224293ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeReYvQnKyu7k3uoEWSZqRI6bJigU1y5/W+uUFajH+s=;
        b=RflVgsvx7RCB0NVcoPe0fOGSg6EScLAvWGUOJF16bb1NJGJkCVB0KGyXi6dUuhtYtV
         ZM8LyOguSzylipElJMkCcmlzedQC45dtNJJTfAX59zwIeFOZuMAu5T9uRi+7K/mNr/i5
         pxxtZNz9CXxhprURMiVKYmYAb04zsB8b6uNR7zXSYhXe1QfekdUYa3/IPS9+d7OyCb4x
         J5LMjAEMewM3KKWP4SCC0GKrx6SyUbewm6PnECxplw30xY+7pg32EZqNa5lUSxVHT+wV
         yTGnyizCVAMKPkGl6GpVfOpvh/bIdRIAKzQ1820nYAmredNK1ISGo1cf5QTphEonLTtH
         CnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeReYvQnKyu7k3uoEWSZqRI6bJigU1y5/W+uUFajH+s=;
        b=fu7oHxAAXnM15I/PahM+R1h23uS+UvA8wx/ddxZxBHn4d9jo62pgcjJRyOj1IQxhts
         3uhepC+TEecoZqgWHQGCBVrXZsIELEm83ZuEQ3tvP9ok/ye3kW4gPS8o3YFb1bVluCJj
         iGeF4hR34LLp7GgflWJUhckT4bQlpa9wWzmQBY/dG6B7HuiUefnsFGvvMw/N2RCmyo9o
         Z6FQv+RP2QeRnc/HsXfIy9kHIOHjY7wDpy77/kH026fbBgBWw90L0aVnWKXFFrIUCHS2
         gyV0hIiBShRg9g1y4+yYGgmZLmsLXJq4fo9iDlVvvqkdLHr//ji8UvzgNW4gMKVGhexb
         c3Eg==
X-Gm-Message-State: AOAM531fO8nlAhhb0sdfNIyNK4BALZG5Sj80rRTE3nILvfMC2IBLD2QW
        KNheMpHqnpBGIezVsk6YXHq8ARS0ZRiIRWecBLalqZu1
X-Google-Smtp-Source: ABdhPJyukuIj8SZEZNsVfF8m8sQP5jBclDvrKgoP9D+HrG7P8wdrO8G5zElE0eM6CQPkcKnMeZlUKMbLpjh83TXdx6s=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr7251683ljj.257.1590148266596;
 Fri, 22 May 2020 04:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 22 May 2020 17:20:55 +0530
Message-ID: <CAFqt6za+frJBV+7+W-Dfd2HVWEzpdHxt4SsQtDb9y=fyrqoMJw@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt/fsl_hypervisor: Correcting error handling path
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, dsterba@suse.com,
        Arnd Bergmann <arnd@arndb.de>, Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 1:45 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> First, when memory allocation for sg_list_unaligned failed, there
> is no point of calling put_pages() as we haven't pinned any pages.
>
> Second, if get_user_pages_fast() failed we should unpinned num_pinned
> pages, no point of checking till num_pages.
>
> This will address both.

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/virt/fsl_hypervisor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 1b0b11b..ea344d7 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>         unsigned int i;
>         long ret = 0;
> -       int num_pinned; /* return value from get_user_pages() */
> +       int num_pinned = 0; /* return value from get_user_pages() */
>         phys_addr_t remote_paddr; /* The next address in the remote buffer */
>         uint32_t count; /* The number of bytes left to copy */
>
> @@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>  exit:
>         if (pages) {
> -               for (i = 0; i < num_pages; i++)
> +               for (i = 0; i < num_pinned; i++)
>                         if (pages[i])
>                                 put_page(pages[i]);
>         }
> --
> 1.9.1
>
