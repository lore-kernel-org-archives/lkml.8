Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A8C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2221927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zzywysm.com header.i=@zzywysm.com header.b="Clo51chj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBYASA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:18:00 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44160 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBYAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:17:59 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so4952654qvg.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Hj2Q6Th/gQb2U2GjE+pOXijBZbYnELZ4m88+fidep6g=;
        b=Clo51chjHw+kX+EyDtU3WFqbGC8rpzz8Qz2XTwryGNisBxKImIY+dBwGWiBqWmwmdz
         CGqslhLSe2IVKyn3LqGqQbK5Es4RTleZTswetYBEzuA+i3JpehrOc1f8qJAPpN7XzVBF
         6nN7q71nOI3+AIXSGv1lI/jq2nR3GW61ActWbmsS7Rtezq9L48cfKdrGGyTcY8gVUlBt
         Uw8vvbZ0RmC5O6ylSsj+g1oN+hCAD4+Ox7YfyxR5F8+INLiELMVYLl+rqjITj91NtXKE
         FF0vfH2oPkXs/sfk8bfdPbMPq7+IlSm38PyN6zfo/czVXpedVOHeqqOrmE07S3z1CTHG
         xBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Hj2Q6Th/gQb2U2GjE+pOXijBZbYnELZ4m88+fidep6g=;
        b=Pd0D1IAfTo2eRn4lV6erzEXn9oDHArHuUBB+KcffU9vQEp/XkvbSL6ymIWoh4pJZOm
         phjmJQefBmpRLP3y7LCVrT7kStsLwLzkrO5Iv/wwx0j4Duh7yC4ATTsmJ7b0kzPYun4N
         Y4a7kyBe3g66EPDP7AJnzxbpZxWYQa84/xux5OeY4eI13RmvQu6JnRvDb5MhdlFA8Ftl
         DJPjWd+wthnSZ/k2gPKaKxbwz9VuS6GlO3qVBfXnk7m2JaEaMNLoT2VBCXaMrrXS4FjO
         UZttq2OoP2xUXU5AQ2YSRQcF/7OqPLtN4MYfZa10d0S5ymJHBv5eIk0Bk6KaQlWOu+5Q
         QruA==
X-Gm-Message-State: APjAAAVz3emk4Lc9lauVt/kTkKtemWHaV1UZanH+aTxIgB9ivZhfoGFr
        22+wkqFipMoSMuCVHaaY3N/RV1kA3O8=
X-Google-Smtp-Source: APXvYqw43+I6fwmLBxZQejb48XT/Wh40W+xzBYUcVJbes0kC28X7LikvcxTifUQDm1xulYYIeB9Eeg==
X-Received: by 2002:a05:6214:16ce:: with SMTP id d14mr43977979qvz.151.1582589877212;
        Mon, 24 Feb 2020 16:17:57 -0800 (PST)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id g2sm6500480qkb.27.2020.02.24.16.17.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 16:17:56 -0800 (PST)
From:   Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Linux Warning Report - 5.6-rc3
Message-Id: <2BDD2716-BC2C-4DD8-B0B0-E33C56FAF0A5@zzywysm.com>
Date:   Mon, 24 Feb 2020 18:17:54 -0600
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of Linux 5.6-rc3, the defconfig still builds with 33 warnings.

Can we get it down to zero by the time 5.6 ships?

zzy


zzy@esquivalience:~/linux-5.6-rc3$ make -j4 KCFLAGS=3D"-Wall -Wextra =
-Wno-unused-parameter -Wno-missing-field-initializers" > =
build_log_5.6-rc3
kernel/time/hrtimer.c:120:21: warning: initialized field overwritten =
[-Woverride-init]
  [CLOCK_REALTIME] =3D HRTIMER_BASE_REALTIME,
                     ^~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:120:21: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[0]=E2=80=99)
kernel/time/hrtimer.c:121:22: warning: initialized field overwritten =
[-Woverride-init]
  [CLOCK_MONOTONIC] =3D HRTIMER_BASE_MONOTONIC,
                      ^~~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:121:22: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[1]=E2=80=99)
kernel/time/hrtimer.c:122:21: warning: initialized field overwritten =
[-Woverride-init]
  [CLOCK_BOOTTIME] =3D HRTIMER_BASE_BOOTTIME,
                     ^~~~~~~~~~~~~~~~~~~~~
