Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93401C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AC920740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeD6Nm2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgEMMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEMMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:06:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:06:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so16421289ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rqWzzkOtBCpmgaVCKpj7+jaGD37zCFqeMtexNP5QRuE=;
        b=qeD6Nm2mKPVu1exoYnpXJhhjBKHZdaUMDm2AWDFhZys9RnaspB+P9VkYujGl31nKqn
         WagkYgVtSZCMVipmZjuysPlRWLkGigdsNodZaDhc8L2KEn/n+Aw5NlowCNryZdhwjJuZ
         I9a/eMvfwWEwNfBAin+KyqE8TYwXYIKwsKK5kx0W4srvRYKEU6cic5if37CexbOe7xS0
         bzXvtii3T3raofA0lLhK649Whj5GXdeYkJEF+6/JSFgiGI9sB03QalwmwGx5+Beo6eyE
         B8IRfi1FpydyMtcRG9+Cz8cFmpY5Io9Gk1UvzF3XnQ59sCTh9fi8i9S9h6NmsJmNxg4i
         Tgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rqWzzkOtBCpmgaVCKpj7+jaGD37zCFqeMtexNP5QRuE=;
        b=WVskLeRH1xRu3KLMzme/zcoIgoNdfK0W3VGc4e8XMK65+2zxdICOdKBwniiO97B9pA
         9sM9cOnI1HXNPxQ39LN8LsdASM4Yn/VpKWAhjsUDEs3S0p5lGX8+6p2uJGpHtT8ozu88
         ftjdskaSoyl0/e9gciEKfk5ez25ecPOno0BZy6fk6iZkNp/6H36IeOf9CH4L9k0H83lR
         vgcuKC41FQlY+HrJZXQynrVbepooebwd9Ypz+7LKZHGgIOjpCzg4z8iN0eTPryC/P/KI
         2w5/Cm0gu/7UVi9RbQP9JdwNjPnOZ790k1iAlCQGCJnjReNvaDgg1ZVxku4WcjoyglnS
         m5Vg==
X-Gm-Message-State: AOAM531ovPTF/awgV1DT95naxea8QWaC3RTHLLJSZfNsJKWcsFE0Dx+9
        Yq1QK9q4FNzfV4LjI+hr1UpYKc3Za+JnVqont/nlYvrwtxA=
X-Google-Smtp-Source: ABdhPJySqd5aKEee2N8mNCkrbF8REchFhQ7yF5jLHkOX7270Pxv7mqJsGVq7Ix9WFSznPLx8EacrYqvbMQJ7yygKp68=
X-Received: by 2002:a2e:8590:: with SMTP id b16mr17846575lji.45.1589371579390;
 Wed, 13 May 2020 05:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200510101308.10451-1-john.oldman@polehill.co.uk> <20200513115823.GC953616@kroah.com>
In-Reply-To: <20200513115823.GC953616@kroah.com>
Reply-To: john.oldman@polehill.co.uk
From:   John Oldman <john.oldman60@gmail.com>
Date:   Wed, 13 May 2020 13:06:08 +0100
Message-ID: <CAMJX__Qx_MyOmqiphz_Fg0X8itu8PDtNNpFTKqxGabK6v1bsLg@mail.gmail.com>
Subject: Re: [PATCH V3] staging: vc04_services: vchiq_connected.c: Block
 comment alignment
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Oldman <john.oldman@polehill.co.uk>, nsaenzjulienne@suse.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yea I agree, will re-submit...
Cheers
john

On Wed, 13 May 2020 at 12:58, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 10, 2020 at 11:13:08AM +0100, John Oldman wrote:
> > Coding style issue
> > This patch clears the checkpatch.pl "Block comments should align the * on each line" warning.
> >
> > Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> > ---
> > v1: Initial attempt.
> > v2: Resubmitted with shorter comment line, as suggested by Greg KH.
> > v3: Resubmitted with descriptiuon text moved into the comment area.
> >
> >  .../interface/vchiq_arm/vchiq_connected.c     | 32 +++++++++----------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> > index 1640906e3929..993535bbc479 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> > @@ -15,10 +15,10 @@ static   int                        g_once_init;
> >  static   struct mutex               g_connected_mutex;
> >
> >  /****************************************************************************
> > -*
> > -* Function to initialize our lock.
> > -*
> > -***************************************************************************/
> > + *
> > + * Function to initialize our lock.
> > + *
> > + ***************************************************************************/
> >
> >  static void connected_init(void)
>
> Shouldn't that really be written as:
>
> /* Function to initialize our lock */
> static void connect_init(void);
>
>
> No need for the /****** mess, and no need for the blank line.
>
> Simple and clean is best.
>
> thanks,
>
> greg k-h
