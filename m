Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1544BC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9777217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nnWTpEg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANEwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 23:52:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40202 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANEwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:52:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so12145834wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kdjzg/OEJ3U/n4z5ghVCYhNKmhmqsmyxQa/XtrqBQiU=;
        b=nnWTpEg+MgOnuUhZXlIaKchwkY/TwJoS51ktgSnLLxjhRjBlYi+D6OBCmdwyfLdzLe
         873MHwbfUdBmKv1qTe1SN6rVUTg0KbSYQXKmTcqDDotrcUDEGA8mz7b3CzAOoMhKt2T3
         GglM21MyVfjQd87kNLWNbsWtI5rN9drI5n2jB5xDyS99MQh9m1X1y8FGXk8HAxySqXzT
         AQU5xfswknreI83h58ZSDJBF0BZJUJlAME7SpQuO2+VKGR1N93RY/Wcypnm7HT8Do8T2
         A+J7/jkYCNx9a9k0WmcZtMouAf7u61tdGByBJIJ1nF0lyiFbIjjkKQ8V1UWoesDGPNo9
         5SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdjzg/OEJ3U/n4z5ghVCYhNKmhmqsmyxQa/XtrqBQiU=;
        b=Wa1c/A4DsxT3XXSAfmLL/15VHpTzNjuQZCDWwCf1aFMoPiGLDxCdLc5xDJmko9KhV4
         VdHigNXL3+tP82gstIJbnrTeLZGms+lBG/Jdo0hgQZ00Z4FmDVS2VYJxEs6wW9opz7Sy
         OZ+xeTD4s5M2PGHi0FqKKhyyNVOdIYofXVTGsar5tJnpNDIo7ayTRzPlSYpc4/sEpti/
         TYqhex4+64WpI3IhBaD9SbyxDpzoq55HuQEGxMGBPfHEIr9BYPApKIwe17WdAtVf0Uih
         d8XG94vuZQYdnMzBQkgMiWDc+ba8aSeJapuJs4q2w8FLltLC/dTHO73yR2n8T81bWJJm
         Ohnw==
X-Gm-Message-State: APjAAAUhsVi14X6MVU4PrJIFkQnRv68eDTgI8LrpJoK5S85tHzGJQqqk
        XojLTea/W0Quey/uGkOzlWF21cYl2ZGdjyCfcNELsw==
X-Google-Smtp-Source: APXvYqxekq8Q6Ko5YGFKD2N3dqW+2HgsyXZWMWzqcM/WcztnksE1zFepCPnkkoyvQYT4vbpacWQUb9tjyzLTD/sEnZE=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr24014206wmk.124.1578977548667;
 Mon, 13 Jan 2020 20:52:28 -0800 (PST)
MIME-Version: 1.0
References: <1578897500-23897-1-git-send-email-yash.shah@sifive.com> <1578897500-23897-2-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1578897500-23897-2-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Jan 2020 10:22:17 +0530
Message-ID: <CAAhSdy2sxmmZDqHx401RA4pm8Vn8sx0ocjNOmYGXHokfNrgNXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: cacheinfo: Implement cache_get_priv_group
 with a generic ops structure
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:09 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> Implement cache_get_priv_group() that will make use of a generic ops
> structure to return a private attribute group for custom cache info.
>
> Using riscv_set_cacheinfo_ops() users can hook their own custom function
> to return the private attribute group for cacheinfo. In future we can
> add more ops to this generic ops structure for SOC specific cacheinfo.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/include/asm/cacheinfo.h | 15 +++++++++++++++
>  arch/riscv/kernel/cacheinfo.c      | 17 +++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>
> diff --git a/arch/riscv/include/asm/cacheinfo.h b/arch/riscv/include/asm/cacheinfo.h
> new file mode 100644
> index 0000000..5d9662e
> --- /dev/null
> +++ b/arch/riscv/include/asm/cacheinfo.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_CACHEINFO_H
> +#define _ASM_RISCV_CACHEINFO_H
> +
> +#include <linux/cacheinfo.h>
> +
> +struct riscv_cacheinfo_ops {
> +       const struct attribute_group * (*get_priv_group)(struct cacheinfo
> +                                                       *this_leaf);
> +};
> +
> +void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops);
> +
> +#endif /* _ASM_RISCV_CACHEINFO_H */
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 4c90c07..bd0f122 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -7,6 +7,23 @@
>  #include <linux/cpu.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <asm/cacheinfo.h>
> +
> +static struct riscv_cacheinfo_ops *rv_cache_ops;
> +
> +void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops)
> +{
> +       rv_cache_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_set_cacheinfo_ops);
> +
> +const struct attribute_group *
> +cache_get_priv_group(struct cacheinfo *this_leaf)
> +{
> +       if (rv_cache_ops && rv_cache_ops->get_priv_group)
> +               return rv_cache_ops->get_priv_group(this_leaf);
> +       return NULL;
> +}
>
>  static void ci_leaf_init(struct cacheinfo *this_leaf,
>                          struct device_node *node,
> --
> 2.7.4
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
