Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5789C20776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6roFE5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgDALja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:39:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35094 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgDALja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:39:30 -0400
Received: by mail-io1-f68.google.com with SMTP id o3so19690321ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6LtkV31Mx0Wb2yWk+q4vycLOOPy+wzd4O74v4uZk5c=;
        b=n6roFE5dLAi4JKjmSsulf2z+8Omo6kkxYtrR1zQC48clYebJV3t5LbN0FcqhYZ9rLp
         Q9qu6iMTDaVaWr5jo9STCgs6GkqQK0qdL5jaReYmYfpMUzSfh8LDdo6rOrfIN6yoz+7T
         NBZnggh28MMaUluimTxJt44ZWOBkSv60Q/j0ms1mrozVASJhJOqjnKwIkjrOOf6NGABN
         qF0VWNuJ7QL3LAEbzWipYJZLowk9oMHyjaKxmFr4j20JgvPR6wBwlSMaIepoEJPnWPKE
         PrkT+PZIc1T8jXG270hT9KQr3X7Y9zDRNtH0DjYLe0Da8lxtpY7Vq4CD67KAa7KAABkM
         P/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6LtkV31Mx0Wb2yWk+q4vycLOOPy+wzd4O74v4uZk5c=;
        b=d1/bj2dhCDGiBE2pxJuPYjObGbzPcYdUspuzmewyC3nL5AIIiikFtQePMrAtJdCX2X
         ZnhIe1FP3lB7+7Spp0ZcVe6Df8z9WjOWuxzIs3YrhuqvOrYqu64q1aEoLM3obko+dO3x
         mJkTj9hgxuU+rSeF7vyBWl5j33EEEKA6qbC9JtVJAxJtXtjv+X3BJfb4oONJ4UlguH9+
         lLJbGOKB8yaFICSEr/KO4ouij/Cs7MkK10S6OfDk9VJDjBiP62gE78hri59PGj016ZrX
         8n3hZD4kinfUb5HZtaO2k/X+GiVyVny/UFLVTKZZXykzQluPLZGJdYI1ZktuH0qf0sa/
         c+XA==
X-Gm-Message-State: ANhLgQ0Ynw3P+w3wO33FdEeyVkC/VW9LVq3A9AInMSO3/IksSZjZfTCE
        cBlftK6bcnAGi0+bEJqQuzhQGxD6iIHNMcfXWQ==
X-Google-Smtp-Source: ADFU+vvUtYp5erv69vCz5C7zMJFuQoYTx5bIquJakLPUKHJ9s2Ui++AVwJabmaFX5DajcUrRg9nMPrjN76MTMFJGkyY=
X-Received: by 2002:a05:6602:2242:: with SMTP id o2mr19807209ioo.22.1585741167864;
 Wed, 01 Apr 2020 04:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <20200331175810.30204-1-andrew.cooper3@citrix.com> <CAMzpN2i6Nf0VDZ82mXyFixN879FC4eZfqe-LzWGkvygcz1gH_Q@mail.gmail.com>
 <c46bcb6d-4256-2d65-9cd9-33e010846de4@citrix.com> <CAMzpN2gdkmYYbQatFk66QMpiuZSfnUQUVtJ30VYF7nsX_+XVgA@mail.gmail.com>
 <bdf7995d-2d50-9bb9-8066-6c4ccfaa5b52@citrix.com>
In-Reply-To: <bdf7995d-2d50-9bb9-8066-6c4ccfaa5b52@citrix.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Apr 2020 07:39:16 -0400
Message-ID: <CAMzpN2g0LS5anGc7CXco4pgBHhGzc8hw+shMOg8WEWGsx+BHpg@mail.gmail.com>
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

