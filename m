Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D186C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3A20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgAJPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:52:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52914 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:52:14 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ipwa3-0005uL-EB
        for linux-kernel@vger.kernel.org; Fri, 10 Jan 2020 15:52:11 +0000
Received: by mail-ot1-f69.google.com with SMTP id e22so1237765ote.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8/Y2cObCbtCE26judrO9UsDxGUStHvjaWi0HH63cZM=;
        b=PCdGkb01BXJHTjcW9EGy+iWhBf/3cC7W1iXQlht31V1I1+eRY9b+M1fOgSwVa3C7qs
         CwtwJZRNftTavOIfIl5tzpL2LKRLmMXbJ8JG63eSGaxYGcKagUlLF3PGCl+GzbWLSR1D
         FQFAGiD367mM6kw0yf1cGh6xLW7v7cGuqasUMog0pztoBw6+SLXMZdSdBQdxIcPXsm3Q
         Kl2el2tYb+AnYO8gNss0ZkNGVQiAeIyTxn/Oc3uAv3hlRueiHwROJq/Qfbyv/LdvKYUI
         0a0P1ReCKK8kjI6cIjpqnuJS15JMWisgCnIHtEjTXmoO+ycABLRxRpICg9W7EPozcvpf
         h1+Q==
X-Gm-Message-State: APjAAAUqHx1+dlKqoUdmAhlc636uaGm2P7iQp8KaSscPNx2IpG+AibZn
        QwLGUGMy+j2YcEXHqSiS5rtHkmYRmGudRXkFbIr3tRy7Zz35INoZ4D3z5bX0Sna64trXycZm1sU
        Uyr0UA4thoLSwp/wmb54rbKdgUwX3wnT81EUSMS54tC7s2VBTb9Xojuhcjg==
X-Received: by 2002:a05:6808:aba:: with SMTP id r26mr2610247oij.4.1578671529981;
        Fri, 10 Jan 2020 07:52:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4U5/Eei+IKj5uy59q12wc0wosUa0qQS+sc9rlFDM3l2mJyPy8NllwB2mPtnNVYhYREH4/IfvIF7a3u3WJDxw=
X-Received: by 2002:a05:6808:aba:: with SMTP id r26mr2610231oij.4.1578671529690;
 Fri, 10 Jan 2020 07:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20200110080211.22626-1-kai.heng.feng@canonical.com> <Pine.LNX.4.44L0.2001101038390.1467-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001101038390.1467-100000@iolanthe.rowland.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 10 Jan 2020 23:51:58 +0800
Message-ID: <CAAd53p56QynOLJPi3kKiQB1iScrDxj3X1FiycuVF7tP75yPD8A@mail.gmail.com>
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

On Fri, Jan 10, 2020 at 11:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 10 Jan 2020, Kai-Heng Feng wrote:
>
> > Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> > bus when bringing underlying ports from U3 to U0.
> >
> > Disabling LPM on the hub during setting link state is not enough, so
> > let's disable LPM completely for this hub.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/usb/core/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 6b6413073584..2fb7c1602280 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -371,6 +371,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> >       { USB_DEVICE(0x0b05, 0x17e0), .driver_info =
> >                       USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> >
> > +     /* Realtek hub in Dell WD19 (Type-C) */
> > +     { USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> > +
> >       /* Action Semiconductor flash disk */
> >       { USB_DEVICE(0x10d6, 0x2200), .driver_info =
> >                       USB_QUIRK_STRING_FETCH_255 },
> >
>
> This is a very partial patch.  There were four hunks in the original
> version but there's only one hunk in V2.

Because the original approach is insufficient, it significantly
reduced the fail rate but the issue is still there.
USB_QUIRK_NO_LPM is used instead so no other parts are needed.

Kai-Heng

>
> Alan Stern
>
