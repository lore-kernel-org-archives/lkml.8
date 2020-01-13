Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586FC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CA221556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578878658;
	bh=c7D0+8Yxt1YIAoqx/y0qXgL7XrBYbISC++FSBYNNrHI=;
	h=From:Date:Subject:To:List-ID:From;
	b=fzwaYonDMWSnGfwH61ttal3+QEV8VWbV8LoFLwjQIROkXHP7OUJtve7UHHzVtJ9dT
	 rsvBz9VE27kJ6S8YbOAzki8hiG4Sy7qRVXghvKzPNjg8NJwo1FdH/coQLCN672hiDY
	 BQmDiJOiKwFzypzyKDN923nPMgkBfFoK57bB8s/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgAMBYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:24:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40121 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgAMBYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:24:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so8161671ljk.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=GVzCQj9dh1MeVL+lsh2sBh5omI0oJ30adc4LdDvgteA=;
        b=BF8hMlgomGGCx0Bmd4M0RLkGopf+b+pvKOelmaqqIh7WmKXJ5qWNKnB8wxntNpLt4h
         7k5I6LftYIXuqzWhXQD1XZ7Se+J8W2iIK/AVBcgW7N1BmjLiiTIPXRJXW4fds1vBykEo
         wwRiqY29fP2wUU6Mh3QElKfg59F1rGTUkgfO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GVzCQj9dh1MeVL+lsh2sBh5omI0oJ30adc4LdDvgteA=;
        b=rXymyWEctgxdDubWU8u/yYtdL7lykrDDmSVXB+cPQDx4bwNglMlZKhqTTD068SQI2L
         1588SnisVOXQSGuZ47gqJQx63AFeXuDpVJuCdcI5CUj6ub7jBBoQHI+6EUS0OZYvUCAM
         xskx3pXHAbxVSGhRbJMmXUXvVUlzkDQxNgE+u6QZnXxbFoWeDWEbgR9JNEVrsfEyRRjE
         Q+VBCTKcW/U0vNSdNdOxIVNB31snWfQY43H/MNHhbWpWjSaKD00odrc/B0tj373g50z2
         JC7wnL09OuHkGMa++MkHZCfIPwkhk8zvyYGbQVnNjdBB76m3/KF5G5Go4EgXI83Vdw7R
         pTDA==
X-Gm-Message-State: APjAAAUaW23+cxw4WoBrHmbScN4/caBJ+fKLjYctQpK8abuy1kanYmXd
        Crj0zUbCzKqQlkn7oaI6HZIiK58gNgE=
X-Google-Smtp-Source: APXvYqxaTA1EBLfbHM8/sDE0eQmqujRHZZ6aj4A/B7lmAMcYG/e+3ON+uzUy7dy5h3TaXcM8xwg4Iw==
X-Received: by 2002:a2e:3a0c:: with SMTP id h12mr9133599lja.200.1578878653176;
        Sun, 12 Jan 2020 17:24:13 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h81sm4798915lfd.83.2020.01.12.17.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 17:24:12 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id v201so5585021lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 17:24:11 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr8011594lfm.29.1578878651238;
 Sun, 12 Jan 2020 17:24:11 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jan 2020 17:23:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZRs-nL2SQ3syoyC8-Ycaj-AcH18UHe2b3GV0ayf0ZjQ@mail.gmail.com>
Message-ID: <CAHk-=wjZRs-nL2SQ3syoyC8-Ycaj-AcH18UHe2b3GV0ayf0ZjQ@mail.gmail.com>
Subject: Linux 5.5-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things have picked up a _bit_ after the holiday season, but it's still
pretty quiet. Not outrageously so: this could almost be a normal rc5,
just slightly calmer than usual.

Let's see how things go. I do suspect that this ends up being one of
those "rc8" releases, not because things look particularly bad right
now, but simply because the holiday season has meant that both the
testing side and the development side have been quiet. But who knows?
It's entirely possible that we'll just have a very quiet next two
weeks, and I go "there is no point in delaying things".

