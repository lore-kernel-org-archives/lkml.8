Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FAC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA28F214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GRicch/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBFTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:33:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34243 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:33:05 -0500
Received: by mail-il1-f194.google.com with SMTP id l4so6215908ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4taPn/MiVMkxFL2WltQygQjngQbCvQPQoX2JhXpnxk=;
        b=GRicch/O+DqUdUakmb/AuYSUmJgILvyUT897jtgKqqfV7oBPQi6GtOuUrqJUoEwJxU
         /fCwGYCuDos0UZHr88jKUBJFidEgte8UZvSpJBluECpgcSAqFeezmqC6vwYPdxDaLNVO
         c0nLVceziEhYXmOrKMNoE0kB0baSy274m0P38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4taPn/MiVMkxFL2WltQygQjngQbCvQPQoX2JhXpnxk=;
        b=nYvdeaQujpNvdGEqQGmoDW6Y8NcUtSDVbEzzAOuxRl1ZCtrAbXLRwC6kMEhMJz56Te
         t1nS+N2krpbWSx4qTVK4boDCZgachNgX/zu8e6qahvhizB99LLvEfCBDkLb7Jghfkm4U
         2qoYxSC3cHOE1Iy3FJVhj5LMnqtdbjq7RHkouuGXqDDJOAKK6psRmSYdT0vCMWnS9yFN
         effiYv1dBW7fAY8aSG0A0MUSeUJeimB8WelxRh5s/3w1e3UmGZvVlruVxH01GqjEmiei
         J7GckAeqwm+vFATkukiQvkJewGk70zv5ARzRqk1u0mzXaD1AAZrL1csNpc+0M61/ihrI
         jD2w==
X-Gm-Message-State: APjAAAXpiMEb91mBYT2g0OFRsQXvuy6SL4NqNPE+T71rDCTSWG2cqNEW
        qzBcIWGDfhbF+nbLhE4MqpUc3efqp7k=
X-Google-Smtp-Source: APXvYqyXQWSyCHEoPslFXbkjuuT3T5PMYN2TWmKFWYbbqdH0sGOc3vprOnnRb3ciHVjvSnbzF3g8jA==
X-Received: by 2002:a92:910b:: with SMTP id t11mr5552776ild.195.1581017583985;
        Thu, 06 Feb 2020 11:33:03 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id t11sm245802ilm.52.2020.02.06.11.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 11:33:03 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id s18so6224058iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:33:03 -0800 (PST)
X-Received: by 2002:a92:508:: with SMTP id q8mr5430583ile.187.1581017582916;
 Thu, 06 Feb 2020 11:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20200206191521.94559-1-swboyd@chromium.org>
In-Reply-To: <20200206191521.94559-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Feb 2020 11:32:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U5YNe5ODREBMcxSfhih8O48kwD_t+apAFD391Oekmkcg@mail.gmail.com>
Message-ID: <CAD=FV=U5YNe5ODREBMcxSfhih8O48kwD_t+apAFD391Oekmkcg@mail.gmail.com>
Subject: Re: [PATCH v2] genirq: Clarify that irq wake state is orthogonal to enable/disable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 6, 2020 at 11:15 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There's some confusion around if an irq that's disabled with
> disable_irq() can still wake the system from sleep states such as
> "suspend to RAM". Let's clarify this in the kernel documentation for
> irq_set_irq_wake() so that it's clear that an irq can be disabled and
> still wake the system if it has been marked for wakeup.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Added the last sentence from tglx
>
>  kernel/irq/manage.c | 7 +++++++
>  1 file changed, 7 insertions(+)

FWIW this mathes my understanding and in the past I've done work to
'drivers/pinctrl/pinctrl-rockchip.c' making it support this exact
thing.  Thanks for documenting.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
