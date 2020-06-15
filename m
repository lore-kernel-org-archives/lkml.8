Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CFC20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5y+0H5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgFOTFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:05:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94BDC061A0E;
        Mon, 15 Jun 2020 12:05:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so19101101iow.8;
        Mon, 15 Jun 2020 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlZB0LoHOoKwQ25KMcwRS0hvH3SBcs0IIs6yHO+vpjo=;
        b=M5y+0H5UBj1QDe1vqlNBfbMBYsTjZ+0iYenjFgi2255cNAbbu49yNXp9E+1ldZh+LT
         d9hFBsjun9b+bmxqA3bY9bEiccRUFTei3YnSYtuKVfCfeC5TMfSGfcyQpl9xJc66YdSj
         QEhuVa+RYnhCyPNI6H75ZkRwZ28sZVMTA0vkUtUxd55clOHJgZxfX/F1UIBRQPCtS/I+
         hJKtmDDey99OVr2abgfmV9eCOfgKDie/+0nrWtRCdVv1sMPZp+S7wdGR/DVczn1gZErY
         GiTjXX3+STQ8j6rk1cU6GRq9OITPAUHPnu2bby7MdV1O/D6KaQ9qG3syqgyOA1SvJdi+
         V+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlZB0LoHOoKwQ25KMcwRS0hvH3SBcs0IIs6yHO+vpjo=;
        b=CdKV31WEmNx/j+CsTJDrcSdX1SimmDMu0jM3GFS43Xa3AmLAihwUqTnYuEyH7UrcX2
         DMSaMk8qwo2DMzaVUDLmv8d4H+DDleH4MskIrmKPIFNa9UXdLP5Bew9lJJUKdvQARHNr
         9LdkfeQPCdfzhCwphIrC2LKN4r0FwetC7b5ekrHvdQ4up0aaB7KxvfNpGLslxR4CMEIp
         PfzcN1Jy/zfq9w8cuBxScY5XTBGDzZElOGtVn7ZAFKXFq/BNzKXo5sDm+e75Q1akccdQ
         QfjHOPL6Aw6vA3S6ihFvm74M/KsYLVg/pV8JMf6XWLQ3FlV/6h0sPZLOpALfhcRtG62E
         4FiQ==
X-Gm-Message-State: AOAM5327YasPFMIiTal8guWGeSqtduC+VisCTDPiR6wWbOeadXkUNazr
        3Gp9CJP/rolPiWmGjqN62tFaV6qdKQQJdMVqCfhgdXrS
X-Google-Smtp-Source: ABdhPJwFitc4fctNCGzL+an035af/hiZ0EyeHkkdO35NxHNkYJBKqvTtkAKnJdUaC4ZGvsObyOsChpvFN+rEKmpIIyc=
X-Received: by 2002:a5e:8e47:: with SMTP id r7mr29172100ioo.204.1592247941114;
 Mon, 15 Jun 2020 12:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 15 Jun 2020 15:05:30 -0400
Message-ID: <CAC=U0a13v6_qS0oa3Tdbf89o3ywSkugu=oMHwR_4gf9ucKg61g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements to spi-bcm-qspi
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

This block is used on multiple Broadcom SoCs and would like to get
comments from all who deal with iProc and have touched this file as
well.
Please copy :
Florian Fainelli <f.fainelli@gmail.com>
Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
and
bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM SPI DRIVER)

Kamal

On Mon, Jun 15, 2020 at 12:06 AM Mark Tomlinson
<mark.tomlinson@alliedtelesis.co.nz> wrote:
>
> This series of patches came from a single large Broadcom patch that
> implements drivers for a number of their integrated switch chips. Mostly
> this is just splitting the qspi driver into smaller parts and doesn't
> include much original from me.
>
> Mark Tomlinson (5):
>   spi: bcm-qspi: Add support for setting BSPI clock
>   spi: bcm-qspi: Improve debug reading SPI data
>   spi: bcm-qspi: Do not split transfers into small chunks
>   spi: bcm-qspi: Make multiple data blocks interrupt-driven
>   spi: bcm-qspi: Improve interrupt handling
>
>  drivers/spi/spi-bcm-qspi.c | 189 ++++++++++++++++++++++---------------
>  drivers/spi/spi-bcm-qspi.h |   5 +-
>  2 files changed, 115 insertions(+), 79 deletions(-)
>
> --
> 2.27.0
>
