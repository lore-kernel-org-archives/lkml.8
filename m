Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8B7C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8202024656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zzywysm.com header.i=@zzywysm.com header.b="PZuZtOnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCIT3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:29:10 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46065 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCIT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:29:10 -0400
Received: by mail-qt1-f173.google.com with SMTP id a4so7880226qto.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=D1RQVVTaADBtxnkz7ZAg6EZYsruUO6GS4yel/89PSJg=;
        b=PZuZtOnl2iZtFLMUBQd7KhYAc8mZdQJwb35yOxaHAWCW+bnMLWJETCaRksqS3Ept1s
         7lU4KMrQXx+oQ1+VLvCwlHxRrDWphuN209n0c1DLc5wi6A4KCH3mRt3aQvAInGlZIQ/y
         ag7dM+RujJAmf6Zqy5G+NQoG3aZWU4y+gG8WHFkc3V1ijp76/N4hDjnYrYPwa8kkcHAA
         lA7huYoQXma16B0MMA7VRS5zf81dJlfwdJBsUa7sgNDdvGPuYDFFOGIlpEGZGs82NAbX
         98hlEZusYkBAvpLQKcXc/FjRx89CHpVMhqhlcfcgMUFq1SEpOn7avS/dL1pR/40wwBfX
         83vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=D1RQVVTaADBtxnkz7ZAg6EZYsruUO6GS4yel/89PSJg=;
        b=Zah18ddZO+qXJQ3fsxUqsueEpdsseIrvNmJaCyrRiHQBtuICWC+lJDQ1pEvmUPvIz1
         aLwHbM4IxTovaaiQ+O4zMXUGumNuX1Hjk1BfUEBahGROqYPpVeDXUcqQFdEDLlIeWXCF
         r1E9y01SQJR1LZTXIvla6XSGiXHAJybCEuO4dWNe+qKxoTnKM5wsPmJUDatPJhAOyLdY
         BOE0lt+Gm7QvKqHCp9KhTPFJuW5vDvFHYEePrYtwPzj6gOKGFjzpHxMfZlk9oR8zHX0x
         2AchQAsLWi03jalFDR4+y7xHio67NmKGXverEiItdmLrH2NVkAc5zft5ikxd/Fd8cpfS
         GbkQ==
X-Gm-Message-State: ANhLgQ1g6XjXZw5R0fTYE6CzbSxM6WfSC7L2u51wofagaSCCLBkBVZQx
        zF9+in+OxCbunOLVkNXlmeMh3XE8P30=
X-Google-Smtp-Source: ADFU+vtzdxLJmvtWT7BeBbmUsXrS5TWSTiA2Z0DuDRinVcA7rpxTiGf/1NjhtzC5OxZBmmZMKCgDmw==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr15531236qtg.314.1583782147730;
        Mon, 09 Mar 2020 12:29:07 -0700 (PDT)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id g22sm7952517qtp.8.2020.03.09.12.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 12:29:07 -0700 (PDT)
From:   Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Linux Warning Report - 5.6-rc5
Message-Id: <20327C9D-3F55-41D1-86E4-DBAA7B229C88@zzywysm.com>
Date:   Mon, 9 Mar 2020 14:29:04 -0500
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still holding steady at 32 warnings in the defconfig build.

zzy



zzy@esquivalience:~/linux-5.6-rc5$ make -j4 KCFLAGS=3D"-Wall -Wextra =
-Wno-unused-parameter -Wno-missing-field-initializers" > =
build_log_5.6-rc5
arch/x86/kernel/jump_label.c:61:1: warning: =E2=80=98inline=E2=80=99 is =
not at beginning of declaration [-Wold-style-declaration]
   61 | static void inline __jump_label_transform(struct jump_entry =
*entry,
      | ^~~~~~
kernel/time/hrtimer.c:120:21: warning: initialized field overwritten =
[-Woverride-init]
  120 |  [CLOCK_REALTIME] =3D HRTIMER_BASE_REALTIME,
      |                     ^~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:120:21: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[0]=E2=80=99)
kernel/time/hrtimer.c:121:22: warning: initialized field overwritten =
[-Woverride-init]
  121 |  [CLOCK_MONOTONIC] =3D HRTIMER_BASE_MONOTONIC,
      |                      ^~~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:121:22: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[1]=E2=80=99)
kernel/time/hrtimer.c:122:21: warning: initialized field overwritten =
[-Woverride-init]
  122 |  [CLOCK_BOOTTIME] =3D HRTIMER_BASE_BOOTTIME,
      |                     ^~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:122:21: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[7]=E2=80=99)
kernel/time/hrtimer.c:123:17: warning: initialized field overwritten =
[-Woverride-init]
  123 |  [CLOCK_TAI]  =3D HRTIMER_BASE_TAI,
      |                 ^~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:123:17: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[11]=E2=80=99)
