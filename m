Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0850C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADC520724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593994590;
	bh=TpT7N864Cg+9SPo9JyXLZmq9apn/ionggliQ+H54No8=;
	h=From:Date:Subject:To:List-ID:From;
	b=L6m4cmnfR+KCvWlOoT4JPEstKqyL5dN5FMR1msB79cxB29BdFNn7BJrvkL8+oMZpe
	 Rc/nHByrlFatlDO9uS3ri4bk0DKRnxQtiBV1zxoGlvsD1mEYoaeRmWdJD+s2hxvjuB
	 HUvFOqH49czqxJ+WN+4kRuPT1H8hzIltqRvheLhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGFAQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgGFAQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:16:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860FCC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 17:16:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so18425725ljn.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cQgGT4IbHadTg2T909FOOIg6agbXAjHZhi3RIyIhMNk=;
        b=ZO0u7Y76C0Nvlt3Cb8XKlWGH8mm7vpWY9vUzUI5YT9vOeJASPxN+2I0eJaER0e06rM
         RaUPhBI3l7oAMWkyXLW4qdr6tYcsbAzUrJnkSRYnbUqeZnZqibHnBTTTPZTye7dHADsa
         YLvTxFdnG6waLtEMXAUa9hTHSuRsTsl2uzRK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cQgGT4IbHadTg2T909FOOIg6agbXAjHZhi3RIyIhMNk=;
        b=sVVFFQKUDsTiegnFLZxfEk4EyOORYSlEZlXhtaOtS7MyJgLfEQmJErHuBYXQT2q7V7
         qQ2v1ALMb0346AzF6+NjTkxdO1n5OAvAUQ8A6WbbqswPoyEHBzhihCARLrNzjQ5NX4DY
         U6VZYt6TITBZK0TAmM3eF+jgQOdHgAQN1wXFvZWWYl9eElComfWA3g4SU9Pxl5vSMYAa
         CZ9BvujOR4yeFX8pKHAqXxjsbiVg2I+IFl9CJAkC/mEZ04+GAdEX6UbMjWN/NKfhecyF
         Zp7iUKMrUf2p7UatmlVYbK1BIJFya0aUP9n/2seAya1MVnuenrQaTvgOqn8+1aWGPrfb
         9fcQ==
X-Gm-Message-State: AOAM533Iv/JDcyWpNJv4OjTRJiqWhuTE5jgPB+AdCBOFi2bcxujs42qx
        FLrAHgqJOTQS7rpxsigzhqA+Z1KJSM8=
X-Google-Smtp-Source: ABdhPJxqPNFwT7Swgxwi12JAQmtHX1DOJXht5SYlZZ+kawrQinOGKBAIXvPZorOSck71pt6Cu1v/XA==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr26451107lji.129.1593994578301;
        Sun, 05 Jul 2020 17:16:18 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s8sm5788384ljh.74.2020.07.05.17.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 17:16:17 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m26so21609145lfo.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 17:16:17 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr28621833lfn.30.1593994576651;
 Sun, 05 Jul 2020 17:16:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jul 2020 17:16:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaNDpCRkeBGbdTOh84_mqfG7N1qPk8HZXJzbh8TOB_hA@mail.gmail.com>
Message-ID: <CAHk-=whaNDpCRkeBGbdTOh84_mqfG7N1qPk8HZXJzbh8TOB_hA@mail.gmail.com>
Subject: Linux 5.8-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if rc3 was larger than usual, rc4 now makes up for that by being
smaller than usual. It's been quite a calm week.

Is that just the normal fluctuation? Probably. The timing of the
individual pull requests end up just varying, so some rc's end up
large and some end up smaller, and maybe rc4 is small exactly
_because_ rc3 was larger..

It might also be due to the July 4th preparations in the US, where
presumably a number of US developers might have made this a three-day
weekend.

For example, for me, usually Friday and Saturday are my busiest days
during the release windows, because that's when a lot of developers
send in their end-of-the-week work pull request. But just looking at
my pull requests, this week there were (a) fewer of them and (b) they
were skewed to Thursday/Friday instead.

