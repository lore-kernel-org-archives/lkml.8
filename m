Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09AC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0931C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgAJHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:35:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAJHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:35:53 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ipopj-0001Jw-R5
        for linux-kernel@vger.kernel.org; Fri, 10 Jan 2020 07:35:52 +0000
Received: by mail-ot1-f69.google.com with SMTP id 73so538732otj.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkFahSTywvqn5j5X/7juimxnMuGVeAK18BGmio6HoZw=;
        b=Nd8TfAOT6qvIoIhpODSKxl17t+p9YOubCFyjR67fNE0G6r/DpV6DqykWlQiuf3KOQT
         C2e/PGYoXw0MFpeHZm6LcrQyOqQMHCN7lKk7GfhW/a9SV1S5EPqRNpofufTAk1QNOS5K
         IuNvLjC/mU++8KlMEX4WWZCFlo3E2MprTm1iUJhM2DE2S4Jderry3ck77mqdhXyMZjNI
         qzJrIXH1L8brKcED5a2YWfUa50aTZLEhzjaXs9FGfvUUbBwVjdXgghOi2g8vk3GJ+7l/
         dgtn5Mq3GTbAaLjAYYgzXaJjsLR9GpcI4jUlvWjBxBt6770Ovi9frBfK4jX9zafuRNUN
         3BLQ==
X-Gm-Message-State: APjAAAWvKMMSJuA+RfVsPhL3HXXf83rOeuh0+Ipi8ly3nBNUAUmirerv
        SF6u5e2v6Zus/OKYzhad9ZPtTYPrWT9ARQK5yD2XfpavIUDdt5Pm9vsjrfI8/1VBOkgqX6Ae3eR
        GXXOv5zSLQ5cEiy522Cm4nP+C5athiLW0H3uRpAuhP5dKy4l44XuD3lmOPg==
X-Received: by 2002:aca:2419:: with SMTP id n25mr1229246oic.13.1578641750557;
        Thu, 09 Jan 2020 23:35:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuBy33kewJNyY+KyNet6/qLs+DSuqtwhqq5q4SMD4TyxqUukaZwkF34vIpgcwDcgi7iTsY1+4vIVHFbRMI5sk=
X-Received: by 2002:aca:2419:: with SMTP id n25mr1229235oic.13.1578641750299;
 Thu, 09 Jan 2020 23:35:50 -0800 (PST)
MIME-Version: 1.0
References: <90B37743-30D1-41BB-8272-D5FBDC89C88F@canonical.com> <Pine.LNX.4.44L0.2001061007070.1514-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001061007070.1514-100000@iolanthe.rowland.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 10 Jan 2020 15:35:39 +0800
Message-ID: <CAAd53p7NhhQL=5teoaLQ4r5Y-QDGysGoXS-wwGc1fh59rfYu2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
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

On Mon, Jan 6, 2020 at 11:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 6 Jan 2020, Kai-Heng Feng wrote:
>
> > > On Jan 5, 2020, at 00:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Sat, 4 Jan 2020, Kai-Heng Feng wrote:
> > >
> > >>>>>> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> > >>>>>>        }
> > >>>>>>
> > >>>>>>        /* see 7.1.7.7; affects power usage, but not budgeting */
> > >>>>>> -      if (hub_is_superspeed(hub->hdev))
> > >>>>>> +      if (hub_is_superspeed(hub->hdev)) {
> > >>>>>> +              if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> > >>>>>> +                      usb_lock_device(hub->hdev);
> > >>>>>> +                      usb_unlocked_disable_lpm(hub->hdev);
> > >>>>>> +              }
> > >>>>>>                status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
> > >>>>>> -      else
> > >>>>>> +              if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
> > >>>>>> +                      usb_unlocked_enable_lpm(hub->hdev);
> > >>>>>> +                      usb_unlock_device(hub->hdev);
> > >>>>>
> > >>>>> The locking here seems questionable.  Doesn't this code sometimes get
> > >>>>> called with the hub already locked?  Or with the child device locked
> > >>>>> (in which case locking the hub would violate the normal locking order:
> > >>>>> parent first, child second)?
> > >>>
> > >>> I did a little checking.  In many cases the child device _will_ be
> > >>> locked at this point.
> > >>>
> > >>>> Maybe introduce a new lock? The lock however will only be used by this specific hub.
> > >>>> But I still want the LPM can be enabled for this hub.
> > >>>
> > >>> Do you really need to lock the hub at all?  What would the lock protect
> > >>> against?
> > >>
> > >> There can be multiple usb_port_resume() run at the same time for different ports, so this is to prevent LPM enable/disable race.
> > >
> > > But there can't really be an LPM enable/disable race, can there?  The
> > > individual function calls are protected by the bandwidth mutex taken by
> > > the usb_unlocked_{en|dis}able_lpm routines, and the overall LPM setting
> > > is controlled by the hub device's lpm_disable_counter.
> >
> > For enable/disable LPM itself, there's no race.
> > But the lock here is to protect hub_set_port_link_state().
> > If we don't lock the hub, other instances of usb_port_resume()
> > routine can enable LPM and we want the LPM stays disabled until
> > hub_set_port_link_state() is done.
>
> That's what I was trying to explain above.  Other instances of
> usb_port_resume() _can't_ enable LPM while this instance is running,
> because the lpm_disable_counter value will be > 0.

Yes you are right, there's actually no race.
The hub is still a bit flaky with this approach, so I'll resend a v2
to simply disable LPM for this hub.

Kai-Heng

>
> Alan Stern
>
