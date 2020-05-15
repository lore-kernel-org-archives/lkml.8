Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B85E2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6H2CZQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgEOF1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgEOF1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:27:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BDC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:27:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so731053lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFA9bbGYP/a1tRAzYnvdKIyV9KR03xqslMsPA2GhaEE=;
        b=s6H2CZQhAVWPesp83Vkn3sBxPSVa6jQbN6fsIX0XOl3jGwZqiuaU+1h4sgCVgMNgfP
         ZS3FGPsixpa2xUCuNo7l0qafR63fTE2yu09QNEMhxCbaCms81eJhwMj7Oych3RfqYuh+
         JpxG+mWoK5a3BNlXpqvCZ6m7g9hTzJ6B8/y1vtPD5+DQLnI7rLt9VLsHnmCZtS7k9R3A
         Fa9aQaH1YMkiK7LH0Grw2a5tZ72JU+aCdAGaOrbKGVfcZkHfk46XxJxYdg4o5LGpd+04
         sZn+wgF2JgAMFaLkjvKmEm+fOZ8ZWmzEuCwF6kRzAE4+ec++IJQNukV6TpOMWww/rf8a
         wHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFA9bbGYP/a1tRAzYnvdKIyV9KR03xqslMsPA2GhaEE=;
        b=R165F5W66CkYZhlcV+VlEifKcb1TvLmv37mcc23QQTCHkYU2uPuj/NU5m+DSmmZSh5
         cEcH8nJoyVDR3FhQOo+jSZWofBT4E3LckASbeZDtr8+RMe6w/22yYY2nnFs0vPn3Oh7a
         mU2+L89wYWd+juiRF4p+vdQSyBczZ8G1YS9Lcx2ZWp9RGm/7gd9v/1BOsPDxwwYeBuqK
         gC8wgiEuZDJ5upj2WZ8DvY2/iwvpVjTxPGUBfwMsA2ynPaoB7NtcTEHWLaBT4RM064g0
         h4I9nXnI/jk8qDrONaz3jdMF/9IJzAVMNdYcDsiK3s0qATHuOskal4rYJ9AMnuoCeXfZ
         Vi2A==
X-Gm-Message-State: AOAM532cElg2ceDSHwGc7ejb0Nle4pD4ie9TBBf/QelRd8RBPNJWtTOq
        Sg9oNJS62oVN4+KnqmMJtdVVLGWq9wFnfy09U/uP0w==
X-Google-Smtp-Source: ABdhPJx6uoL2OEPa5ViXeATYDIi6r1UNXExSU+Hf1bncATF6/SYkNy31Q0bXCIUZ2socnPo8/ocEWPQdms6w56+/6CE=
X-Received: by 2002:ac2:4436:: with SMTP id w22mr1112111lfl.55.1589520433239;
 Thu, 14 May 2020 22:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200311175735.2007-1-sshivamurthy@micron.com>
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 May 2020 10:57:01 +0530
Message-ID: <CA+G9fYuavikY4yjc+bjnvDGHGwQRs6bf31gUa3gyFzd=0zLR7Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Add new series Micron SPI NAND devices
To:     shiva.linuxworks@gmail.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Poonam Aggrwal <poonam.aggrwal@nxp.com>,
        Suram Suram <suram@nxp.com>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 at 23:28, <shiva.linuxworks@gmail.com> wrote:
>
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
>
> This patchset is for the new series of Micron SPI NAND devices, and the
> following links are their datasheets.

While boot NXP ls2088 device with mainline kernel the following
nand warning noticed. How critical this warning ?

[    1.357722] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x48
[    1.364085] nand: Micron MT29F16G08ABACAWP
[    1.368181] nand: 2048 MiB, SLC, erase size: 512 KiB, page size:
4096, OOB size: 224
[    1.375932] nand: WARNING: 530000000.flash: the ECC used on your
system is too weak compared to the one required by the NAND chip

[    1.388767] Bad block table found at page 524160, version 0x01
[    1.396833] Bad block table found at page 524032, version 0x01
[    1.403781] nand_read_bbt: bad block at 0x000002d00000
[    1.408921] nand_read_bbt: bad block at 0x000002d80000
[    1.414750] fsl,ifc-nand 530000000.nand: IFC NAND device at
0x530000000, bank 2


Full test log,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc5-55-g1ae7efb38854/testrun/18254/log

- Naresh