So who knows. The end result is that it's been fairly calm, and
there's certainly been discussion of upcoming fixes, but I still have
the feeling that 5.8 is looking fairly normal and things are
developing smoothly despite the size of this release.

The shortlog is appended, but it's all really pretty small and nothing
odd stands out. From a stats standpoint, the drm fixes are about a
quarter of the diff (and i915 stands out there), but even that is
mainly because the sources for the i915 context state clearing shaders
had been missed.

In fact, if you consider those shader sources to be documentation fro
what the blobs in the i915 state clearing were about, then almost half
the diff in rc4 ends up being basically documentation, scripts, and
self-tests.

The rest is small fixes all over: mainly architecture code, drivers,
and filesystems. Scan the shortlog below if you care deeply about the
details, but honestly, I'd rather you all just build the result, and
report back if you find any issues..

Thanks,
              Linus

---

Alex Deucher (2):
      drm/amdgpu/atomfirmware: fix vram_info fetching for renoir
      drm/amdgpu: use %u rather than %d for sclk/mclk

Amit Kucheria (1):
      thermal/drivers/tsens: Fix compilation warnings by making functions s=
tatic

Andreas Gruenbacher (2):
      gfs2: Don't return NULL from gfs2_inode_lookup
      gfs2: Don't sleep during glock hash walk

Andy Lutomirski (11):
      x86/entry: Assert that syscalls are on the right stack
      x86/entry: Move SYSENTER's regs->sp and regs->flags fixups into C
      x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
      selftests/x86/syscall_nt: Add more flag combinations
      selftests/x86/syscall_nt: Clear weird flags after each test
      selftests/x86: Consolidate and fix get/set_eflags() helpers
      x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
      x86/entry, selftests: Further improve user entry sanity checks
      x86/entry/xen: Route #DB correctly on Xen PV
      x86/entry/32: Fix #MC and #DB wiring on x86_32
      x86/ldt: Disable 16-bit segments on Xen PV

Andy Shevchenko (1):
      i2c: eg20t: Load module automatically if ID matches

Aneesh Kumar K.V (1):
      powerpc/mm/pkeys: Make pkey access check work on execute_only_key

Angelo Dureghello (1):
      m68k: mm: fix node memblock init

Anson Huang (1):
      thermal/drivers: imx: Fix missing of_node_put() at probe time

Ard Biesheuvel (1):
      arm64/alternatives: use subsections for replacement sequences

Barry Song (1):
      mm/cma.c: use exact_nid true to fix possible per-numa cma leak

Bernard Zhao (1):
      drm/msm: fix potential memleak in error branch

Binbin Zhou (1):
      tpm/st33zp24: fix spelling mistake "drescription" -> "description"

Bob Peterson (6):
      gfs2: fix trans slab error when withdraw occurs inside log_flush
      gfs2: eliminate GIF_ORDERED in favor of list_empty
      gfs2: freeze should work on read-only mounts
      gfs2: read-only mounts should grab the sd_freeze_gl glock
      gfs2: When freezing gfs2, use GL_EXACT and not GL_NOCACHE
      gfs2: The freeze glock should never be frozen

Chen Tao (1):
      drm/msm/dpu: fix error return code in dpu_encoder_init

Chen-Yu Tsai (1):
      drm: sun4i: hdmi: Remove extra HPD polling

Chris Packham (1):
      i2c: algo-pca: Add 0x78 as SCL stuck low status for PCA9665

Christoph Hellwig (3):
      scsi: mptfusion: Don't use GFP_ATOMIC for larger DMA allocations
      nvme: fix a crash in nvme_mpath_add_disk
      vmalloc: fix the owner argument for the new __vmalloc_node_range call=
ers

Christophe Leroy (1):
      SUNRPC: Add missing definition of ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE

Chu Lin (1):
      hwmon: (max6697) Make sure the OVERT mask is set correctly

