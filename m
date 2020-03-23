Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F9C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7EE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS8WBIEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCWFmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:42:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39028 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:42:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so6957796pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sIiezijPs+jRs+EmHDt7uhGz2MDV2SCJjKFrMlfDAw=;
        b=SS8WBIEdRmdQcu7wIhsI/B/dLfnVuJRvuzKOWwaEC/PY64QE9Zr2P4iOMufJ97P0kr
         8lOO343uH02aWk1viy7uD/fzVH4YfwYNKWU3Z2cVIyBcQGZjcOcN42p+lLaW0/X5ewH7
         VLyypqCULId3RT/z8X68eFYakFxLRpanJZfq4Rur1JPh5ohE8K48Gj3MOCbcqQ/fRQT4
         0by7yaqVrl0/xGzfZbyqNTLJWVjAJBq1p5X/KgrVCcrcNb3iwXTBlylhvq429yuOtnoV
         iVOff4f3zY3up6Vm+38W8FVVmcLVjszLejiJXQsFmCrHNp56uXa/W+K8rFTcgt0zLKXJ
         BG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2sIiezijPs+jRs+EmHDt7uhGz2MDV2SCJjKFrMlfDAw=;
        b=btlaMSoQNinD1Mn+OPHaRyy7hpv3XvU7LHZDrCBdclaQYXdg9ZkHAXoibL6evgdVWC
         FxdwIw8PWPapOIr65mfipXsPUdNtsKmtBpTltCow7Ioj64BBS+zkVScHCJz/ViDU49X5
         30PueT+YnrdiIYzq4cyB+iUYNSFD8Gkp4MlTQxT5OCPQRJCPbkAiTkBIZ0Q4o7Tt+X0Q
         GJXVCkRBd30GoFY4tO2Z6Ya+MdPw+JBjUQmy5yXw0FwIbBSFvHfkWHUlXS92ShNC6gbM
         rVtKg5MgFAXOxMufIAlVq6YnC+ySiheE+cZ2r/lChQwgS1hyvEwFZbZ0ycKKabJxYcrT
         PW1w==
X-Gm-Message-State: ANhLgQ3cHtOhPqpxxGQ9bP2rfCPGbw1MzML3fQJ1OEf+ZiBjRGTLi0db
        vgs5QJAH9kjOLjbSe9o9MBrXQCRiyxY=
X-Google-Smtp-Source: ADFU+vvWcc+4sgimLWomClk8+wJYIejxzRanWF5Qwd42znipyENqPEacbDzdUz3rUfAm9g81PVJC/Q==
X-Received: by 2002:a62:170f:: with SMTP id 15mr21989979pfx.12.1584942141091;
        Sun, 22 Mar 2020 22:42:21 -0700 (PDT)
Received: from Slackware ([103.231.91.69])
        by smtp.gmail.com with ESMTPSA id i4sm3062285pjg.4.2020.03.22.22.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 22:42:20 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:12:09 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.6-rc7 build...compile...boot without fuss!
Message-ID: <20200323054209.GA1803@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wipv1y2Z7=CDQ5ajb2OvSyq-0BL9yLRPm1YqW+sjcSDzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <CAHk-=wipv1y2Z7=CDQ5ajb2OvSyq-0BL9yLRPm1YqW+sjcSDzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18:47 Sun 22 Mar 2020, Linus Torvalds wrote:
>The world around us may be going through strange times, but at least
>so far kernel development looks normal.
>
>The bulk this week is - as usual - drivers: gpu, mmc, staging, iio,
>usb, sound... But there's some VM fixes, some arch updates,
>documentation and tooling (mostly turbostat).
>
>Nothing really stands out, it's all pretty small. I'm going to be
>optimistic, and say that it's because we're nicely on track for a
>normal calm release, but obviously it may be partly because everybody
>is distracted by virus worries. But I haven't seen anything that looks
>hugely worrisome on the kernel side.
>
>Go test,
>
>               Linus


Well, build,compile and boot without fuss.



