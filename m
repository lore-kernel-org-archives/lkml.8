Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF4C54E8E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518CA208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589150166;
	bh=afXTUZxYXaY0woqOyopy1bHMtsweK91ehE3HuWEY6bU=;
	h=From:Date:Subject:To:List-ID:From;
	b=dq5l7NY5xuwuH/pvv9V/ekTNTUW1rj4W5KNoGF0Srq+QrTa+tAMkZ8rDwPZKlTOod
	 ahLmOd3jH1YR+LKW/XyQxl9ogJDJxeREE9lgu1o5d3ZGtp5IMYCpgFSMCIFnUbnZ9V
	 Z6SwhVL5b9h/p3FfISquHtNLSmf3m8uML1z/vUoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgEJWgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbgEJWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 18:36:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 15:36:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f11so7458847ljp.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J0ezxF8+kV9VzONA5BpKBHrKCkiVsskbiwJ4iRGafYE=;
        b=ezFwy1J9/LYLDnsu3Tsc9E/Sji0dzGQnOhY0bl3dtHT67hqyVE8DL34CsJNvLrDhaV
         CEXmK6Lg/GrkDVa2lvNOIpP8v70ZpO2wESF7Q6yURMkxpCPQpnB3lER9NoPRgHRAp1eE
         8Ok+F6ooPomVBCGKZP/hR566kUxaI4tzEWaDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J0ezxF8+kV9VzONA5BpKBHrKCkiVsskbiwJ4iRGafYE=;
        b=p6K4rQ2KeA3no6p89cWndPr62BlPqpQfST5KoGgMIEsjTI59OPNPYquStEkkRvBvJi
         2Xc5/G61pGEOzaZmzCRrNF5ZRnr/sFAvdp4tLC9Irv7q/E9FnZioQBii/LB+S5Gk7Mzi
         rqD/orGWKuGtcCCrxKzcZQAR3GmnfFzk+At9VQoJmZvUwu7h6smpEW4+bkchGy26oy6Z
         9iU8lOZy5ejts5kxVo9/fxB0fOYVAq7+nqBspjmZfJfynxK0h/a69qURYUPwgOjDEpx7
         HNDc81MNtfJeEJDNSlmOkEJFU2AT1pHBWVCVzFiYWMsabggwLZo7f4Fdd/2QADdJhDDj
         Elzw==
X-Gm-Message-State: AOAM532XCEDEiPA7VfSJUvk5g+Vuvi+zKJp6jjqLrm49mGIt1E5GeC5O
        dA+85kwKi9IucaiapEI4RoqLjtcQ8UE=
X-Google-Smtp-Source: ABdhPJx8Phdi7GYqu6D6mINRoV9HsupA70aKTYIlrrT0lwdRvJk76CYfNP9qblB569fG53DiPSSdcA==
X-Received: by 2002:a2e:8658:: with SMTP id i24mr7732944ljj.287.1589150160694;
        Sun, 10 May 2020 15:36:00 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q19sm7866788ljj.84.2020.05.10.15.35.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 15:35:59 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id j3so7420413ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 15:35:59 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr8180978ljg.204.1589150158789;
 Sun, 10 May 2020 15:35:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 15:35:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5ziqqgf9dMfwoNLy8A1SX36n1RuDYTyRX6O_Vmcr42g@mail.gmail.com>
Message-ID: <CAHk-=wi5ziqqgf9dMfwoNLy8A1SX36n1RuDYTyRX6O_Vmcr42g@mail.gmail.com>
Subject: Linux 5.7-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we've had a calm release so far, with most of the rc's up until now
smaller than average.

That changes with rc5, which is still pretty much in line with
historical data, but rather than being slightly on the small side, it
is slightly larger than average for this time in the release cycle.

And for once, this is not really a source of concern for me. Because
as mentioned last weekend for the rc4 release, the last rc was likely
smaller simply because that week hadn't seen any networking updates,
nor some of the usual driver pull requests.

So 5.7-rc5 is a bit larger than the last few rc5's have been - but it
was something I was expecting simply because of some pent-up pull
requests that came in this week rather than the week before.

