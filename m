Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B8C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9462080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spNyOxSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgH1K1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgH1K1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:27:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509DC061264;
        Fri, 28 Aug 2020 03:27:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f26so711589ljc.8;
        Fri, 28 Aug 2020 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9lkDtTLkGO4tunK9zfL/WiafTkLAKRGScdfHrpzp3JI=;
        b=spNyOxSftXQHpB4Sd8g8X4z8C5IO1ZTMyOsFoosXikVQn7HyGPcWHLis8+XCxg8x0x
         HLdKXM8I3erEmOcY/9eHeYUlr5oySoV0rmEsf/SXrQZzI8NXe5LxG/Prsk/d7JleYVn5
         tccBNcpl+6Nc+enEpm58fJ8zYDlO+1deYvDb6MdyqQ2LFzev3va+VdaKjadspPdsNoJU
         9e5W8jI8t4VJfqIUcU2zK5SlZQ4WUFrxXd9VsRL5iGdsHW3dfaa/VHvUJ/xUBISvnPhs
         86rkMjvNn54zPjANcWI4Yoddi+kxaDENxbUglwUFAdpqSZy4pZTC5l7o+psJBs31MaLM
         Ib3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9lkDtTLkGO4tunK9zfL/WiafTkLAKRGScdfHrpzp3JI=;
        b=Or5okKLArD47X2vDeXLVXB2TLRVzKwPMx6euetdBqh07hyXoS7P3uzlZgtAXCGnqj5
         XaRMHZOxbyrtfiPmomy9B3n3WjTs1k5Ol6qA17PmOQfCR1Ujny4ARMclMX2w+SUH7Hra
         ML8PZrxz0zgmoGdgMzBHFN8qtSmozoyrKtlUtYz0UOpmzxhSChIlOmMrbtWHMc7TOg8n
         8bHsD9kNmPRAgL7ZZou20hDJ2HAeqOzTiQHgQmd3xo5T1GjF8ph/PM5B/bHHv2VKfoyX
         J+T03RzCV23eMKbgZdW8OdzuAXNck+Ou5uFUjFZpvlONGna5+Yb3kE+brZeGLwZArOwN
         p6ug==
X-Gm-Message-State: AOAM531xz+Ci5q5Uwo3H5ZvwEtncMn4uLFQFLQOD80aDeoDWUuKEUHjp
        g/4j2asGJ6rHjSA1v06UsWOnitF44J7fh2CnYdo=
X-Google-Smtp-Source: ABdhPJym9/rev86EcxGFP4d6ftha9uJUJcdwhmiamaAHPf17cUq+zUwL7bIUrFoz/Ydafu1saf4+BKlVaVOJXTmXCQs=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr531200ljn.356.1598610458337;
 Fri, 28 Aug 2020 03:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
 <20200827140001.GE813478@kuha.fi.intel.com> <CADiBU393V_iQw_8Hx2braL=8QpvQuTY0059C-XkqmjO9W=aBgQ@mail.gmail.com>
 <20200828093835.GC174928@kuha.fi.intel.com>
In-Reply-To: <20200828093835.GC174928@kuha.fi.intel.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 28 Aug 2020 18:27:26 +0800
Message-ID: <CADiBU3-S025q10WYzLk+v2K-5V+iTP=zDu4i8srTpHQvRkm0UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2020=E5=B9=B48=
=E6=9C=8828=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:39=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, Aug 27, 2020 at 10:51:43PM +0800, ChiYuan Huang wrote:
> > Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2020=E5=B9=
=B48=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:00=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Aug 27, 2020 at 07:18:55PM +0800, cy_huang wrote:
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > > > It works with Type-C Port Controller Manager to provide USB PD
> > > > and USB Type-C functionalities.
> > > >
> > > > v1 to v2
> > > > 1. Add fix to Prevent the race condition from interrupt and tcpci p=
ort
> > > > unregister during module remove.
> > > >
> > > > v2 to v3
> > > > 1. Change comment style for the head of source code.
> > > > 2. No need to print error for platform_get_irq_byname.
> > > > 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> > > > 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> > > > 5. Rename DT binding documents from mt6360 to mt636x.
> > >
> > > You don't place additional changelog here...
> > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > ---
> > >
> > > You put it here, after that '---' marker:
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#the-canonical-patch-format
> > >
> > HI Hekki:
> >      after reading the document, I have a little bit confused how to
> > use diffstat for the changelog.
> >       Is there any example that make me know to write a clear
> > description for the changelog?
>
> Picking the latest patch from linux-usb ml. with version history:
> https://lore.kernel.org/linux-usb/1598083553-31896-11-git-send-email-chun=
feng.yun@mediatek.com/
>
> See how the last tag line "Signed-off-by: Chunfeng Yun..." is followed
> by marker "---", which then is followed by the version history (the
> version history is then also ended with the marker "---", a step that
> I don't think is mandatory, but commonly used and often recommended).
>
> That way that patch version history does not contaminate the actual
> commit message.
>
>
> thanks,
>
Ah, I already send the patch v4, I only add the changelog after the
sign-off --- label, but forget to add --- after changelog ended

Please let me resend the patch v4 to add --- label after the change log ede=
d.
> --
> heikki