[    3.085160] EXT4-fs (sda): mounted filesystem with ordered data mode.
Opts: (null)
[    3.086661] ext4 filesystem being mounted at /root supports
timestamps until 2038 (0x7fffffff)
[    3.087398] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.100575] devtmpfs: mounted
[    3.109763] Freeing unused decrypted memory: 2040K
[    3.168224] Freeing unused kernel image (initmem) memory: 1568K
[    3.169033] Write protecting the kernel read-only data: 26624k
[    3.172891] Freeing unused kernel image (text/rodata gap) memory:
2040K
[    3.174589] Freeing unused kernel image (rodata/data gap) memory:
1040K
[    3.175361] rodata_test: all tests were successful
[    3.175732] Run /sbin/init as init process
[    3.211147] process '/bin/busybox' started with executable stack
[    3.355965] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.356633] ext4 filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[    3.372172] tsc: Refined TSC clocksource calibration: 2194.918 MHz
[    3.372923] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x1fa37202099, max_idle_ns: 440795206796 ns
[    3.373631] clocksource: Switched to clocksource tsc
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator... [    4.441038] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting network: OK

Welcome to Buildroot
buildroot login: [    9.580962] random: crng init done

Welcome to Buildroot
buildroot login: root
# uname -a
Linux buildroot 5.6.0-rc7-Slackware #1 SMP Mon Mar 23 09:27:26 IST 2020
x86_64 GNU/Linux


~Bhaskar






