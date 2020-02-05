Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B92FC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4A72072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIe94Htw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBEUhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:37:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33721 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:37:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so1825527pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:subject:to:user-agent:date;
        bh=JA9U3lMcjVD9b5RIjVPhWH5ezNuBP6H4YZzYXXPJPIc=;
        b=KIe94HtwlrPW5pdT9hCyAKjlKGKec/Ct0Rq/apcA7FZAxc6SYDoxf1RDptDgNpwSzt
         9Qf+NOvupRHGsZL51gD/SmipATp5JsaDFOvsJJhZU59GE5JXzBfZZvGCMOWGt+ZMje7c
         udPE/nsMmS1jd8j4HNsPIp7QUIAGGjSeTN1kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:subject:to
         :user-agent:date;
        bh=JA9U3lMcjVD9b5RIjVPhWH5ezNuBP6H4YZzYXXPJPIc=;
        b=VaqRa0isqss3JIjPtpPdSpU0a4rHWUiKDGANRgYHtzYVxVg9dVvQY7HtAMdMS1kdU6
         f0XjkzZjpnUGiPT+4NttzkuT2ClLOQJe1l9++ULAGP/kQMbmRejGcyeLctJl0wXXM8Re
         xeu8ASM3VzgNGE+llIcTKr53d2KJ1Di/ANmhkEvl5U8kc5C0I9kpGoY5bKlQaPCIfh6K
         O+Jhecbh0A0jocDHYIJaPVjY30h6rlitAldKpZua3VW9VKGnHEzCLkFNX2DhlVEBw05f
         5o9+4sx0ekkACC1q5vtSpV7fZEw2bnAzxfFNVmtqdkctMoKtupHBf2y3xwjCDM1jbA3Y
         cTnA==
X-Gm-Message-State: APjAAAVphWsSDwKc5UDQSWUrs1UvNNlEEvGOSoFEr2o+bRir9KqyfBdP
        W1UrilV5Mkn0HstazUoZQxjTdgNdoBc=
X-Google-Smtp-Source: APXvYqww+3qh1orSl+ZzLGNXqbCMq4LpsoCJX2Oy3KuKRaWo+JRpQTgBqO2fQWTKY0BJ8EEQORNCXQ==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr28781221pff.98.1580935072407;
        Wed, 05 Feb 2020 12:37:52 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ep2sm604059pjb.31.2020.02.05.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 12:37:51 -0800 (PST)
Message-ID: <5e3b279f.1c69fb81.383f9.1da3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87zhdxrzhh.fsf@nanos.tec.linutronix.de>
References: <20200205060953.49167-1-swboyd@chromium.org> <87zhdxrzhh.fsf@nanos.tec.linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] genirq: Clarify that irq wake state is orthogonal to enable/disable
To:     Thomas Gleixner <tglx@linutronix.de>
User-Agent: alot/0.8.1
Date:   Wed, 05 Feb 2020 12:37:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2020-02-05 04:27:06)
> Stephen Boyd <swboyd@chromium.org> writes:
> > There's some confusion around if an irq that's disabled with
> > disable_irq() can still wake the system from sleep states such as
> > "suspend to RAM". Let's clarify this in the kernel documentation for
> > irq_set_irq_wake() so that it's clear that an irq can be disabled and
> > still wake the system if it has been marked for wakeup.
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Maulik Shah <mkshah@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  kernel/irq/manage.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 818b2802d3e7..fa8db98c8699 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -731,6 +731,11 @@ static int set_irq_wake_real(unsigned int irq, uns=
igned int on)
> >   *
> >   *   Wakeup mode lets this IRQ wake the system from sleep
> >   *   states like "suspend to RAM".
> > + *
> > + *   Note: irq enable/disable state is completely orthogonal
> > + *   to the enable/disable state of irq wake. An irq can be
> > + *   disabled with disable_irq() and still wake the system as
> > + *   long as the irq has wake enabled.
>=20
> It clearly should say that this is really depending on the hardware
> implementation of the particual interrupt chip whether disabled + wake
> mode is supported.
>=20

Ok. I'm having trouble parsing this. Is there a consistent wording that
can be put here?

The API seems fraught with peril if an implementation of an irqchip is
allowed to ignore wakeup on interrupts that are marked for wakeup while
the irq is disabled. Driver writers won't be able to write drivers that
work across implementations if the irq can't wake the system reliably.

