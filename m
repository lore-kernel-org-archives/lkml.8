Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA43A206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028382;
	bh=zy8k+1eN3+gm4KsCC12pnROL4Y4wTaQRf9SLMs6D5jE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bU1VxBgGPAjKw62WKD4CKPDEJZT9U5J/mR+YhwGIZR+o6wSdRiJpyqO594jcZUTSG
	 Ffnj3c2OeUtzXoHyKg3R3NSjq2LHiHGoNVAsQtGcsQ7Yn+XQkRPqYaWpMEUx5hokx3
	 AmaP9W4rXMUvNqI6/BsWVqG+Yd0UcKzVdHRc9VGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHUQqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgHUQqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:46:05 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C961420732
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028364;
        bh=zy8k+1eN3+gm4KsCC12pnROL4Y4wTaQRf9SLMs6D5jE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RKXK/WvnJwGTbCl1n4XKRQVUIl33WgHAJtjzEpCAm6vM+5ZV7vxYopf3l3n4e3MT6
         T34D3XAl4qSGHiXzuNxjJ/cNkNCjknc94+EtVmlUohEsKugF40oPAFiBiGknPoflAO
         wNQY3Cm54EXT/ZnE3t/kun+EBLfMrHrF6XPqsVns=
Received: by mail-ot1-f43.google.com with SMTP id q9so2067674oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:46:04 -0700 (PDT)
X-Gm-Message-State: AOAM532L2WFMhoXltz5ZxJcUKcfnwy8/xJ+1KAIddwqlKXT0Ox3Kqe5l
        xSFZbtIQGVyCEKi6NYp/9Wjd8QzXVlNhuLDKBQ==
X-Google-Smtp-Source: ABdhPJwBdt8FRpGaCU2dwiEpVuhUVKBmRWiUDQJTPr2yqm53JFLkEOBpsYBroQRaAxrctm46coQeobYVctdwV5H/ECI=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr2633205otp.192.1598028364153;
 Fri, 21 Aug 2020 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154848.GI7871@localhost.localdomain>
In-Reply-To: <20200821154848.GI7871@localhost.localdomain>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Aug 2020 10:45:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Message-ID: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV) maintainers
To:     Steve Wahl <steve.wahl@hpe.com>, Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Joe Perches

On Fri, Aug 21, 2020 at 9:48 AM Steve Wahl <steve.wahl@hpe.com> wrote:
>
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

get_maintainers.pl doesn't work on MAINTAINERS. You need to send this
to the maintainers of the files listed in the entry below. Looks like
that would be the x86 maintainers.


What did Mauro, David and I do to become MAINTAINERS maintainers?

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(commit_signer:127/806=16%,authored:80/806=10%)
Rob Herring <robh@kernel.org> (commit_signer:103/806=13%)
"David S. Miller" <davem@davemloft.net> (commit_signer:99/806=12%)
linux-kernel@vger.kernel.org (open list)


Can we make --no-git-fallback the default? It's useful for
informational purposes, but never for who to email patches to. Having
no output would be better, then submitters have to think about where
to send patches.

What ever happened to splitting up MAINTAINERS to subdirectories? That
would help routing MAINTAINERS changes to the right maintainers.

Rob


> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..4c2143d8ae45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18874,6 +18874,15 @@ S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
>  F:     arch/x86/platform
>
> +X86 PLATFORM UV HPE SUPERDOME FLEX
> +M:     Steve Wahl <steve.wahl@hpe.com>
> +R:     Dimitri Sivanich <dimitri.sivanich@hpe.com>
> +R:     Russ Anderson <russ.anderson@hpe.com>
> +S:     Supported
> +F:     arch/x86/include/asm/uv/
> +F:     arch/x86/kernel/apic/x2apic_uv_x.c
> +F:     arch/x86/platform/uv/
> +
>  X86 VDSO
>  M:     Andy Lutomirski <luto@kernel.org>
>  L:     linux-kernel@vger.kernel.org
> --
> 2.12.3
>