>
>---
>
>Alberto Mattea (1):
>      usb: xhci: apply XHCI_SUSPEND_DELAY to AMD XHCI controller 1022:145c
>
>Alexander Shishkin (4):
>      stm class: sys-t: Fix the use of time_after()
>      intel_th: msu: Fix the unexpected state warning
>      intel_th: Fix user-visible error codes
>      intel_th: pci: Add Elkhart Lake CPU support
>
>Alexandru Tachici (1):
>      iio: accel: adxl372: Set iio_chan BE
>
>Anthony Mallet (2):
>      USB: cdc-acm: fix close_delay and closing_wait units in TIOCSSERIAL
>      USB: cdc-acm: fix rounding error in TIOCSSERIAL
>
>Ard Biesheuvel (1):
>      ARM: 8961/2: Fix Kbuild issue caused by per-task stack protector
>GCC plugin
>
>Arnd Bergmann (1):
>      drm/komeda: mark PM functions as __maybe_unused
>
>Baoquan He (1):
>      mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>
>Caz Yokoyama (1):
>      Revert "drm/i915/tgl: Add extra hdc flush workaround"
>
>Chen Yu (5):
>      tools/power turbostat: Support Cometlake
>      tools/power turbostat: Support Tiger Lake
>      tools/power turbostat: Support Ice Lake server
>      tools/power turbostat: Support Jasper Lake
>      tools/power turbostat: Support Elkhart Lake
>
>Chen-Tsung Hsieh (1):
>      HID: google: add moonball USB id
>
>Chris Down (2):
>      mm, memcg: fix corruption on 64-bit divisor in memory.high throttling
>      mm, memcg: throttle allocators based on ancestral memory.high
>
>Chris Wilson (1):
>      drm/i915/execlists: Track active elements during dequeue
>
>Christian Brauner (1):
>      binderfs: use refcount for binder control devices too
>
>Christophe Leroy (1):
>      powerpc/kasan: Fix shadow memory protection with CONFIG_KASAN_VMALLOC
>
>Chunguang Xu (1):
>      memcg: fix NULL pointer dereference in __mem_cgroup_usage_unregister=
_event
>
>Corentin Labbe (1):
>      rtc: max8907: add missing select REGMAP_IRQ
>
>Cristian Marussi (2):
>      arm64: smp: fix smp_send_stop() behaviour
>      arm64: smp: fix crash_smp_send_stop() behaviour
>
>Dan Carpenter (2):
>      thunderbolt: Fix error code in tb_port_is_width_supported()
>      cifs: potential unintitliazed error code in cifs_getattr()
>
>Daniele Palmas (1):
>      USB: serial: option: add ME910G1 ECM composition 0x110b
>
>Eric Biggers (3):
>      tty: drop outdated comments about release_tty() locking
>      tty: fix compat TIOCGSERIAL leaking uninitialized memory
>      tty: fix compat TIOCGSERIAL checking wrong function ptr
>
>Eugen Hristev (1):
>      iio: adc: at91-sama5d2_adc: fix differential channels in triggered m=
ode
>
>Eugeniy Paltsev (1):
>      initramfs: restore default compression behavior
>
>Evan Quan (1):
>      drm/amdgpu: add fbdev suspend/resume on gpu reset
>
>Fabrice Gasnier (1):
>      iio: trigger: stm32-timer: disable master mode when stopping
>
>Filipe Manana (2):
>      btrfs: fix log context list corruption after rename whiteout error
>      btrfs: fix removal of raid[56|1c34} incompat flags after
>removing block group
>
>Florian Fainelli (1):
>      ARM: 8957/1: VDSO: Match ARMv8 timer in cntvct_functional()
>
>Gerd Hoffmann (1):
>      drm/bochs: downgrade pci_request_region failure from error to warning
>
>Greg Kurz (1):
>      KVM: PPC: Fix kernel crash with PR KVM
>
>Hans de Goede (3):
>      mmc: sdhci-acpi: Switch signal voltage back to 3.3V on suspend
>on external microSD on Lenovo Miix 320
>      mmc: sdhci-acpi: Disable write protect detection on Acer Aspire
>Switch 10 (SW5-012)
>      usb: quirks: add NO_LPM quirk for RTL8153 based ethernet adapters
>
>Heikki Krogerus (2):
>      usb: typec: ucsi: displayport: Fix NULL pointer dereference
>      usb: typec: ucsi: displayport: Fix a potential race during registrat=
ion
>
>James Zhu (3):
>      drm/amdgpu: fix typo for vcn1 idle check
>      drm/amdgpu: fix typo for vcn2/jpeg2 idle check
>      drm/amdgpu: fix typo for vcn2.5/jpeg2.5 idle check
>
>Jann Horn (1):
>      mm: slub: add missing TID bump in kmem_cache_alloc_bulk()
>
>Jens Axboe (2):
>      io_uring: make sure openat/openat2 honor rlimit nofile
>      io_uring: make sure accept honor rlimit nofile
>
>Jernej Skrabec (1):
>      drm/bridge: dw-hdmi: fix AVI frame colorimetry
>
>Jessica Yu (1):
>      modpost: move the namespace field in Module.symvers last
>
>Jian-Hong Pan (2):
>      ALSA: hda/realtek - Enable headset mic of Acer X2660G with ALC662
>      ALSA: hda/realtek - Enable the headset of Acer N50-600 with ALC662
>
>Joerg Roedel (1):
>      x86/mm: split vmalloc_sync_all()
>
>Johan Hovold (3):
>      staging: greybus: loopback_test: fix poll-mask build breakage
>      staging: greybus: loopback_test: fix potential path truncation
>      staging: greybus: loopback_test: fix potential path truncations
>
>J=C3=A9r=C3=B4me Pouiller (5):
>      staging: wfx: fix warning about freeing in-use mutex during
>device unregister
>      staging: wfx: fix lines ending with a comma instead of a semicolon
>      staging: wfx: make warning about pending frame less scary
>      staging: wfx: fix RCU usage in wfx_join_finalize()
>      staging: wfx: fix RCU usage between hif_join() and ieee80211_bss_get=
_ie()
>
>Kai-Heng Feng (2):
>      ALSA: hda/realtek: Fix pop noise on ALC225
>      USB: Disable LPM on WD19's Realtek Hub
>
>Kees Cook (1):
>      ARM: 8958/1: rename missed uaccess .fixup section
>
>Len Brown (5):
>      tools/power turbostat: Fix gcc build warnings
>      tools/power turbostat: Fix missing SYS_LPI counter on some Chromeboo=
ks
>      tools/power turbostat: Fix 32-bit capabilities warning
>      tools/power turbostat: Print cpuidle information
>      tools/power turbostat: update version
>
>Linus Torvalds (3):
>      mm: slub: be more careful about the double cmpxchg of freelist
>      locks: reinstate locks_delete_block optimization
>      Linux 5.6-rc7
>
>Mario Kleiner (2):
>      drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017
>      drm/amd/display: Fix pageflip event race condition for DCN.
>
>Masahiro Yamada (4):
>      kconfig: introduce m32-flag and m64-flag
>      int128: fix __uint128_t compiler test in Kconfig
>      kbuild: doc: fix references to other documents
>      mmc: sdhci-cadence: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN for UniPhier
>
>Matt Roper (1):
>      drm/i915: Handle all MCR ranges
>
>Michael Straube (1):
>      staging: rtl8188eu: Add device id for MERCUSYS MW150US v2
>
>Michal Hocko (1):
>      mm: do not allow MADV_PAGEOUT for CoW pages
>
>Micha=C5=82 Miros=C5=82aw (1):
>      mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
>
>Mikhail Petrov (1):
>      scripts/kallsyms: fix wrong kallsyms_relative_base
>
>Murphy Zhou (1):
>      CIFS: fiemap: do not return EINVAL if get nothing
>
>Nathan Chancellor (1):
>      kbuild: Disable -Wpointer-to-enum-cast
>
>Olivier Moysan (1):
>      iio: adc: stm32-dfsdm: fix sleep in atomic context
>
>Pavel Begunkov (1):
>      io_uring: NULL-deref for IOSQE_{ASYNC,DRAIN}
>
>Peter Chen (1):
>      usb: chipidea: udc: fix sleeping function called from invalid context
>
>Petr =C5=A0tetiar (1):
>      iio: chemical: sps30: fix missing triggered buffer dependency
>
>Prabhath Sajeepa (1):
>      nvme-rdma: Avoid double freeing of async event data
>
>Qian Cai (2):
>      page-flags: fix a crash at SetPageError(THP_SWAP)
>      mm/mmu_notifier: silence PROVE_RCU_LIST warnings
>
>Qiujun Huang (1):
>      drm/lease: fix WARNING in idr_destroy
>
>Ran Wang (1):
>      usb: host: xhci-plat: add a shutdown
>
>Ricky Wu (1):
>      mmc: rtsx_pci: Fix support for speed-modes that relies on tuning
>
>Roman Penyaev (1):
>      epoll: fix possible lost wakeup on epoll_ctl() path
>
>SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
>      kbuild: Fix inconsistent comment
>
>Sagi Grimberg (1):
>      nvmet-tcp: set MSG_MORE only if we actually have more to send
>
>Samuel Thibault (1):
>      staging/speakup: fix get_word non-space look-ahead
>
>Scott Chen (1):
>      USB: serial: pl2303: add device-id for HP LD381
>
>Shyam Prasad N (1):
>      CIFS: Increment num_remote_opens stats counter even in case of
>smb2_query_dir_first
>
>Srinivas Kandagatla (1):
>      slimbus: ngd: add v2.1.0 compatible
>
>Stanley.Yang (1):
>      drm/amd/display: fix typos for dcn20_funcs and dcn21_funcs struct
>
>Stephan Gerhold (1):
>      iio: magnetometer: ak8974: Fix negative raw values in sysfs
>
>Steven Rostedt (VMware) (1):
>      xhci: Do not open code __print_symbolic() in xhci trace events
>
>Takashi Iwai (7):
>      ALSA: pcm: oss: Avoid plugin buffer overflow
>      ALSA: line6: Fix endless MIDI read loop
>      HID: hid-picolcd_fb: Use scnprintf() for avoiding potential
>buffer overflow
>      HID: hid-sensor-custom: Use scnprintf() for avoiding potential
>buffer overflow
>      ALSA: pcm: oss: Remove WARNING from snd_pcm_plug_alloc() checks
>      ALSA: seq: virmidi: Fix running status after receiving sysex
>      ALSA: seq: oss: Fix running status after receiving sysex
>
>Tom St Denis (1):
>      drm/amd/amdgpu: Fix GPR read from debugfs (v2)
>
>Tomas Novotny (2):
>      iio: light: vcnl4000: update sampling periods for vcnl4200
>      iio: light: vcnl4000: update sampling periods for vcnl4040
>
>Tony Fischetti (1):
>      HID: add ALWAYS_POLL quirk to lenovo pixart mouse
>
>Vincenzo Frascino (1):
>      arm64: compat: Fix syscall number of compat_clock_getres
>
>Vlastimil Babka (1):
>      mm, slub: prevent kmalloc_node crashes and memory leaks
>
>Wen-chien Jesse Sung (1):
>      iio: st_sensors: remap SMO8840 to LIS2DH12
>
>Will Deacon (1):
>      arm64: kpti: Fix "kpti=3Doff" when KASLR is enabled
>
>Xiao Yang (1):
>      modpost: Get proper section index by get_secindex() instead of st_sh=
ndx
>
>YueHaibing (1):
>      iio: ping: set pa_laser_ping_cfg in of_ping_match

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl54TCgACgkQsjqdtxFL
KRVBdggAk+YGCvUv/Xa36X94ckDmSg3uOfKjgk+moT0hZfcHHVAnn97PLHD01jkz
qekRqZD4Femk2ergc/SlgRVFcjxT5kIv9NsTSD1PfkQG5n2NFZ5jhSv6OPap7zac
zCmr8I+MzR/AFwvfpd7QEh5bC6CyF9RAn4BhQOgmHWvQqdNqyxIs4nWf0QUNgvS3
kEkmNdam1+xI3Nrp8/e15rtRbXs0X9a2d671vwr28NKzMSfTsk43BkgYFMlm06Dc
RMUjiV7Fe964Xx0D3mbip1EPsDC98IMKaJCyOxcMmZb8UHfi1/Axr93V9Hj7+wOr
DeXvD74KGqHpCDjeinjX37EwT8H23Q==
=0Rxl
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