So nothing looks particularly worrisome, and normally I'd be very
happy with a quiet rc6. I just suspect that there's some pent-up work
still, and I'm left waiting for the other shoe to drop...

Anyway, rc6 is dominated mostly by drivers. There's a little bit of
everything there: networking perhaps stands out, but there's USB, GPU,
HID, MTD, sound, gpio, block and misc other driver updates there.

Outside of drivers, there's core networking, some minor arch updates
(ARC, RISC-V, one arm64 revert), some tracing fixes, and a set of
fixes for the clone3() system call

But all of it is pretty small, and nothing really looks scary at all.
Scan the shortlog below if you are into that, but otherwise just go
forth and test it out all,

             Linus

---

Aaron Ma (1):
      HID: multitouch: Add LG MELF0410 I2C touchscreen support

Alan Stern (2):
      HID: Fix slab-out-of-bounds read in hid_field_extract
      USB: Fix: Don't skip endpoint descriptors with maxpacket=0

Alex Deucher (1):
      Revert "drm/amdgpu: Set no-retry as default."

Alexandre Belloni (1):
      rtc: cmos: Revert "rtc: Fix the AltCentury value on AMD/Hygon platform"

Amanieu d'Antras (8):
      arm64: Move __ARCH_WANT_SYS_CLONE3 definition to uapi headers
      arm64: Implement copy_thread_tls
      arm: Implement copy_thread_tls
      parisc: Implement copy_thread_tls
      riscv: Implement copy_thread_tls
      xtensa: Implement copy_thread_tls
      clone3: ensure copy_thread_tls is implemented
      um: Implement copy_thread_tls

Amir Mahdi Ghorbanian (1):
      mtd: onenand: omap2: Fix errors in style

Amit Engel (1):
      nvmet: fix per feat data len for get_feature

Amit Kucheria (1):
      drivers: thermal: tsens: Work with old DTBs

Andreas Kemnade (1):
      watchdog: rn5t618_wdt: fix module aliases

Andrew Lunn (2):
      net: freescale: fec: Fix ethtool -d runtime PM
      net: dsa: mv88e6xxx: Preserve priority when setting CPU port.

Anson Huang (1):
      Input: imx_sc_key - only take the valid data from SCU firmware
as key state

Arnd Bergmann (6):
      Input: input_event - fix struct padding on sparc64
      usb: udc: tegra: select USB_ROLE_SWITCH
      ASoC: Intel: boards: Fix compile-testing RT1011/RT5682
      pinctrl: lochnagar: select GPIOLIB
      atm: eni: fix uninitialized variable warning
      mtd: sm_ftl: fix NULL pointer warning

Axel Lin (2):
      regulator: axp20x: Fix axp20x_set_ramp_delay
      regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops

Bartosz Golaszewski (1):
      gpio: mockup: fix coding style

Baruch Siach (1):
      net: dsa: mv88e6xxx: force cmode write on 6141/6341

Bjorn Andersson (1):
      phy: qcom-qmp: Increase PHY ready timeout

Carl Huang (1):
      net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue

Catalin Marinas (1):
      arm64: Revert support for execute-only user mappings

Chen-Yu Tsai (5):
      rtc: sun6i: Add support for RTC clocks on R40
      regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask
      drm/sun4i: tcon: Set RGB DCLK min. divider based on hardware model
      net: stmmac: dwmac-sunxi: Allow all RGMII modes
      net: stmmac: dwmac-sun8i: Allow all RGMII modes

Chris Wilson (3):
      drm/i915/gt: Mark up virtual engine uabi_instance
      drm/i915/gt: Do not restore invalid RS state
      drm/i915/gt: Restore coarse power gating

Christophe Kerello (1):
      mtd: rawnand: stm32_fmc2: avoid to lock the CPU bus

Chuhong Yuan (1):
      ASoC: fsl_audmix: add missed pm_runtime_disable

