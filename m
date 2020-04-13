Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E789C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:42:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6291D20735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6291D20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgDMHmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:42:13 -0400
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AAC008651;
        Mon, 13 Apr 2020 00:42:13 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id i27so5394400ota.7;
        Mon, 13 Apr 2020 00:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d708XQKpnHs/u2LgctRBUUp8mQtOH0Q66KFRsQSWh+Q=;
        b=Bbv7QTfdArRZ9fPYMwMyRqaxMpDGu8B+jX5XXByAQCHi1AjPpp6oQeFsR9lOPtkQiC
         ASHH0TO0tCw/ToX2RNMDyN/VHAicN3eQC/2YeOXLxm6gAWVOsOMSzfXcODEHYk0m7BHX
         bXYE3PQ2HqCtEzJAQyqoI24MdJgmIQMCAFfDnhWrtFHx+WmVdStyPWVtdTNiW9Opz6VO
         ZXztHNbw4dKWI5jvarPWZXaqdxkSrBMaZDfBT/Nnc15CHi54chsZSMTwtIV4BlpwM92B
         y5gHRocJseyCpkKZ+llGBwZqj5nDRnoNrbDeYRkUdte7bWTVaRnVkQdecZom7HE+8e3o
         bfXQ==
X-Gm-Message-State: AGi0PuYrKfQJcfM4QZFowIfBVvCRwXlt5TgNGnTgg2gu8zeD9SZx81tp
        uVKDQi1s02pWYVrP2uob89gcCJJbYgB/X/DetXE=
X-Google-Smtp-Source: APiQypIRnInq/orWeaoAPrkHsOfmBEXAmFtHcWXt7jzY5yBQE+fHrQJiHteCrRoPj6ZkngX8ciKhcGkSv1Z7yb3ea/Q=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr13431915otk.250.1586763732609;
 Mon, 13 Apr 2020 00:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200413014743.16353-1-masahiroy@kernel.org>
In-Reply-To: <20200413014743.16353-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Apr 2020 09:42:01 +0200
Message-ID: <CAMuHMdWyouYStBj=kjJuMwgi1ZNQkBC8J+ums7id6t2exOj=WA@mail.gmail.com>
Subject: Re: [PATCH] sh: fix build error in mm/init.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 7:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> The closing parenthesis is missing.
>
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         int ret;
>
> -       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>                 return -EINVAL;
>
>         /* We only have ZONE_NORMAL, so this is easy.. */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
