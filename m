Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF13C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E6920747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOw3yLgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgGAGCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGAGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:02:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC89C061755;
        Tue, 30 Jun 2020 23:02:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y2so23733102ioy.3;
        Tue, 30 Jun 2020 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apnFSdbPwF1o56s17ulMPEE2hZAsrJ4zcexv/p3RBbU=;
        b=OOw3yLgsSxtLJh3tTP2bz7gfpJCG+yblTyab9ix6/mnkZMBzDR6KuDI8jMoyAtd8DM
         QwhunX89zS2/hRlwRfn+hBaKPKlKlpsM7xc+6qzV/FCWhqte7DMlSLlLXulq95PCYSnP
         4at/vGEf15PFaLAIiqHC6ZiG85eF973yQaCUorLTuZ6qSGxkxscDQPdA2uR/j20e9FML
         0Lfkkoh5Xpb5Qv2LE80DE3oqASDrBbpF3IruiU0Sahbvy5HMRvLPT1oDXnCMaO8Jzlom
         al4y2mGHk+EMaKndcOjtHznNgtUVb7QtbHLJOCEVcqFXci5k6OWRnqTlyUY1p5L7raGM
         kCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apnFSdbPwF1o56s17ulMPEE2hZAsrJ4zcexv/p3RBbU=;
        b=fHZEp72rG8FLmYUNJP6N9kK+QI1ZbKZp7V+vwoaOqAaB0iBkWzLoWQknsgv9RqLsq7
         +wJEKExrddKj9nEJbBKJLGX1o9bs1rUgHrXIzIqiWFCZqjta+v5Ntnye/Keztlk56fk3
         tPgKrAm3Z1oldLO89se8OCw1kWXsZzNF8DbewVfw80f2UKWQi9b2M1msnOm9Pst70VGf
         iUxBLcXnBSTekIA9nmpz9DfOA+akCWIKlbYRPXFOOIloINw0MUQtL3oADLACfQsYWyiG
         8e/hkBTCY2gtz+Ah/GuaiXfzyH7phSJ3XKu05Yt4U7wqZVTND7qdtnUPsjc5p77eD6zK
         TY4Q==
X-Gm-Message-State: AOAM532e0a4jALY4QFW4iC6gZ5t6vI+0X4aIB5YWk2YY95ZBUjEk7ly2
        5oZ8/idFG4JCSwmgM9zJvKzaZ47rmxORGXmDGkYD0Q==
X-Google-Smtp-Source: ABdhPJxzvO3VNMKGQCSeCdurw0pLCbkKFbJVum2RNr7viC/winzObjCs3nC8XeKtYmRNhrnf20I/dXuau8Y58Ti04ys=
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr711199iow.28.1593583333268;
 Tue, 30 Jun 2020 23:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200630174123.GA1906678@kroah.com>
In-Reply-To: <20200630174123.GA1906678@kroah.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 1 Jul 2020 14:02:00 +0800
Message-ID: <CAL411-pgboix6=1=jKNv_4JaHiC8fKDJ4_mryooMepeHdB-2AA@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix up terminology
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> index 3a7179e90f4e..1a12aab208b4 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -474,7 +474,7 @@ config USB_DUMMY_HCD
>         help
>           This host controller driver emulates USB, looping all data transfer
>           requests back to a USB "gadget driver" in the same host.  The host
> -         side is the master; the gadget side is the slave.  Gadget drivers
> +         side is the controller; the gadget side is the device.  Gadget drivers

'the host side is the controller' may not be suitable.

Peter