Colin Xu (4):
      drm/i915/gvt: Add one missing MMIO handler for D_SKL_PLUS
      drm/i915/gvt: Fix two CFL MMIO handling caused by regression.
      drm/i915/gvt: Fix incorrect check of enabled bits in mask registers
      drm/i915/gvt: Use GFP_ATOMIC instead of GFP_KERNEL in atomic context

Dan Carpenter (2):
      scsi: qla2xxx: Fix a condition in qla2x00_find_all_fabric_devs()
      exfat: add missing brelse() calls on error paths

Daniel Jordan (1):
      padata: upgrade smp_mb__after_atomic to smp_mb in padata_do_serial

Dave Chinner (1):
      xfs: fix use-after-free on CIL context on shutdown

David Gibson (1):
      tpm: ibmvtpm: Wait for ready buffer before probing for TPM2 attribute=
s

David Gow (2):
      kunit: kunit_tool: Fix invalid result when build fails
      Documentation: kunit: Add some troubleshooting tips to the FAQ

Dien Pham (1):
      thermal/drivers/rcar_gen3: Fix undefined temperature if negative

Douglas Anderson (2):
      tpm_tis_spi: Don't send anything during flow control
      tpm_tis_spi: Prefer async probe

Dov Murik (1):
      docs: kbuild: fix ReST formatting

Eric Anholt (2):
      drm/msm: Fix address space size after refactor.
      drm/msm: Fix setup of a6xx create_address_space.

Eric Biggers (1):
      block/keyslot-manager: use kvfree_sensitive()

Fabio Estevam (5):
      dt-bindings: usb: aspeed: Remove the leading zeroes
      dt-bindings: display: arm: versatile: Pass the sysreg unit name
      dt-bindings: thermal: Remove soc unit address
      dt-bindings: thermal: k3: Fix the reg property
      dt-bindings: clock: imx: Fix e-mail address

Finley Xiao (1):
      thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from p=
ower

Flavio Suligoi (1):
      doc: devicetree: bindings: fix spelling mistake

Guenter Roeck (1):
      hwmon: (bt1-pvt) Mark is_visible functions static

Hauke Mehrtens (1):
      MIPS: Add missing EHB in mtc0 -> mfc0 sequence for DSPen

Herbert Xu (1):
      crypto: af_alg - fix use-after-free in af_alg_accept() due to
bh_lock_sock()

Hou Tao (2):
      blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flag=
s
      virtio-blk: free vblk-vqs in error path of virtblk_probe()

Hyeongseok.Kim (1):
      exfat: Set the unused characters of FileName field to the value 0000h

Hyunchul Lee (1):
      exfat: call sync_filesystem for read-only remount

Ivan Mironov (1):
      drm/amd/powerplay: Fix NULL dereference in lock_bus() on Vega20 w/o R=
AS

J. Bruce Fields (3):
      nfsd: apply umask on fs without ACL support
      nfsd4: fix nfsdfs reference count loop
      nfsd: fix nfsdfs inode reference count leak

James Bottomley (1):
      tpm: Fix TIS locality timeout problems

Jan Kundr=C3=A1t (1):
      hwmon: (pmbus) Fix page vs. register when accessing fans

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Tiger Lake PCH-H

Jarkko Sakkinen (4):
      Revert "tpm: selftest: cleanup after unseal with wrong auth/policy te=
st"
      selftests: tpm: Use 'test -e' instead of 'test -f'
      selftests: tpm: Use /bin/sh instead of /bin/bash
      tpm_tis: Remove the HID IFX0102

Javed Hasan (2):
      scsi: libfc: Handling of extra kref
      scsi: libfc: Skip additional kref updating work event

Jens Axboe (2):
      io_uring: use signal based task_work running
      io_uring: fix regression with always ignoring signals in io_cqring_wa=
it()

Jiaxun Yang (1):
      irqchip/loongson-pci-msi: Fix a typo in Kconfig

Joel Savitz (1):
      mm/page_alloc: fix documentation error

