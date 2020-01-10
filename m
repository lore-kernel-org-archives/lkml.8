Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C5C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69512080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHeg3zcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgAJJsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:48:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37005 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgAJJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:48:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so988295lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FFFiRJG2Dmj1usFksXLqBJzjpKKPyDXbH4wvjVOZ1fI=;
        b=fHeg3zcYAN6IsU2PBo8d8qUA5VIjV7aP5xIopvN9+GYaWvabxKQdPZmjlp0elLlMF0
         cAlgVxJbtY1aUQfL7gecLka+OXevllMONO5rb7KjGKZoCSHI648HqWeHXbCLSdWJzs5H
         /fyMLojFbJXZpABWDfDKoEN29rnyISYwIOiYbKWR4vL5sqv9d6yjuVxRMeCkyeO3RJZS
         7KC011LldD+8Im5wFPSTICt06key7gj77rLCu0CaWsC/0FA0nf5343ga0Nch1ywFcdcC
         m6FC1b8wWbTMh3/ZqMcWG+MtfFnwR7sxuNNLxLLAs8FMXzet/DWsZVg2QUXjaLIsKXLa
         gaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FFFiRJG2Dmj1usFksXLqBJzjpKKPyDXbH4wvjVOZ1fI=;
        b=mpo/fY/XzbNai9HXjkGV8ErbCncbUCQVxUtxiPCkawTrmkcqq9Ihmbvx4tUYCAXuXx
         pcLu0OnK4+3Msej9zZAQcZ1RFUCHgq55Dzqfe/9j0DPrdXCergbAnYze8n/vANk6O3yW
         J+w6NwnPVOOpEnmTu7MaLaJaSIhNtlbqipB/z7yR8O4mS8tJeNYs4wVQ6ziSkJDpoKAh
         Xk7+TVtAOWFRHc46YT5vKviIZagKOElUUxRl9AOUeth1ydh3RQJDp6NeGoYyLBXNP3hx
         eEUOkpd5V9jUHZmjUEmq2jHGrrAoT3x6IXBaE5Tm7U2pVuEIWyb7TWwql4kTtTcGGqTR
         3s/Q==
X-Gm-Message-State: APjAAAUji1X69V7siTr62u6TGvevCbwT0LQRZhklKWPIlmpScffyFspD
        t7qjP94Mbmm/NSAE6ZMcg4ToJEU80rXLW04+CQjwOA==
X-Google-Smtp-Source: APXvYqy1hKppXBuZzaJ8wvQHVvxsOwK2OC2jrtZeqo2fPHlYKSjgOOm97Jf6kySEAch4zMkOG4k8gTAMgGlr7szdTvI=
X-Received: by 2002:ac2:599c:: with SMTP id w28mr1784527lfn.78.1578649699221;
 Fri, 10 Jan 2020 01:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20200110094304.446-1-zhenzhong.duan@gmail.com>
In-Reply-To: <20200110094304.446-1-zhenzhong.duan@gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Fri, 10 Jan 2020 17:48:07 +0800
Message-ID: <CAFH1YnOuRgbOu6Dz-hgowAxN41+04pjQHW25QCnT5ZRsR=E9DA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot/KASLR: Fix unused variable warning
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I mean [PATCH v3]

On Fri, Jan 10, 2020 at 5:43 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> w=
rote:
>
> Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
> If any of the two macros is undefined, below warning triggers during
> build with 'make EXTRA_CFLAGS=3D-Wall binrpm-pkg', fix it by moving 'i'
> in the guard.
>
> arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable =E2=80=
=98i=E2=80=99 [-Wunused-variable]
>
> Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel i=
n immovable memory only")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
> v3: remove changes from 0/1 to false/true per Tglx
>     add the command details about triggering build warning per Boris
>
> v2: update description per Boris.
>
>  arch/x86/boot/compressed/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/=
kaslr.c
> index d7408af55738..62bc46684581 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *reg=
ion,
>                                unsigned long long minimum,
>                                unsigned long long image_size)
>  {
> -       int i;
>         /*
>          * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>          * use @region directly.
> @@ -711,6 +710,7 @@ static bool process_mem_region(struct mem_vector *reg=
ion,
>         }
>
>  #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
> +       int i;
>         /*
>          * If immovable memory found, filter the intersection between
>          * immovable memory and @region.
> --
> 2.17.1
>
