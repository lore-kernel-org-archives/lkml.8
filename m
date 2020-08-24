Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C11C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22FC20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="px+SxYSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHXAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:46:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 17:46:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r4so3405730pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3Sn4luWN59E9l5sOcuG07vrRx+axfClEulrGX5OQB0=;
        b=px+SxYSilBr1BcgBPFFfFO6WPZk8LPiRX7C/iuEVZuW0v5WPUEAbyGLi1tal1R4qBx
         CLDTkr2crfwPIyGr8Y14ov8oRwz/krGEN7k6vEuXSNjijJT1qkTZ+RoOfSbsl8Nl5zXq
         cjPUA/QAVTgb26ukRLgPic6phlXh6k6x1CgwgkqtXeWrhFbBboGHdifdpm1cikftLqIA
         u88cdcpYzhsli4EXNSCDXLrdxslAh6rH9qQ7n7zgAL5PwWvwYov6ALdjPCyAKF3TuYEq
         ulJpgrQzxwa8vUXgM6BarI9Jbf/r0gKeftOwZ9tWm/SIeViF05nSZz6GRMM+mTmWaX3o
         F3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=e3Sn4luWN59E9l5sOcuG07vrRx+axfClEulrGX5OQB0=;
        b=o8+PivZYOfLAGDDC/ZL9xB1Pyx8DewgwKLc+I+xAYvyq6sTzKfKj8vDsuFSn7+S+bo
         GuhcXbjwHGe8HO15D3KIWvoF97hZensQU7Ku5IWCU9Mu5rQfI/qrYDJFZCFWeHTCQx7v
         bUIDCz1IZpjbNqG5qbT7F5Z486y8JtwtEs/P8zrNfwfhbSd/Ds2P2329Rk6kU4SrnVPz
         G/pPEaSUIqRw3U4Ee7MyRv2LFQOipDrneSvR9v2E8FcLPx0Y11APN3EScM+zPhm8nyzK
         u7D+LbdcOHwAsTcJQSvZNuTWsEwJ1/oBZDRe986asNWaU2koRJe/b3lGGkzjfxXj/7wt
         R8FQ==
X-Gm-Message-State: AOAM532h4IyuMwQy5vtl0Wkermoh/mDjukW/gNKIUBffrJaX8sxrlsDs
        ov3zZWkss5ik0B3nlnTEdaw=
X-Google-Smtp-Source: ABdhPJzSCWhg2LiQ6IXjAtBmQWsrMRqYgkQbGnR4uzPldqiGNSpSgWfYg4TovwDmRnAcs3N/hgsV6w==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr2149669ply.197.1598230013736;
        Sun, 23 Aug 2020 17:46:53 -0700 (PDT)
Received: from Gentoo (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id o2sm2861119pjh.4.2020.08.23.17.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 17:46:52 -0700 (PDT)
Date:   Mon, 24 Aug 2020 06:16:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ..and it built & boot without fuss!!Linux 5.9-rc2
Message-ID: <20200824004642.GA5105@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiy7qFBRVibt+kHoceCwsiPeMRZXDajq1oCsk+AUOU4cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiy7qFBRVibt+kHoceCwsiPeMRZXDajq1oCsk+AUOU4cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:23 Sun 23 Aug 2020, Linus Torvalds wrote:
>It's Sunday afternoon, which means it's time for another release candidate.
>
>Nothing in particular stands out, there's a random collection of fixes
>and updates in here. It is perhaps a bit filesystem-heavy, because the
>ext4 updates came in late, so a bit unusually we have 20+% of the
>patch being under fs/, and that's the biggest chunk in here after the
>usual driver updates (sound, gpu, networking, scsi, vfio).
>
>Other than that, it's mostly arch fixes and some tooling fixes, with a
>smattering elsewhere.
>
>The appended shortlog gives an overview of the details, it's all
>pretty small stuff. The diffstat shows the ext4 changes and a RISC-V
>timer chip standing out, and even those aren't really particularly
>big.
>
>Please test,
>                   Linus
>

>-

Something for your eyes!! :)



[    3.197593] EXT4-fs (sda): mounted filesystem with ordered data mode. Op=
ts: (null)
[    3.199024] ext4 filesystem being mounted at /root supports timestamps u=
ntil 2038 (0x7fffffff)
[    3.199604] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.205407] devtmpfs: mounted
[    3.218549] Freeing unused decrypted memory: 2040K
[    3.278265] Freeing unused kernel image (initmem) memory: 1608K
[    3.278973] Write protecting the kernel read-only data: 26624k
[    3.282717] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    3.284312] Freeing unused kernel image (rodata/data gap) memory: 904K
[    3.285022] rodata_test: all tests were successful
[    3.285559] Run /sbin/init as init process
[    3.410069] tsc: Refined TSC clocksource calibration: 2194.918 MHz
[    3.410533] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa=
37202099, max_idle_ns: 440795206796 ns
[    3.411227] clocksource: Switched to clocksource tsc
[    3.467617] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.468312] ext4 filesystem being remounted at / supports timestamps unt=
il 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator: OK
Saving random seed: [    4.576470] random: dd: uninitialized urandom read (=
512 bytes read)
OK
Starting network: [    4.659892] random: crng init done
OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.9.0-rc2-Gentoo #1 SMP Mon Aug 24 04:28:02 IST=
 2020 x86_64 GNU/Linux