John Stultz (1):
      drm/msm: Fix 0xfffflub in "Refactor address space initialization"

Jordan Crouse (1):
      drm/msm: Fix up the rest of the messed up address sizes

Joseph Salisbury (1):
      Drivers: hv: Change flag to write log level in panic msg to false

Jo=C3=A3o H. Spies (1):
      MIPS: ingenic: gcw0: Fix HP detection GPIO.

Juergen Gross (2):
      xen/xenbus: avoid large structs and arrays on the stack
      xen/xenbus: let xenbus_map_ring_valloc() return errno values only

KP Singh (1):
      security: Fix hook iteration and default value for inode_copy_up_xatt=
r

Kalyan Thota (1):
      drm/msm/dpu: request for display color blocks based on hw catalog ent=
ry

Kangmin Park (1):
      dt-bindings: mailbox: zynqmp_ipi: fix unit address

Kees Cook (1):
      samples/vfs: avoid warning in statx override

Kefeng Wang (1):
      rcuperf: Fix printk format warning

Krishna Manikandan (1):
      drm/msm/dpu: allow initialization of encoder locks during encoder ini=
t

Krzysztof Kozlowski (4):
      spi: spi-fsl-dspi: Fix lockup if device is removed during SPI transfe=
r
      spi: spi-fsl-dspi: Fix lockup if device is shutdown during SPI transf=
er
      spi: spi-fsl-dspi: Fix external abort on interrupt in resume or exit =
paths
      spi: spi-fsl-dspi: Initialize completion before possible interrupt

Linus Torvalds (2):
      x86/ldt: use "pr_info_once()" instead of open-coding it badly
      Linux 5.8-rc4

Marc Zyngier (1):
      irqchip/gic: Atomically update affinity

Marek Szyprowski (1):
      drm/exynos: Properly propagate return value in drm_iommu_attach_devic=
e()

Martin Blumenstingl (1):
      MIPS: lantiq: xway: sysctrl: fix the GPHY clock alias names

Masahiro Yamada (7):
      gcc-plugins: fix gcc-plugins directory path in documentation
      dt-bindings: bus: uniphier-system-bus: fix warning in example
      dt-bindings: fix error in 'make clean' after 'make dt_binding_check'
      dt-bindings: do not build processed-schema.yaml for 'make
dt_binding_check'
      dt-bindings: copy process-schema-examples.yaml to process-schema.yaml
      kbuild: fix CONFIG_CC_CAN_LINK(_STATIC) for cross-compilation with Cl=
ang
      kbuild: make Clang build userprogs for target architecture

Matthew Wilcox (Oracle) (1):
      Call sysctl_head_finish on error

Maurizio Drocco (1):
      ima: extend boot_aggregate with kernel measurements

Mauro Carvalho Chehab (13):
      dt: update a reference for reneases pcar file renamed to yaml
      dt: fix broken links due to txt->yaml renames
      dt: Fix broken references to renamed docs
      dt: fix reference to olpc,xo1.75-ec.txt
      docs: dt: minor adjustments at writing-schema.rst
      kconfig: qconf: cleanup includes
      kconfig: qconf: make search fully work again on split mode
      kconfig: qconf: make debug links work again
      kconfig: qconf: re-implement setSelected()
      kconfig: qconf: simplify the goBack() logic
      kconfig: qconf: don't show goback button on splitMode
      kconfig: qconf: navigate menus on hyperlinks
      kconfig: qconf: parse newer types at debug info

Mel Gorman (1):
      Revert "fs: Do not check if there is a fsnotify watcher on pseudo ino=
des"

Michael Kao (1):
      thermal/drivers/mediatek: Fix bank number settings on mt8183

Mika Westerberg (1):
      PCI: Make pcie_find_root_port() work for Root Ports

Mike Kravetz (1):
      mm/hugetlb.c: fix pages per hugetlb calculation

Mike Rapoport (1):
      m68k: nommu: register start of the memory with memblock