And while being slightly larger than usual, it's by no means
outrageously so. It may have set a new record for number of non-merge
commits in the 5.x series, but it did so by one single measly commit:
300 commits in 5.7-rc5 vs 299 commits in 5.6-rc5 (while the average
for this time in the release cycle hovers just over 200).

So nothing in here looks all that worrisome. The diffstat looks fairly
nice and flat, and the slightly elevated commit count does seem to be
just the usual timing fluctuation.

The changes are spread out, with nothing really dominating. Drivers,
networking, arch updates, kvm, tooling, documentation.. A little bit
of everything, and nothing that looks outrageous.

We'll see what the next few weeks bring, but at least for now it all
feels normal, and like the 5.7 release is tracking well.

So please keep testing, and if you haven't dared a 5.7 pre-release
kernel yet, we're well into the "things look calm and safe to test"
time.

I dare you all to prove me wrong. Go ahead, make my day ;)

                Linus

---

 Ahmed Abdelsalam (1):
      seg6: fix SRH processing to comply with RFC8754

Alan Maguire (2):
      ftrace/selftests: workaround cgroup RT scheduling issues
      ftrace/selftest: make unresolved cases cause failure if
--fail-unresolved set

Alan Stern (2):
      HID: usbhid: Fix race between usbhid_close() and usbhid_stop()
      USB: core: Fix misleading driver bug report

Alex Elder (3):
      net: ipa: fix a bug in ipa_endpoint_stop()
      net: ipa: fix an error message in gsi_channel_init_one()
      net: ipa: zero return code before issuing generic EE command

Alexey Dobriyan (1):
      nvme-pci: fix "slimmer CQ head update"

Andreas Schwab (1):
      riscv: add Linux note to vdso

Andy Shevchenko (2):
      net: macb: Fix runtime PM refcounting
      stmmac: intel: Fix kernel crash due to wrong error path

Anthony Felice (1):
      net: tc35815: Fix phydev supported/advertising mask

Antoine Tenart (1):
      net: macsec: fix rtnl locking issue

Anup Patel (3):
      RISC-V: Export riscv_cpuid_to_hartid_mask() API
      RISC-V: Add bitmap reprensenting ISA features common across CPUs
      RISC-V: Remove N-extension related defines

Archana Patni (1):
      platform/x86: intel_pmc_core: Change Jasper Lake S0ix debug reg
map back to ICL

Arnd Bergmann (6):
      netfilter: nf_osf: avoid passing pointer to local var
      HID: mcp2221: add gpiolib dependency
      drop_monitor: work around gcc-10 stringop-overflow warning
      sun6i: dsi: fix gcc-4.8
      cxgb4/chcr: avoid -Wreturn-local-addr warning
      platform/x86: intel_pmc_core: avoid unused-function warnings

Artem Borisov (1):
      HID: alps: Add AUI1657 device ID

Arun Easi (1):
      scsi: qla2xxx: Fix hang when issuing nvme disconnect-all in NPIV

Atish Patra (1):
      RISC-V: Remove unused code from STRICT_KERNEL_RWX

Aurabindo Pillai (1):
      drm/amd/display: Prevent dpcd reads with passive dongles

Aya Levin (1):
      devlink: Fix reporter's recovery condition

Aymeric Agon-Rambosson (1):
      scripts/gdb: repair rb_first() and rb_last()

Baruch Siach (1):
      net: phy: marvell10g: fix temperature sensor on 2110

Bjorn Andersson (1):
      phy: qualcomm: usb-hs-28nm: Prepare clocks in init

Brian King (1):
      scsi: ibmvfc: Don't send implicit logouts prior to NPIV login

Bryan O'Donoghue (1):
      usb: chipidea: msm: Ensure proper controller reset using role switch =
API

ChenTao (1):
      interconnect: qcom: Move the static keyword to the front of declarati=
on

Christian Borntraeger (1):
      KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction

Christian Gromm (1):
      most: core: use function subsys_initcall()

Christoph Hellwig (3):
      vboxsf: don't use the source name in the bdi name
      bdi: move bdi_dev_name out of line
      bdi: add a ->dev_name field to struct backing_dev_info

Christophe JAILLET (2):
      net/sonic: Fix a resource leak in an error handling path in
'jazz_sonic_probe()'
      net: moxa: Fix a potential double 'free_irq()'

Clay McClure (1):
      net: Make PTP-specific drivers depend on PTP_1588_CLOCK