Chunming Zhou (1):
      drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu

Colin Ian King (3):
      ASoC: SOF: imx8: fix memory allocation failure check on priv->pd_dev
      tracing: Fix indentation issue
      usb: ohci-da8xx: ensure error return on variable error is set

Dan Murphy (2):
      can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before
parsing the config
      can: tcan4x5x: tcan4x5x_parse_config(): Disable the INH pin
device-state GPIO is unavailable

Daniel Baluta (2):
      ASoC: soc-core: Set dpcm_playback / dpcm_capture
      ASoC: SOF: imx8: Fix dsp_box offset

Daniel Borkmann (1):
      bpf: Fix passing modified ctx to ld/abs/ind instruction

Daniele Palmas (2):
      USB: serial: option: add Telit ME910G1 0x110a composition
      USB: serial: option: add ZLP support for 0x1bc7/0x9010

David Engraf (1):
      watchdog: max77620_wdt: fix potential build errors

David S. Miller (2):
      net: Correct type of tcp_syncookies sysctl.
      net: Update GIT url in maintainers.

Dmitry Osipenko (2):
      cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs
      gpio: max77620: Add missing dependency on GPIOLIB_IRQCHIP

Dmitry Torokhov (4):
      HID: hid-input: clear unmapped usages
      Input: uinput - always report EPOLLOUT
      Input: add safety guards to input_set_keycode()
      HID: hiddev: fix mess in hiddev_open()

Dmytro Linkin (1):
      net/mlx5e: Avoid duplicating rule destinations

Douglas Gilbert (1):
      USB-PD tcpm: bad warning+size, PPS adapters

Dragos Tarcatu (1):
      ASoC: topology: Prevent use-after-free in snd_soc_get_pcm_runtime()

Eli Cohen (1):
      net/mlx5e: Fix hairpin RSS table size

Eran Ben Elisha (1):
      net/mlx5e: Always print health reporter message to dmesg

Erez Shitrit (1):
      net/mlx5: DR, Init lists that are used in rule's member

Eric Dumazet (6):
      vlan: fix memory leak in vlan_dev_set_egress_priority
      vlan: vlan_changelink() should propagate errors
      net: usb: lan78xx: fix possible skb leak
      pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM
      gtp: fix bad unlock balance in gtp_encap_enable_socket
      macvlan: do not assume mac_header is set in macvlan_broadcast()

Eugen Hristev (2):
      i2c: at91: fix clk_offset for sam9x60
      dt-bindings: i2c: at91: fix i2c-sda-hold-time-ns documentation for sam9x60

Eugeniy Paltsev (2):
      ARC: asm-offsets: remove duplicate entry
      ARC: pt_regs: remove hardcoded registers offset

Even Xu (1):
      HID: intel-ish-hid: ipc: add CMP device id

Fabio Estevam (1):
      watchdog: imx7ulp: Fix missing conversion of imx7ulp_wdt_enable()

Fenghua Yu (1):
      drivers/net/b44: Change to non-atomic bit operations on pwol_mask

Florian Faber (1):
      can: mscan: mscan_rx_poll(): fix rx path lockup when returning
from polling to irq mode

Florian Westphal (3):
      netfilter: arp_tables: init netns pointer in xt_tgchk_param struct
      netfilter: conntrack: dccp, sctp: handle null timeout argument
      netfilter: ipset: avoid null deref when IPSET_ATTR_LINENO is present

Geert Uytterhoeven (1):
      drm/fb-helper: Round up bits_per_pixel if possible

Guenter Roeck (1):
      usb: chipidea: host: Disable port power only if previously enabled

Guo Ren (1):
      riscv: Fixup obvious bug for fp-regs reset

Gustavo A. R. Silva (1):
      can: tcan4x5x: tcan4x5x_parse_config(): fix inconsistent IS_ERR
and PTR_ERR

Hangbin Liu (2):
      vxlan: fix tos value before xmit
      selftests: loopback.sh: skip this test if the driver does not support

