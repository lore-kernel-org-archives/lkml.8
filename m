Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DCEC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A720719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqFRrl3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDFFSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:18:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36492 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFFSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:18:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so12083369oib.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 22:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMbMU7WDe4dfGwLCVUZeLiiA7XDmbCMQqpwKjNc2rA0=;
        b=kqFRrl3M92hO+CBuMyAX8SqUpmwu1/7m9El6rvLiEmjYhNcCTvg+XoQ0nZQjKiAu4u
         W6GyC6zo7EP4EDWOT96sr2i7QQXaAQID3mdt9I1CVd0zagJfdPBVTQPP7R/84ARc+dSb
         csF1rOYihnSmwBMBs/4+LYHm7s1wxjpMKHpl60rOy/SJMwsr/IVcu7+6iDuIkx3kz45q
         ArkTUB3UUHHPxOU/fhdpho9O+VrDNKlf6EdTrpX/75rfwkFZWvSHKdcB5NWfG+j6brkE
         vS3fG1T2G8n/sTghHIS7Ol04/Wt5p2v8+lV1j46TIF1u5wRWj8YQ+JYDcpEApTbP/VXE
         mZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMbMU7WDe4dfGwLCVUZeLiiA7XDmbCMQqpwKjNc2rA0=;
        b=JfrUAckrT3AhONv/qm03mc+PVej3eyqXV63C45g9uPijZBtZ1G2h5j4Wzq8BTjsxhP
         jYfrkw2mKLEizpOa5X3szaDOY6yCzOOUJGHUunIYyWRF7QSa6iG3D05fE4oR0pz8H2pk
         CssDUVLnCZy10XurJ0AQc/EYLCVcnVPokEDPe18O5EP1+srUl27NW9qOAbmgztqww8x6
         PK5e0xnR3urZUGq/RtVxEF1NEXU1LqSykB33qUjhBxAVqF/CmWs9zMzRYlG6s9YTvj/X
         fjRkbXxAj3nTFwlY/BU/ybpUkBfwk43tbVHfq7/uII5pSluXwDTZGgdl+3N7ovPJxWiR
         qv0w==
X-Gm-Message-State: AGi0PuYW+HLjOWBFIX8CAQZ6Xdfja+ACkCgGRUEY25RkV5CkerOhHdcp
        ctKAVZMhvsnSmCnVfze9RNZdfTwV0lGMSGo8Si8=
X-Google-Smtp-Source: APiQypL7x8RkhZzn5LiyZ3hImB34Rai81E6wXfZZeI/aN4qQwVxactVM00JGTDwMSAuIGUNyC2Vcd9MIvc9Io8MlD84=
X-Received: by 2002:aca:d553:: with SMTP id m80mr11654887oig.30.1586150313643;
 Sun, 05 Apr 2020 22:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200404125845.1381080-1-gch981213@gmail.com>
In-Reply-To: <20200404125845.1381080-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 6 Apr 2020 13:18:22 +0800
Message-ID: <CAJsYDVLA3fgjBGdStkiZeqEv8q2j2sUdDzgj3QdahB=tvyYJWg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
To:     Robert Marko <robimarko@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert!

On Sat, Apr 4, 2020 at 9:01 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> "line over 80 characters" warning produced by checkpatch.pl isn't
> fixed because I think a revert commit should bring a file back to
> what it was before.
> I don't have a w25q256jv available and can't compare SFDP table
> to create a fix similar to mx25l25635 one.

I just tried and unable to dump SFDP on my W25Q256FV,
probably because my chip is too old to have one.
Could you check if your W25Q256JV has this and dump it?
Just add some prints in spi_nor_read_sfdp.
If a 4-byte address instruction table is present, current kernel
should be able to discover 4B_OPCODES support automatically.
Even if that's not the case we may still be able to distinguish
W25Q256FV and W25Q256JV using SFDP table.

-- 
Regards,
Chuanhong Guo