Colin Ian King (1):
      net: stmmac: gmac5+: fix potential integer overflow on 32 bit multipl=
y

Cong Wang (3):
      net_sched: fix tcm_parent in tc filter dump
      atm: fix a UAF in lec_arp_clear_vccs()
      atm: fix a memory leak of vcc->user_back

Dan Carpenter (4):
      platform/x86: surface3_power: Fix a NULL vs IS_ERR() check in probe
      bus: mhi: core: Fix a NULL vs IS_ERR check in mhi_create_devices()
      net: mvpp2: prevent buffer overflow in mvpp22_rss_ctx()
      net: mvpp2: cls: Prevent buffer overflow in mvpp2_ethtool_cls_rule_de=
l()

Dan Murphy (2):
      net: phy: DP83822: Fix WoL in config init to be disabled
      net: phy: DP83TC811: Fix WoL in config init to be disabled

Daniel Kolesa (1):
      drm/amd/display: work around fp code being emitted outside of
DC_FP_START/END

Daniel Playfair Cal (1):
      HID: i2c-hid: reset Synaptics SYNA2393 on resume

David Ahern (1):
      ipv6: Use global sernum for dst validation with nexthop objects

David Hildenbrand (1):
      mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()

Dejin Zheng (3):
      net: macb: fix an issue about leak related system resources
      net: enetc: fix an issue about leak system resources
      net: broadcom: fix a mistake about ioremap resource

Erez Shitrit (1):
      net/mlx5: DR, On creation set CQ's arm_db member to right value

Eric Dumazet (7):
      net: remove obsolete comment
      fq_codel: fix TCA_FQ_CODEL_DROP_BATCH_SIZE sanity checks
      sch_choke: avoid potential panic in choke_reset()
      sch_sfq: validate silly quantum values
      net_sched: sch_skbprio: add message validation to skbprio_change()
      selftests: net: tcp_mmap: clear whole tcp_zerocopy_receive struct
      selftests: net: tcp_mmap: fix SO_RCVLOWAT setting

Evan Quan (2):
      drm/amdgpu: move kfd suspend after ip_suspend_phase1
      drm/amdgpu: drop redundant cg/pg ungate on runpm enter

Fabian Schindlatz (1):
      HID: logitech: Add support for Logitech G11 extra keys

Fangrui Song (1):
      KVM: arm64: Delete duplicated label in invalid_vector

Filipe Manana (1):
      percpu: make pcpu_alloc() aware of current gfp context

Florian Fainelli (3):
      Revert "tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart"
      net: dsa: Do not make user port errors fatal
      net: dsa: Do not leave DSA master with NULL netdev_ops

Florian Westphal (1):
      mptcp: replace mptcp_disconnect with a stub

Fr=C3=A9d=C3=A9ric Pierret (fepitre) (1):
      gcc-common.h: Update for GCC 10

Gavin Shan (1):
      net/ena: Fix build warning in ena_xdp_set()

Geert Uytterhoeven (1):
      ionic: Use debugfs_create_bool() to export bool

George Spelvin (1):
      batman-adv: fix batadv_nc_random_weight_tq

Grygorii Strashko (1):
      net: ethernet: ti: am65-cpsw-nuss: fix irqs type

Guillaume Nault (1):
      netfilter: nat: never update the UDP checksum when it's 0

Gurchetan Singh (1):
      drm/virtio: create context before RESOURCE_CREATE_2D in 3D mode

Gustavo A. R. Silva (1):
      uapi: revert flexible-array conversions

Gwendal Grignou (1):
      platform/chrome: cros_ec_sensorhub: Allocate sensorhub resource
before claiming sensors

H. Nikolaus Schaller (1):
      drm: ingenic-drm: add MODULE_DEVICE_TABLE

Hans de Goede (2):
      HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K12A
keyboard-dock
      platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA

Heikki Krogerus (1):
      usb: typec: intel_pmc_mux: Fix the property names

Henry Willard (1):
      mm: limit boost_watermark on small zones

Ido Schimmel (1):
      net: bridge: vlan: Add a schedule point during VLAN processing

Ivan Delalande (1):
      scripts/decodecode: fix trapping instruction formatting