In file included from kernel/bpf/core.c:21:
kernel/bpf/core.c: In function =E2=80=98___bpf_prog_run=E2=80=99:
./include/linux/filter.h:863:3: warning: cast between incompatible =
function types from =E2=80=98u64 (*)(u64,  u64,  u64,  u64,  u64)=E2=80=99=
 {aka =E2=80=98long long unsigned int (*)(long long unsigned int,  long =
long unsigned int,  long long unsigned int,  long long unsigned int,  =
long long unsigned int)=E2=80=99} to =E2=80=98u64 (*)(u64,  u64,  u64,  =
u64,  u64,  const struct bpf_insn *)=E2=80=99 {aka =E2=80=98long long =
unsigned int (*)(long long unsigned int,  long long unsigned int,  long =
long unsigned int,  long long unsigned int,  long long unsigned int,  =
const struct bpf_insn *)=E2=80=99} [-Wcast-function-type]
  863 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
      |   ^
kernel/bpf/core.c:1513:13: note: in expansion of macro =
=E2=80=98__bpf_call_base_args=E2=80=99
 1513 |   BPF_R0 =3D (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
      |             ^~~~~~~~~~~~~~~~~~~~
kernel/bpf/core.c: In function =E2=80=98bpf_patch_call_args=E2=80=99:
./include/linux/filter.h:863:3: warning: cast between incompatible =
function types from =E2=80=98u64 (*)(u64,  u64,  u64,  u64,  u64)=E2=80=99=
 {aka =E2=80=98long long unsigned int (*)(long long unsigned int,  long =
long unsigned int,  long long unsigned int,  long long unsigned int,  =
long long unsigned int)=E2=80=99} to =E2=80=98u64 (*)(u64,  u64,  u64,  =
u64,  u64,  const struct bpf_insn *)=E2=80=99 {aka =E2=80=98long long =
unsigned int (*)(long long unsigned int,  long long unsigned int,  long =
long unsigned int,  long long unsigned int,  long long unsigned int,  =
const struct bpf_insn *)=E2=80=99} [-Wcast-function-type]
  863 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
      |   ^
kernel/bpf/core.c:1704:3: note: in expansion of macro =
=E2=80=98__bpf_call_base_args=E2=80=99
 1704 |   __bpf_call_base_args;
      |   ^~~~~~~~~~~~~~~~~~~~
kernel/trace/blktrace.c: In function =E2=80=98__trace_note_message=E2=80=99=
:
kernel/trace/blktrace.c:145:63: warning: parameter =E2=80=98blkcg=E2=80=99=
 set but not used [-Wunused-but-set-parameter]
  145 | void __trace_note_message(struct blk_trace *bt, struct blkcg =
*blkcg,
      |                                                 =
~~~~~~~~~~~~~~^~~~~
In file included from ./include/linux/capability.h:16,
                 from security/commoncap.c:5:
security/commoncap.c: In function =E2=80=98cap_prctl_drop=E2=80=99:
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
  373 | #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
      |                           ^~
security/commoncap.c:1145:7: note: in expansion of macro =E2=80=98cap_vali=
d=E2=80=99
 1145 |  if (!cap_valid(cap))
      |       ^~~~~~~~~
security/commoncap.c: In function =E2=80=98cap_task_prctl=E2=80=99:
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
  373 | #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
      |                           ^~
security/commoncap.c:1175:8: note: in expansion of macro =E2=80=98cap_vali=
d=E2=80=99
 1175 |   if (!cap_valid(arg2))
      |        ^~~~~~~~~
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
  373 | #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
      |                           ^~
security/commoncap.c:1260:10: note: in expansion of macro =
=E2=80=98cap_valid=E2=80=99
 1260 |   if (((!cap_valid(arg3)) | arg4 | arg5))
      |          ^~~~~~~~~
drivers/video/fbdev/core/fbmon.c: In function =E2=80=98get_monspecs=E2=80=99=
:
drivers/video/fbdev/core/fbmon.c:812:47: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
  812 |   DPRINTK("      Configurable signal level\n");
      |                                               ^
drivers/video/fbdev/core/fbmon.c:842:24: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
  842 |   DPRINTK("variable\n");
      |                        ^
drivers/video/fbdev/core/fbmon.c:847:24: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
  847 |   DPRINTK("variable\n");
      |                        ^
drivers/acpi/scan.c: In function =E2=80=98acpi_bus_get_wakeup_device_flags=
=E2=80=99:
drivers/acpi/scan.c:903:43: warning: suggest braces around empty body in =
an =E2=80=98if=E2=80=99 statement [-Wempty-body]
  903 |     "error in _DSW or _PSW evaluation\n"));
      |                                           ^
drivers/acpi/acpi_processor.c: In function =
=E2=80=98acpi_processor_errata_piix4=E2=80=99:
drivers/acpi/acpi_processor.c:133:67: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
  133 |       "Bus master activity detection (BM-IDE) erratum =
enabled\n"));
      |                                                                  =
 ^
drivers/acpi/acpi_processor.c:136:54: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
  136 |       "Type-F DMA livelock erratum (C3 disabled)\n"));
      |                                                      ^
