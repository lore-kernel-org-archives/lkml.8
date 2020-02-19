Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F989C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A4A2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSJnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:43:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:33426 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:43:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE0F12E5;
        Wed, 19 Feb 2020 09:42:58 +0000 (UTC)
Date:   Wed, 19 Feb 2020 02:42:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: arm: tcm: Fix a few typos
Message-ID: <20200219024253.3ce1d2b2@lwn.net>
In-Reply-To: <20200218163829.13066-1-j.neuschaefer@gmx.net>
References: <20200218163829.13066-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 17:38:25 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/arm/tcm.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arm/tcm.rst b/Documentation/arm/tcm.rst
> index effd9c7bc968..b256f9783883 100644
> --- a/Documentation/arm/tcm.rst
> +++ b/Documentation/arm/tcm.rst
> @@ -4,18 +4,18 @@ ARM TCM (Tightly-Coupled Memory) handling in Linux
> 
>  Written by Linus Walleij <linus.walleij@stericsson.com>
> 
> -Some ARM SoC:s have a so-called TCM (Tightly-Coupled Memory).
> +Some ARM SoCs have a so-called TCM (Tightly-Coupled Memory).
>  This is usually just a few (4-64) KiB of RAM inside the ARM
>  processor.
> 
> -Due to being embedded inside the CPU The TCM has a
> +Due to being embedded inside the CPU, the TCM has a
>  Harvard-architecture, so there is an ITCM (instruction TCM)
>  and a DTCM (data TCM). The DTCM can not contain any
>  instructions, but the ITCM can actually contain data.
>  The size of DTCM or ITCM is minimum 4KiB so the typical
>  minimum configuration is 4KiB ITCM and 4KiB DTCM.
> 
> -ARM CPU:s have special registers to read out status, physical
> +ARM CPUs have special registers to read out status, physical
>  location and size of TCM memories. arch/arm/include/asm/cputype.h
>  defines a CPUID_TCM register that you can read out from the
>  system control coprocessor. Documentation from ARM can be found

Applied, thanks.

jon
