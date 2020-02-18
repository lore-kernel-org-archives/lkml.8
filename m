Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23825C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCD324654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6M6HrVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRSl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:41:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43475 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgBRSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:41:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so15261993qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8trNULk0p7YTqlS76VkwaHxCoBJjgc3YSZwDVrMPcc=;
        b=h6M6HrVl/s5ivPkO5Z1ae1j41oRDK/YZ/CMQeyTHeCm70Xf8uzH3NUd2U1TEIBQctu
         zaEPJnigmUn3fvfj0Sa0Vtkti5inbKWVcYrGvzz2Z9j3tAywKdkucVFFz9PkvyoLP6wY
         /5mIIY9IuOmrH7z2JMau9X++QuLwtDTXvMskap9MpzjyVWX//o0rQmGkyGijHqEUft0+
         AU7HWAlmw783ySPgijXZvqNYfdh2o/ASnQ85K/RkvHNBsduuWv8f5kxmfZKVXm30kVa7
         V0121A5vUilpN8Q72rXVxAfFiad3uPlDcFp8JTCASh2TMuKUxiBf1gGHBdEe1Hb0xtjP
         zpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8trNULk0p7YTqlS76VkwaHxCoBJjgc3YSZwDVrMPcc=;
        b=gr5wWMrrlKZiw4eIQzfSGIR2vm/ekKAOAjrRfebiGh6ObSZnbdjTkAXirA3dhtvs7q
         QQLMAE5ir0GaBWEcvx4XJQ4o+b0dbkLH3Y17aIzD8Enpi7J8Rcw2k4JPdXwZ3YQ1edz6
         jcmRlVpeDgkxPhF3HlpmUUr9eMqf3u/N+4C6I2SxtP/NKiuL3eFvoJ5hBwfHNRNfvb9h
         d8j0NDQ85m+CwKUgk+BqWdPux78iU2K2Cxtli2OXpUgiBo9hpOehmchll14rFc+G4CO8
         8HQkhwvLDyc+2aXqpNFhoqBrjloYxAKZ4jS9zi+bBw7FN0wy9mrMtye5KYpvziirDJl9
         brZw==
X-Gm-Message-State: APjAAAVI/TyKNsrLBYoJT/HWiK5CDvMs/Pjy8ROIevHTgJFioEehamkd
        l+pKtUia2of1VLRxolowAUWoRPT9Zskbmwl5c10aJA==
X-Google-Smtp-Source: APXvYqwNn+oeDOLhVeJz9u7cgOo+LDlda9ul4xQGNdm+tuTn6q87++mwk68MeqHh4jfoH64EprmRSvnltHAJHxaIXcI=
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr18764287qta.189.1582051287712;
 Tue, 18 Feb 2020 10:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20191227063204.5813-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20191227063204.5813-1-xiyou.wangcong@gmail.com>
From:   Chenbo Feng <fengc@google.com>
Date:   Tue, 18 Feb 2020 10:41:16 -0800
Message-ID: <CAMOXUJ=mvh0Aj-==wmPGh6x3dz0K3YTfaSw+osMwU=rgQv+Qkw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: free dmabuf->name in dma_buf_release()
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com,
        Greg Hackmann <ghackmann@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Chenbo Feng <fengc@google.com>


On Thu, Dec 26, 2019 at 10:32 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> dma-buff name can be set via DMA_BUF_SET_NAME ioctl, but once set
> it never gets freed.
>
> Free it in dma_buf_release().
>
> Fixes: bb2bb9030425 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
> Reported-by: syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com
> Cc: Greg Hackmann <ghackmann@google.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index ce41cd9b758a..2427398ff22a 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -108,6 +108,7 @@ static int dma_buf_release(struct inode *inode, struct file *file)
>                 dma_resv_fini(dmabuf->resv);
>
>         module_put(dmabuf->owner);
> +       kfree(dmabuf->name);
>         kfree(dmabuf);
>         return 0;
>  }
> --
> 2.21.0
>