Jacob Keller (1):
      ice: cleanup language in ice.rst for fw.app

Jakub Kicinski (1):
      devlink: fix return value after hitting end in region read

James Hilliard (1):
      component: Silence bind error on -EPROBE_DEFER

Janakarajan Natarajan (1):
      arch/x86/kvm/svm/sev.c: change flag passed to GUP fast in sev_pin_mem=
ory()

Jann Horn (1):
      x86/entry/64: Fix unwind hints in rewind_stack_do_exit()

Jason A. Donenfeld (8):
      wireguard: queueing: cleanup ptr_ring in error path of packet_queue_i=
nit
      crypto: arch/lib - limit simd usage to 4k chunks
      crypto: arch/nhpoly1305 - process in explicit 4k chunks
      wireguard: selftests: use normal kernel stack size on ppc64
      wireguard: socket: remove errant restriction on looping to self
      wireguard: send/receive: cond_resched() when processing worker ringbu=
ffers
      wireguard: selftests: initalize ipv6 members to NULL to squelch
clang warning
      wireguard: send/receive: use explicit unlikely branch instead of
implicit coalescing

Jason Gerecke (3):
      HID: wacom: Read HID_DG_CONTACTMAX directly for non-generic devices
      Revert "HID: wacom: generic: read the number of expected touches
on a per collection basis"
      HID: wacom: Report 2nd-gen Intuos Pro S center button status over BT

Jason Yan (2):
      platform/x86/intel-uncore-freq: make uncore_root_kobj static
      net: dsa: mv88e6xxx: remove duplicate assignment of struct members

Jeff Layton (1):
      ceph: fix endianness bug when handling MDS session feature bits

Jeffrey Hugo (5):
      bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
      bus: mhi: core: Remove link_status() callback
      bus: mhi: core: Offload register accesses to the controller
      bus: mhi: core: Fix typo in comment
      bus: mhi: core: Fix channel device name conflict

Jens Axboe (1):
      io_uring: don't use 'fd' for openat/openat2/statx

Jeremy Linton (1):
      usb: usbfs: correct kernel->user page attribute mismatch

Jia He (1):
      vhost: vsock: kick send_pkt worker once device is started

Jiri Kosina (1):
      HID: alps: ALPS_1657 is too specific; use U1_UNICORN_LEGACY instead

Jiri Pirko (1):
      mlxsw: spectrum_acl_tcam: Position vchunk in a vregion list properly

Joerg Roedel (5):
      iommu/amd: Fix race in increase_address_space()/fetch_pte()
      iommu/amd: Do not loop forever when trying to increase address space
      iommu/amd: Call domain_flush_complete() in update_domain()
      iommu/amd: Update Device Table in increase_address_space()
      iommu/amd: Do not flush Device Table in iommu_map_page()

John Stultz (5):
      phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
      driver core: Revert default driver_deferred_probe_timeout value to 0
      driver core: Use dev_warn() instead of dev_WARN() for
deferred_probe_timeout warnings
      driver core: Ensure wait_for_device_probe() waits until the
deferred_probe_timeout fires
      regulator: Revert "Use driver_deferred_probe_timeout for
regulator_init_complete_work"

Josh Poimboeuf (12):
      objtool: Fix stack offset tracking for indirect CFAs
      x86/entry/64: Fix unwind hints in register clearing code
      x86/entry/64: Fix unwind hints in kernel exit path
      x86/entry/64: Fix unwind hints in __switch_to_asm()
      x86/unwind/orc: Convert global variables to static
      x86/unwind: Prevent false warnings for non-current tasks
      x86/unwind/orc: Prevent unwinding before ORC initialization
      x86/unwind/orc: Fix error path for bad ORC entry type
      x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
      objtool: Fix infinite loop in for_offset_range()
      x86/unwind/orc: Move ORC sorting variables under !CONFIG_MODULES
      objtool: Fix infinite loop in find_jump_table()

Jules Irenge (1):
      cxgb4: Add missing annotation for service_ofldq()

Julia Lawall (2):
      dp83640: reverse arguments to list_add_tail
      iommu/virtio: Reverse arguments to list_add

Julian Wiedmann (1):
      s390/qeth: fix cancelling of TX timer on dev_close()

Juliet Kim (1):
      ibmvnic: Skip fatal error reset after passive init

