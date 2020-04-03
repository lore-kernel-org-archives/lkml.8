Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C394C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45D207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKfwGVIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbgDCBfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:35:16 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40805 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:35:15 -0400
Received: by mail-wr1-f42.google.com with SMTP id s8so4493214wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 18:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=okSzurA2TnTvishCfA5UABEnEmnZ1xC7aBRu4+DTlSg=;
        b=ZKfwGVICCjRx5AWbAhHCXAgDeMHWdOi5C4RE0z1zPUPuoU2rWpb5wystqf2uqosPVJ
         bdb9FQS3BrN4wC8okLZnEDzl1SrxB+qdmdFeYV1/apo4VpVsqdVSfEdTmZFLxJwYy5C/
         hun4imbdf1de+VHlZEl8nVMg99+6dwrgLcew+tTkoTJox7p3/IH3EXSAe6yJkkkgQJqy
         a5cofaCJzqJ6uiaSzd7WyETrmqGujjICdiv1Y/wGbvGRzD3wm+NoRjGAOOYW+8dVC+h7
         7SDl1VckNapg0oXqqGmYfYlc4l7fI9eULatsCHzkbwJPvEn6nP07VffpV+ibbIeUYkEU
         kjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=okSzurA2TnTvishCfA5UABEnEmnZ1xC7aBRu4+DTlSg=;
        b=Ng/JbAhKAHGoBcqmMIlrZlj0/oMy+ntn0IQ6luzH83HtQ3sKnrUV4V3LYgaddja25A
         nWrbjLHYXzdegfe6iGLlFzZVSgEt1vzft3nu8CND++xg6xNJr7Ys1sgiofY4w4SM4jrc
         t33eqANZ4BEfNIB4Z+pjLAMB0KdVksLiqcekMDsA33RgOwwfM8n3KcNohwprLbpgoTbg
         Azd64LwLfyf88weZmzJ6kvhHS8RM83nb8zSbHxdrwUtWoNZT3tNUmrDZKMFjwU5KDZw8
         8Eb/PPcRCx12W7K1IqrIkipN/Zh3LB/MUD4up/x51yIDCycFz35qqwQw68GRK2nA4pFk
         mBuA==
X-Gm-Message-State: AGi0PuZ9TwhOxWRg0qcty88p/Kg65sEt1RSM5RZ3GAaVlYmpf93KUpqb
        7lDFtzkI8wlmyd9pPcIyUIbW+lSqKNUrBaJx6naKuQ==
X-Google-Smtp-Source: APiQypICUUEzh8Ovv2uj0iM+NAXefNvD6iBSf4eXgHc7MVsGchk3KaHDRgkNZbMTlHbF/HnBzXAk4eyny2V+Rwsa7hk=
X-Received: by 2002:adf:aacf:: with SMTP id i15mr6013203wrc.31.1585877712013;
 Thu, 02 Apr 2020 18:35:12 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Lu=C3=ADs_Matallui?= <matallui@gmail.com>
Date:   Thu, 2 Apr 2020 19:35:01 -0600
Message-ID: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
Subject: Help with IRQ-MSI-IRQ bridges
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order to
get interrupts from devices external to the ARM subsystem.
I already got some pointers from Maz and have been able to create the
drivers with the stacked domains and can now see the mappings working
fine across domains.

Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, a.k.a
MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI bridge).

I now have the interrupts working, but it seems like I'm missing a
bunch of them. And therefore my device doesn't work properly.
The main difference between my HW and Marvell's is that my IRQs are
not level-triggered and the MSIs don't support the two messages for
level-triggered interrupts.

To illustrate my system:

DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP)
--line--> GICv2

For MSIC, all I can do is configure the address and data for the MSI,
and I believe on every rising edge of the Device IRQ, an MSI is sent.
For GICP, all I have is a doorbell and a way to enable/disable it, and
whenever the doorbell is enabled and has a value != 0, the IRQ line to
GICv2 gets asserted.

The first thing I noticed is that when I get an interrupt, the IRQ
flow goes like:

  handle_irq();
  irq_eoi();

So, I guess my first question here is, how can I guarantee that I
don't get another MSI whilst in handle_irq()?
If I do, then I will clear the doorbell on irq_eoi() (because that's
my only choice) and will lose the queued IRQs.

It also seems that I'm missing IRQs in the beginning after probing the
device, and before it was working for me when I was setting up all
these registers manually and simply using GICv2 as my only interrupt
controller.
I do see the unmask() ops being called for all my stacked irqchips, so
I don't understand how I'm missing so many interrupts.

Any help would be truly appreciated.

Thanks,
ltanica
