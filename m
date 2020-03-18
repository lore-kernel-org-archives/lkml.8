Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E819C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09E20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOnwiiMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRDcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:32:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36347 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:32:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so25395372ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rk1TNn9ccL64hLpFaQmDzETAL+uZeDH4VFQOlNX0f9E=;
        b=JOnwiiMYFQXtb2xnbGwhKz2wC2VxNj9jz34jNn6+JFXWTYBEuuhSpw7vmLqyqfR8I7
         zExlhZ11nargyUNu4yQs63Nd52Y5BorRDxLkhY1n4VFcMoJ+3q2JJB5i5OhkUn9dGBDl
         ksKn4N4/9yCDI6+ZSGaOo2/gOB6ODxXI8uDT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rk1TNn9ccL64hLpFaQmDzETAL+uZeDH4VFQOlNX0f9E=;
        b=KcpIIFeXwk4PyovBVpWopVpP+vwiB4rVkGKQCGooexpopCVFKRxNHziyiS3dpNRFZn
         02ATNeF3H+SEO8MnI8xH1xKTleBf0A7+q53snlLOy/noM7JoOyeBUu+16Pi7S6xIEh9M
         Z8USkpCF6ojCSsB3V6k4MEMwFCeMEVyNZ+GhZ1OqUSxhzqaX1DeS5XupbEKsHRwHQieY
         RIMY3jnyCRrsU2z6808oEzpvw3LrOBR/+SUm5LuxHJR5HRT9xlRU9uUvyvvssvWP+wnH
         uoC16N1T0T2dB1hib45kFUsiV92w4C2rp74A/swJ2OBVj7fzrEn3TF38iKgMK2YOgiFf
         EUrA==
X-Gm-Message-State: ANhLgQ39Mnf5vvwfdX0k/eJq/F1SQ+YgB2Lp0WiS2AvWPoRcRnmhk/xI
        VM0+hmfRTnKu1lCmWJ8w0pvKWkgVjkn72Z20kcl/dw==
X-Google-Smtp-Source: ADFU+vvhy/JGNfeAuOfif/EtDsFzaiV+uyNdlFFtcUZMOyA/iNLYdOOxOXQ1YzX96Ht4w3nQeYJ2t8XKn5zw3nK1fIQ=
X-Received: by 2002:a2e:9214:: with SMTP id k20mr1105319ljg.157.1584502321247;
 Tue, 17 Mar 2020 20:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200317042216.20623-1-rayagonda.kokatanur@broadcom.com> <20200317192916.GA708@MININT-65B7IF6>
In-Reply-To: <20200317192916.GA708@MININT-65B7IF6>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Wed, 18 Mar 2020 09:01:49 +0530
Message-ID: <CAHO=5PEindrDHk6oLLQvHup3csnrTGqUe8SMO0RqaNX7f_rztA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] maillbox: bcm-flexrm-mailbox: handle cmpl_pool dma
 allocation failure
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:01 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> On 2020-03-17 09:52:16, Rayagonda Kokatanur wrote:
> > Handle 'cmpl_pool' dma memory allocation failure.
> >
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> This looks correct to me.
>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>
> It would be ideal if we could include this tag when applying the fix (or
> sending a v2):
>
> Fixes: a9a9da47f8e6 ("mailbox: no need to check return value of debugfs_create functions")
Thank you, added missing Fixes tag and sent v2.

>
> Thanks!
>
> Tyler
>
> > ---
> >  drivers/mailbox/bcm-flexrm-mailbox.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> > index 8ee9db274802..bee33abb5308 100644
> > --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> > +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> > @@ -1599,6 +1599,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
> >                                         1 << RING_CMPL_ALIGN_ORDER, 0);
> >       if (!mbox->cmpl_pool) {
> >               ret = -ENOMEM;
> > +             goto fail_destroy_bd_pool;
> >       }
> >
> >       /* Allocate platform MSIs for each ring */
> > @@ -1661,6 +1662,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
> >       platform_msi_domain_free_irqs(dev);
> >  fail_destroy_cmpl_pool:
> >       dma_pool_destroy(mbox->cmpl_pool);
> > +fail_destroy_bd_pool:
> >       dma_pool_destroy(mbox->bd_pool);
> >  fail:
> >       return ret;
> > --
> > 2.17.1
> >
