Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8EFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44619206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gXPMEWnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCCHPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:15:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgCCHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id v22so2049933qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 23:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypYkPGQ+tuqNht2BOkSbdXQNq89bA72Qai2EXZj0f5o=;
        b=gXPMEWnOC5Cy3ZPGY+FzhF5FeyaaKpTZhjCaytHjaH7R5bIJ+NeoX29usAxajcmFWD
         0osf+xGKl8I1Rk25X70aOLLAx066ylCSu2IiUw76f42PjizbAasiLLQU6eaWVZ08Ecla
         Nphech8ot3kQYbTOsW3KbZ+gn5bvdm8A5nHQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypYkPGQ+tuqNht2BOkSbdXQNq89bA72Qai2EXZj0f5o=;
        b=jdZLcVoVFEwfPYa/hRoLjF3hqW8OdifXcF9G2IzUC6/LERFFnthGhwPKAhy5c1wuUx
         tft+oCHcNBFfLBDx9gmDmJaq+nUCRHl8CAgwxx3UTObfBgIZn4bV7crMHwN5u717ueJ4
         0LcGOCWixcf1cF4BnYSTzOULqglMiVou1Cvb3NP64CcTnCbTg5mm+Uf3aMDaF+kXvOst
         2nPlQA1Jif6GOoHhW4Gv6lf7cuIzg3Y4QTA35VP+4zX2ffbRXA0YJKRCxZvN9TvHtXTM
         WWGIriJhA+3YTt0AAos6f7PQn6e0LS1dKp2z9fsSk1mT1L4aU+BuqrOPYGmBuh2tjqd/
         fiCg==
X-Gm-Message-State: ANhLgQ2qphF9INQwI2YZDLeazXW/ZMlTMSHBOQrDABjvw+nUas9yS+77
        KZg8xPW8tUdO3B/iq07N04ylxK6TACCB2LLUfsM=
X-Google-Smtp-Source: ADFU+vvpPdIPrOMla3lHMKsvtgOsYhvOly+EDWJuxYHMS9CAj7ketuc9MhtRLZmEt1grmksChe08v/qQPfdfCEzGbUE=
X-Received: by 2002:aed:3841:: with SMTP id j59mr3274883qte.220.1583219742473;
 Mon, 02 Mar 2020 23:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 3 Mar 2020 07:15:31 +0000
Message-ID: <CACPK8Xcvf2wSE5Y4E8Lbs6R9mHhztvNsr8vNrYaPX+kMMUhZvA@mail.gmail.com>
Subject: Re: [PATCH 00/23] mtd: spi-nor: Move manufacturer/SFDP code out of
 the core
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic.Desroches@microchip.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Michal Simek <michal.simek@xilinx.com>, ludovic.barre@st.com,
        john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        nishkadg.linux@gmail.com, Michael Walle <michael@walle.cc>,
        dinguyen@kernel.org, thor.thayer@linux.intel.com,
        Stephen Boyd <swboyd@chromium.org>, opensource@jilayne.com,
        mika.westerberg@linux.intel.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, jethro@fortanix.com, info@metux.net,
        alexander.sverdlin@nokia.com, rfontana@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Mon, 2 Mar 2020 at 18:07, <Tudor.Ambarus@microchip.com> wrote:
>
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>
> Hello,
>
> This patch series is an attempt at getting all manufacturer specific
> quirks/code out of the core to make the core logic more readable and
> thus ease maintainance.

I tried to apply this to linus' tree (5.6-rc4) but it had a bunch of
conflicts. What did you base this on?