~Bhaskar



>
>Adrian Hunter (3):
>      scsi: ufs-pci: Add quirk for broken auto-hibernate for Intel EHL
>      scsi: ufs: Fix interrupt error message for shared interrupts
>      scsi: ufs: Improve interrupt handling for shared interrupts
>
>Al Viro (1):
>      do_epoll_ctl(): clean the failure exits up a bit
>
>Alaa Hleihel (1):
>      net/sched: act_ct: Fix skb double-free in
>tcf_ct_handle_fragments() error flow
>
>Alain Volmat (1):
>      spi: stm32: always perform registers configuration prior to transfer
>
>Alex Williamson (2):
>      vfio-pci: Avoid recursive read-lock usage
>      vfio/type1: Add proper error unwind for vfio_iommu_replay()
>
>Alex Zhuravlev (2):
>      ext4: add prefetching for block allocation bitmaps
>      ext4: skip non-loaded groups at cr=3D0/1 when scanning for good grou=
ps
>
>Alexander A. Klimov (1):
>      ext4: replace HTTP links with HTTPS ones
>
>Alexander Tsoy (1):
>      ALSA: usb-audio: Add capture support for Saffire 6 (USB 1.1)
>
>Alvin =C5=A0ipraga (1):
>      macvlan: validate setting of multiple remote source MAC addresses
>
>Amelie Delaunay (3):
>      spi: stm32: fix fifo threshold level in case of short transfer
>      spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
>      spi: stm32: fixes suspend/resume management
>
>Andrew Lunn (1):
>      net: devlink: Remove overzealous WARN_ON with snapshots
>
>Andrii Nakryiko (13):
>      bpf: Fix XDP FD-based attach/detach logic around
>XDP_FLAGS_UPDATE_IF_NOEXIST
>      tools/bpftool: Make skeleton code C++17-friendly by dropping typeof()
>      tools/bpftool: Fix compilation warnings in 32-bit mode
>      selftest/bpf: Fix compilation warnings in 32-bit mode
>      libbpf: Fix BTF-defined map-in-map initialization on 32-bit host arc=
hes
>      libbpf: Handle BTF pointer sizes more carefully
>      selftests/bpf: Fix btf_dump test cases on 32-bit arches
>      libbpf: Enforce 64-bitness of BTF for BPF object files
>      selftests/bpf: Correct various core_reloc 64-bit assumptions
>      tools/bpftool: Generate data section struct with conservative alignm=
ent
>      selftests/bpf: Make test_varlen work with 32-bit user-space arch
>      libbpf: Fix build on ppc64le architecture
>      bpf: xdp: Fix XDP mode when no mode flags specified
>
>Aneesh Kumar K.V (2):
>      powerpc/pkeys: Fix build error with PPC_MEM_KEYS disabled
>      mm/vunmap: add cond_resched() in vunmap_pmd_range
>
>Anju T Sudhakar (1):
>      powerpc/perf: Add support for outputting extended regs in perf intr_=
regs
>
>Anthony Koo (2):
>      drm/amd/display: Fix LFC multiplier changing erratically
>      drm/amd/display: Switch to immediate mode for updating infopackets
>
>Antonio Borneo (1):
>      spi: stm32h7: fix race condition at end of transfer
>
>Anup Patel (4):
>      RISC-V: Add mechanism to provide custom IPI operations
>      clocksource/drivers: Add CLINT timer driver
>      RISC-V: Remove CLINT related code from timer and arch
>      dt-bindings: timer: Add CLINT bindings
>
>Ard Biesheuvel (2):
>      efi/x86: Move 32-bit code into efi_32.c
>      Documentation: efi: remove description of efi=3Dold_map
>
>Aric Cyr (1):
>      drm/amd/display: Fix incorrect backlight register offset for DCN
>
>Arun Easi (2):
>      scsi: qla2xxx: Allow ql2xextended_error_logging special value 1
>to be set anytime
>      scsi: qla2xxx: Fix WARN_ON in qla_nvme_register_hba
>
>Arvind Sankar (6):
>      x86/boot/compressed: Use builtin mem functions for decompressor
>      lib/string.c: Use freestanding environment
>      efi/x86: Mark kernel rodata non-executable for mixed mode
>      efi/libstub: Stop parsing arguments at "--"
>      efi/libstub: Handle NULL cmdline
>      efi/libstub: Handle unterminated cmdline
>
>Athira Rajeev (2):
>      powerpc/perf: Add extended regs support for power10 platform
>      powerpc/perf: Fix soft lockups due to missed interrupt accounting
>
>Bean Huo (1):
>      scsi: ufs: No need to send Abort Task if the task in DB was cleared
>
>Bhawanpreet Lakha (1):
>      drm/amdgpu: parse ta firmware for navy_flounder
>
>Bin Meng (1):
>      riscv: Add SiFive drivers to rv32_defconfig
>
>Charan Teja Reddy (1):
>      mm, page_alloc: fix core hung in free_pcppages_bulk()
>
>Chris Park (3):
>      drm/amd/display: Call DMUB for eDP power control
>      drm/amd/display: Assign correct left shift
>      drm/amd/display: Reset scrambling on Test Pattern
>
>Chris Wilson (3):
>      drm/i915: Provide the perf pmu.module
>      drm/i915: Copy default modparams to mock i915_device
>      drm/i915/display: Check for an LPSP encoder before dereferencing
>
>Christoph Hellwig (2):
>      dma-pool: fix coherent pool allocations for IOMMU mappings
>      PCI/P2PDMA: Fix build without DMA ops
>
>Christophe JAILLET (1):
>      drm: amdgpu: Use the correct size when allocating memory
>
>Christophe Leroy (4):
>      powerpc/fixmap: Fix the size of the early debug area
>      powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
>      powerpc/32s: Fix is_module_segment() when MODULES_VADDR is defined
>      powerpc/32s: Fix module loading failure when VMALLOC_END is over
>0xf0000000
>
>Colin Ian King (6):
>      of/address: check for invalid range.cpu_addr
>      RDMA/hns: Fix spelling mistake "epmty" -> "empty"
>      RDMA/usnic: Fix spelling mistake "transistion" -> "transition"
>      net: mscc: ocelot: remove duplicate "the the" phrase in Kconfig text
>      net: ipv4: remove duplicate "the the" phrase in Kconfig text
>      RDMA/core: Fix spelling mistake "Could't" -> "Couldn't"
>
>Colin Xu (2):
>      drm/i915/gvt: Do not destroy ppgtt_mm during vGPU D3->D0.
>      drm/i915/gvt: Do not reset pv_notified when vGPU transit from D3->D0
>
>Cong Wang (2):
>      bonding: fix a potential double-unregister
>      tipc: fix uninit skb->data in tipc_nl_compat_dumpit()
>
>Daniel Kolesa (1):
>      drm/amdgpu/display: use GFP_ATOMIC in dcn20_validate_bandwidth_inter=
nal
>
>David Ahern (1):
>      selftests: disable rp_filter for icmp_redirect.sh
>
>David Howells (3):
>      watch_queue: Limit the number of watches a user can hold
>      afs: Fix key ref leak in afs_put_operation()
>      afs: Fix NULL deref in afs_dynroot_depopulate()
>
>David Laight (1):
>      net: sctp: Fix negotiation of the number of data streams.
>
>David S. Miller (1):
>      Revert "net: xdp: pull ethernet header off packet after
>computing skb->protocol"
>
>Dinghao Liu (1):
>      ASoC: intel: Fix memleak in sst_media_open
>
>Dio Putra (1):
>      ext4: fix coding style in file.c
>
>Dmitry Monakhov (1):
>      ext4: export msg_count and warning_count via sysfs
>
>Dmytro Laktyushkin (1):
>      drm/amd/display: fix dcn3 wide timing dsc validation
>
>Doug Berger (1):
>      mm: include CMA pages in lowmem_reserve at boot
>
>Douglas Gilbert (1):
>      scsi: scsi_debug: Fix scp is NULL errors
>
>Edward Cree (6):
>      sfc: check hash is valid before using it
>      sfc: really check hash is valid before using it
>      sfc: take correct lock in ef100_reset()
>      sfc: null out channel->rps_flow_id after freeing it
>      sfc: don't free_irq()s if they were never requested
>      sfc: fix build warnings on 32-bit
>
>Enzo Matsumiya (1):
>      scsi: qla2xxx: Use MBX_TOV_SECONDS for mailbox command timeout values
>
>Eric Biggers (2):
>      ext4: don't hardcode bit values in EXT4_FL_USER_*
>      ext4: use generic names for generic ioctls
>
>Eric Dumazet (1):
>      can: j1939: fix kernel-infoleak in j1939_sk_sock2sockaddr_can()
>
>Eric Sandeen (1):
>      ext4: fix potential negative array index in do_split()
>
>Evan Quan (2):
>      drm/amd/powerplay: correct Vega20 cached smu feature state
>      drm/amd/powerplay: correct UVD/VCE PG state on custom pptable upload=
ing
>
>Fabian Frederick (3):
>      selftests: netfilter: add checktool function
>      selftests: netfilter: add MTU arguments to flowtables
>      selftests: netfilter: kill running process only
>
>Fabio Estevam (2):
>      ASoC: wm8962: Do not remove ADDITIONAL_CONTROL_4 from readable
>register list
>      dt-bindings: Use Shawn Guo's preferred e-mail for i.MX bindings
>
>Florian Westphal (6):
>      netfilter: nft_compat: remove flush counter optimization
>      netfilter: avoid ipv6 -> nf_defrag_ipv6 module dependency
>      netfilter: nf_tables: free chain context when BINDING flag is missing
>      netfilter: ebtables: reject bogus getopt len value
>      mptcp: sendmsg: reset iter on error
>      mptcp: sendmsg: reset iter on error redux
>
>Frederic Barrat (1):
>      powerpc/powernv/pci: Fix possible crash when releasing DMA resources
>
>Fugang Duan (1):
>      net: fec: correct the error path for regulator disable in probe
>
>Ganji Aravind (2):
>      cxgb4: Fix work request size calculation for loopback test
>      cxgb4: Fix race between loopback and normal Tx path
>
>Geert Uytterhoeven (4):
>      dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs=
1-sel
>      dt: writing-schema: Miscellaneous grammar fixes
>      dt-bindings: net: renesas, ether: Improve schema validation
>      dt-bindings: vendor-prefixes: Remove trailing whitespace
>
>George Spelvin (1):
>      drm/i915/selftests: Avoid passing a random 0 into ilog2
>
>Grzegorz Szczurek (1):
>      i40e: Fix crash during removing i40e driver
>
>Guchun Chen (1):
>      drm/amdgpu: fix NULL pointer access issue when unloading driver
>
>Haiyang Zhang (2):
>      hv_netvsc: Remove "unlikely" from netvsc_select_queue
>      hv_netvsc: Fix the queue_mapping in netvsc_vf_xmit()
>
>Hector Martin (1):
>      ALSA: usb-audio: Update documentation comment for MS2109 quirk
>
>Heiko Carstens (2):
>      s390/runtime_instrumentation: fix storage key handling
>      s390/ptrace: fix storage key handling
>
>Huang Rui (1):
>      drm/amdkfd: fix the wrong sdma instance query for renoir
>
>Hugh Dickins (2):
>      khugepaged: adjust VM_BUG_ON_MM() in __khugepaged_enter()
>      uprobes: __replace_page() avoid BUG in munlock_vma_page()
>
>Hui Wang (1):
>      ASoC: amd: renoir: restore two more registers during resume
>
>Imre Deak (1):
>      drm/i915/tgl: Make sure TC-cold is blocked before enabling TC
>AUX power wells
>
>Jaehyun Chung (1):
>      drm/amd/display: Blank stream before destroying HDCP session
>
>Jan Kara (9):
>      ext4: do not block RWF_NOWAIT dio write on unallocated space
>      ext4: don't BUG on inconsistent journal feature
>      ext4: handle error of ext4_setup_system_zone() on remount
>      ext4: don't allow overlapping system zones
>      ext4: check journal inode extents more carefully
>      ext4: fold ext4_data_block_valid_rcu() into the caller
>      ext4: handle add_system_zone() failure in ext4_setup_system_zone()
>      ext4: correctly restore system zone info when remount fails
>      ext4: fix checking of directory entry validity for inline directories
>
>Jann Horn (1):
>      romfs: fix uninitialized memory leak in romfs_dev_read()
>
>Jarod Wilson (1):
>      bonding: show saner speed for broadcast mode
>
>Jason A. Donenfeld (1):
>      net: xdp: pull ethernet header off packet after computing skb->proto=
col
>
>Jean-Philippe Brucker (1):
>      libbpf: Handle GCC built-in types for Arm NEON
>
>Jens Axboe (4):
>      io_uring: find and cancel head link async work on files exit
>      io_uring: get rid of kiocb_wait_page_queue_init()
>      io_uring: cleanup io_import_iovec() of pre-mapped request
>      io_uring: use system_unbound_wq for ring exit work
>
>Jessica Clarke (1):
>      arch/ia64: Restore arch-specific pgd_offset_k implementation
>
>Jianlin Lv (1):
>      selftests/bpf: Fix segmentation fault in test_progs
>
>Jiansong Chen (2):
>      drm/amdgpu: disable gfxoff for navy_flounder
>      Revert "drm/amdgpu: disable gfxoff for navy_flounder"
>
>Jim Mattson (2):
>      kvm: x86: Toggling CR4.SMAP does not load PDPTEs in PAE mode
>      kvm: x86: Toggling CR4.PKE does not load PDPTEs in PAE mode
>
>Jing Xiangfeng (1):
>      scsi: ufs: ti-j721e-ufs: Fix error return in ti_j721e_ufs_probe()
>
>Jiri Olsa (2):
>      bpf: Iterate through all PT_NOTE sections when looking for build id
>      tools/resolve_btfids: Fix sections with wrong alignment
>
>Jiri Wiesner (1):
>      bonding: fix active-backup failover for current ARP slave
>
>Joe Perches (2):
>      Makefile.extrawarn: Move sign-compare from W=3D2 to W=3D3
>      genksyms: keywords: Use __restrict not _restrict
>
>Joe Stringer (1):
>      doc: Add link to bpf helpers man page
>
>Johannes Berg (1):
>      netlink: fix state reallocation in policy export
>
>John Fastabend (5):
>      bpf: sock_ops ctx access may stomp registers in corner case
>      bpf: sock_ops sk access may stomp registers when dst_reg =3D src_reg
>      bpf, selftests: Add tests for ctx access in sock_ops with single reg=
ister
>      bpf, selftests: Add tests for sock_ops load with r9, r8.r7 registers
>      bpf, selftests: Add tests to sock_ops for loading sk
>
>Juergen Gross (1):
>      efi: avoid error message when booting under Xen
>
>Kaige Li (1):
>      net: phy: mscc: Fix a couple of spelling mistakes "spcified" ->
>"specified"
>
>Kaike Wan (1):
>      RDMA/hfi1: Correct an interlock issue for TID RDMA WRITE request
>
>Kajol Jain (1):
>      powerpc/perf/hv-24x7: Move cpumask file to top folder of hv-24x7 dri=
ver
>
>Kees Cook (2):
>      mailmap: Restore dictionary sorting
>      mailmap: Add WeiXiong Liao
>
>Kevin Wang (1):
>      drm/amdgpu: fix uninit-value in arcturus_log_thermal_throttling_even=
t()
>
>Keyur Patel (1):
>      ext4: fix spelling mistakes in extents.c
>
>Krunoslav Kovac (1):
>      drm/amd/display: fix pow() crashing when given base 0
>
>Kyoungho Koo (1):
>      ext4: remove unused parameter of ext4_generic_delete_entry function
>
>Lee Jones (12):
>      net: bonding: bond_3ad: Fix a bunch of kerneldoc parameter issues
>      net: bonding: bond_main: Document 'proto' and rename
>'new_active' parameters
>      net: ethernet: 3com: 3c574_cs: Remove set but unused variables
>'tx' and 'rx'
>      net: bonding: bond_alb: Describe
>alb_handle_addr_collision_on_attach()'s 'bond' and 'addr' params
>      net: ethernet: 8390: axnet_cs: Document unused parameter 'txqueue'
>      net: wan: dlci: Remove set but not used variable 'err'
>      net: fddi: skfp: hwmtm: Remove seemingly unused variable 'ID_sccs'
>      net: fddi: skfp: fplustm: Remove seemingly unused variable 'ID_sccs'
>      net: fddi: skfp: smt: Place definition of 'smt_pdef' under same
>stipulations as its use
>      net: fddi: skfp: smt: Remove seemingly unused variable 'ID_sccs'
>      net: fddi: skfp: cfm: Remove set but unused variable 'oldstate'
>      net: fddi: skfp: cfm: Remove seemingly unused variable 'ID_sccs'
>
>Leon Romanovsky (2):
>      MAINTAINERS: Update Mellanox and Cumulus Network addresses to new do=
main
>      mm/rodata_test.c: fix missing function declaration
>
>Li Heng (1):
>      efi: add missed destroy_workqueue when efisubsys_init fails
>
>Liang Wang (1):
>      ALSA: isa: fix spelling mistakes in the comments
>
>Linus Torvalds (1):
>      Linux 5.9-rc2
>
>Liu ChengZhe (1):
>      drm/amdgpu: Skip some registers config for SRIOV
>
>Lukas Czerner (3):
>      jbd2: make sure jh have b_transaction set in refile/unfile_buffer
>      ext4: handle read only external journal device
>      ext4: handle option set by mount flags correctly
>
>Lukas Wunner (1):
>      spi: Prevent adding devices below an unregistering controller
>
>Madalin Bucur (1):
>      dt-bindings: net: correct description of phy-connection-type
>
>Madhavan Srinivasan (2):
>      powerpc: Add POWER10 raw mode cputable entry
>      powerpc/kernel: Cleanup machine check function declarations
>
>Mahesh Bandewar (1):
>      ipvlan: fix device features
>
>Marc Zyngier (4):
>      of: address: Work around missing device_type property in pcie nodes
>      arm64: Move handling of erratum 1418040 into C code
>      arm64: Allow booting of late CPUs affected by erratum 1418040
>      epoll: Keep a reference on files added to the check list
>
>Mark Tomlinson (1):
>      gre6: Fix reception with IP6_TNL_F_RCV_DSCP_COPY
>
>Markus Elfring (1):
>      ext4: delete unnecessary checks before brelse()
>
>Masahiro Yamada (8):
>      extract-cert: add static to local data
>      kbuild: remove redundant patterns in filter/filter-out
>      kconfig: qconf: fix signal connection to invalid slots
>      kconfig: qconf: fix the popup menu in the ConfigInfoView window
>      kconfig: qconf: remove unused colNr
>      kconfig: qconf: remove qInfo() to get back Qt4 support
>      kconfig: qconf: remove redundant help in the info view
>      kconfig: qconf: replace deprecated QString::sprintf() with QTextStre=
am
>
>Matt Roper (1):
>      drm/i915: Update bw_buddy pagemask table
>
>Maxim Mikityanskiy (3):
>      ethtool: Fix preserving of wanted feature bits in netlink interface
>      ethtool: Account for hw_features in netlink interface
>      ethtool: Don't omit the netlink reply if no features were changed
>
>Miaohe Lin (2):
>      net: Fix potential wrong skb->protocol in skb_vlan_untag()
>      net: handle the return value of pskb_carve_frag_list() correctly
>
>Michael Neuling (1):
>      powerpc: Fix P10 PVR revision in /proc/cpuinfo for SMT4 cores
>
>Michael Roth (1):
>      powerpc/pseries/hotplug-cpu: wait indefinitely for vCPU death
>
>Mike Christie (1):
>      scsi: fcoe: Fix I/O path allocation
>
>Mike Pozulp (3):
>      ALSA: hda/realtek: Add quirk for Samsung Galaxy Flex Book
>      ALSA: hda/realtek: Add model alc298-samsung-headphone
>      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
>
>Min Li (1):
>      ptp: ptp_clockmatrix: use i2c_master_send for i2c write
>
>Necip Fazil Yildiran (1):
>      net: qrtr: fix usage of idr in port assignment to socket
>
>Nick Desaulniers (1):
>      mailmap: add Andi Kleen
>
>Nicolas Saenz Julienne (1):
>      dma-pool: Only allocate from CMA when in same memory zone
>
>Niklas Schnelle (4):
>      s390/pci: ignore stale configuration request event
>      s390/pci: fix zpci_bus_link_virtfn()
>      s390/pci: re-introduce zpci_remove_device()
>      s390/pci: fix PF/VF linking on hot plug
>
>Nikolay Aleksandrov (1):
>      net: nexthop: don't allow empty NHA_GROUP
>
>Nivedita Singhvi (1):
>      docs: networking: bonding.rst resources section cleanup
>
>Oleksij Rempel (5):
>      can: j1939: transport: j1939_simple_recv(): ignore local J1939
>messages send not by J1939 stack
>      can: j1939: transport: j1939_session_tx_dat(): fix
>use-after-free read in j1939_tp_txtimer()
>      can: j1939: socket: j1939_sk_bind(): make sure ml_priv is allocated
>      can: j1939: transport: add j1939_session_skb_find_by_offset() functi=
on
>      can: j1939: transport: j1939_xtp_rx_dat_one(): compare own
>packets to detect corruptions
>
>Paolo Bonzini (1):
>      KVM: x86: fix access code passed to gva_to_gpa
>
>Paul Hsieh (1):
>      drm/amd/display: Fix DFPstate hang due to view port changed
>
>Pavel Begunkov (3):
>      io_uring: fix racy req->flags modification
>      io_uring: comment on kfree(iovec) checks
>      io_uring: kill extra iovec=3DNULL in import_iovec()
>
>Peilin Ye (1):
>      net/smc: Prevent kernel-infoleak in __smc_diag_dump()
>
>Phillip Lougher (1):
>      squashfs: avoid bio_alloc() failure with 1Mbyte blocks
>
>Przemyslaw Patynowski (1):
>      i40e: Set RX_ONLY mode for unicast promiscuous on VLAN
>
>Qi Liu (1):
>      drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioc=
tl()
>
>Quinn Tran (7):
>      scsi: qla2xxx: Flush all sessions on zone disable
>      scsi: qla2xxx: Flush I/O on zone disable
>      scsi: qla2xxx: Indicate correct supported speeds for Mezz card
>      scsi: qla2xxx: Fix login timeout
>      scsi: qla2xxx: Reduce noisy debug message
>      scsi: qla2xxx: Fix null pointer access during disconnect from subsys=
tem
>      Revert "scsi: qla2xxx: Disable T10-DIF feature with FC-NVMe during p=
robe"
>
>Rajendra Nayak (1):
>      opp: Enable resources again if they were disabled earlier
>
>Randy Dunlap (2):
>      phylink: <linux/phylink.h>: fix function prototype kernel-doc warning
>      Fix build error when CONFIG_ACPI is not set/enabled:
>
>Ravulapati Vishnu vardhan rao (1):
>      ASoC: amd: Replacing component->name with codec_dai->name.
>
>Rob Herring (2):
>      KVM: arm64: Print warning when cpu erratum can cause guests to deadl=
ock
>      dt-bindings: PCI: intel,lgm-pcie: Fix matching on all
>snps,dw-pcie instances
>
>Sameer Pujar (1):
>      ALSA: hda: avoid reset of sdo_limit
>
>Saurav Kashyap (2):
>      scsi: qla2xxx: Check if FW supports MQ before enabling
>      Revert "scsi: qla2xxx: Fix crash on qla2x00_mailbox_command"
>
>Sean Christopherson (1):
>      x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM
>
>Sebastian Andrzej Siewior (1):
>      net: atlantic: Use readx_poll_timeout() for large timeout
>
>Selvin Xavier (1):
>      RDMA/bnxt_re: Do not add user qps to flushlist
>
>Shay Agroskin (3):
>      net: ena: Prevent reset after device destruction
>      net: ena: Change WARN_ON expression in ena_del_napi_in_range()
>      net: ena: Make missed_tx stat incremental
>
>Shengjiu Wang (1):
>      ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level function
>
>Shijie Luo (3):
>      ext4: remove some redundant function declarations
>      ext4: change to use fallthrough macro
>      jbd2: clean up checksum verification in do_one_pass()
>
>Srinivas Kandagatla (3):
>      ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
>      ASoC: q6routing: add dummy register read/write function
>      ASoC: msm8916-wcd-analog: fix register Interrupt offset
>
>Stanislav Fomichev (1):
>      selftests/bpf: Fix v4_to_v6 in sk_lookup
>
>Stanley Chu (3):
>      scsi: ufs: Fix possible infinite loop in ufshcd_hold
>      scsi: ufs-mediatek: Fix incorrect time to wait link status
>      scsi: ufs: Clean up completed request without interrupt notification
>
>Steffen Maier (1):
>      scsi: zfcp: Fix use-after-free in request timeout handlers
>
>Stephen Boyd (3):
>      opp: Put opp table in dev_pm_opp_set_rate() for empty tables
>      opp: Put opp table in dev_pm_opp_set_rate() if _set_opp_bw() fails
>      ARM64: vdso32: Install vdso32 from vdso_install
>
>Stephen Suryaputra (1):
>      netfilter: nf_tables: nft_exthdr: the presence return value
>should be little-endian
>
>Stylon Wang (1):
>      drm/amd/display: Fix EDID parsing after resume from suspend
>
>Sumera Priyadarsini (1):
>      net: gianfar: Add of_node_put() before goto statement
>
>Sylwester Nawrocki (2):
>      ASoC: wm8994: Prevent access to invalid VU register bits on WM1811
>      ASoC: wm8994: Avoid attempts to read unreadable registers
>
>Takashi Iwai (7):
>      ASoC: tegra: tegra186_dspk: Fix compile warning with CONFIG_PM=3Dn
>      ASoC: tegra: tegra210_admaif: Fix compile warning with CONFIG_PM=3Dn
>      ASoC: tegra: tegra210_ahub: Fix compile warning with CONFIG_PM=3Dn
>      ASoC: tegra: tegra210_dmic: Fix compile warning with CONFIG_PM=3Dn
>      ASoC: tegra: tegra210_i2s: Fix compile warning with CONFIG_PM=3Dn
>      ASoC: fsl: Fix unused variable warning
>      ASoC: Make soc_component_read() returning an error code again
>
>Theodore Ts'o (2):
>      ext4: indicate via a block bitmap read is prefetched via a tracepoint
>      ext4: add prefetch_block_bitmaps mount option
>
>Thomas Gleixner (1):
>      core/entry: Respect syscall number rewrites
>
>Tianjia Zhang (1):
>      drm/i915: Fix wrong return value in intel_atomic_check()
>
>Tobias Klauser (1):
>      bpf: Fix two typos in uapi/linux/bpf.h
>
>Tobias Schramm (1):
>      spi: stm32: clear only asserted irq flags on interrupt
>
>Toke H=C3=B8iland-J=C3=B8rgensen (2):
>      libbpf: Prevent overriding errno when logging errors
>      libbpf: Fix map index used in error message
>
>Tom Rix (1):
>      net: dsa: b53: check for timeout
>
>Tom Yan (1):
>      ALSA: usb-audio: ignore broken processing/extension unit
>
>Tony Luck (1):
>      EDAC/{i7core,sb,pnd2,skx}: Fix error event severity
>
>Vaibhav Shankar (1):
>      perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown
>
>Vasant Hegde (1):
>      powerpc/pseries: Do not initiate shutdown when system is running on =
UPS
>
>Veronika Kabatova (1):
>      selftests/bpf: Remove test_align leftovers
>
>Vineeth Vijayan (1):
>      s390/cio: add cond_resched() in the slow_eval_known_fn() loop
>
>Vinicius Costa Gomes (1):
>      igc: Fix PTP initialization
>
>Wang Hai (1):
>      net: gemini: Fix missing free_netdev() in error path of
>gemini_ethernet_port_probe()
>
>Wei Yongjun (1):
>      kernel/relay.c: fix memleak on destroy relay channel
>
>Weihang Li (1):
>      Revert "RDMA/hns: Reserve one sge in order to avoid local length err=
or"
>
>Will Deacon (2):
>      KVM: Pass MMU notifier range flags to kvm_unmap_hva_range()
>      KVM: arm64: Only reschedule if MMU_NOTIFIER_RANGE_BLOCKABLE is not s=
et
>
>Xianting Tian (2):
>      jbd2: fix incorrect code style
>      fs: prevent BUG_ON in submit_bh_wbc()
>
>Xie He (1):
>      drivers/net/wan/hdlc_x25: Added needed_headroom and a skb->len check
>
>Xin He (1):
>      drm/virtio: fix memory leak in virtio_gpu_cleanup_object()
>
>Xin Long (3):
>      tipc: not enable tipc when ipv6 works as a module
>      ipv6: some fixes for ipv6_dev_find()
>      tipc: call rcu_read_lock() in tipc_aead_encrypt_done()
>
>Xu Wang (3):
>      otx2_common: Use devm_kcalloc() in otx2_config_npa()
>      mballoc: replace seq_printf with seq_puts
>      hugetlb_cgroup: convert comma to semicolon
>
>Yang Shi (1):
>      mm/memory.c: skip spurious TLB flush for retried page fault
>
>Yang Weijiang (1):
>      selftests: kvm: Use a shorter encoding to clear RAX
>
>Yauheni Kaliuta (1):
>      bpf: selftests: global_funcs: Check err_str before strstr
>
>Yi Zhuang (1):
>      ext4: lost matching-pair of trace in ext4_unlink
>
>Yonghong Song (5):
>      libbpf: Do not use __builtin_offsetof for offsetof
>      bpf: Use get_file_rcu() instead of get_file() for task_file iterator
>      bpf: Fix a rcu_sched stall issue with bpf task/task_file iterator
>      bpf: Avoid visit same object multiple times
>      bpftool: Handle EAGAIN error code properly in pids collection
>
>Zhang Changzhong (4):
>      can: j1939: fix support for multipacket broadcast message
>      can: j1939: cancel rxtimer on multipacket broadcast session complete
>      can: j1939: abort multipacket broadcast session when timeout occurs
>      can: j1939: add rxtimer for multipacket broadcast session
>
>brookxu (8):
>      ext4: fix spelling typos in ext4_mb_initialize_context
>      ext4: delete the invalid BUGON in ext4_mb_load_buddy_gfp()
>      ext4: fix typos in ext4_mb_regular_allocator() comment
>      ext4: delete invalid comments near ext4_mb_check_limits()
>      ext4: optimize the implementation of ext4_mb_good_group()
>      ext4: add mb_debug logging when there are lost chunks
>      ext4: reorganize if statement of ext4_mb_release_context()
>      ext4: limit the length of per-inode prealloc list
>
>kyoungho koo (1):
>      ext4: Fix comment typo "the the".
>
>shiwu.zhang (1):
>      drm/amdgpu: update gc golden register for arcturus
>
>zhangyi (F) (4):
>      jbd2: add the missing unlock_buffer() in the error path of
>jbd2_write_superblock()
>      ext4: abort the filesystem if failed to async write metadata buffer
>      jbd2: abort journal if free a async write error metadata buffer
>      jbd2: remove unused parameter in jbd2_journal_try_to_free_buffers()
>
>zhengliang (1):
>      ext4: lost matching-pair of trace in ext4_truncate

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9DDe8ACgkQsjqdtxFL
KRX/CQf/UQ6Z59COJJ+ly5aNVi9TFCTqtCLL7O8m3MdggsHJAQwMhrVwi8oiUXYB
VMzu+dPA0RCDm57aTZ6KkPEDLbwJ9DTu+qpqYzV5q2/9ElbMOGNObg/iPBKl3i+c
Mo1rkMBXsPFVuwl5aEIGAUzRE5lATQI4JRPKalqBT/pXGtAhVnNHr/s8geHVopP5
sfm//Ox7uGX1ZewROMAHFQ0W7e+7FKzeLSn3kEb1TMeGGlG+eGw7MRaiTaAPGB4w
1idK4PuLdXOzQXxZYN7UxjbwAoyaqOfZc05/15CiDjzYkR9RjfoFmXxd13/M8/iQ
DtgNdozrFcyTFrg27liiv8qkqiUPbw==
=0J0S
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
