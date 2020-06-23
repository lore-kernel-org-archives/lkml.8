Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBB3206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592923030;
	bh=mkt8dmPDhXNmt2xf23Tm96zuc+IIftb4GzsYnAog1gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TIelzdwJBL3KYry7JgC8gOrgLOB4QB7kvHGr9Y+LmxV0snIe/QLjZj6jwj4ULv9W2
	 0SzWMTQieVIwwJdGk57XAi4i6lbBQGNx6nCxuxkog7N7un9Rq9Y3+4ICPRdoZyceMZ
	 Y9mlBG7DQ1JTuN6Vvmt6IpDkec3DJRv8UDEgM6l0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgFWOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgFWOhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:37:08 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94AA20776;
        Tue, 23 Jun 2020 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923028;
        bh=mkt8dmPDhXNmt2xf23Tm96zuc+IIftb4GzsYnAog1gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nrckng5bhZywoY2H4UQEn8ZatmqTxurbAUbnXWiUCmbZZDTgj7xj3HI4KK4Usolu3
         DAu0alGoTzXr16Vm52qbehY4kwbd8ozxR+XMTCt2W4Yt6QKN58HzyZygJw8gCBjNNc
         idTyGSKrHvbraiB0ZDtgL+XjksVYkGoi1duT6krE=
Received: by mail-lj1-f179.google.com with SMTP id q19so23746091lji.2;
        Tue, 23 Jun 2020 07:37:07 -0700 (PDT)
X-Gm-Message-State: AOAM533shaZOb6nSP3rLBKbLr/hHqrG3IslbD89GSRWDwcA4Tk4wSMr4
        kUcAPEV6wx3htN/pXukaau2RUws9rnBCThQ1crM=
X-Google-Smtp-Source: ABdhPJwAKP2RwWCfrk1lzjJQi1Ti/32Bj7LA/Y6jCdNCwky8kwiheblaoXr2cW9hCKV23rZ6oFRVXfEvEvSTJfd3h1c=
X-Received: by 2002:a2e:954c:: with SMTP id t12mr11068568ljh.287.1592923026058;
 Tue, 23 Jun 2020 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
In-Reply-To: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jun 2020 16:36:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdr6Fq93e8yZUPB_PGWfY4X9+fvWGznkUy=0DQ8=QeiKw@mail.gmail.com>
Message-ID: <CAJKOXPdr6Fq93e8yZUPB_PGWfY4X9+fvWGznkUy=0DQ8=QeiKw@mail.gmail.com>
Subject: Re: krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     gtucker@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 16:23, kernelci.org bot <bot@kernelci.org> wrote:
>
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
>
> Summary:
>   Start:      d6fe116541b7 Merge branch 'next/soc' into for-next
>   Plain log:  https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
>   HTML log:   https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
>   Result:     5b17a04addc2 ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       krzysztof
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>   Branch:     for-next
>   Target:     bcm2837-rpi-3-b

Looks like false positive. The commit does not touch anything in arm64/bcm.

Best regards,
Krzysztof
