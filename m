Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A136C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8020737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583947570;
	bh=S+RgHi0f88gJM9qhcjf/Imb64fipFgVlZGnzFNUVNPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vJd2LqB2fQrJp1+864s75kbYgpTNa2yyeAL71jyctxp0zUb6aoZW37QaxIupYQiU9
	 IOC7RwD9UJT/KTchE5OGqDVCcoqC6UoZiHdLHZty8H6QTt0p8WRi8XjhSh7dVtnUEx
	 EFCk/Cr8qePwAKVsZhNGnttwoGm4TDwLBguGwymg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgCKR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:26:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40696 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgCKR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:26:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so2408901lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UQVTnSguLvRHX8NkQfjS8un3uykC9cqMpLahtA/RCg=;
        b=GrfSUxt32RjLZyaJPIAa3ArKZfFLgmyXUhhc6z9ZYUHpqkjsZJXWpZTdbOeR0enVyY
         cErHS778dqtMr3tuFGIFaNXU7LUM/bueoJ9eXLgY0fNFghVCnkTw99fpgxs9DerMYc71
         sTgy2oVN6YxRd7pO9A9+Fj5ve8WsIRlC/QPTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UQVTnSguLvRHX8NkQfjS8un3uykC9cqMpLahtA/RCg=;
        b=nc8sJSrkx1lgrF+UzbP9i2zDtEgS9PnTOyJbJBzFcUte6UdfdrDzEO8iq2/40uo4I6
         +7zeRFrMEmn86e8eOmyB2hqGp9NoeYEDc5A4QU7v8ZUf9jFXs+Szfr1TscCcEqrc04KN
         FX4htAMw6vF3CClAQyBAzjsqztXh20G9L0blvpEirFTXDwIj6QBY70RR8F6XszY2t/QB
         yB3Qux+RhKaYiRA+SMnwPux5QN2VgBZrx4jnSlV4xteTz9u+rbmF/iUBrAMXj6B5VlZA
         n2+c0P6XMxfGuc0pNLzwu3toqSu6H8zkydbeAqahgkYfKAmmKTp9VNHmAeET0h/YF55d
         Yj2w==
X-Gm-Message-State: ANhLgQ3h/dq/clINv4ZABdxVFj1OWvJ4qHhKtcxiVtCRkQC+Fs+Wl0N7
        wq2NbpQGsGxeikhSIj2YSwA/88RpaNc=
X-Google-Smtp-Source: ADFU+vu7FNiwmmJ2Km4l2zlwJKVF3dTORJCs7vzH2pgHEjcdM1sCL/lsv4BaR2zwHrdhPS63I1Btiw==
X-Received: by 2002:a19:98a:: with SMTP id 132mr2722690lfj.171.1583947565534;
        Wed, 11 Mar 2020 10:26:05 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j17sm10472903ljc.0.2020.03.11.10.26.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:26:04 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 19so3241029ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:26:04 -0700 (PDT)
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr2749942ljp.150.1583947564287;
 Wed, 11 Mar 2020 10:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200311160710.376090-1-hch@lst.de> <20200311161423.GA3941932@kroah.com>
 <20200311161551.GA24878@lst.de> <20200311171802.GA3952198@kroah.com>
In-Reply-To: <20200311171802.GA3952198@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:25:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5hFUTG8qEzfJTecND2pSuxe0XcVPMjBpX7f1m19Wjqw@mail.gmail.com>
Message-ID: <CAHk-=wj5hFUTG8qEzfJTecND2pSuxe0XcVPMjBpX7f1m19Wjqw@mail.gmail.com>
Subject: Re: [PATCH] device core: fix dma_mask handling in platform_device_register_full
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Is this still needed with the patch that Linus just committed to his
> tree?

My patch is basically the same, just with the field renamed too, and
not blindly just assigning to "*pdev->dev.dma_mask" (my variant does

        pdev->platform_dma_mask = pdevinfo->dma_mask;
        pdev->dev.dma_mask = &pdev->platform_dma_mask;

instead of that incomprehensible

        *pdev->dev.dma_mask = pdevinfo->dma_mask;

which depends on that dev.dma_mask pointer having been initialized in
a random place earlier).

I had the cleanups (uncommited) in my tree, and just removed the
kfree() as per Christoph.

             Linus
