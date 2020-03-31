Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E573BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D0D20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZdqLlKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgCaWXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:23:15 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34055 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:23:14 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so21120283ils.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARULjoQtf8jPl9YqlhaD51ipsNLJ+vghKOqa6OLsOPo=;
        b=dZdqLlKRkU86VDF62uJLHfuCDf8eo3GdRNsrTZtoJdBJvUnUbOllORbKn2dfSviOuj
         jupV1jPyS46zuDcazR+NUSdOd6NADudFuOP5a2UquWQDxV6kfKoLeaEq6OlheM/uCFg3
         8AwuJ5CIbgiesR2IRpA0jyBZq7qlnQqTDeGu3PqlmDAqyfaT8OpGBUJD6veQBRDj9HyR
         Wi5uUZlsXbywQ5uRRRgKHnQsWQYcgqrEDAPtG8sXfZXshEfNZd6lqchfyGKE/flscyig
         lyyU9RhCdw6Q7MSRNRqVhXkFlAOmW6T9r7OIPKll4Tw9MPOg7dD9ZEXehPOFdnZYZ8yo
         qrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARULjoQtf8jPl9YqlhaD51ipsNLJ+vghKOqa6OLsOPo=;
        b=GkqKrPIsTbHmXPnmlryjvCp0PzDtiaPfA/IEbkxm2RXElk1qxtgCd8ulf01kyep9Zc
         Sbp0jd8RnIZlvT9GStl7ZaoVsNoVrOSinUhgniIYs/+tk2jOB69C2+JGXYFaW7Jm2qeX
         teuxCt0KhTH9oVuqlRMjEDPUsIv3dKtXCLXZPW+45SIWitDtrudK7zw8aWmfx+K79G32
         sh9wWWrbuu3zntNh3d7Kj7IS60NZ0RUjVUdqFcR7dkC4aYAI9GsXgoxHHOrOFYeIijft
         7TbyNIe8cjvsZSUthev2GeNdP5P33MyiQgKRYg4QhPy+slLTsaOc7KaZ9X1zhb2TdWvx
         wFHw==
X-Gm-Message-State: ANhLgQ10/FeSwF7UbejuKRO0cSDHAxGtp+iIWImwFCuoLCuwRCrbyHBH
        vH5t+81adhQdk2PtdmevZyGFwpbT94cR7qscmQ==
X-Google-Smtp-Source: ADFU+vsj50NA2QZq5d3aXCb/oZdLL7Edfcfds9DzJKtEvNWgm5PlBDoa4mvyHeRO8QNk5V7Xfm1xJRMyK3B5/3X+FNc=
X-Received: by 2002:a92:86d1:: with SMTP id l78mr18569494ilh.172.1585693392005;
 Tue, 31 Mar 2020 15:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200325101431.12341-1-andrew.cooper3@citrix.com> <20200331175810.30204-1-andrew.cooper3@citrix.com>