drivers/acpi/acpi_processor.c: In function =
=E2=80=98acpi_processor_get_info=E2=80=99:
drivers/acpi/acpi_processor.c:251:49: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
  251 |       "No bus mastering arbitration control\n"));
      |                                                 ^
drivers/acpi/processor_pdc.c: In function =E2=80=98acpi_processor_eval_pdc=
=E2=80=99:
drivers/acpi/processor_pdc.c:136:65: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
  136 |       "Could not evaluate _PDC, using legacy perf. =
control.\n"));
      |                                                                 =
^
drivers/tty/vt/keyboard.c: In function =E2=80=98k_fn=E2=80=99:
drivers/tty/vt/keyboard.c:740:22: warning: comparison is always true due =
to limited range of data type [-Wtype-limits]
  740 |  if ((unsigned)value < ARRAY_SIZE(func_table)) {
      |                      ^
fs/posix_acl.c: In function =E2=80=98get_acl=E2=80=99:
fs/posix_acl.c:127:22: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
  127 |   /* fall through */ ;
      |                      ^
lib/errname.c:15:67: warning: initialized field overwritten =
[-Woverride-init]
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > =
300)] =3D "-" #err
      |                                                                  =
 ^~~
lib/errname.c:172:2: note: in expansion of macro =E2=80=98E=E2=80=99
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^
lib/errname.c:15:67: note: (near initialization for =E2=80=98names_0[35]=E2=
=80=99)
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > =
300)] =3D "-" #err
      |                                                                  =
 ^~~
lib/errname.c:172:2: note: in expansion of macro =E2=80=98E=E2=80=99
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^
lib/radix-tree.c: In function =E2=80=98set_iter_tags=E2=80=99:
lib/radix-tree.c:1134:15: warning: comparison is always false due to =
limited range of data type [-Wtype-limits]
 1134 |  if (tag_long < RADIX_TREE_TAG_LONGS - 1) {
      |               ^
In file included from drivers/ata/ahci.c:35:
drivers/ata/ahci.h:384:16: warning: initialized field overwritten =
[-Woverride-init]
  384 |  .can_queue  =3D AHCI_MAX_CMDS,   \
      |                ^~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  103 |  AHCI_SHT("ahci"),
      |  ^~~~~~~~
drivers/ata/ahci.h:384:16: note: (near initialization for =
=E2=80=98ahci_sht.can_queue=E2=80=99)
  384 |  .can_queue  =3D AHCI_MAX_CMDS,   \
      |                ^~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  103 |  AHCI_SHT("ahci"),
      |  ^~~~~~~~
drivers/ata/ahci.h:388:17: warning: initialized field overwritten =
[-Woverride-init]
  388 |  .sdev_attrs  =3D ahci_sdev_attrs
      |                 ^~~~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  103 |  AHCI_SHT("ahci"),
      |  ^~~~~~~~
drivers/ata/ahci.h:388:17: note: (near initialization for =
=E2=80=98ahci_sht.sdev_attrs=E2=80=99)
  388 |  .sdev_attrs  =3D ahci_sdev_attrs
      |                 ^~~~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  103 |  AHCI_SHT("ahci"),
      |  ^~~~~~~~
drivers/usb/core/sysfs.c: In function =E2=80=98usb_create_sysfs_intf_files=
=E2=80=99:
drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty =
body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
 1266 |   ; /* We don't actually care if the function fails. */
      |   ^
drivers/input/mouse/synaptics.c: In function =
=E2=80=98synaptics_process_packet=E2=80=99:
drivers/input/mouse/synaptics.c:1105:6: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
 1105 |      ;   /* Nothing, treat a pen as a single finger */
      |      ^
drivers/md/md.c: In function =E2=80=98bind_rdev_to_array=E2=80=99:
drivers/md/md.c:2438:27: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
 2438 |   /* failure here is OK */;
      |                           ^
drivers/md/md.c: In function =E2=80=98slot_store=E2=80=99:
drivers/md/md.c:3200:28: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
 3200 |    /* failure here is OK */;
      |                            ^
drivers/md/md.c: In function =E2=80=98remove_and_add_spares=E2=80=99:
drivers/md/md.c:9045:29: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
 9045 |     /* failure here is OK */;
      |                             ^
drivers/hid/hid-lgff.c: In function =E2=80=98hid_lgff_play=E2=80=99:
drivers/hid/hid-lgff.c:65:24: warning: comparison of unsigned expression =
< 0 is always false [-Wtype-limits]
   65 | #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
      |                        ^
drivers/hid/hid-lgff.c:86:3: note: in expansion of macro =E2=80=98CLAMP=E2=
=80=99
   86 |   CLAMP(left);
      |   ^~~~~
drivers/hid/hid-lgff.c:65:24: warning: comparison of unsigned expression =
< 0 is always false [-Wtype-limits]
   65 | #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
      |                        ^
drivers/hid/hid-lgff.c:87:3: note: in expansion of macro =E2=80=98CLAMP=E2=
=80=99
   87 |   CLAMP(right);
      |   ^~~~~

