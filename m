Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5366C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DCA20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zzywysm.com header.i=@zzywysm.com header.b="WjsTF9Cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBQAxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:53:11 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37786 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgBQAxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:53:11 -0500
Received: by mail-yw1-f68.google.com with SMTP id l5so7182999ywd.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=+vD7Tj2It4qbaLszay/BA6p3WsaabWkuBK3qPJ9oNkc=;
        b=WjsTF9CrU/LztdzgAeorKJx/ZGuMRXLLxTE06wZmUtXF1sm7LoazmT5mFqdt4FD1i6
         ZfvJkIQTMa43AcqFgP0tfUKePaMxQTT41ZKBuiVgq6d58oPITX/2AFraaOX3WYhAkrEi
         5QFqeFIrL5314WC+DaZJnT+YzkFzpLP0VSaEwXSjD97GAjWH/XEbm2zc4UxMR3bWyWr+
         tLGoOsqzTbvPvNvZkTaR/2ucEzv9/op0S2wd6aPDoxwKxidHeMq3Os9Bqqx1nzoz62ch
         rv0TPyN1mEM9dabnSl+KTyXr5UPV+g15hDT/4p914mpb/TVoRAvtQ4nclXy4MtjI1uUO
         8b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=+vD7Tj2It4qbaLszay/BA6p3WsaabWkuBK3qPJ9oNkc=;
        b=JjTag3hkjtwGyWiQ6W6ue43cPfvhtmgK3nBhMRkwaDFkk6PDgB6sUv/NihDGGuffZO
         m9kOm/NVRUgz1XWeWiVr+iMrl8aNIrRMzKmdPMjQcJeVQdik6YM3YAkXWxbd54OrRhrX
         WOvuX5gtw3es1VlAEjxlavulGYOXVFWmWfYG/Te6HXo6RGNWT+zalsPEMrgsF+OLU1wm
         VykRIkaaQgFiyNUH0EskQefrq9eew1I7HQamBcITudeshg/LhnRLy19FoxBcS4rQ0EUc
         UbZ3Gzw3k5HPY8DfIrUMo1cubWT9OfACz89+1ML8h+WEwlcV5+CboXFDjZxBe8l6sH4y
         jxZQ==
X-Gm-Message-State: APjAAAV4jF42QwT+ZDcpT3chdWWxjnp5hOFB7uJQPquZtJKeuFm/1saW
        cWshtkQ67huHd788/XCsIP9v0FVumxE=
X-Google-Smtp-Source: APXvYqwMGt+TrUCoG4rOKaKC9IY4hPJEK+K/zu5NYajouwlVHIPZ3nfOY11+L2veY4jxI9nNZq6Jwg==
X-Received: by 2002:a81:8603:: with SMTP id w3mr10274479ywf.316.1581900789175;
        Sun, 16 Feb 2020 16:53:09 -0800 (PST)
Received: from [10.0.1.16] (c-67-175-226-4.hsd1.il.comcast.net. [67.175.226.4])
        by smtp.gmail.com with ESMTPSA id i84sm5535064ywc.43.2020.02.16.16.53.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 16:53:08 -0800 (PST)
From:   Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Linux Warning Report - 5.6-rc2
Message-Id: <D3253D80-8977-437D-A758-3B3E79F84E27@zzywysm.com>
Date:   Sun, 16 Feb 2020 18:53:07 -0600
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 12, 2020, Linus Torvalds wrote:
"I do not want to see a _single_ warning in the kernel build. Yes, we
have one in the samples code, and even that annoys the hell out of =
me.=E2=80=9D

(Source: <https://lkml.org/lkml/2020/2/12/996>)

A noble goal, and one I endorse.

With that in mind, I decided to see if the Linux kernel truly builds =
warning-free.  Spoiler: it did not.  I built Linux 5.6-rc2 with gcc =
9.2.1-9ubuntu2 using make defconfig.

Result: 33 warnings.

Let me know if you=E2=80=99re interested in:
* regular warning reports
* additional code coverage beyond defconfig
* additional warning types

(Note, I am not a member of this list, please include me directly on any =
replies.)

Regards,
zzy



zzy@esquivalience:~/linux-5.6-rc2$ make -j6 KCFLAGS=3D"-Wall -Wextra =
-Wno-unused-parameter -Wno-missing-field-initializers" > =
build_log_5.6-rc2
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
arch/x86/kernel/jump_label.c:61:1: warning: =E2=80=98inline=E2=80=99 is =
not at beginning of declaration [-Wold-style-declaration]
   61 | static void inline __jump_label_transform(struct jump_entry =
*entry,
      | ^~~~~~
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
drivers/scsi/sr.c:691:12: warning: initialized field overwritten =
[-Woverride-init]
  691 |  .ioctl  =3D sr_block_compat_ioctl,
      |            ^~~~~~~~~~~~~~~~~~~~~
drivers/scsi/sr.c:691:12: note: (near initialization for =
=E2=80=98sr_bdops.ioctl=E2=80=99)
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
drivers/input/mouse/synaptics.c: In function =
=E2=80=98synaptics_process_packet=E2=80=99:
drivers/input/mouse/synaptics.c:1105:6: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
 1105 |      ;   /* Nothing, treat a pen as a single finger */
      |      ^
drivers/usb/core/sysfs.c: In function =E2=80=98usb_create_sysfs_intf_files=
=E2=80=99:
drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty =
body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
 1266 |   ; /* We don't actually care if the function fails. */
      |   ^
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