In-Reply-To: <20200331175810.30204-1-andrew.cooper3@citrix.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 31 Mar 2020 18:23:00 -0400
Message-ID: <CAMzpN2i6Nf0VDZ82mXyFixN879FC4eZfqe-LzWGkvygcz1gH_Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/smpboot: Remove 486-isms from the modern AP boot path
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        jailhouse-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 1:59 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> Linux has an implementation of the Universal Start-up Algorithm (MP spec,
> Appendix B.4, Application Processor Startup), which includes unconditionally
> writing to the Bios Data Area and CMOS registers.
>
> The warm reset vector is only necessary in the non-integrated Local APIC case.
> UV and Jailhouse already have an opt-out for this behaviour, but blindly using
> the BDA and CMOS on a UEFI or other reduced hardware system isn't clever.
>
> We could make this conditional on the integrated-ness of the Local APIC, but
> 486-era SMP isn't supported.  Drop the logic completely, tidying up the includ
> list and header files as appropriate.
>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: James Morris <jmorris@namei.org>
> CC: David Howells <dhowells@redhat.com>
> CC: Andrew Cooper <andrew.cooper3@citrix.com>
> CC: Matthew Garrett <mjg59@google.com>
> CC: Josh Boyer <jwboyer@redhat.com>
> CC: Steve Wahl <steve.wahl@hpe.com>
> CC: Mike Travis <mike.travis@hpe.com>
> CC: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> CC: Giovanni Gherdovich <ggherdovich@suse.cz>
> CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Martin Molnar <martin.molnar.programming@gmail.com>
> CC: Pingfan Liu <kernelfans@gmail.com>
> CC: linux-kernel@vger.kernel.org
> CC: jailhouse-dev@googlegroups.com
> Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> v2:
>  * Drop logic entirely, rather than retaining support in 32bit builds.
> ---
>  arch/x86/include/asm/apic.h        |  6 -----
>  arch/x86/include/asm/x86_init.h    |  1 -
>  arch/x86/kernel/apic/x2apic_uv_x.c |  1 -
>  arch/x86/kernel/jailhouse.c        |  1 -
>  arch/x86/kernel/platform-quirks.c  |  1 -
>  arch/x86/kernel/smpboot.c          | 50 --------------------------------------
>  6 files changed, 60 deletions(-)
>
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 19e94af9cc5d..5c33f9374b28 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -472,12 +472,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
>                 return (x >> 24) & 0x0F;
>  }
>
> -/*
> - * Warm reset vector position:
> - */
> -#define TRAMPOLINE_PHYS_LOW            0x467
> -#define TRAMPOLINE_PHYS_HIGH           0x469
> -
>  extern void generic_bigsmp_probe(void);
>
>  #ifdef CONFIG_X86_LOCAL_APIC
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 96d9cd208610..006a5d7fd7eb 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -229,7 +229,6 @@ enum x86_legacy_i8042_state {
>  struct x86_legacy_features {
>         enum x86_legacy_i8042_state i8042;
>         int rtc;
> -       int warm_reset;
>         int no_vga;
>         int reserve_bios_regions;
>         struct x86_legacy_devices devices;
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index ad53b2abc859..5afcfd193592 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -343,7 +343,6 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
>         } else if (!strcmp(oem_table_id, "UVH")) {
>                 /* Only UV1 systems: */
>                 uv_system_type = UV_NON_UNIQUE_APIC;
> -               x86_platform.legacy.warm_reset = 0;
>                 __this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
>                 uv_set_apicid_hibit();
>                 uv_apic = 1;
> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> index 6eb8b50ea07e..d628fe92d6af 100644
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -210,7 +210,6 @@ static void __init jailhouse_init_platform(void)
>         x86_platform.calibrate_tsc      = jailhouse_get_tsc;
>         x86_platform.get_wallclock      = jailhouse_get_wallclock;
>         x86_platform.legacy.rtc         = 0;
> -       x86_platform.legacy.warm_reset  = 0;
>         x86_platform.legacy.i8042       = X86_LEGACY_I8042_PLATFORM_ABSENT;
>
>         legacy_pic                      = &null_legacy_pic;
> diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
> index b348a672f71d..d922c5e0c678 100644
> --- a/arch/x86/kernel/platform-quirks.c
> +++ b/arch/x86/kernel/platform-quirks.c
> @@ -9,7 +9,6 @@ void __init x86_early_init_platform_quirks(void)
>  {
>         x86_platform.legacy.i8042 = X86_LEGACY_I8042_EXPECTED_PRESENT;
>         x86_platform.legacy.rtc = 1;
> -       x86_platform.legacy.warm_reset = 1;
>         x86_platform.legacy.reserve_bios_regions = 0;
>         x86_platform.legacy.devices.pnpbios = 1;
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index fe3ab9632f3b..a9f5b511d0b4 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -72,7 +72,6 @@
>  #include <asm/fpu/internal.h>
>  #include <asm/setup.h>
>  #include <asm/uv/uv.h>
> -#include <linux/mc146818rtc.h>
>  #include <asm/i8259.h>
>  #include <asm/misc.h>
>  #include <asm/qspinlock.h>
> @@ -119,34 +118,6 @@ int arch_update_cpu_topology(void)
>         return retval;
>  }
>
> -static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&rtc_lock, flags);
> -       CMOS_WRITE(0xa, 0xf);
> -       spin_unlock_irqrestore(&rtc_lock, flags);
> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
> -                                                       start_eip >> 4;
> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
> -                                                       start_eip & 0xf;
> -}
> -
> -static inline void smpboot_restore_warm_reset_vector(void)
> -{
> -       unsigned long flags;
> -
> -       /*
> -        * Paranoid:  Set warm reset code and vector here back
> -        * to default values.
> -        */
> -       spin_lock_irqsave(&rtc_lock, flags);
> -       CMOS_WRITE(0, 0xf);
> -       spin_unlock_irqrestore(&rtc_lock, flags);
> -
> -       *((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
> -}
> -
>  static void init_freq_invariance(void);
>
>  /*
> @@ -1049,20 +1020,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>          * the targeted processor.
>          */
>
> -       if (x86_platform.legacy.warm_reset) {
> -
> -               pr_debug("Setting warm reset code and vector.\n");
> -
> -               smpboot_setup_warm_reset_vector(start_ip);
> -               /*
> -                * Be paranoid about clearing APIC errors.
> -               */
> -               if (APIC_INTEGRATED(boot_cpu_apic_version)) {
> -                       apic_write(APIC_ESR, 0);
> -                       apic_read(APIC_ESR);
> -               }
> -       }
> -
>         /*
>          * AP might wait on cpu_callout_mask in cpu_init() with
>          * cpu_initialized_mask set if previous attempt to online
> @@ -1118,13 +1075,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>                 }
>         }
>
> -       if (x86_platform.legacy.warm_reset) {
> -               /*
> -                * Cleanup possible dangling ends...
> -                */
> -               smpboot_restore_warm_reset_vector();
> -       }
> -
>         return boot_error;
>  }

You removed x86_platform.legacy.warm_reset in the original patch, but
that is missing in V2.

--
Brian Gerst
