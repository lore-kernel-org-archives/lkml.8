Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A4C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C356521569
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkseAph0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBJRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:09:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35733 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBJRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:09:03 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so8419053iob.2;
        Mon, 10 Feb 2020 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7TMYFnb5/RylQGjk6pwzyOMg8V/VoQJOxgPOgvp4TQ=;
        b=qkseAph0tr0+SBm6cWzFPpfeUipxzvfJYFreIZj2Jc+t+btZhb30Pnb9mpex9HMBQg
         s+lqIIVdZp6P2b3ej3X+DSvXo9boYOAwkuRDpXFDFmb+unXmhjjzgsHiz5svYX4DA8zg
         SjCbWxPPQUcXM8nbqah4fNmVOA1FdsMC0BHByvTzA51IJ0YsIIyEGfx+O//kXPUerzEf
         EIqa1QT6+2UztMHYkEf0K83GPRPas7oB/Uhs8YQQ0TBkd7fhYDVMJEhC8GzWTYLDhGGL
         QLCgft+GLsJlvjVkAelArQw8+7x4nxey6QHvnSH8+g5esCnP3XRGogXyLcpGt3tjBarC
         7LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7TMYFnb5/RylQGjk6pwzyOMg8V/VoQJOxgPOgvp4TQ=;
        b=HbK6sNOsBdvCXbutCPso6ePzZKeHduhFjPs6xbfXB5WYtyUdNVqsd2H2BKAHvX2o62
         FUuXFyeq9vB671F9wXympEUV0uf0MwV2wc0h9Ekv/WLMJQMhgg3fLfLZ5ZCbbYnAiu1a
         pqfuJ/QdO7ZMjWpWxjl+N8ra7wXLlnNUEjv9+lA2Zv8zKhyWU1/+OZ0krmF/QTK8sYcI
         mKlbSgIp5P1r6Fqq7BGonYzjnU/slNTqcqpusXJ5gi67EL4zDxHUoHgOAx8QDMtDfhO0
         6ITs1HZ6Dbqeu/uv1bvdc+YDzzAypGria53eyypSEcsljgQRTjwZZiIihf6qemCmoNmN
         MTeQ==
X-Gm-Message-State: APjAAAWTg9YzNVqKgopNS2hXbZnbggWJxYu29NV5Px3800xMSmqY/NOM
        JMvzkg8x3wCq/RLQjoyDtUTIPd97MwG/AVGsB1c=
X-Google-Smtp-Source: APXvYqyDx6797nOWepvliuKmQFE1G8xSfLPt0573SCGJDKIhe8kTAtSqJjvSkmUZPLV3kuczOpS2tsqodoJhp8fk1gs=
X-Received: by 2002:a6b:b48e:: with SMTP id d136mr9655577iof.243.1581354542360;
 Mon, 10 Feb 2020 09:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20200210105108.1128-1-linux.amoon@gmail.com> <20200210135612.GB2163@pi3>
In-Reply-To: <20200210135612.GB2163@pi3>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 10 Feb 2020 22:38:52 +0530
Message-ID: <CANAwSgT9aq123H-pO2u6iN2E8towsWUFcWDsA9TbVqP30j=10w@mail.gmail.com>
Subject: Re: [PATCHv3 0/3] Add support for suspend clk for Exynos5422 SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 10 Feb 2020 at 19:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Feb 10, 2020 at 10:51:05AM +0000, Anand Moon wrote:
> > Long time ago I tried to add suspend clk for dwc3 phy
> > which was wrong appoch, see below.
> >
> > [0] https://lore.kernel.org/patchwork/patch/837635/
> > [1] https://lore.kernel.org/patchwork/patch/837636/
> >
>

Thanks for your review comments.

> You ignored parts of my review from these previous patches. I asked for
> describing WHY are you doing this and WHAT problem are you trying to
> solve. I asked for this multiple times. Unfortunately I cannot find the
> answers to my questions in this patchset...
>
> Best regards,
> Krzysztof

I dont know how to resolve this issue, but I want to re-post
some of my changes back for review. let me try again.

My future goal is to add #power-domain for FSYS and FSYS2
which I am trying to resolve some issue.
Also add run-time power management for USB3 drivers.

Here is the clk diagram for FSYS clk as per Exynos5422 user manual.
[0] https://imgur.com/gallery/zAiBoyh

As per the USB 3.0 Architecture T I.

2.13.1 PHY Power Management
The SS PHY has power states P0, P1, P2, and P3, corresponding to the
SS LPM states of U0, U1, U2,and U3. In the P3 state,SS PHY does not drive
the default functional clock,instead, the *susp_clk* is used in its place.

So enable the suspend clk help control the power management
states for the DWC3 controller.

-Anand
