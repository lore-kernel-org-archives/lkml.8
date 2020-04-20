Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC0C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BC72082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTLWW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:22:22 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42897 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:22:21 -0400
Received: by mail-il1-f193.google.com with SMTP id t10so9321531ilg.9;
        Mon, 20 Apr 2020 04:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pccoCR8bT7vHRl0vUz7N7kMnUn1VVOEIOeGXPVDk95E=;
        b=k+P74HIj1AA0JQdyTtPkrKTRc3NsUwUphlWyf9eSuvOs2ZPJCMCi+v+2TFaD23BetV
         PHqLCKOpODqoK1Eunwk+4/+HIq7yekZOpSwE4m9YcCszl0geFdQKF9WOg/c8tvwQlQpC
         d0XVVGr+kflxTZ56OKiRubAdYWnpM8KPH9jj1O7Br2lxM2GKbqj8rYMffAmUvg0n8mBH
         m7QjREZZqTbCQU4/xME3jlpWpRpHJxdG0zDiEBs5Xz/w6uqDtTl5FcsFTHjSI6JMwfxW
         6wiYrn/IEKfsO0pwrxTiiJlMug0MKw7J9RxTF1QDbGicyF85nt0dFfa1W18Tae+liah7
         F8+Q==
X-Gm-Message-State: AGi0PuZI0U0R3zjBMHvfvfDcF3taAqSExMkVSDsCtW3Qhfs8bomH5Jx0
        T9SLvxY/qCG4S5NtGfxGVXQFcOmT2FyQskNYN9c=
X-Google-Smtp-Source: APiQypJih+IGWE6cV7mZ3c/9zRUrKM5YERvG07E+axOwrqifX1twhy4o7Zuo5eRqjkk28lKbGEBAK3L9NVPhHoqv4C0=
X-Received: by 2002:a92:50f:: with SMTP id q15mr9239890ile.4.1587381740415;
 Mon, 20 Apr 2020 04:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200420110715.12032-1-matwey@sai.msu.ru> <752db40d-5aed-4a97-a050-bc1376547f87@xilinx.com>
In-Reply-To: <752db40d-5aed-4a97-a050-bc1376547f87@xilinx.com>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Mon, 20 Apr 2020 14:22:09 +0300
Message-ID: <CAJs94EYAppZSWR1ahKhpm5BiF6W6AGPu1OXJLRvFAx93sHRzwA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: zynq: Fix ethernet PHY for v5 schematics
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anton Gerasimov <tossel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

пн, 20 апр. 2020 г. в 14:19, Michal Simek <michal.simek@xilinx.com>:
>
> On 20. 04. 20 13:07, Matwey V. Kornilov wrote:
> > There are at least two different versions existing for MYIR Zturn:
> >
> >  * v4 schematics has Atheros AR8035 PHY at 0b000
> >      http://www.myirtech.com/download/Zynq7000/Z-TURNBOARD_schematic.pdf
> >  * v5 schematics has Micrel KSZ9031 PHY at 0b011
> >      v5 schematics available at DVD disk supplied with the board
> >
> > Specify both PHYs to make ethernet interface working for any board
> > revision. This commit relies on of_mdiobus_register() behaviour.
>
> typo - behavior.
>
> I think it will be very useful to describe that current behavior.
> Also would be good to test it on v4.

I don't have v4 board, so I will highly appreciate if somebody test
the patch with v4 board.

>
> Thanks,
> Michal



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