Misono Tomohiro (1):
      hwmon: (acpi_power_meter) Fix potential memory leak in
acpi_power_meter_add()

Namjae Jeon (1):
      exfat: move setting VOL_DIRTY over exfat_remove_entries()

Navid Emamdoost (1):
      drm/exynos: fix ref count leak in mic_pre_enable

Nicholas Kazlauskas (1):
      drm/amd/display: Only revalidate bandwidth on medium and fast updates

Oleg Nesterov (1):
      task_work: teach task_work_add() to do signal_wake_up()

Palmer Dabbelt (1):
      irqchip/riscv-intc: Fix a typo in a pr_warn()

Paul Aurich (6):
      cifs: Display local UID details for SMB sessions in DebugData
      SMB3: Honor 'seal' flag for multiuser mounts
      SMB3: Honor persistent/resilient handle flags for multiuser mounts
      SMB3: Honor lease disabling for multiuser mounts
      SMB3: Honor 'handletimeout' flag for multiuser mounts
      SMB3: Honor 'posix' flag for multiuser mounts

Paul Menzel (1):
      .gitignore: Do not track `defconfig` from `make savedefconfig`

Petteri Aimonen (1):
      x86/fpu: Reset MXCSR to default in kernel_fpu_begin()

Ricardo Ribalda (1):
      i2c: designware: platdrv: Set class based on DMI

Rikard Falkeborn (1):
      kunit: kunit_config: Fix parsing of CONFIG options with space

Rob Herring (1):
      scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c

Rodrigo Vivi (1):
      drm/i915: Include asm sources for {ivb, hsw}_clear_kernel.c

Ronnie Sahlberg (1):
      cifs: prevent truncation from long to int in wait_for_free_credits

Sagi Grimberg (1):
      nvme: fix identify error status silent ignore

Sai Prakash Ranjan (3):
      arm64: Add MIDR value for KRYO4XX gold CPU cores
      arm64: Add KRYO4XX gold CPU cores to erratum list 1463225 and 1418040
      arm64: Add KRYO4XX silver CPU cores to erratum list 1530923 and 10247=
18

Sami Tolvanen (1):
      security: fix the key_permission LSM hook function type

Sean Christopherson (1):
      x86/split_lock: Don't write MSR_TEST_CTRL on CPUs that aren't whiteli=
sted

Serge Semin (1):
      hwmon: (bt1-pvt) Define Temp- and Volt-to-N poly as maybe-unused

Srinivas Pandruvada (1):
      ACPI: DPTF: Add battery participant for TigerLake

Sumeet Pawnikar (1):
      ACPI: fan: Fix Tiger Lake ACPI device ID

Sumit Semwal (1):
      dma-buf: Move dma_buf_release() from fops to dentry_ops

Sungjong Seo (1):
      exfat: flush dirty metadata in fsync

Tamseel Shams (1):
      drm/exynos: Remove dev_err() on platform_get_irq() failure

Tao Ren (1):
      hwmon: (pmbus) fix a typo in Kconfig SENSORS_IR35221 option

Tiezhu Yang (1):
      thermal/drivers/sprd: Fix return value of sprd_thm_probe()

Uriel Guajardo (1):
      kunit: show error if kunit results are not present

Vasily Averin (1):
      tpm_tis: extra chip->ops check on error path in tpm_tis_core_init

Wei Yongjun (1):
      block: make function __bio_integrity_free() static

Weilong Chen (1):
      fork: annotate data race in copy_process()

Wolfram Sang (3):
      i2c: slave-eeprom: update documentation
      i2c: add Kconfig help text for slave mode
      i2c: mlxcpld: check correct size of maximum RECV_LEN packet

Xiaofei Tan (1):
      arm/xen: remove the unused macro GRANT_TABLE_PHYSADDR

Xingxing Su (1):
      MIPS: Do not use smp_processor_id() in preemptible code

Zenghui Yu (1):
      irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in ato=
mic

Zhang Xiaoxu (1):
      cifs: Fix the target file was deleted when rename failed.