KP Singh (1):
      security: Fix the default value of fs_context_parse_param hook

Kashyap Chamarthy (1):
      docs/virt/kvm: Document configuring and running nested guests

Kees Cook (2):
      gcc-plugins/stackleak: Avoid assignment for unused macro argument
      ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST

Khazhismel Kumykov (1):
      eventpoll: fix missing wakeup for ovflist in ep_poll_callback

Kishon Vijay Abraham I (1):
      MAINTAINERS: Add Vinod Koul as Generic PHY co-maintainer

Konstantin Khlebnikov (1):
      ftrace/x86: Fix trace event registration for syscalls without argumen=
ts

Linus Torvalds (9):
      gcc-10 warnings: fix low-hanging fruit
      Stop the ad-hoc games with -Wno-maybe-initialized
      gcc-10: disable 'zero-length-bounds' warning for now
      gcc-10: disable 'array-bounds' warning for now
      gcc-10: disable 'stringop-overflow' warning for now
      gcc-10: disable 'restrict' warning for now
      gcc-10: avoid shadowing standard library 'free()' in crypto
      gcc-10: mark more functions __init to avoid section mismatch warnings
      Linux 5.7-rc5

Luis Chamberlain (1):
      coredump: fix crash when umh is disabled

Luis Henriques (1):
      ceph: demote quotarealm lookup warning to a debug message

Lukas Bulwahn (2):
      MAINTAINERS: remove entry after hp100 driver removal
      MAINTAINERS: put DYNAMIC INTERRUPT MODERATION in proper order

Maciej Grochowski (1):
      kernel/kcov.c: fix typos in kcov_remote_start documentation

Manivannan Sadhasivam (1):
      bus: mhi: Fix parsing of mhi_flags

Marc Zyngier (9):
      KVM: arm: vgic: Fix limit condition when writing to GICD_I[CS]ACTIVER
      KVM: arm64: PSCI: Narrow input registers when using 32bit functions
      KVM: arm64: PSCI: Forbid 64bit functions for 32bit guests
      KVM: arm: vgic: Synchronize the whole guest on GIC{D,R}_I{S,C}ACTIVER=
 read
      KVM: arm: vgic: Only use the virtual state when userspace
accesses enable bits
      KVM: arm: vgic-v2: Only use the virtual state when userspace
accesses pending bits
      KVM: arm64: Save/restore sp_el0 as part of __guest_enter
      KVM: arm64: vgic-v4: Initialize GICv4.1 even in the absence of a
virtual ITS
      KVM: arm64: Fix 32bit PC wrap-around

Mark Rutland (1):
      arm64: hugetlb: avoid potential NULL dereference

Masami Hiramatsu (5):
      selftests/ftrace: Make XFAIL green color
      bootconfig: Fix to remove bootconfig data from initrd while boot
      tracing/kprobes: Fix a double initialization typo
      tracing/boottime: Fix kprobe event API usage
      tracing/kprobes: Reject new event if loc is NULL

Matt Jolly (2):
      net: usb: qmi_wwan: add support for DW5816e
      USB: serial: qcserial: Add DW5816e support

Maxim Petrov (1):
      stmmac: fix pointer check after utilization in stmmac_interrupt

Michael Chan (4):
      bnxt_en: Fix VF anti-spoof filter setup.
      bnxt_en: Improve AER slot reset.
      bnxt_en: Return error when allocating zero size context memory.
      bnxt_en: Fix VLAN acceleration handling in bnxt_fix_features().

Michel D=C3=A4nzer (1):
      drm/amdgpu/dc: Use WARN_ON_ONCE for ASSERT

Mika Westerberg (1):
      thunderbolt: Check return value of tb_sw_read() in usb4_switch_op()

Miroslav Benes (1):
      x86/unwind/orc: Don't skip the first frame for inactive tasks

Moshe Shemesh (2):
      net/mlx5: Fix forced completion access non initialized command entry
      net/mlx5: Fix command entry leak in Internal Error State

Murali Karicheri (1):
      net: hsr: fix incorrect type usage for protocol variable

Nathan Chancellor (1):
      hv_netvsc: Fix netvsc_start_xmit's return type

Nicolas Pitre (1):
      vt: fix unicode console freeing with a common interface

