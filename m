Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF919C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F820702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrwygqyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbgFXBmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbgFXBmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:42:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:42:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so419733lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH0tAGQq1BBULbJhaRLZe9wibhEE9CPMcxPoeDgsIXo=;
        b=hrwygqyviHvNHNSuFUOOEL2dFdviH/PkTR9095I5sLIWWon3BfVE5WtNasNL58ejFi
         KXmGstLaOPg5DhsugMicAwdqFzAXlOXN6dkqbSwjRCkxOXrqT2w5hMBnYEwHqXg57BOI
         2ZJg37z8FMid4xpU+DQA5kZMQxx45fJSUAeo3gFDfL21g2tHNXS3eK+kjTTANcDyZYmf
         kFCM0kyW4N9Yp35+BgyoIBy9xeTWzIQz+RJgJ48kUi+Hvsl/YnkZbQwZE5+qpAKxwnjS
         cf+yVF62mnl5qGtUmesukfF5lRL85urJdXPtdVC5PGB1yBSH1u3Y+TvWMOVg4KwnVCfj
         alyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH0tAGQq1BBULbJhaRLZe9wibhEE9CPMcxPoeDgsIXo=;
        b=Pn385hrH49kYlFtNSYqztwYS4DB/CeiE6NBAqKjNagU+BNq6IfEvW4ycVCuu1HOIOC
         9OoCqqvK84V+ja4K2rp1ZyRXT9wy6VLZVPRd31mFatvIqc6MHL4yul+HrgOohZ3pB/Pn
         SOnKG+yMxA8Kv3nDSMejAfCl922UY4Z0H7m2n4yE/jjdRRVv1wJmgS2JxjbrKavCY4KK
         c5bBbSRjXmhYIOq7Y2xwt3fDd6hnTB+RR40+PTRBtmXmATwV2aYVOXrHBW9l5kJkMcZm
         MV9Xh89e0g/YShsij/YTQ+2haZlqKG+/ldYUJVre5LWn8u3w1bDZ0VoGzjNFiBlSgUo5
         htvw==
X-Gm-Message-State: AOAM530iyBdUkdQTu5s/L7EZJGlrSckf78sXtIMSVyGYWT8OBvW3zvw/
        i24Ifv2r7ze7bmDPOZR8/AvYFS0fjQIVRs8cIkU=
X-Google-Smtp-Source: ABdhPJyy+b/yipYHxlc6xRvYIDGHu4kWqUlayegQPNvTqrwy+3hA/s3GRg5U/CIbsLOyGvmY5pWvHCgeTuuYlI1FNA4=
X-Received: by 2002:a19:6c6:: with SMTP id 189mr14091743lfg.94.1592962925767;
 Tue, 23 Jun 2020 18:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <1588709912-8065-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1588709912-8065-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 24 Jun 2020 07:11:54 +0530
Message-ID: <CAFqt6zYiiDpZE9poaEXShmWfqwjYYKa4tRqBhiaLMBPdvynWZg@mail.gmail.com>
Subject: Re: [PATCH] VMCI: Avoid extra check for access_ok()
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marshall <hubcap@omnibond.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, dvhart@infradead.org,
        sgarzare@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, May 6, 2020 at 1:40 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> get_user_pages_fast() is already having a check for the same. This
> double check can be removed.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Does this need to be marked as stable ?

> ---
>  drivers/misc/vmw_vmci/vmci_host.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> index ce16d6b..2d8328d9 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -233,8 +233,6 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
>          * about the size.
>          */
>         BUILD_BUG_ON(sizeof(bool) != sizeof(u8));
> -       if (!access_ok((void __user *)uva, sizeof(u8)))
> -               return VMCI_ERROR_GENERIC;
>
>         /*
>          * Lock physical page backing a given user VA.
> --
> 1.9.1
>
