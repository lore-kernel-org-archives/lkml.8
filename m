Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D4AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A48E2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTA3SJS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgH0BL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgH0BL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:11:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0ADC06179E;
        Wed, 26 Aug 2020 18:11:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so4500174ljn.11;
        Wed, 26 Aug 2020 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/8pB8Sw21i7XQLubODjblLQyuDRrCYhn+Eq3ZDQVx0=;
        b=TTA3SJS1N/caMZX9Nag1kHB/iT0fK4yOYmxP3aMRd75Z2BueqjS4WGzvX3hU8cgNYw
         br9qLPus7nDMRlbM630MvGiWgR1tFlr7ZG7v8SNBu0iNMCvRVjwsOqIkMyz8/8fUKaIx
         C6hGhspEoFOxM6rUY5ERS3UNGItKKusEBXK6LvtdJK9W/07KMy6mXl8uaaEVjKS4knsy
         bXY4/ngTaCKfitIuKfJkwr4X4xSCDpUlXpf+EOUZN6EZwNhHrX7mHfgfrp4hX3TLmvib
         E3oxNcnZGr5WYLHtA4bAkRY6e6wnO+UOegOwN9VrxZtijgjOT8pY3w02NPCumMMjc8BF
         JhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/8pB8Sw21i7XQLubODjblLQyuDRrCYhn+Eq3ZDQVx0=;
        b=K5yngT98r+vREXxXPrOdi/O2dEdhF+/hh0jafnKIWoGgvU4xVC9zWi0zAQWZoVCm1W
         E+2uouZH94MCE4AyVprcgLT2nz9pilUiX7aSaCNzOJ30G3LUBHn2fIe0udurtkbAhQ6u
         mWeLlANMrfFeKp4Yp2NrrjJ3H8mJzTLmdV9Cmq//w7/g0N0XUi5XdGF1HrVGAx7IC+Lf
         cT3xinf5nPE8+5CMSixYl1MnpVkPNv61cy7FzwUMV2QnmZKqJJqd5l9BpnMsE5PTvbry
         QHdlO1lNGLCDfVocgJ9GV/VxdHNPNOH31/Mbv010MYyw5lxFSITSK+0gkeiarEZKZwt/
         mjsA==
X-Gm-Message-State: AOAM530Nzfdb4LEKUIU+kntjjnyt+t5WUuzXyu+YhMxv4f+nUTv4hkiy
        8RmM1DwJvc2v48mfxTV0pXHTQAImlCJNexjJJDAtF3qtLqU=
X-Google-Smtp-Source: ABdhPJydzD1WwH6+x47tyNqs5lJxZhmJOXy71zWRsrVhFlJb3UW8drng/iudHsH+0nuncrCwHunivBrN3aq1Cyaa5dk=
X-Received: by 2002:a2e:2c0e:: with SMTP id s14mr8994396ljs.28.1598490716116;
 Wed, 26 Aug 2020 18:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <1598440602-8648-1-git-send-email-u0084500@gmail.com>
 <a7d1a5d9-97e9-bcf6-23f4-2c4be356913f@roeck-us.net> <CADiBU3_x5-P8A0erchFpWucX4_R8M01-CdOJv38FjrPGSn+55A@mail.gmail.com>
 <627dd188-9379-1179-432e-b53948052823@roeck-us.net>
In-Reply-To: <627dd188-9379-1179-432e-b53948052823@roeck-us.net>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 09:11:44 +0800
Message-ID: <CADiBU3_GX+BvxQCDkMtf70sXHnwFVNmBCJsrydROHjy5Lr9B4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/26/20 5:59 PM, =E5=95=9F=E5=8E=9F=E9=BB=83 wrote:
> [ ... ]
> >>> +static int mt6360_tcpc_remove(struct platform_device *pdev)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti =3D platform_get_drvdata(pdev);
> >>> +
> >>> +     tcpci_unregister_port(mti->tcpci);
> >>
> >> That leaves interrupts enabled, which might be racy
> >> because interrupts are still enabled here.
> > M..., yes, it will cause the race condition during module remove.
> > I'll add disable_irq before tcpci unregister to prevent it.
>
> Or just set TCPC_ALERT_MASK to 0, as in tcpci.c.
Both are right, Thx. I'll choose one.

BTW, it seems enum typec_cc_status is used by tcpci.h.
If I don't include tcpm.h, it will raise a warning during the compile time.
>
> Guenter
