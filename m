Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F42067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596547301;
	bh=wm1oWIkz07CI36FMnq4rtXhsNGI+Mj4JBSlrCfDJPAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gf2avnPwwSrQs3hMxSQWJdx36bQ+m/0hcxEZT5iSPY1ZnHjLGXdG2hafFcVPSFE4b
	 8noLiUDHA5waNZysFTCE9GbE5Q6/F7pBI5jIQYI/IAhW5XZb43+yyQwaCHrk//SY5H
	 dDHoJ8dJcaSeYdAfANfW30w2OBI6JdXH+czUtypw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgHDNVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgHDNSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:18:53 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AEE208C7;
        Tue,  4 Aug 2020 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596547094;
        bh=wm1oWIkz07CI36FMnq4rtXhsNGI+Mj4JBSlrCfDJPAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0jgn1VYqfdxa5LdhVuzklR9cLtBODKcqNJ3aBUxv4msLpxK6Sz3egMCyEhYBSiCKB
         3p+23CyCty+EfglMWaGZyDH6lSCnMIdQjMUbpmFpBR6RemHzEP7Iru2dR2i0xg/jFS
         ws7XFMfZlkhTK/LIBlLFHdZY9RlLwyMK2llPUhtE=
Received: by mail-ot1-f47.google.com with SMTP id e11so6313662otk.4;
        Tue, 04 Aug 2020 06:18:13 -0700 (PDT)
X-Gm-Message-State: AOAM531qsNqX5wxYnokEWFlcaBe//Vl2+XFckS/6/HPlqYx6F5OxNKBf
        ECgeTougaMwfBv/8EUpAEQVQoYk0nra/jmJlqFs=
X-Google-Smtp-Source: ABdhPJzHxSRDNEtGr5s2Fp+eY2I9/mBGbmaBN6cxwMOl06eur/SxYwUp7Y6U9Pc9z5WiTzXxj2I/7LwkJQ/wxudGz9c=
X-Received: by 2002:a9d:3a04:: with SMTP id j4mr17263203otc.108.1596547093325;
 Tue, 04 Aug 2020 06:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200804124417.27102-1-alex.bennee@linaro.org>
In-Reply-To: <20200804124417.27102-1-alex.bennee@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Aug 2020 15:18:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
Message-ID: <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] put arm64 kvm_config on a diet
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 at 14:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Hi,
>
> When building guest kernels for virtualisation we were bringing in a
> bunch of stuff from physical hardware which we don't need for our
> idealised fixable virtual PCI devices. This series makes some Kconfig
> changes to allow the ThunderX and XGene PCI drivers to be compiled
> out. It also drops PCI_QUIRKS from the KVM guest build as a virtual
> PCI device should be quirk free.
>

What about PCI passthrough?

> This is my first time hacking around Kconfig so I hope I've got the
> balance between depends and selects right but please let be know if it
> could be specified in a cleaner way.
>
> Alex Benn=C3=A9e (3):
>   arm64: allow de-selection of ThunderX PCI controllers
>   arm64: gate the whole of pci-xgene on CONFIG_PCI_XGENE
>   kernel/configs: don't include PCI_QUIRKS in KVM guest configs
>
>  arch/arm64/Kconfig.platforms    | 2 ++
>  arch/arm64/configs/defconfig    | 1 +
>  drivers/pci/controller/Kconfig  | 7 +++++++
>  drivers/pci/controller/Makefile | 8 +++-----
>  kernel/configs/kvm_guest.config | 1 +
>  5 files changed, 14 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