Hans de Goede (4):
      HID: ite: Add USB id match for Acer SW5-012 keyboard dock
      HID: asus: Ignore Asus vendor-page usage-code 0xff events
      gpiolib: acpi: Turn dmi_system_id table into a generic quirk table
      gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism

Harry Pan (1):
      powercap: intel_rapl: add NULL pointer check to rapl_mmio_cpu_online()

Heikki Krogerus (1):
      usb: typec: ucsi: Fix the notification bit offsets

Ian Abbott (1):
      staging: comedi: adv_pci1710: fix AI channels 16-31 for PCI-1713

Igor Russkikh (3):
      net: atlantic: broken link status on old fw
      net: atlantic: loopback configuration in improper place
      net: atlantic: remove duplicate entries

Jarkko Sakkinen (1):
      tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"

Jason Gerecke (1):
      HID: wacom: Recognize new MobileStudio Pro PID

Jens Axboe (2):
      block: remove unused mp_bvec_last_segment
      io_uring: remove punt of short reads to async context

Jesper Dangaard Brouer (1):
      doc/net: Update git https URLs in netdev-FAQ documentation

Jiping Ma (1):
      stmmac: debugfs entry name is not be changed when udev rename device name.

Jiri Kosina (1):
      HID: hidraw, uhid: Always report EPOLLOUT

Joel Fernandes (Google) (1):
      tracing: Change offset type to s32 in preempt/irq tracepoints

Johan Hovold (3):
      USB: core: fix check for duplicate endpoints
      can: kvaser_usb: fix interface sanity check
      can: gs_usb: gs_usb_probe(): use descriptors of current altsetting

Jon Derrick (2):
      iommu: Remove device link to group on failure
      iommu/vt-d: Unlink device if failed to add to group

Jonas Karlman (1):
      phy/rockchip: inno-hdmi: round clock rate down to closest 1000 Hz

Jose Abreu (1):
      net: stmmac: Fixed link does not need MDIO Bus

Kai Vehmanen (3):
      ASoC: SOF: fix fault at driver unload after failed probe
      drm/i915: Limit audio CDCLK>=2*BCLK constraint back to GLK only
      ALSA: hda: enable regmap internal locking

Kaike Wan (2):
      IB/hfi1: Don't cancel unused work item
      IB/hfi1: Adjust flow PSN with the correct resync_psn

Kailang Yang (3):
      ALSA: hda/realtek - Add new codec supported for ALCS1200A
      ALSA: hda/realtek - Set EAPD control to default for ALC222
      ALSA: hda/realtek - Add quirk for the bass speaker on Lenovo
Yoga X1 7th gen

Kaitao Cheng (1):
      kernel/trace: Fix do not unregister tracepoints when register
sched_migrate_task fail

Kees Cook (1):
      pstore/ram: Regularize prz label allocation lifetime

Keith Busch (1):
      nvme: Translate more status codes to blk_status_t

Krzysztof Kozlowski (4):
      MAINTAINERS: Drop obsolete entries from Samsung sxgbe ethernet driver
      net: wan: sdla: Fix cast from pointer to integer of different size
      net: ethernet: sxgbe: Rename Samsung to lowercase
      mtd: onenand: samsung: Fix iomem access with regular memcpy

Kunihiko Hayashi (1):
      spi: uniphier: Fix FIFO threshold

Linus Torvalds (1):
      Linux 5.5-rc6

Liran Alon (1):
      net: Google gve: Remove dma_wmb() before ringing doorbell

Malcolm Priestley (5):
      staging: vt6656: Fix non zero logical return of, usb_control_msg
      staging: vt6656: correct return of vnt_init_registers.
      staging: vt6656: limit reg output to block size
      staging: vt6656: remove bool from vnt_radio_power_on ret
      staging: vt6656: set usb_set_intfdata on driver fail.

Manasi Navare (1):
      drm/i915/dp: Disable Port sync mode correctly on teardown

