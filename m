Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6958206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="v8Fz6qm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbgEMTcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733166AbgEMTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:32:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:32:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id re23so553989ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BE622nGiTtu6v9vVxV14reu8OE6xnzpoEgMB5sSvex8=;
        b=v8Fz6qm1UPHcy4fzB1etrJtc5izL/GqEwddtqreXSdnRxvaCZO93lPxWCxy6dYNopO
         ovTSMdPH5x3EcqCJVFhALEQGdCHBhHOxJcbfjejGwXLVpdyoqWR5grnKsbYXYZBYMTDW
         jdw79nr8BGsjc84MHBGJGCPWGXXZwQUJRnP+/fUYQH/KFcDG4sQTaAkDVB8uy3r4Kva6
         1c7eENLEXz1TDTmM0bZq9Iq19X+gC84bVj2IETeUpm3AzHtoHxtTTygNy6flCIvIIatX
         8sbRRDzTOIcjexPkw9H2mGRXMJHZRNgjjEi7x7v3MQgHq21h514+LW7nHsvIA1sRMo47
         ddUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BE622nGiTtu6v9vVxV14reu8OE6xnzpoEgMB5sSvex8=;
        b=EaqotwrOsycnism/E1xZOHrIYd+NwxW0tqRmM1gcKXciZ6bdLzUfEnlrOugrUhAFiT
         XRUs+cFijnEWhOpuNfGQBCocARHDLFe+sCHWci28dAotCkJQ0dkUMFK2Jc+Ny65tdGZA
         2cvb3QhGX2BDKx6fPULtmCMmsd0ORanoZSz5Sut1Bd0uoPMS7EEAwGrjdrCoOnUw0dSW
         O04oj2eqrQFR6wmnHVdwP7GmLLtUNH5l8U+WLpPuDJ69hg4X2l4LyKKWfS/IN8dgad1v
         Cb//Y55DL2JJUwslJHHNuLR54JFmE3+RBp+AsJNIH+DOYxDPIwEhz9nAu7awJ9iUbyyY
         R25A==
X-Gm-Message-State: AOAM530j0tgf41XtAVNsq128p2toMYEwyKe6JZPkXD1HBwr8UTNDVPNh
        XtlbvvhSu4i27PCF63l1krxyStzWOW9GPw9m+Q3qgA==
X-Google-Smtp-Source: ABdhPJyabrOM2lVYltf63j7FVFAWHDtm2qZfMMxJE1PMk+5hOmSTpa6jO7omyjX4bgwtMZQAU7ZWXlAoEFkPAqDYUoE=
X-Received: by 2002:a17:906:af6f:: with SMTP id os15mr609937ejb.78.1589398364557;
 Wed, 13 May 2020 12:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <1589186626-17243-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1589186626-17243-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 13 May 2020 16:32:33 -0300
Message-ID: <CAAEAJfAzcRTLE3HWHJqWvuENYnPCU-E6TdaDWXc+WNHOaUqdyA@mail.gmail.com>
Subject: Re: [PATCH] [media] tw686x: add a missing newline when printing
 parameter 'dma_mode'
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 at 05:49, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
> When I cat module parameter 'dma_mode' by sysfs, it displays as follows.
> It is better to add a newline for easy reading.
>
> [root@hulk-202 ~]# cat /sys/module/tw686x/parameters/dma_mode
> memcpy[root@hulk-202 ~]#
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

I don't mind this change, but I don't think this is standard.
The lack of newline follows what other drivers are doing.

# hexdump -c /sys/module/acpi/parameters/ec_event_clearing
0000000   q   u   e   r   y
0000005

Is it really an issue for you?

Thanks,
Ezequiel

> ---
>  drivers/media/pci/tw686x/tw686x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
> index 74ae4f0..bfc61da 100644
> --- a/drivers/media/pci/tw686x/tw686x-core.c
> +++ b/drivers/media/pci/tw686x/tw686x-core.c
> @@ -71,7 +71,7 @@ static const char *dma_mode_name(unsigned int mode)
>
>  static int tw686x_dma_mode_get(char *buffer, const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s", dma_mode_name(dma_mode));
> +       return sprintf(buffer, "%s\n", dma_mode_name(dma_mode));
>  }
>
>  static int tw686x_dma_mode_set(const char *val, const struct kernel_param *kp)
> --
> 1.7.12.4
>
