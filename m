Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD830C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781F220673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9jkHudz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgAJC1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:27:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36072 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbgAJC1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:27:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so492192ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 18:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IVAveBZjpIfJ4omwAA+IQvTDlq09Uc7HsY0eJNGnBoQ=;
        b=Z9jkHudzgmru0+/sPDhBxRg2Dki429DfS/4CZPZ3UyWbscbfW8IKDcbzT1ZkLyq9cV
         L7P7vZ50A7yU9cx7YdDueY39MpskcnaFKFUHvc4S6UFVVOA8MMhmkPnCNXSVppwmxF9P
         AQJiaMW7+PwGzUYlX2AojdkQ6zgv2gUQ9j6BinFapxoEkmQYB+ruJZtUlOLitvzCbUPa
         LU03L2WPsZUPZvTGym2GtvsEOZzC2ee7oDcoQKLwogTNbLTpDmdDTxzB29F28hW3dFMq
         dhHWmopGuXs51FvFZ+z4iZjYG0/ccQInM7RGIpyF6lviRG+5Bn4v+C6LZ2ss2FGxoNhE
         ZAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IVAveBZjpIfJ4omwAA+IQvTDlq09Uc7HsY0eJNGnBoQ=;
        b=siOEXqFNtV/fy+/HwRwdOKzD4iWvyY1ve27/aMBLCd/YUeNdk0blLKGDCXeF9VHpM+
         8y/MBxInUY2vkACFlEcpYIKc7OTkyyCxFlPJKRwcRiQoJ8QnEnWZDrj4Rsnl6C82mxm4
         FEvhWloeLLDBKALq75xE3O5HwnjPqbWGa3s7+IU07oqGF9Jc8fxJUXC05CpeA3JNkf/1
         8rozdkbs0mDnObzGTopn5d/z8zkJOz5PjsIpov3Flxdt/H55+XTd4kDl+QwPm6u9fv5L
         34KZfOzp0Oxe+33icUSlYo2Yw6dm3y5hAsDFXqOouRyF+YcjqdO66OP2ldDffAKzXsBn
         u8CQ==
X-Gm-Message-State: APjAAAVVkNnX4+s7tNPPrbI84ffzYfFKy2glBqVnCz9HLK95oDvGsvqV
        hAer8ZjIRKmlYvslZ88BVkpe5DCi5uYjNgWLDPw=
X-Google-Smtp-Source: APXvYqxqb4MffpgRoz4mqIfIwmosGfyuI4PgkVLo/LE14JBIHt4uHHTRi02T/AlYkC/9ZfEQSRHYxvJPFaB7pkwC5+8=
X-Received: by 2002:a2e:9883:: with SMTP id b3mr787847ljj.80.1578623233860;
 Thu, 09 Jan 2020 18:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic> <20200109204638.GA523773@rani.riverdale.lan>
In-Reply-To: <20200109204638.GA523773@rani.riverdale.lan>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Fri, 10 Jan 2020 10:27:02 +0800
Message-ID: <CAFH1YnNA9qfM4tPzKKDaQD6DPxnE=tJsB7AUZQBohDTW3zm=Xg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote=
:
>
> On Thu, Jan 09, 2020 at 07:40:55PM +0100, Borislav Petkov wrote:
> > On Fri, Jan 03, 2020 at 11:39:29AM +0800, Zhenzhong Duan wrote:
> > > Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE an=
d
> > > CONFIG_ACPI are defined, but definition of variable 'i' is out of gua=
rd.
> > > If any of the two macros is undefined, below warning triggers during
> > > build, fix it by moving 'i' in the guard.
> > >
> > > arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable =E2=
=80=98i=E2=80=99 [-Wunused-variable]
> >
> > How do you trigger this?
> >
> > I have:
> >
> > $  grep -E "(CONFIG_MEMORY_HOTREMOVE|CONFIG_ACPI)" .config
> > # CONFIG_ACPI is not set
> >
> > but no warning. Neither with gcc 8 nor with gcc 9.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
>
> The boot/compressed Makefile resets KBUILD_CFLAGS.  Following hack and
> building with W=3D1 shows it, or just add -Wunused in there.
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed=
/Makefile
> index 56aa5fa0a66b..791c0d5a952a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -35,6 +35,9 @@ KBUILD_CFLAGS +=3D $(cflags-y)
>  KBUILD_CFLAGS +=3D -mno-mmx -mno-sse
>  KBUILD_CFLAGS +=3D $(call cc-option,-ffreestanding)
>  KBUILD_CFLAGS +=3D $(call cc-option,-fno-stack-protector)
> +
> +include scripts/Makefile.extrawarn
> +
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS +=3D -Wno-pointer-sign

Yes. Will you send this formally? Not clear if there is other reason making
KBUILD_CFLAGS for arch/x86/boot/compressed different from other part.

Regards
Zhenzhong