Marcel Holtmann (2):
      HID: hidraw: Fix returning EPOLLOUT from hidraw_poll
      HID: uhid: Fix returning EPOLLOUT from uhid_char_poll

Masahiro Yamada (2):
      tipc: do not add socket.o to tipc-y twice
      tipc: remove meaningless assignment in Makefile

Matt Roper (2):
      drm/i915: Add Wa_1408615072 and Wa_1407596294 to icl,ehl
      drm/i915: Add Wa_1407352427:icl,ehl

Michael Guralnik (1):
      net/mlx5: Move devlink registration before interfaces load

Michael Straube (1):
      staging: rtl8188eu: Add device code for TP-Link TL-WN727N v5.21

Mike Rapoport (1):
      ARC: mm: drop stale define of __ARCH_USE_5LEVEL_HACK

Ming Lei (1):
      fs: move guard_bio_eod() after bio_set_op_attrs

Niklas Cassel (1):
      MAINTAINERS: Remove myself as co-maintainer for qcom-ethqos

Oliver Hartkopp (1):
      can: can_dropped_invalid_skb(): ensure an initialized headroom
in outgoing CAN sk_buffs

Olivier Moysan (3):
      ASoC: stm32: spdifrx: fix inconsistent lock state
      ASoC: stm32: spdifrx: fix race condition in irq handler
      ASoC: stm32: spdifrx: fix input pin state management

Pablo Neira Ayuso (2):
      netfilter: nf_tables: unbind callbacks from flowtable destroy path
      netfilter: flowtable: add nf_flowtable_time_stamp

Pan Zhang (1):
      drivers/hid/hid-multitouch.c: fix a possible null pointer access.

Parav Pandit (1):
      Revert "net/mlx5: Support lockless FTE read lookups"

Patrick Steinhardt (1):
      iommu/vt-d: Fix adding non-PCI devices to Intel IOMMU

Paul Cercueil (3):
      usb: musb: jz4740: Silence error if code is -EPROBE_DEFER
      usb: musb: dma: Correct parameter passed to IRQ handler
      usb: musb: Disable pullup at init

Pavel Balan (1):
      HID: Add quirk for incorrect input length on Lenovo Y720

Pengcheng Yang (1):
      tcp: fix "old stuff" D-SACK causing SACK to be treated as D-SACK

Peter Chen (1):
      usb: cdns3: should not use the same dev_id for shared interrupt handler

Peter Ujfalusi (1):
      mtd: onenand: omap2: Pass correct flags for prep_dma_memcpy

Petr Machata (2):
      mlxsw: spectrum_qdisc: Ignore grafting of invisible FIFO
      net: sch_prio: When ungrafting, replace with FIFO

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: hda: hda-dai: fix oops on hda_link .hw_free

Priit Laes (1):
      HID: Add quirk for Xin-Mo Dual Controller

Punit Agrawal (1):
      serdev: Don't claim unsupported ACPI serial devices

Qi Zhou (1):
      usb: missing parentheses in USE_NEW_SCHEME

Qian Cai (1):
      iommu/dma: fix variable 'cookie' set but not used

Qianggui Song (1):
      pinctrl: meson: Fix wrong shift value when get drive-strength

Ran Bi (1):
      rtc: mt6397: fix alarm register overwrite

Randy Dunlap (1):
      arc: eznps: fix allmodconfig kconfig warning

Rodrigo Rivas Costa (1):
      HID: steam: Fix input device disappearing

Roman Gushchin (1):
      bpf: cgroup: prevent out-of-order release of cgroup bpf

Russell King (3):
      watchdog: orion: fix platform_get_irq() complaints
      net: phylink: fix failure to register on x86 systems
      i2c: fix bus recovery stop mode timing

Sean Nyekjaer (2):
      can: tcan4x5x: tcan4x5x_can_probe(): get the device out of
standby before register access
      can: tcan4x5x: tcan4x5x_parse_config(): reset device before
register access

