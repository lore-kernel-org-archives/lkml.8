Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A845C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1012A206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lDamH6EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgCKPDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:03:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37335 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:03:47 -0400
Received: by mail-vs1-f68.google.com with SMTP id o24so1530285vsp.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa/UZZRfDX9qffcRnjXvDssLTWrWNyoM8rWpLWYegKE=;
        b=lDamH6EB4i1VKZnPYXwOv6nUEeh+kM6NRhcYKZ+te+ZXk8zM2ynUwlg7YokKti+Exn
         24c2fO1yBQ2j+rbRntd/JqvoKToNVzV7vPJg+pFPTvnoPC8dvxC2tV/t0HeDS2LgdyCN
         5ncfbziBuTXa1WL36iaGrQmAvRUYwNNzhe8ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa/UZZRfDX9qffcRnjXvDssLTWrWNyoM8rWpLWYegKE=;
        b=oFIoQh8ySWw+nr9EoU1yAGx2TpVYQxQqgUspL7sVS6Ttdlej93C8bMohrSROdSDihC
         PD36PETJXLQzM3GuIKZvuNw7cQs/7RSE2xaa7yWe1Bd0jv46uECNjhpAJIwN9/KyRs7z
         /rX3AoUlQvZqUDxwRQtfhrIVqZo3hoHbuHfCGVH8JVKPhgnTUA0dyeQ7gGTjyyolcfVU
         elVgJkQeyC6a8B+4sgDOF+Us7tTDR5YjWvXe7DQjphnDjejqrSds89Alnh1Pcv6MBexW
         kAl+06fXidKY2eEts6lC2WA10bsroY3Tft41iV178OPZx+JmcqeMGmq0mGjOLg/it3o7
         U44g==
X-Gm-Message-State: ANhLgQ1FPiu5/Qf4kndyAUHcLkf5oeOabI1u0JZmqAoNnD4fuNUcJHpz
        TaHumX0ojbHmRGCtDnN309tmzZBK2wY=
X-Google-Smtp-Source: ADFU+vv11i/H6kIy0XNXYUM5SYrKXOekOgSmHE6bCAjPPY6QOPy/gErQG/94PNEyjY9Vq6VNfUzP0Q==
X-Received: by 2002:a67:6f84:: with SMTP id k126mr2183377vsc.112.1583939025466;
        Wed, 11 Mar 2020 08:03:45 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g126sm14252986vke.8.2020.03.11.08.03.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:03:40 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id u24so1509469vso.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:03:40 -0700 (PDT)
X-Received: by 2002:a05:6102:1cf:: with SMTP id s15mr2199757vsq.109.1583939019324;
 Wed, 11 Mar 2020 08:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200306235951.214678-1-dianders@chromium.org>
 <20200306155707.RFT.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid> <85758e97-8c0c-5c4e-24ad-d3e8b2b01d3c@codeaurora.org>
In-Reply-To: <85758e97-8c0c-5c4e-24ad-d3e8b2b01d3c@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Mar 2020 08:03:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X649r8qrNRZSezUBEuJbt0oZg6VBweAGjEhxOPp0zf2w@mail.gmail.com>
Message-ID: <CAD=FV=X649r8qrNRZSezUBEuJbt0oZg6VBweAGjEhxOPp0zf2w@mail.gmail.com>
Subject: Re: [RFT PATCH 1/9] drivers: qcom: rpmh-rsc: Clean code
 reading/writing regs/cmds
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 11, 2020 at 1:47 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> > This patch makes two changes, both of which should be no-ops:
> >
> > 1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg() /
> >    write_tcs_cmd().
>
> i agree that there are two different write function doing same thing except last addition (RSC_DRV_CMD_OFFSET * cmd_id)
>
> can you please rename write_tcs_cmd() to write_tcs_reg(), add above operation in it, and then remove existing write_tcs_reg().
> this way we have only one read and one write function.
>
> so at the end we will two function as,
>
> static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> {
>         return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
>                              RSC_DRV_CMD_OFFSET * cmd_id);
> }
>
> static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id,
>                           u32 data)
> {
>         writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
>                        RSC_DRV_CMD_OFFSET * cmd_id);
> }

I can if you insist and this is still better than the existing
(inconsistent) code.

...but I still feel that having two functions adds value here.


Anyone else who is CCed want to weigh in and tie break?


> > 2. Change the order of operations in the above functions to make it
> >    more obvious to me what the math is doing.  Specifically first you
> >    want to find the right TCS, then the right register, and then
> >    multiply by the command ID if necessary.
> With above change, i don't think you need to re-order this.
> specifically from tcs->base, we find right "reg" first and if it happens to be tcs then intended tcs, and then cmd inside tcs.

There was never any "need" to re-order.  That math works out to be the
same.  This is just clearer.

As an example, let's look at this:

struct point {
  int x;
  int y;
};
struct point points[10];

Let's say you have:
  void *points_base = &(points[0]);

...and now you want to find &(points[5].y).  What does your math look like?

a) points_base + (sizeof(struct point) * 5) + 4 ;

...or...

b) points_base + 4 + (sizeof(struct point) * 5);


Both calculations give the same result, but I am arguring that "a)" is
more intuitive.  Specifically you deal with the array access first and
then deal with the offset within the structure that you found.


-Doug
