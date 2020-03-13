Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACCC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0EE2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Svo7zeoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCMVHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:07:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39943 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:07:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f3so6843457wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctrrvsauAYuF+5TZRvlwZdq08mz1JQ5bpHPFrWuBNr4=;
        b=Svo7zeocU6WeReAJ0ARsPwMuvSxptIHLhgPIFefBnZPEgG3FnK7tlqkWb7i3HOx5vL
         VqIJixbFQCwfd8MGlA7fSHwwWQNaHCqOvQ9m3WtJIB+UnsMRMYMZKMn/00sakmoj55Xu
         Z3/TNEbyJZzM2ZGXSyR73sB/2Nk0vJcW+6GyPWiNj7nO5yA9XRhdmKNWsopYUJtYt4QW
         VV9bGGawnMGRYIRVN8R4lXD7VyZ/Xuu0K7XeOBl2nODRTmHtzKpY5GY+42fn66+vKffB
         VfdATghzXSOLKiTo7jvnVseKl8R7tuI2mE+U+32kp57yPJ1VQV/w4ar6oX00nmofuiwC
         6Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctrrvsauAYuF+5TZRvlwZdq08mz1JQ5bpHPFrWuBNr4=;
        b=D/hbG2msGClne5wieYWFCmLFLhHfzvOdlNruLpqGWutb6HaBo6MwEtZq3HtIvlvasV
         qY+4SaYp3/6UKXWCc0PEM8Hlj39dzKSGxoqFWHyrgGu8IBPkvq5Lt4iLr0wbBq/JVbQz
         +x4WEHPeVuB5Zpqbob36HfjSDjwQ9qpy8vctZLsDMUOFr4iPFi9/BUprGnMDH9o7zxkl
         ABA6MN3VpqkD1ycGhrh2+GRI/iN9s+sF6UWNdvTz2AByS3OaNfyeVJJGsCF3KgWg9yYf
         /9ic2K+8v+hMWVUvEaaA6qihYbhcqvWPGuylFBtqw1U2wuMl1sEaAjUQfblMsWZEAqCI
         FJqg==
X-Gm-Message-State: ANhLgQ0Maj4skNXpEkkS/oov0+GsUznUALnB6iaHQ0as22Mmg+VN+xux
        fBIXaQArgtUG5vzh4LeySpY104x7sEHjcr0DYlnC9A==
X-Google-Smtp-Source: ADFU+vsIUBmJY+qJUpydM7cUlRZIlWdsbcgH0EazC9FLlBHdfGb9NDjL1C/xJGV9L08jQ8hdqvDculuC7IAjSKJD3C8=
X-Received: by 2002:adf:91c3:: with SMTP id 61mr6714394wri.384.1584133622854;
 Fri, 13 Mar 2020 14:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <1583941433-15876-1-git-send-email-tharvey@gateworks.com>
 <20200313153151.e5nmsbr6yrzchdxi@rric.localdomain> <20200313191230.qrrlo7ht24fhfhvj@rric.localdomain>
 <CAJ+vNU0q7wW8JPC8FjEkD4a-ZJc1QAmVNne0w1T4MX9pd4bCyg@mail.gmail.com> <20200313202444.vdfdowbudlsxmqsf@rric.localdomain>
In-Reply-To: <20200313202444.vdfdowbudlsxmqsf@rric.localdomain>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 13 Mar 2020 14:06:50 -0700
Message-ID: <CAJ+vNU1S+z1xLAW2nxpGTZN_6wzr0+t=4q5NDRVpCc92d_98hQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: fix irq_request_resources
To:     Robert Richter <rrichter@marvell.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 1:24 PM Robert Richter <rrichter@marvell.com> wrote:
>
> On 13.03.20 12:41:19, Tim Harvey wrote:
> > On Fri, Mar 13, 2020 at 12:12 PM Robert Richter <rrichter@marvell.com> wrote:
> > >
> > > On 13.03.20 16:31:51, Robert Richter wrote:
> > > > On 11.03.20 08:43:53, Tim Harvey wrote:
> > > > > If there are no parent resources do not call irq_chip_request_resources_parent
> > > > > at all as this will return an error.
> > > > >
> > > > > This resolves a regression where devices using a thunderx gpio as an interrupt
> > > > > would fail probing.
> > > > >
> > > > > Fixes: 0d04d0c ("gpio: thunderx: Use the default parent apis for {request,release}_resources")
> > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > ---
> > > > >  drivers/gpio/gpio-thunderx.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> > > Looking at the original code, the parent resources are requested only
> > > if existing. So the change is ok.
> > >
> > > On the other hand, the overall change using irq_chip_{request,
> > > release}_resources_parent() became pointless now. It is unreadable and
> > > more complex now. Thus, commit 0d04d0c should just be reverted.
> > >
> > > The function interface is limited. Instead of letting the child device
> > > deal with the parent, parent requests should be handled directly in
> > > irq_request_resources(). Another aspect is that the code for this
> > > driver has been already removed upstream and ti_sci_inta_msi.c is the
> > > last remaining user of it. This speaks also for a removal by a revert.
>
> > A revert does make the most sense to me and it works for 5.2, 5.3, and
> > 5.5 but the revert fails for 5.4 and needs some manual intervention.
>
> v5.4 should additionally revert a7fc89f9d5fc ("gpio: thunderx: Switch
> to GPIOLIB_IRQCHIP"). v5.5 contains this revert too (a564ac35d605
> Revert "gpio: thunderx: Switch to GPIOLIB_IRQCHIP") and the code in
> that area is the same then for all kernels from 5.2 to 5.5, which is
> basically a revert back to 5.1. I think this is ok.
>
> Do you have a particular test case to test the driver that I can use
> for my own testing?
>

Robert,

The hardware I have has an interrupt controller with its upstream
interrupt to an OctoenTX GPIO (and its driver is in progress and not
yet accepted upstream which means this issue in 5.2/5.3/5.4 doesn't
affect me). I'm unclear if you just need a device that has an
interrupt on the OcteonTX GPIO or if the device has to be an interrupt
controller to trigger the issue as is my case.

Tim
