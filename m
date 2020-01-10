Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D569206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAJQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:46:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54813 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgAJQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:46:28 -0500
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ipxQX-0001id-Vu
        for linux-kernel@vger.kernel.org; Fri, 10 Jan 2020 16:46:26 +0000
Received: by mail-ot1-f72.google.com with SMTP id 21so1312954otk.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQVWx4QNhRD4TIH8ouCI9fTYbhvOJqvf6CUY9/jji4k=;
        b=johWZZ8+h3NpLkkJVhesoi4wrlqUnZ2gyx4WP/joCsIV4Hkl88VN0Czc7tZqYr0S0m
         Kjn6F8IbR/5DJHLtmQE8BNhvnqRciRuK8FnP4KvclhZHJiR4wCMClvLQzg5+ZOGrPQ6c
         QbeLb9b/tHF7QMfYfkcIsNKMm1bG6Ob7+weSMEkz5CvYe7MVyMLGshQAchGVqEig7saW
         2WCTgVGZe0YvYAHQxmh+VnGBXNICsmWoFgHm8ZRPsPuFBR10DYZcu0WJ86ht+FUnc8NC
         0ppsDEVCSe4Fjbpsn7FqnE9r//MaPMzNhugY6X7P/4x/54UZYk76F8le318k9LjQoGmu
         vIGw==
X-Gm-Message-State: APjAAAXDGD68pR99fpyWlBR1H9VsoZJGZ2NTNCIlP2Hz7ga+dhB9CDQP
        vDcUT9IFJsVlyUzXeBcP87MOMc2dpXoPrWGelzM0OCQR4OkgiaiOPdUy/fduqBtIsKUWeJQzJoM
        4RczG7rmrQO4+oc8T/iNJ+ae7reZiYKfLVuehzEKIgifAE8R/Gi2bRD4wrw==
X-Received: by 2002:a05:6808:aba:: with SMTP id r26mr2799671oij.4.1578674784193;
        Fri, 10 Jan 2020 08:46:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzq1MqosWbF4CVhTlVU69vywCAnfgPQvC6kJVir/1da8ItWsx4qTVXuRYH/TzuJwTcRxPDk7Sm9MfunFZqb4Eo=
X-Received: by 2002:a05:6808:aba:: with SMTP id r26mr2799650oij.4.1578674783906;
 Fri, 10 Jan 2020 08:46:23 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p56QynOLJPi3kKiQB1iScrDxj3X1FiycuVF7tP75yPD8A@mail.gmail.com>
 <Pine.LNX.4.44L0.2001101135450.1467-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001101135450.1467-100000@iolanthe.rowland.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 11 Jan 2020 00:46:13 +0800
Message-ID: <CAAd53p7aFKEgic+48EsN=vMjtoyDhVP7HkOMQic20-o9mAY0Ug@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:36 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 10 Jan 2020, Kai-Heng Feng wrote:
>
> > On Fri, Jan 10, 2020 at 11:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 10 Jan 2020, Kai-Heng Feng wrote:
> > >
> > > > Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> > > > bus when bringing underlying ports from U3 to U0.
> > > >
> > > > Disabling LPM on the hub during setting link state is not enough, so
> > > > let's disable LPM completely for this hub.
> > > >
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  drivers/usb/core/quirks.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > > > index 6b6413073584..2fb7c1602280 100644
> > > > --- a/drivers/usb/core/quirks.c
> > > > +++ b/drivers/usb/core/quirks.c
> > > > @@ -371,6 +371,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> > > >       { USB_DEVICE(0x0b05, 0x17e0), .driver_info =
> > > >                       USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> > > >
> > > > +     /* Realtek hub in Dell WD19 (Type-C) */
> > > > +     { USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> > > > +
> > > >       /* Action Semiconductor flash disk */
> > > >       { USB_DEVICE(0x10d6, 0x2200), .driver_info =
> > > >                       USB_QUIRK_STRING_FETCH_255 },
> > > >
> > >
> > > This is a very partial patch.  There were four hunks in the original
> > > version but there's only one hunk in V2.
> >
> > Because the original approach is insufficient, it significantly
> > reduced the fail rate but the issue is still there.
> > USB_QUIRK_NO_LPM is used instead so no other parts are needed.
>
> Oh, all right.  This change looks okay to me.  Has AceLan Kao tested
> it?

He didn't test it. I have physical access to the hardware and I've
thoroughly tested it.

Kai-Heng

>
> Alan Stern
>