Oleg Nesterov (1):
      ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()

Oliver Neukum (2):
      USB: serial: garmin_gps: add sanity checking for data length
      USB: uas: add quirk for LaCie 2Big Quadra

Oscar Carter (1):
      staging: gasket: Check the return value of gasket_get_bar_index()

Pablo Neira Ayuso (1):
      net: flow_offload: skip hw stats check for FLOW_ACTION_HW_STATS_DONT_=
CARE

Paolo Abeni (7):
      mptcp: fix race in msk status update
      mptcp: consolidate synack processing.
      mptcp: move option parsing into mptcp_incoming_options()
      mptcp: avoid a WARN on bad input.
      mptcp: fix 'use_ack' option access.
      mptcp: initialize the data_fin field for mpc packets
      mptcp: fix uninitialized value access

Paolo Bonzini (3):
      KVM: SVM: fill in kvm_run->debug.arch.dr[67]
      kvm: ioapic: Restrict lazy EOI update to edge-triggered interrupts
      kvm: x86: Use KVM CPU capabilities to determine CR4 reserved bits

Parav Pandit (3):
      net/mlx5: E-switch, Fix error unwinding flow for steering init failur=
e
      net/mlx5: E-switch, Fix printing wrong error value
      net/mlx5: E-switch, Fix mutex init order

Pavel Begunkov (1):
      splice: move f_mode checks to do_{splice,tee}()

Peter Xu (2):
      KVM: selftests: Fix build for evmcs.h
      KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly

Prashant Malani (1):
      usb: typec: mux: intel: Handle alt mode HPD_HIGH

Qiushi Wu (1):
      nfp: abm: fix a memory leak bug

Qiwu Chen (1):
      mm/vmscan: remove unnecessary argument description of isolate_lru_pag=
es()

Quinn Tran (1):
      scsi: qla2xxx: Delete all sessions before unregister local nvme port

Rahul Lakkireddy (1):
      cxgb4: fix EOTID leak when disabling TC-MQPRIO offload

Richard Clark (1):
      aquantia: Fix the media type of AQC100 ethernet controller in the dri=
ver

Rick Edgecombe (1):
      x86/mm/cpa: Flush direct map alias during cpa

Roi Dayan (1):
      net/mlx5e: Fix q counters on uplink representors

Roman Li (1):
      drm/amd/display: fix counter in wait_for_no_pipes_pending

Roman Mashak (1):
      neigh: send protocol value in neighbor create notification

Roman Penyaev (2):
      kselftests: introduce new epoll60 testcase for catching lost wakeups
      epoll: atomically remove wait entry on wake up

Sage Weil (1):
      MAINTAINERS: remove myself as ceph co-maintainer

Sagi Grimberg (1):
      nvme: fix possible hang when ns scanning fails during error recovery

Saravana Kannan (1):
      driver core: Fix handling of fw_devlink=3Dpermissive

Scott Dial (1):
      net: macsec: preserve ingress frame ordering

Sean Christopherson (2):
      KVM: nVMX: Replace a BUG_ON(1) with BUG() to squash clang warning
      KVM: VMX: Explicitly clear RFLAGS.CF and RFLAGS.ZF in VM-Exit RSB pat=
h

Sean Paul (1):
      drm: Fix HDCP failures when SRM fw is missing

Sebastian Reichel (1):
      HID: multitouch: add eGalaxTouch P80H84 support

Shannon Nelson (3):
      ionic: no link check until after probe
      ionic: refresh devinfo after fw-upgrade
      ionic: add device reset to fw upgrade down

Shuah Khan (1):
      selftests: fix kvm relocatable native/cross builds and installs

Shubhrajyoti Datta (1):
      tty: xilinx_uartps: Fix missing id assignment to the console

Stefan Hajnoczi (1):
      virtio-blk: handle block_device_operations callbacks after hot unplug

Stefano Garzarella (2):
      vhost/vsock: fix packet delivery order to monitoring devices
      vsock/virtio: fix multiple packet delivery to monitoring devices

Steven Rostedt (VMware) (2):
      tracing: Wait for preempt irq delay thread to finish
      tracing: Add a vmalloc_sync_mappings() for safe measure

