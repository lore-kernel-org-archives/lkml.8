Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0AEC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D74420679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV9jS8xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgG0X7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0X7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:59:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:59:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i138so8751589ild.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40PEaev2AR89A76wIRPh9VfSUB5wAXw9k1uNgC1xL9I=;
        b=QV9jS8xGVpXS1MnzL+IOlUZ00NhuszDykNVROAl12nkRTkPSRJLf8LWBy7IRcQeBX5
         Q7f1VxShoP8ALlK0YhPDWsDbywP86qxft9UyqmnZuX+rR645yR4+nVqTHWAwl2Gb52kv
         /BqhaOQy6KgfBLL+wrtuwtW4qoNCupFxb70UW7HRopA6YU2/2dju9n1s3CLS4500Q0wK
         hgbLm2BsulQtzVxybbH+gZEHdWSP1sCjbAhQBJQXzqutkN7XHkgyJE8oR+BNXYDS4r39
         T6lK2ZqTNfxiCaLRnb83C7QgeaRLag0TKTConCjZSzPTEONEKPDoaxjfEJfiWpm9lJ/A
         qAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40PEaev2AR89A76wIRPh9VfSUB5wAXw9k1uNgC1xL9I=;
        b=JaeEkizBXLA7UkcHlA2QpYAusqhNS0rXU5JALLijcxHI2dvbOKInOwyfludYp/CHZr
         /JHK3jCvXsppufEf6kD6JCq36Fa3/0ly/dOBr4YfwC/uTi8ptOAD3HiZ8doJp/pJGD44
         a/4PAXQ+VIymKMFefB0UjTKt4sHkrCg4H/yjFYil2JnJ0vMHtJE3d+mZxi9UzBbL5unF
         5zIsCnb/8gigmVYnUuT9M+WeqcXPgFobeLp+JIs5jLHVQZyoTS6tGELm9dx0/pkNYmTA
         Yii9f92XkO0pT43SetdEYmJObyFf2pbrtByW5QAbTo24n5jvu4RXnOCst7DvO0Jcf83N
         P8uQ==
X-Gm-Message-State: AOAM531LsjdzdUpnChfR7nBKPAFwuyJh8N/3LC6pQuGXZbppXH4zMT8D
        zbCxIjUKE9KqA5T6K1HuI0Z0zVaK4vo6a6BLPHoKtdzz
X-Google-Smtp-Source: ABdhPJySvicnnryYF1OslzmbsSVu5tO/Hy3Wk6Iz23QfOb9jDrUA0O4lYDXYPFMGDFdRo7HCdOu6N4VcluEmZYHL/U0=
X-Received: by 2002:a92:7a07:: with SMTP id v7mr16791692ilc.122.1595894340476;
 Mon, 27 Jul 2020 16:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200727171112.2781-1-weiyongjun1@huawei.com>
In-Reply-To: <20200727171112.2781-1-weiyongjun1@huawei.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 28 Jul 2020 09:58:49 +1000
Message-ID: <CAOSf1CESE9tM_oJLwzfwx0AZfeJNXP719kJuo-Ba+NSY6BYhFg@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/powernv/sriov: Remove unused but set
 variable 'phb'
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:01 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Gcc report warning as follows:
>
> arch/powerpc/platforms/powernv/pci-sriov.c:602:25: warning:
>  variable 'phb' set but not used [-Wunused-but-set-variable]
>   602 |  struct pnv_phb        *phb;
>       |                         ^~~
>
> This variable is not used, so this commit removing it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/powerpc/platforms/powernv/pci-sriov.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> index 8404d8c3901d..7894745fd4f8 100644
> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> @@ -599,10 +599,8 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  static void pnv_pci_sriov_disable(struct pci_dev *pdev)
>  {
>         u16                    num_vfs, base_pe;
> -       struct pnv_phb        *phb;
>         struct pnv_iov_data   *iov;
>
> -       phb = pci_bus_to_pnvhb(pdev->bus);
>         iov = pnv_iov_get(pdev);
>         num_vfs = iov->num_vfs;
>         base_pe = iov->vf_pe_arr[0].pe_number;
>

Acked-by: Oliver O'Halloran <oohall@gmail.com>
