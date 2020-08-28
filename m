Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B727207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASiPmnut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgH1OwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgH1OwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:52:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF8C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:52:05 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e14so704472vsa.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmW/UzfIpiqxIVOvn5t5U7Hz6pKUYnMVNjjF5Y3VXtc=;
        b=ASiPmnut8ciHDn1eSNZN++Q0EY9sH3AlBER8f194LxUx7jFUhiZzA+dHhYDJe9W8Au
         A6ww7IdEnLBpDyW+d1rISSIosnSHvUGxstDL8aY4ECfWCKliS/yftWa+Z1Wh+qDLcS44
         PNLPuzuGVLk1e/7BL/tLO4+bGfz6TWrbQZre2HTRo/wJTXOml58huo5DUJIaiXwx9wEv
         vOBD2caU600iGI5oR6r0Jz+TPCcpek7SzfwI2LmIl/3cutVX7uqCFbn6NvS/rWCjOoE4
         6T+OPEShQMiP/pEhX4QitVQpQEqgFjPUSkjmJ4aJA2V0+SsLpIDUKxxPIYKwqoxMCBDS
         BJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmW/UzfIpiqxIVOvn5t5U7Hz6pKUYnMVNjjF5Y3VXtc=;
        b=JWcWuDPfs6/wcnn8+yJ1wIML6syuC8Oh1CTV4NYtB+aUusSwsUz3CLw9pI1IWtGZnO
         8XFq6N5lwf0GVjNhlMXGgveDgVY8cBwXNrHxZbYbf4PfPUB998FSoQfl34JBbRAS1ylB
         eloswQWZZnUc2NI1YugBNTmRIcL2yL567P78fdBODIUJ1AmqAo6Rl2A5FeSTgXv3q5IU
         bDxbsxw4minhs/4ixZpM6wp+cKwwGM5/GCKZP8bKmBf8+2ovvUMKDTz+XaUpWWCzmvNQ
         nJ+3eqNME/WPZgmsGV/dT+xVGqecRUnecp+JbqCpx7J01anfvKlUZLYQyM/6ibC1XNY0
         d5Bg==
X-Gm-Message-State: AOAM531zootcgETJR2VtHNB2Af5UliIatE+u8l+E1HKHKcxIcy5Hf0HU
        h63kLJelWjhthzEnDJB2inLJczUiFQSN72XdEzGvpA==
X-Google-Smtp-Source: ABdhPJxPLcaFKo8fXT9ratgxwY2hdZT7QpICZojESZhKVTSgGJCpiS5lrKCfG4YYue2Q/mEVwjb/FVS4d0AGzNdzj5Q=
X-Received: by 2002:a67:e449:: with SMTP id n9mr1036754vsm.118.1598626324771;
 Fri, 28 Aug 2020 07:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com> <20200825042210.300632-8-badhri@google.com>
 <fb1a7030-2649-c0cf-dd2a-651516333da7@infradead.org>
In-Reply-To: <fb1a7030-2649-c0cf-dd2a-651516333da7@infradead.org>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 28 Aug 2020 07:51:28 -0700
Message-ID: <CAPTae5KiP7DGJ8V0xtt3k0GUD6VtTBqCJzm6G1NGD+JrOexmXQ@mail.gmail.com>
Subject: Re: [PATCH 07/14 v1] usb: typec: tcpci_maxim: Chip level TCPC driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:16 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/24/20 9:22 PM, Badhri Jagan Sridharan wrote:
> > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > index fa3f39336246..7c9722b02afe 100644
> > --- a/drivers/usb/typec/tcpm/Kconfig
> > +++ b/drivers/usb/typec/tcpm/Kconfig
> > @@ -27,6 +27,12 @@ config TYPEC_RT1711H
> >         Type-C Port Controller Manager to provide USB PD and USB
> >         Type-C functionalities.
> >
> > +config TYPEC_TCPCI_MAXIM
> > +     tristate "Maxim TCPCI based Type-C chip driver"
> > +     select USB_PSY
>
> is that        USB_PHY
> ?
Yes and not a dependency here. Will remove. Thanks for catching this !

>
> > +     help
> > +       MAXIM TCPCI based Type-C chip driver
>
> end that with '.' please.
Ack ! will fix it in the next version.

>
> > +
> >  endif # TYPEC_TCPCI
> >
> >  config TYPEC_FUSB302
>
>
> --
> ~Randy
>
