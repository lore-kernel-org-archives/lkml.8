Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B19721473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3g9j1xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDSJvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbgDSJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:51:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85014C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:51:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w145so5420728lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9JI33hna/+DxESkUc7SCOMzfYQhchoF06eN0/wfACI=;
        b=p3g9j1xnjdCtzhbgZS6lVhDB+mXR+o9+FTp1/dXRbri/Wmu8K7EsTY54Buw14cqV/t
         VKxBLkOHqGwNawDndp5tVo/S7shTTp5VMCP5HXlx8k/HYr2tWG8IWRdGbpqCALRIZzQM
         Uz+TJKMudQF8GP6epv9M+qUY0yPfFOA3Rtftp5MoijLCN0kLYX66lDmQHN005k+sIOr/
         4WL3/aPNX72Hze9blP2PGXgcyc7ChGVoR33ORT9uk0i6aKO5Tp5fvInqHRq/KFyuRFxh
         70sd1Nm6cx1GNlcjDDS6kH2o/l0cYZ87Zsa8nqUlRZhyHhUD5FqIDNJ3V6gaweMl1PwH
         Ge+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9JI33hna/+DxESkUc7SCOMzfYQhchoF06eN0/wfACI=;
        b=PdfkTXzF41FMiNilC8ETAxP4oBuVzfRmIAcHNtwEOJk5VeDh1yAs597tcSvRxvEBEJ
         sliPtWMs5cpANPoZN47ZopCKcMLhQaeewGQcHpGO1Pof4Z/MnJO0h7+xvo12ojhw5alG
         uQTGxwtKajNAHOfmLZaztzIbf9ToLl6sxoNwNDcAcGySEtwO1mfO4GAdZlTtYVMUC6od
         6xyRoVTcc7eScAwId9c2wlaLjKPv0pE4JxA+ww5QGro6t+5S/HSZWMMDo0IskEqzbGGC
         TP6MKbuEYRj3CmVBHCxLc5bGsBtyjYRb8PzRaT41m5rqvzWyaAUAjPyf7W88KKTF4QYB
         NNFw==
X-Gm-Message-State: AGi0PuZtgTStrOc/UZ9Pk+3i/aMVBB1DbGt8aiF+70JCgB2E33ut+vnD
        rOUtOsd4YffKIwF259IHxPHcAC5QqWEGutoOuL1CGg==
X-Google-Smtp-Source: APiQypIlD7DYc2IomXQqpRtLDysv7ESAnj92UknD/T+xCMSjLv6O3t2ovN2pL1+lrcMzWtZaNVqxUacU/pQItDMN1+I=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr7019601lfe.47.1587289892894;
 Sun, 19 Apr 2020 02:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200418081637.1585-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200418081637.1585-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Apr 2020 11:51:21 +0200
Message-ID: <CACRpkdZ347msE7ohENGw1nBLJX1zQybywKoMA8HgZ6Cc6d9Z-A@mail.gmail.com>
Subject: Re: [PATCH] PCI: v3-semi: Fix a memory leak in some error handling
 paths in 'v3_pci_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 10:16 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> IF we fails somewhere in 'v3_pci_probe()', we need to free 'host'.
> Use the managed version of 'pci_alloc_host_bridge()' to do that easily.
> The use of managed resources is already widely used in this driver.
>
> Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
