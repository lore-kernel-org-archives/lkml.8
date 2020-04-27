Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CEFC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178952063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587996802;
	bh=Xg8u6B1gRKJJyhc2ghpbZWMsF25bOlRNgkDeAPMsyhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SmfYB3gFxibV6kfnm4YkHkhQLxwy2U5d2SACgnxHxSfp34cD7kp6t1hgny+Fc7L2A
	 6xqaLMu5T0p7An1D2JO7mo3mkXAe3oOSyz9jmxlE24KR0WlxgsgfR6k0+pEtrSFwex
	 NgbNydyYHLBJFdCcTScCrCnQhDAh/Gm5ncrugm8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgD0ONV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgD0ONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:13:21 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CAD32063A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587996800;
        bh=Xg8u6B1gRKJJyhc2ghpbZWMsF25bOlRNgkDeAPMsyhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=osEHPWYdXxkYQ78QupC0ZbxmDHM4nKIFYj+hceaPPcun89vocxPgKHy9Qq40zoUbk
         QrSGQhV62SZsNwG4VYijAjgIkna3Zq5CZv8uSHXvJpUm0nEf2beyNZ5DWzkUmgTNml
         Q4e1Vc2b+Xxgtf65Jn47m5wnj59udKDIW1tjL3uk=
Received: by mail-qt1-f176.google.com with SMTP id x12so13785235qts.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:13:20 -0700 (PDT)
X-Gm-Message-State: AGi0PubIF6YXTfdX4GnVJSw1Pd26mPUtiDnstmb8CcUf6rarSzqnP6so
        wRCw2HSPTfPmP2buFcsolyAQgIVLiNWAQ/kS+w==
X-Google-Smtp-Source: APiQypIvO+0zNT12ohswoL68dXvl6sO1zbOdn5h7ZevGpjPFRFXJndduPs3pSHS2ibmtQnJF8M8fsotgSW9W3De7vbk=
X-Received: by 2002:ac8:7cba:: with SMTP id z26mr23458821qtv.143.1587996798916;
 Mon, 27 Apr 2020 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200420030538.101696-1-wenhu.wang@vivo.com>
In-Reply-To: <20200420030538.101696-1-wenhu.wang@vivo.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Apr 2020 09:13:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK3fpM_tUjHvAMbNzf_nry_iORLXaQBFC8xDK+mxhHDRQ@mail.gmail.com>
Message-ID: <CAL_JsqK3fpM_tUjHvAMbNzf_nry_iORLXaQBFC8xDK+mxhHDRQ@mail.gmail.com>
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level SRAM access
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kernel@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:06 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> A generic User-Kernel interface that allows a misc device created
> by it to support file-operations of ioctl and mmap to access SRAM
> memory from user level. Different kinds of SRAM alloction and free
> APIs could be registered by specific SRAM hardware level driver to
> the available list and then be chosen by users to allocate and map
> SRAM memory from user level.
>
> It is extremely helpful for the user space applications that require
> high performance memory accesses, such as embedded networking devices
> that would process data in user space, and PowerPC e500 is a case.
>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> Changes since v1: addressed comments from Arnd
>  * Changed the ioctl cmd definitions using _IO micros
>  * Export interfaces for HW-SRAM drivers to register apis to available list
>  * Modified allocation alignment to PAGE_SIZE
>  * Use phys_addr_t as type of SRAM resource size and offset
>  * Support compat_ioctl
>  * Misc device name:sram
>
> Note: From this on, the SRAM_UAPI driver is independent to any hardware
> drivers, so I would only commit the patch itself as v2, while the v1 of
> it was wrapped together with patches for Freescale L2-Cache-SRAM device.
> Then after, I'd create patches for Freescale L2-Cache-SRAM device as
> another series.

There's work to add SRAM support to dma-buf heaps[1]. Take a look and
see if that works for you.

Rob

[1] https://lore.kernel.org/lkml/20200424222740.16259-1-afd@ti.com/
