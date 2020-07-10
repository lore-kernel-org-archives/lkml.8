Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583C62072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iz5+7TZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgGJDPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:15:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F084C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:15:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id d198so2254164vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xK96ZEj03BYxsiwTCEC7aLn5QyV2i1PW83BHZdlgiE=;
        b=iz5+7TZuV43ycSJaAM7QXsHXHZMrqwe1VHhvH7nzaLRNqyuSzRIKsTm9ZY6hcyT6xL
         rUeURvW6GTpfMb+6hgPG7XBznhNpcnfnoWcODmOEsJARCaoCb5xul+H0TsOjwz8m0Gpt
         8etFgsVIuVEHJxU8FqnuyA13ZWtKyl5k05Cmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xK96ZEj03BYxsiwTCEC7aLn5QyV2i1PW83BHZdlgiE=;
        b=E83Wfzuuug2EhOBltvmAIjrZ4/8naUfYLpEBm+oqwm5ciF2i4ZeHe0Afoo8hJ79Ny/
         j5tkpaZ3hg2w1ySUVZtX8vJOS3GSGhQxMdcd7G2xUd05dHcSqAO/LscyZE4ls+zPrYGl
         pwPYq7vxgxu4U2NSLHKLQWEbFcbuEbwu3ThNLIikFZLU3HRR5YovjoHuGrmbJqCOsFHm
         Qi52Cnw/Xi3nQ/FSvgGTD+sFV/wn8+uyJUup1RDXRn7GqZIYhJOt4NCmE9wmTdgLaXdp
         b1zfqz0glBHXnILq2MMQLoLtxRai0Yqwz4ylBFLKc0XYffL8xZphlrcqFDIBZp48aocT
         fOKg==
X-Gm-Message-State: AOAM532Cg1Gt1BuNz1oCXaw61SOLVA3aBXbDb7p4r7HL6yMRmBzi2z/P
        apeJC7h8h+lsmD/poCnFHnterhQ/3DhZwzNotawzBg==
X-Google-Smtp-Source: ABdhPJwwWTRG9i6cMBcyGYThfNXEyr1KpiR5j0/N7lIP76+Rz5QR86zchLcWA1ir6x7GGNOpx8rJ1ZOQxoECbAD4Myo=
X-Received: by 2002:a67:e0c3:: with SMTP id m3mr52687562vsl.1.1594350903351;
 Thu, 09 Jul 2020 20:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <1594348182-431-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1594348182-431-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 10 Jul 2020 11:14:52 +0800
Message-ID: <CANMq1KA2kT1yLGqhJFBKt4sRzzE6r=ABkSX59S-Mjr8Dg8sTOQ@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-mtk: fix the failure of bandwidth allocation
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Ikjoon Jang <ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:30 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> The wMaxPacketSize field of endpoint descriptor may be zero
> as default value in alternate interface, and they are not
> actually selected when start stream, so skip them when try to
> allocate bandwidth.
>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Add this?
Fixes: 0cbd4b34cda9dfd ("xhci: mediatek: support MTK xHCI host controller")

> ---
>  drivers/usb/host/xhci-mtk-sch.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index fea5555..45c54d56 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -557,6 +557,10 @@ static bool need_bw_sch(struct usb_host_endpoint *ep,
>         if (is_fs_or_ls(speed) && !has_tt)
>                 return false;
>
> +       /* skip endpoint with zero maxpkt */
> +       if (usb_endpoint_maxp(&ep->desc) == 0)
> +               return false;
> +
>         return true;
>  }
>
> --
> 1.9.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