kernel/time/hrtimer.c:122:21: note: (near initialization for =
=E2=80=98hrtimer_clock_to_base_table[7]=E2=80=99)
kernel/time/hrtimer.c:123:17: warning: initialized field overwritten =
[-Woverride-init]
  [CLOCK_TAI]  =3D HRTIMER_BASE_TAI,
                 ^~~~~~~~~~~~~~~~
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
  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
   ^
kernel/bpf/core.c:1513:13: note: in expansion of macro =
=E2=80=98__bpf_call_base_args=E2=80=99
   BPF_R0 =3D (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
             ^~~~~~~~~~~~~~~~~~~~
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
  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
   ^
kernel/bpf/core.c:1704:3: note: in expansion of macro =
=E2=80=98__bpf_call_base_args=E2=80=99
   __bpf_call_base_args;
   ^~~~~~~~~~~~~~~~~~~~
kernel/trace/blktrace.c: In function =E2=80=98__trace_note_message=E2=80=99=
:
kernel/trace/blktrace.c:145:63: warning: parameter =E2=80=98blkcg=E2=80=99=
 set but not used [-Wunused-but-set-parameter]
 void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
                                                 ~~~~~~~~~~~~~~^~~~~
arch/x86/kernel/jump_label.c:61:1: warning: =E2=80=98inline=E2=80=99 is =
not at beginning of declaration [-Wold-style-declaration]
 static void inline __jump_label_transform(struct jump_entry *entry,
 ^~~~~~
In file included from ./include/linux/capability.h:16,
                 from security/commoncap.c:5:
security/commoncap.c: In function =E2=80=98cap_prctl_drop=E2=80=99:
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
 #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
                           ^~
security/commoncap.c:1145:7: note: in expansion of macro =E2=80=98cap_vali=
d=E2=80=99
  if (!cap_valid(cap))
       ^~~~~~~~~
security/commoncap.c: In function =E2=80=98cap_task_prctl=E2=80=99:
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
 #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
                           ^~
security/commoncap.c:1175:8: note: in expansion of macro =E2=80=98cap_vali=
d=E2=80=99
   if (!cap_valid(arg2))
        ^~~~~~~~~
./include/uapi/linux/capability.h:373:27: warning: comparison of =
unsigned expression >=3D 0 is always true [-Wtype-limits]
 #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
                           ^~
security/commoncap.c:1260:10: note: in expansion of macro =
=E2=80=98cap_valid=E2=80=99
   if (((!cap_valid(arg3)) | arg4 | arg5))
          ^~~~~~~~~
drivers/video/fbdev/core/fbmon.c: In function =E2=80=98get_monspecs=E2=80=99=
:
drivers/video/fbdev/core/fbmon.c:812:47: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
   DPRINTK("      Configurable signal level\n");
                                               ^
drivers/video/fbdev/core/fbmon.c:842:24: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
   DPRINTK("variable\n");
                        ^
drivers/video/fbdev/core/fbmon.c:847:24: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
   DPRINTK("variable\n");
                        ^
drivers/tty/vt/keyboard.c: In function =E2=80=98k_fn=E2=80=99:
drivers/tty/vt/keyboard.c:740:22: warning: comparison is always true due =
to limited range of data type [-Wtype-limits]
  if ((unsigned)value < ARRAY_SIZE(func_table)) {
                      ^
drivers/acpi/scan.c: In function =E2=80=98acpi_bus_get_wakeup_device_flags=
=E2=80=99:
drivers/acpi/scan.c:903:43: warning: suggest braces around empty body in =
an =E2=80=98if=E2=80=99 statement [-Wempty-body]
     "error in _DSW or _PSW evaluation\n"));
                                           ^
drivers/acpi/acpi_processor.c: In function =
=E2=80=98acpi_processor_errata_piix4=E2=80=99:
drivers/acpi/acpi_processor.c:133:67: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
       "Bus master activity detection (BM-IDE) erratum enabled\n"));
                                                                   ^
drivers/acpi/acpi_processor.c:136:54: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
       "Type-F DMA livelock erratum (C3 disabled)\n"));
                                                      ^
drivers/acpi/acpi_processor.c: In function =
=E2=80=98acpi_processor_get_info=E2=80=99:
drivers/acpi/acpi_processor.c:251:49: warning: suggest braces around =
empty body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
       "No bus mastering arbitration control\n"));
                                                 ^
drivers/acpi/processor_pdc.c: In function =E2=80=98acpi_processor_eval_pdc=
=E2=80=99:
drivers/acpi/processor_pdc.c:136:65: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
       "Could not evaluate _PDC, using legacy perf. control.\n"));
                                                                 ^