On Wed, Apr 1, 2020 at 5:22 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 31/03/2020 23:53, Brian Gerst wrote:
> > On Tue, Mar 31, 2020 at 6:44 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> On 31/03/2020 23:23, Brian Gerst wrote:
> >>> On Tue, Mar 31, 2020 at 1:59 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >>>> Linux has an implementation of the Universal Start-up Algorithm (MP spec,
> >>>> Appendix B.4, Application Processor Startup), which includes unconditionally
> >>>> writing to the Bios Data Area and CMOS registers.
> >>>>
> >>>> The warm reset vector is only necessary in the non-integrated Local APIC case.
> >>>> UV and Jailhouse already have an opt-out for this behaviour, but blindly using
> >>>> the BDA and CMOS on a UEFI or other reduced hardware system isn't clever.
> >>>>
> >>>> We could make this conditional on the integrated-ness of the Local APIC, but
> >>>> 486-era SMP isn't supported.  Drop the logic completely, tidying up the includ
> >>>> list and header files as appropriate.
> >>>>
> >>>> CC: Thomas Gleixner <tglx@linutronix.de>
> >>>> CC: Ingo Molnar <mingo@redhat.com>
> >>>> CC: Borislav Petkov <bp@alien8.de>
> >>>> CC: "H. Peter Anvin" <hpa@zytor.com>
> >>>> CC: x86@kernel.org
> >>>> CC: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> CC: James Morris <jmorris@namei.org>
> >>>> CC: David Howells <dhowells@redhat.com>
> >>>> CC: Andrew Cooper <andrew.cooper3@citrix.com>
> >>>> CC: Matthew Garrett <mjg59@google.com>
> >>>> CC: Josh Boyer <jwboyer@redhat.com>
> >>>> CC: Steve Wahl <steve.wahl@hpe.com>
> >>>> CC: Mike Travis <mike.travis@hpe.com>
> >>>> CC: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> >>>> CC: Arnd Bergmann <arnd@arndb.de>
> >>>> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> >>>> CC: Giovanni Gherdovich <ggherdovich@suse.cz>
> >>>> CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >>>> CC: Len Brown <len.brown@intel.com>
> >>>> CC: Kees Cook <keescook@chromium.org>
> >>>> CC: Martin Molnar <martin.molnar.programming@gmail.com>
> >>>> CC: Pingfan Liu <kernelfans@gmail.com>
> >>>> CC: linux-kernel@vger.kernel.org
> >>>> CC: jailhouse-dev@googlegroups.com
> >>>> Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
> >>>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> >>>> ---
> >>>> v2:
> >>>>  * Drop logic entirely, rather than retaining support in 32bit builds.
> >>>> ---
> >>>>  arch/x86/include/asm/apic.h        |  6 -----
> >>>>  arch/x86/include/asm/x86_init.h    |  1 -
> >>>>  arch/x86/kernel/apic/x2apic_uv_x.c |  1 -
> >>>>  arch/x86/kernel/jailhouse.c        |  1 -
> >>>>  arch/x86/kernel/platform-quirks.c  |  1 -
> >>>>  arch/x86/kernel/smpboot.c          | 50 --------------------------------------
> >>>>  6 files changed, 60 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> >>>> index 19e94af9cc5d..5c33f9374b28 100644
> >>>> --- a/arch/x86/include/asm/apic.h
> >>>> +++ b/arch/x86/include/asm/apic.h
> >>>> @@ -472,12 +472,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
> >>>>                 return (x >> 24) & 0x0F;
> >>>>  }
> >>>>
> >>>> -/*
> >>>> - * Warm reset vector position:
> >>>> - */
> >>>> -#define TRAMPOLINE_PHYS_LOW            0x467
> >>>> -#define TRAMPOLINE_PHYS_HIGH           0x469
> >>>> -
> >>>>  extern void generic_bigsmp_probe(void);
> >>>>
> >>>>  #ifdef CONFIG_X86_LOCAL_APIC
> >>>> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> >>>> index 96d9cd208610..006a5d7fd7eb 100644
> >>>> --- a/arch/x86/include/asm/x86_init.h
> >>>> +++ b/arch/x86/include/asm/x86_init.h
> >>>> @@ -229,7 +229,6 @@ enum x86_legacy_i8042_state {
> >>>>  struct x86_legacy_features {
> >>>>         enum x86_legacy_i8042_state i8042;
> >>>>         int rtc;
> >>>> -       int warm_reset;
> >>>>         int no_vga;
> >>>>         int reserve_bios_regions;
> >>>>         struct x86_legacy_devices devices;
> >>>> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> >>>> index ad53b2abc859..5afcfd193592 100644
> >>>> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> >>>> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> >>>> @@ -343,7 +343,6 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
> >>>>         } else if (!strcmp(oem_table_id, "UVH")) {
> >>>>                 /* Only UV1 systems: */
> >>>>                 uv_system_type = UV_NON_UNIQUE_APIC;
> >>>> -               x86_platform.legacy.warm_reset = 0;
> >>>>                 __this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
> >>>>                 uv_set_apicid_hibit();
> >>>>                 uv_apic = 1;
> >>>> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> >>>> index 6eb8b50ea07e..d628fe92d6af 100644
> >>>> --- a/arch/x86/kernel/jailhouse.c
> >>>> +++ b/arch/x86/kernel/jailhouse.c
> >>>> @@ -210,7 +210,6 @@ static void __init jailhouse_init_platform(void)
> >>>>         x86_platform.calibrate_tsc      = jailhouse_get_tsc;
> >>>>         x86_platform.get_wallclock      = jailhouse_get_wallclock;
> >>>>         x86_platform.legacy.rtc         = 0;
> >>>> -       x86_platform.legacy.warm_reset  = 0;
> >>>>         x86_platform.legacy.i8042       = X86_LEGACY_I8042_PLATFORM_ABSENT;
> >>>>
> >>>>         legacy_pic                      = &null_legacy_pic;
> >>>> diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
> >>>> index b348a672f71d..d922c5e0c678 100644
> >>>> --- a/arch/x86/kernel/platform-quirks.c
> >>>> +++ b/arch/x86/kernel/platform-quirks.c
> >>>> @@ -9,7 +9,6 @@ void __init x86_early_init_platform_quirks(void)
> >>>>  {
> >>>>         x86_platform.legacy.i8042 = X86_LEGACY_I8042_EXPECTED_PRESENT;
> >>>>         x86_platform.legacy.rtc = 1;
> >>>> -       x86_platform.legacy.warm_reset = 1;
> >>>>         x86_platform.legacy.reserve_bios_regions = 0;
> >>>>         x86_platform.legacy.devices.pnpbios = 1;
> >>>>
> >>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> >>>> index fe3ab9632f3b..a9f5b511d0b4 100644
> >>>> --- a/arch/x86/kernel/smpboot.c
> >>>> +++ b/arch/x86/kernel/smpboot.c
> >>>> @@ -72,7 +72,6 @@
> >>>>  #include <asm/fpu/internal.h>
> >>>>  #include <asm/setup.h>
> >>>>  #include <asm/uv/uv.h>
> >>>> -#include <linux/mc146818rtc.h>
> >>>>  #include <asm/i8259.h>
> >>>>  #include <asm/misc.h>
> >>>>  #include <asm/qspinlock.h>
> >>>> @@ -119,34 +118,6 @@ int arch_update_cpu_topology(void)
> >>>>         return retval;
> >>>>  }
> >>>>
> >>>> -static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
> >>>> -{
> >>>> -       unsigned long flags;
> >>>> -
> >>>> -       spin_lock_irqsave(&rtc_lock, flags);
> >>>> -       CMOS_WRITE(0xa, 0xf);
> >>>> -       spin_unlock_irqrestore(&rtc_lock, flags);
> >>>> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
> >>>> -                                                       start_eip >> 4;
> >>>> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
> >>>> -                                                       start_eip & 0xf;
> >>>> -}
> >>>> -
> >>>> -static inline void smpboot_restore_warm_reset_vector(void)
> >>>> -{
> >>>> -       unsigned long flags;
> >>>> -
> >>>> -       /*
> >>>> -        * Paranoid:  Set warm reset code and vector here back
> >>>> -        * to default values.
> >>>> -        */
> >>>> -       spin_lock_irqsave(&rtc_lock, flags);
> >>>> -       CMOS_WRITE(0, 0xf);
> >>>> -       spin_unlock_irqrestore(&rtc_lock, flags);
> >>>> -
> >>>> -       *((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
> >>>> -}
> >>>> -
> >>>>  static void init_freq_invariance(void);
> >>>>
> >>>>  /*
> >>>> @@ -1049,20 +1020,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
> >>>>          * the targeted processor.
> >>>>          */
> >>>>
> >>>> -       if (x86_platform.legacy.warm_reset) {
> >>>> -
> >>>> -               pr_debug("Setting warm reset code and vector.\n");
> >>>> -
> >>>> -               smpboot_setup_warm_reset_vector(start_ip);
> >>>> -               /*
> >>>> -                * Be paranoid about clearing APIC errors.
> >>>> -               */
> >>>> -               if (APIC_INTEGRATED(boot_cpu_apic_version)) {
> >>>> -                       apic_write(APIC_ESR, 0);
> >>>> -                       apic_read(APIC_ESR);
> >>>> -               }
> >>>> -       }
> >>>> -
> >>>>         /*
> >>>>          * AP might wait on cpu_callout_mask in cpu_init() with
> >>>>          * cpu_initialized_mask set if previous attempt to online
> >>>> @@ -1118,13 +1075,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
> >>>>                 }
> >>>>         }
> >>>>
> >>>> -       if (x86_platform.legacy.warm_reset) {
> >>>> -               /*
> >>>> -                * Cleanup possible dangling ends...
> >>>> -                */
> >>>> -               smpboot_restore_warm_reset_vector();
> >>>> -       }
> >>>> -
> >>>>         return boot_error;
> >>>>  }
> >>> You removed x86_platform.legacy.warm_reset in the original patch, but
> >>> that is missing in V2.
> >> Second hunk?  Or are you referring to something different?
> > Removing the warm_reset field from struct x86_legacy_features.
>
> Ok, but that is still present as the 2nd hunk of the patch.

My apologies, Gmail was hiding that section of the patch because it
was a reply to the original patch.  For future reference, add the
version number to the title when resubmitting a patch (ie. [PATCH
v2]).

--
Brian Gerst
