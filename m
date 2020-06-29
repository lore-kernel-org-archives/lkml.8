Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7242082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlPzbSGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbgF2Tmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbgF2Tmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB77CC02F020
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:53:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t198so2057451oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVUn54AkLpOfXd3WnHwQybMvZzd49YHmsReesPzQBek=;
        b=mlPzbSGVuQDa6yw0V2B5fbDGgQNKVtTM3SnXiNRaW1fRb50AGtV0AXGtUJlE2/yEdX
         nI51wWK2J3oPDYyMkOIjx0bvtd09mJUAk8fEjcYCUedYzQEh1ajfbty5WVjX0xkycdl/
         Znct2lTioP9TIgZ7jAh6hD74DRLCyqJP+9ZlKsiSme+Cd/hJk8dB602QkrOUMjoAyt5Z
         5EAauj6bwRoHKwQeF7OPSdXO1ezUAQJt/oE3n51lRvHVvG/8Mt1P55eXkdioqw2I2Fd9
         s7EujhnhlxdB0QG3usWZ0SVk2YWJUmrc+2DqlbWkrlrIzBpM732iyrJ+uP3glud6+Jj2
         sfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVUn54AkLpOfXd3WnHwQybMvZzd49YHmsReesPzQBek=;
        b=CO4544fKCbnQ7BQTgtWqFCjVQ6k9OFJU8J6rZpYL0or6qqJsJgPvST4HqISoYO6+Cm
         kjziwxg1Qtdh37P9jZuAJNbDElBSN/e7qqpMQ8TcG5CEetOp9wPy4F1ZpkcWfyhz69jc
         faYriPZ9ajCVNBjWn/XbqojFfz1Qqp+Dr+Rf5NLqC/eJzfjBcxoVfRvrhdXrfnlCK/v0
         usZca9WnFmDvGFkGNSqcg46V1N88i0WmNqpRKKBdn+2XrB6+nLt01sdGqxMdSS6Eb+R1
         Bp4jwB36EAA1kvOCOmGpxoL2kdJZRt0aEkzFcZ9zLphznP1HbixdtoG4LxOKR5D9Q560
         0yjw==
X-Gm-Message-State: AOAM530g6QUeScnujBUR+gxBfU0hed87eifh/8LxLU6vNoMwTCtRq63u
        Et0pYKystQ0TwrjTk7EjZNZzxDo4cckAw9g7ImQ=
X-Google-Smtp-Source: ABdhPJw60ZZBJdZUuxN9zH9rQ9z3UTCisMhdH6nKsnHlJZbbZ4w7KBbIY9gmfBRG1mz9+OQXYjGqlvsGKM1Er0W4OBk=
X-Received: by 2002:a05:6808:194:: with SMTP id w20mr12426052oic.77.1593442424173;
 Mon, 29 Jun 2020 07:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200613235331.24678-1-TheSven73@gmail.com> <4b0f2a2d-66be-4cdd-8384-a80f6b729d74@microchip.com>
In-Reply-To: <4b0f2a2d-66be-4cdd-8384-a80f6b729d74@microchip.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 29 Jun 2020 10:53:33 -0400
Message-ID: <CAGngYiUFh8XexBZK1U2bHcsvHS2LFAXONgLG7HhY7CDQ=LayWg@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi flash
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Mon, Jun 29, 2020 at 8:50 AM <Tudor.Ambarus@microchip.com> wrote:
>
> I'm reading the following datasheet:
> https://www.winbond.com/resource-files/w25q64jv%20revj%2003272018%20plus.pdf
>
> w25q64jvm (0xef7017) comes with QE bit set to a 0 state, but can be
> set to 1, so Quad mode can be supported. Would you please set SPI_NOR_DUAL_READ
> and SPI_NOR_QUAD_READ flags and test and see if Quad works? If all good,
> please specify in the commit message with which controller you did the tests.
>

Good point !

Unfortunately I'm using the spi controller on an imx6 ("fsl,imx51-ecspi") which
does not support dual or quad mode. So I cannot possibly test this :)

How would you like to proceed? Should I keep this as a private patch, and
wait until someone comes along who can test this on more capable
controller h/w ?

Or should I re-spin the patch without the flags?

Cheers,
Sven
