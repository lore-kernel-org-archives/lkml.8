Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B1620656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRmAh+yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgFHIIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:08:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729011AbgFHIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591603677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZbN71+DLOQDLMNnWvQpaN1N2Hub7a1AniDuqT74J44I=;
        b=JRmAh+ycXt69Cfk7HyNItOR+waL1agt4DbX141wIvqhgFBgPW5r+7SsJlqqA8DVF87pxzo
        mZkULe6iH+GTKui1TPJfM1Vx6sqF4NY41zGwWPt3++7gWxiUQVgRN59wA/EJddRwW2LtAY
        7f2cLtDcHxf8+jLa2v9runTSQpPbzzc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-Pmfw7qhiOKCLnAqIgPfowA-1; Mon, 08 Jun 2020 04:07:56 -0400
X-MC-Unique: Pmfw7qhiOKCLnAqIgPfowA-1
Received: by mail-qk1-f199.google.com with SMTP id p7so13630282qkf.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 01:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbN71+DLOQDLMNnWvQpaN1N2Hub7a1AniDuqT74J44I=;
        b=tZUNDOwmObWQ7aPsQGIHuMZqOY87HW34SNTNOBcV24zsS6AXZlN8BmSz86bUY6baIB
         X2Wj2oI+cAvnBmHBgfKfLI+rOnoZCbN6aK7rXk4k0KW/48HPeCuspfidbTI8M9CiAtIc
         QWUUbdIJJFa8+ceeQTW1hQ9rgurbzk1XV4ZdMWSLqPTIfq3U9+pNkz+2Ky8eBbYGP1xE
         LCiNd0pEYWMPvYBj9T9D7a2/2thYjqr8ARHPUt6MbuA/YNnACDGAEepdxPD96GZUsweU
         0O80yej7gbw/S1/66qYYh55kb085j9g31ZbXwlOqHd8R1pz2/7B64mxCeVGAp8ggIei2
         XDCw==
X-Gm-Message-State: AOAM532OgUzW3RPCtZZIqZyiFd2jsIQndtPIgkmII5eOf486g4A962FP
        dBRRtQBvGYswp8jMXNaW5kpGB23AkDN4dUyjO+1pVrk3t77pEMy7J9ynf28n5EdHdqHiei4ZpHK
        W35jAbnDxKMYJf2Sbo8WH2YWe7EI/BOhUZdne+DSi
X-Received: by 2002:ad4:4d8f:: with SMTP id cv15mr21509534qvb.195.1591603675835;
        Mon, 08 Jun 2020 01:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWj54BrhXlaXyGur0GgPLTutUYY8qIY0pbnzZPMB2tmAwlSKjBWtONJhERHg/zCg3vBVkCjREgic7BjZKcplA=
X-Received: by 2002:ad4:4d8f:: with SMTP id cv15mr21509514qvb.195.1591603675583;
 Mon, 08 Jun 2020 01:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200605194642.62278-1-pasha.tatashin@soleen.com>
In-Reply-To: <20200605194642.62278-1-pasha.tatashin@soleen.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Mon, 8 Jun 2020 13:37:42 +0530
Message-ID: <CACi5LpNvBaAVibj_XpLm1=zk8oUDXpWGZyZJ=TLBkimoUoiD8A@mail.gmail.com>
Subject: Re: [PATCH] kexec: dump kmessage before machine_kexec
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, sashal@kernel.org,
        pmladek@suse.com, Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, "Luck, Tony" <tony.luck@intel.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sat, Jun 6, 2020 at 1:16 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
>
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
>
> Here is example of dmesg data collected after kexec:
>
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..50027f759a97 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/frame.h>
> +#include <linux/kmsg_dump.h>
>
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -1181,6 +1182,7 @@ int kernel_kexec(void)
>                 machine_shutdown();
>         }
>
> +       kmsg_dump(KMSG_DUMP_SHUTDOWN);
>         machine_kexec(kexec_image);
>
>  #ifdef CONFIG_KEXEC_JUMP
> --
> 2.25.1

LGTM, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.