Selvin Xavier (2):
      RDMA/bnxt_re: Avoid freeing MR resources if dereg fails
      RDMA/bnxt_re: Fix Send Work Entry state check while polling completions

Shiraz Saleem (1):
      i40iw: Remove setting of VMA private data and use rdma_user_mmap_io

Srikanth Krishnakar (1):
      watchdog: w83627hf_wdt: Fix support NCT6116D

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Add Tiger Lake PCI device ID

Stefan Berger (2):
      tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing
for interrupts"
      tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"

Stefan Wahren (1):
      i2c: bcm2835: Store pointer to bus clock

Stephen Boyd (1):
      macb: Don't unregister clks unconditionally

Steven Rostedt (VMware) (3):
      tracing: Initialize val to zero in parse_entry of inject code
      tracing: Define MCOUNT_INSN_SIZE when not defined without direct calls
      tracing: Have stack tracer compile when MCOUNT_INSN_SIZE is not defined

Sudip Mukherjee (1):
      tty: always relink the port

Swapna Manupati (1):
      gpio: zynq: Fix for bug in zynq_gpio_restore_context API

Tadeusz Struk (1):
      tpm: Handle negative priv->response_len in tpm_common_read()

Takashi Iwai (2):
      ASoC: core: Fix access to uninitialized list heads
      ALSA: usb-audio: Apply the sample rate quirk for Bose Companion 5

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix request complete check

Thomas Anderson (1):
      drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded

Tony Lindgren (7):
      phy: cpcap-usb: Fix error path when no host driver is loaded
      phy: cpcap-usb: Fix flakey host idling and enumerating of devices
      phy: mapphone-mdm6600: Fix uninitialized status value regression
      phy: cpcap-usb: Prevent USB line glitches from waking up modem
      phy: cpcap-usb: Improve host vs docked mode detection
      phy: cpcap-usb: Drop extra write to usb2 register
      usb: musb: fix idling for suspend after disconnect interrupt

Tudor Ambarus (1):
      mtd: spi-nor: Fix the writing of the Status Register on micron flashes

Tuong Lien (2):
      tipc: fix link overflow issue at socket shutdown
      tipc: fix wrong connect() return code

Vasyl Gomonovych (1):
      mtd: cadence: Fix cast to pointer from integer of different size warning

Vignesh Raghavendra (1):
      spi: Document Octal mode as valid SPI bus width

Vikas Gupta (1):
      firmware: tee_bnxt: Fix multiple call to tee_client_close_context

Vladimir Oltean (2):
      spi: Don't look at TX buffer for PTP system timestamping
      spi: spi-fsl-dspi: Fix 16-bit word order in 32-bit XSPI mode

Wayne Lin (1):
      drm/dp_mst: correct the shifting in DP_REMOTE_I2C_READ

Wen Yang (2):
      sch_cake: avoid possible divide by zero in cake_enqueue()
      ftrace: Avoid potential division by zero in function profiler

Will Deacon (1):
      chardev: Avoid potential use-after-free in 'chrdev_open()'

Xin Long (1):
      sctp: free cmd->obj.chunk for the unprocessed SCTP_CMD_REPLY

Yash Shah (1):
      riscv: move sifive_l2_cache.h to include/soc

Yevgeny Kliteynik (1):
      net/mlx5: DR, No need for atomic refcount for internal SW
steering resources

Ying Xue (1):
      tipc: eliminate KMSAN: uninit-value in __tipc_nl_compat_dumpit error

YueHaibing (1):
      watchdog: tqmx86_wdt: Fix build error

wenxu (4):
      netfilter: nft_flow_offload: fix underflow in flowtable reference counter
      netfilter: nf_flow_table_offload: fix incorrect ethernet dst address
      netfilter: nf_flow_table_offload: check the status of dst_neigh
      netfilter: nf_flow_table_offload: fix the nat port mangle.

wuxu.wu (1):
      spi: spi-dw: Add lock protect dw_spi rx/tx to prevent concurrent calls
