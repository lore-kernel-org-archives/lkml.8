Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB365C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD224655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8AesVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAWMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:31:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38315 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:31:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so1302166plj.5;
        Thu, 23 Jan 2020 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TITrwanSGiU03FmHy+zum6Nkoqyj/cmVKfyRMr4GNWo=;
        b=id8AesVWOlIhfnb+lp2I+MnTAT2ey6G20E+NiVRUdkSy4HrZd4KWmyL8WWoWJ1nWnC
         fbryARk6Sotm4FAz4TgBCoLo71GbzbvAQMlBtot+4O0CnDNtb9YU4Um04juN7Mk1qwpJ
         XNNHLOANMM02Czx8lM3DbVWoONeposIlLmcEGUzWuD0iaXr/JOOsnScCKs3SKiju+NYS
         BQ+uuau/50hCFZ2+AcRoR8ZuiLhQu9zZcCRDwaZCjNdPSm+3b06CqzvcX/v2ZaHDthwv
         ops0NfrG+j3ERvq6PEbZOJ7xhU0/qXZSW0H/9a4kaG0zez4qnR8kxtZ1eYYwICrFXjsp
         PYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TITrwanSGiU03FmHy+zum6Nkoqyj/cmVKfyRMr4GNWo=;
        b=BUR4sjuqE0ra7veRZnoHRkxiO16NqT3s4RIWi3XuoSmHEJrL/kaapaBUy5eGtQlFaq
         6VcV+XxBXEko990H8o0EOBOGIvS3FDVAEmDQ8epXIvzgTizO3AzYe1XXj0GyUT+eAb3K
         0gMlf33ZRwUyxc4HkPzOKzSh3s0f2syODIUOJponIPFy7R0JgZ0bwV4j6YAwyRUcCp4C
         neeX/TgU673tO09Pq3qId7jkjecUPQkCQjIPYkiU6+/nQksRQ/oe7u++QazqmQB0STqf
         3VqwL0Aa+RhmQgT/UGHVk3nM4fCc3QTrzkUe/DlycZu6jyr0G0naaVXJZy3iDsG3KPpA
         sCxA==
X-Gm-Message-State: APjAAAUizKRi15/xeyy740Wjw1y6TEoAbUSZxDJR2QJIytu3iXVpC4Tr
        y2MswVoYblBA+cDYh5H4uBrwPz5fDP7Qj9BtZXw=
X-Google-Smtp-Source: APXvYqzpzxV1B6BZar8ghIA1x+GCPO6IVcHS+YMO7C2DJjhLGiy+Yf/fnfDcSDkEjknCBhmm/hwt/d/lUaNV9ytxENs=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr4321527pjb.30.1579782700146;
 Thu, 23 Jan 2020 04:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20200122164619.73563-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20200122164619.73563-1-mika.westerberg@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jan 2020 14:31:31 +0200
Message-ID: <CAHp75VcTeT0Brhe+in-XKfwwaaXSwfRK0ceNVgUPd_TOpk1TqQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] platform/x86: intel_pmc_ipc: Cleanups
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 6:46 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> This is another independent cleanup series that I split out from my SCU/PMC
> IPC rework patch set [1] as suggested by Greg. This removes code that is
> not used anywhere and makes certain functions static as they are not called
> outside of the driver. We also make the driver to use driver->dev_groups to
> expose sysfs attributes.
>
> [1] https://lkml.org/lkml/2020/1/21/678
>

Pushed to my review and testing queue, thanks!

> Mika Westerberg (9):
>   platform/x86: intel_pmc_ipc: Make intel_pmc_gcr_update() static
>   platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
>   platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_raw_cmd() static
>   platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
>   platform/x86: intel_pmc_ipc: Drop ipc_data_readb()
>   platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
>   platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
>   platform/x86: intel_pmc_ipc: Propagate error from kstrtoul()
>   platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups
>
>  arch/x86/include/asm/intel_pmc_ipc.h |  32 --------
>  drivers/platform/x86/intel_pmc_ipc.c | 114 ++++-----------------------
>  2 files changed, 16 insertions(+), 130 deletions(-)
>
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
