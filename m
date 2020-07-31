Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795DEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577A3206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596205690;
	bh=2DDzoTEvi2mddxT9lLfRARLxUxmdBVeTrTZs1z+/sLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q4b80ZBgqF78LLL5oMZEY3gPEqsYWrRHXRvd6MabOtGwZxP+yfrNWodSAFlRMJw+q
	 Y+v+OSRPb6snk8HaA+RpwsEw0Er64G1yd0hCG9wJsm09hN1zeL3nn2/VyJChYKDEsn
	 C418svNgrcmzm272BdPCaskr4lJ/Z08tRbyFOACM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGaO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgGaO2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:28:08 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D117206FA;
        Fri, 31 Jul 2020 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596205687;
        bh=2DDzoTEvi2mddxT9lLfRARLxUxmdBVeTrTZs1z+/sLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPWMkPYv0d+YdRDtV7ZBl8VYCUsKUtuGzZ3lcGY7B64pu58SxCDiVfPGBXr/dsE7U
         xoyIp+1aJl7qSCBoNgAsrywkaVn/i88E9BpRI7oCF3kY00jcAXVHkl5N+Gk/C+VcTy
         mqgV+ffMMkSaJlZSg51sHrhcmYR+DThu1nVEkci0=
Received: by mail-ot1-f47.google.com with SMTP id r21so12235382ota.10;
        Fri, 31 Jul 2020 07:28:07 -0700 (PDT)
X-Gm-Message-State: AOAM530IoZle1aDx09HhOl750z2VneBzo5MCAT9VClaMHVik2JJ1N66G
        qzOMKPc4J1gFKxyGeqQnuxmb+eEsl1ngXrGbFg==
X-Google-Smtp-Source: ABdhPJxGxwIJ86oXli/RPhBXKuV6VyqST1I6tsLPJ1zlSE/S8vl2zIrkuDu8zGTs/3U8ENQJSqIiq5Xg8IcrYDqoUzM=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr2964725ote.107.1596205686998;
 Fri, 31 Jul 2020 07:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200730005614.32302-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200730005614.32302-1-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 31 Jul 2020 08:27:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPO155zVMqvWbGd84e1Ypk1SJDySU8YCRRA+uy7wtcHA@mail.gmail.com>
Message-ID: <CAL_JsqKPO155zVMqvWbGd84e1Ypk1SJDySU8YCRRA+uy7wtcHA@mail.gmail.com>
Subject: Re: [PATCH] of_address: Guard of_bus_pci_get_flags with CONFIG_PCI
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 7:04 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> After 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser"),
> the last user of of_bus_pci_get_flags when CONFIG_PCI is disabled had gone.
>
> This caused unused function warning when compiling without CONFIG_PCI.
> Fix by guarding it with CONFIG_PCI.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
