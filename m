Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDDC206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mah74+Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgFKKh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:37:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbgFKKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591871874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVpU95O+J56tcCcKm/rQbMqFedeKvQz8SMkjM9+3a7I=;
        b=Mah74+TmCgi6+D6HrO50/4lMw1FzZryCQEYUEpxj5sRov2YfkpXf/wN0zQMTkNCqHFKu9j
        oN8CnmmqeEE+ImrGK/1BsGmHoF6mD5XtHq4oPRNuFoXoStnAF+jfcI9EOFNNgDFWUwY257
        bzUdihzpLn8Y4DkY90Nrg1MuWQJSYNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-V2bqYhnhNjSBKC62ZxAhxw-1; Thu, 11 Jun 2020 06:37:49 -0400
X-MC-Unique: V2bqYhnhNjSBKC62ZxAhxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD211800D41;
        Thu, 11 Jun 2020 10:37:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-51.pek2.redhat.com [10.72.13.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA2CC5D9EF;
        Thu, 11 Jun 2020 10:37:40 +0000 (UTC)
Date:   Thu, 11 Jun 2020 18:37:37 +0800
From:   Dave Young <dyoung@redhat.com>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/5] kexec_file_load() for arm
Message-ID: <20200611103737.GA5079@dhcp-128-65.nay.redhat.com>
References: <CGME20200601142806eucas1p2680c5625411e7a695d8469760a926520@eucas1p2.samsung.com>
 <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc kexec list in case people may missed the pieces.
On 06/01/20 at 04:27pm, Łukasz Stelmach wrote:
> The following series of patches provides implementation of the
> kexec_file_load() system call form the arm architecture. zImage and uImage
> (legacy format) files are supported. Like on arm64, there is no
> possibility of loading a new DTB and the currently loaded is reused.
> 
> Łukasz Stelmach (5):
>   arm: decompressor: set malloc pool size for the decompressor
>   arm: add image header definitions
>   arm: decompressor: define a new zImage tag
>   arm: Add kexec_image_info
>   arm: kexec_file: load zImage or uImage, initrd and dtb
> 
>  arch/arm/Kconfig                       |  15 ++
>  arch/arm/boot/compressed/Makefile      |   2 +
>  arch/arm/boot/compressed/head.S        |   9 +-
>  arch/arm/boot/compressed/vmlinux.lds.S |  22 +--
>  arch/arm/include/asm/image.h           |  87 ++++++++++
>  arch/arm/include/asm/kexec.h           |  14 ++
>  arch/arm/kernel/Makefile               |   5 +-
>  arch/arm/kernel/kexec_uimage.c         |  80 ++++++++++
>  arch/arm/kernel/kexec_zimage.c         | 199 +++++++++++++++++++++++
>  arch/arm/kernel/machine_kexec.c        |  39 ++++-
>  arch/arm/kernel/machine_kexec_file.c   | 209 +++++++++++++++++++++++++
>  11 files changed, 662 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/include/asm/image.h
>  create mode 100644 arch/arm/kernel/kexec_uimage.c
>  create mode 100644 arch/arm/kernel/kexec_zimage.c
>  create mode 100644 arch/arm/kernel/machine_kexec_file.c
> 
> -- 
> 2.26.2
> 

