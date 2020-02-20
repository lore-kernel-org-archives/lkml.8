Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF3C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4792467B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582190504;
	bh=o7emLQ8G4ybHBADSYTkl7UcF8plupI0v+fzIXCTR3s0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=etqzVj2wTzAV9asdEauMhfv8d024LAMP4siOJI2Rjw5ams7uSI9DtcQeKNvqKMBwI
	 aTPK02zmTNUnDMuO6VWCfxTxa0dX0+le0B3mqwqcuj47X4Mx0NK5CGY/zEighhCeZh
	 OcImE6VzYUj0aqIKH+I4vDj1/aCWyCs7BIZmeasY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTJVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:21:43 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F44B2467B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582190503;
        bh=o7emLQ8G4ybHBADSYTkl7UcF8plupI0v+fzIXCTR3s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3suDMIOMPfg0PyCMSwGTsI6vmhxg3dG7cTiQPqDNHyGwHzOTvd6OceOzoQIXrQ+t
         hhIm7PK1PLr5nFZLfm2vI63EGcUi4bkeMibxf0jVsTd+eCBXwAc1QexlWya+zkNvRf
         ThtTaAf5zvF+7DEEaOE99l+LCdIGsTjhOaPpe7vk=
Received: by mail-wm1-f53.google.com with SMTP id a5so1186997wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:21:43 -0800 (PST)
X-Gm-Message-State: APjAAAVO9SYLAFtHOcMve/b2eTgiLd74lm7IREfJkgUvslO0LVxhalaZ
        5SET5lBG84eVVpLyddyvifs7hqF9gN3CaC2Tod8FSQ==
X-Google-Smtp-Source: APXvYqylKi+HKLokR0+lqgERlKcgEjSrkJqeR5Xg1UtM54odKXFIDNYSdZxM+tDoCulLawQ2Z1FxlrES8lM3xvPTQGI=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr3245339wmf.40.1582190501386;
 Thu, 20 Feb 2020 01:21:41 -0800 (PST)
MIME-Version: 1.0
References: <1582289580-24045-1-git-send-email-jingxiangfeng@huawei.com>
In-Reply-To: <1582289580-24045-1-git-send-email-jingxiangfeng@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 10:21:29 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu930691BaDLuoVOU_gz0V8MtfWbfSTKcYuHxDvLz5hAiA@mail.gmail.com>
Message-ID: <CAKv+Gu930691BaDLuoVOU_gz0V8MtfWbfSTKcYuHxDvLz5hAiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: Support to find mirrored memory ranges
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 at 04:43, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> This series enable finding mirrored memory ranges
> functionality on arm64 platform. This feature has been
> implemented on the x86 platform, so we move some
> functions from x86.
>

Hello Jing Xiangfeng,

Could you explain your use case a bit better? Usually, the firmware is
a better place to make modifications to the EFI memory map.

The reason I am asking is that currently, on ARM and arm64, we never
make *any* changes to the firmware provided tables (EFI system table,
EFI memory map, DT/ACPI/SMBIOS tables etc), in order to ensure that
kexec is idempotent, i.e., it will always see the exact same state as
far as the firmware is concerned. This is a bit different from x86,
where the memory map is already modified for various other reasons, so
using it for fake memory regions is not such a big deal.

Do you see a use case for this in production?

> Jing Xiangfeng (2):
>   efi: allow EFI_FAKE_MEMMAP on arm64 platform
>   arm64/efi: support to find mirrored memory ranges
>
>  arch/x86/include/asm/efi.h      |  5 -----
>  arch/x86/platform/efi/efi.c     | 39 ---------------------------------------
>  drivers/firmware/efi/Kconfig    |  2 +-
>  drivers/firmware/efi/arm-init.c |  2 ++
>  drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
>  drivers/firmware/efi/memmap.c   | 16 ++++++++++++++++
>  include/linux/efi.h             |  5 +++++
>  7 files changed, 47 insertions(+), 45 deletions(-)
>
> --
> 1.8.3.1
>