Sultan Alsawaf (1):
      wireguard: send: remove errant newline from packet_encrypt_worker

Sung Lee (1):
      drm/amd/display: Update DCN2.1 DV Code Revision

Suravee Suthikulpanit (1):
      KVM: x86: Fixes posted interrupt check for IRQs delivery modes

Tariq Toukan (1):
      net/mlx4_core: Fix use of ENOSPC around mlx4_counter_alloc()

Tejun Heo (1):
      iocost: protect iocg->abs_vdebt with iocg->waitq.lock

Thierry Reding (1):
      phy: tegra: Select USB_COMMON for usb_get_maximum_speed()

Thomas Gleixner (2):
      x86/apic: Move TSC deadline timer debug printk
      ARM: futex: Address build warning

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      wireguard: receive: use tunnel helpers for decapsulating ECN markings
      tunnel: Propagate ECT(1) when decapsulating as recommended by RFC6040

Tomas Winkler (1):
      mei: me: disable mei interface on LBG servers.

Tuong Lien (1):
      tipc: fix partial topology connection closure

Tyrel Datwyler (1):
      scsi: ibmvscsi: Fix WARN_ON during event pool release

Ulf Hansson (2):
      driver core: platform: Initialize dma_parms for platform devices
      amba: Initialize dma_parms for amba devices

Vasundhara Volam (1):
      bnxt_en: Reduce BNXT_MSIX_VEC_MAX value to supported CQs per PF.

Vincent Chen (1):
      riscv: set max_pfn to the PFN of the last page

Vladimir Oltean (4):
      net: dsa: sja1105: the PTP_CLK extts input reacts on both edges
      net: dsa: ocelot: the MAC table on Felix is twice as large
      net: mscc: ocelot: ANA_AUTOAGE_AGE_PERIOD holds a value in seconds, n=
ot ms
      net: dsa: remove duplicate assignment in dsa_slave_add_cls_matchall_m=
irred

Waiman Long (1):
      mm/slub: fix incorrect interpretation of s->offset

Wei Yang (1):
      tracing: Fix doc mistakes in trace sample

Willem de Bruijn (1):
      net: stricter validation of untrusted gso packets

Wolfram Sang (1):
      staging: ks7010: remove me from CC list

Wu Bo (2):
      ceph: fix special error code in ceph_try_get_caps()
      ceph: fix double unlock in handle_cap_export()

Xiaoguang Wang (2):
      io_uring: fix mismatched finish_wait() calls in io_uring_cancel_files=
()
      io_uring: handle -EFAULT properly in io_uring_setup()

Xiongfeng Wang (1):
      platform/x86: thinkpad_acpi: Remove always false 'value < 0' statemen=
t

Xiyu Yang (7):
      batman-adv: Fix refcnt leak in batadv_show_throughput_override
      batman-adv: Fix refcnt leak in batadv_store_throughput_override
      batman-adv: Fix refcnt leak in batadv_v_ogm_process
      configfs: fix config_item refcnt leak in configfs_rmdir()
      net/tls: Fix sk_psock refcnt leak in bpf_exec_tx_verdict()
      net/x25: Fix x25_neigh refcnt leak when x25 disconnect
      net/tls: Fix sk_psock refcnt leak when in tls_data_ready()

Yafang Shao (1):
      mm, memcg: fix error return value of mem_cgroup_css_alloc()

Yiwei Zhang (1):
      gpu/trace: Minor comment updates for gpu_mem_total tracepoint

Yoshiyuki Kurauchi (1):
      gtp: set NLM_F_MULTI flag in gtp_genl_dump_pdp()

YueHaibing (2):
      platform/x86: wmi: Make two functions static
      net/x25: Fix null-ptr-deref in x25_disconnect

Yufen Yu (1):
      bdi: use bdi_dev_name() to get device name

Yunfeng Ye (1):
      tools/bootconfig: Fix resource leak in apply_xbc()

Zenghui Yu (2):
      KVM: arm64: vgic-v3: Retire all pending LPIs on vcpu destroy
      KVM: arm64: vgic-its: Fix memory leak on the error path of vgic_add_l=
pi()

Zong Li (1):
      riscv: force __cpu_up_ variables to put in data section

Zou Wei (1):
      tracing: Make tracing_snapshot_instance_cond() static