fs/posix_acl.c: In function =E2=80=98get_acl=E2=80=99:
fs/posix_acl.c:127:22: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
   /* fall through */ ;
                      ^
lib/errname.c:15:67: warning: initialized field overwritten =
[-Woverride-init]
 #define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > 300)] =3D =
"-" #err
                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro =E2=80=98E=E2=80=99
  E(EDEADLK), /* EDEADLOCK */
  ^
lib/errname.c:15:67: note: (near initialization for =E2=80=98names_0[35]=E2=
=80=99)
 #define E(err) [err + BUILD_BUG_ON_ZERO(err <=3D 0 || err > 300)] =3D =
"-" #err
                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro =E2=80=98E=E2=80=99
  E(EDEADLK), /* EDEADLOCK */
  ^
lib/radix-tree.c: In function =E2=80=98set_iter_tags=E2=80=99:
lib/radix-tree.c:1134:15: warning: comparison is always false due to =
limited range of data type [-Wtype-limits]
  if (tag_long < RADIX_TREE_TAG_LONGS - 1) {
               ^
drivers/scsi/sr.c:691:12: warning: initialized field overwritten =
[-Woverride-init]
  .ioctl  =3D sr_block_compat_ioctl,
            ^~~~~~~~~~~~~~~~~~~~~
drivers/scsi/sr.c:691:12: note: (near initialization for =
=E2=80=98sr_bdops.ioctl=E2=80=99)
In file included from drivers/ata/ahci.c:35:
drivers/ata/ahci.h:384:16: warning: initialized field overwritten =
[-Woverride-init]
  .can_queue  =3D AHCI_MAX_CMDS,   \
                ^~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  AHCI_SHT("ahci"),
  ^~~~~~~~
drivers/ata/ahci.h:384:16: note: (near initialization for =
=E2=80=98ahci_sht.can_queue=E2=80=99)
  .can_queue  =3D AHCI_MAX_CMDS,   \
                ^~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  AHCI_SHT("ahci"),
  ^~~~~~~~
drivers/ata/ahci.h:388:17: warning: initialized field overwritten =
[-Woverride-init]
  .sdev_attrs  =3D ahci_sdev_attrs
                 ^~~~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  AHCI_SHT("ahci"),
  ^~~~~~~~
drivers/ata/ahci.h:388:17: note: (near initialization for =
=E2=80=98ahci_sht.sdev_attrs=E2=80=99)
  .sdev_attrs  =3D ahci_sdev_attrs
                 ^~~~~~~~~~~~~~~
drivers/ata/ahci.c:103:2: note: in expansion of macro =E2=80=98AHCI_SHT=E2=
=80=99
  AHCI_SHT("ahci"),
  ^~~~~~~~
drivers/usb/core/sysfs.c: In function =E2=80=98usb_create_sysfs_intf_files=
=E2=80=99:
drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty =
body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
   ; /* We don't actually care if the function fails. */
   ^
drivers/input/mouse/synaptics.c: In function =
=E2=80=98synaptics_process_packet=E2=80=99:
drivers/input/mouse/synaptics.c:1105:6: warning: suggest braces around =
empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
      ;   /* Nothing, treat a pen as a single finger */
      ^
drivers/md/md.c: In function =E2=80=98bind_rdev_to_array=E2=80=99:
drivers/md/md.c:2438:27: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
   /* failure here is OK */;
                           ^
drivers/md/md.c: In function =E2=80=98slot_store=E2=80=99:
drivers/md/md.c:3200:28: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
    /* failure here is OK */;
                            ^
drivers/md/md.c: In function =E2=80=98remove_and_add_spares=E2=80=99:
drivers/md/md.c:9045:29: warning: suggest braces around empty body in an =
=E2=80=98if=E2=80=99 statement [-Wempty-body]
     /* failure here is OK */;
                             ^
drivers/hid/hid-lgff.c: In function =E2=80=98hid_lgff_play=E2=80=99:
drivers/hid/hid-lgff.c:65:24: warning: comparison of unsigned expression =
< 0 is always false [-Wtype-limits]
 #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
                        ^
drivers/hid/hid-lgff.c:86:3: note: in expansion of macro =E2=80=98CLAMP=E2=
=80=99
   CLAMP(left);
   ^~~~~
drivers/hid/hid-lgff.c:65:24: warning: comparison of unsigned expression =
< 0 is always false [-Wtype-limits]
 #define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
                        ^
drivers/hid/hid-lgff.c:87:3: note: in expansion of macro =E2=80=98CLAMP=E2=
=80=99
   CLAMP(right);
   ^~~~~

