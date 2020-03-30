Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60F7206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGC9yrxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgC3EVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:21:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgC3EVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:21:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so6216944ply.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f67+bjtYeCtUqo/uAXE3fpyvxao1QzlDS2a4xq8I5P8=;
        b=eGC9yrxkW1EBJ9XjnO/2Qx379c1EZ8KbP+CL/4kAAoj5LQqGksbB271MOlvpN+S1Vr
         m1j8uinIkOzFXWmCb1xl3N5EDSf1BAw/Vd45mqmmOnmdW26h02rgHnYoPriYr4kD7x1p
         Dybka6hxg/eLWSXrqauT7LCa+Aij8Xl4gRActQZpcjUf1tSUivoPmpq8HT80BD4CzyjE
         32FI5nL9FEnb4O+y9rLPty6CO2VgGv6K4Kvy5JuGxQJyx87KJOYryl6V7Odp80gepT3W
         qdGy3h0h+iO68rSKNTaRzcccLv/3gJ3RGb/GfRvc7Nur2/2AD/uYxlscp7/TBVwaWvvu
         vCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f67+bjtYeCtUqo/uAXE3fpyvxao1QzlDS2a4xq8I5P8=;
        b=dwSJG/5Ai/6P4iZxntWw83j1XVzTL06qp93oQJq5IJwRopzQUtyC3UuZQAJgngMyYi
         KlNtzcs61RcWIwO7FjgidByLA06e76lz/d3Po7/X/2pHoeS07bvhESrBLqQsuI1uB4oK
         9UdNa/w+pMh1iSoyrUhwfBjotX1D6xOhOxQuzO+gjVZJMs/WszVXgaNOX34/D5ICfWVl
         mTGvenykG5NqHdaZj1wMbx08woGeP5X1xel4ve6rX6RPe3bcpX+420OTrmE4EN44iptc
         /uyksLTTLTfKceFziB5nftAbabFIY4OjJ2NuD9+qG9Vh+KizvzJu+C757C0XLLDKepPH
         GIGQ==
X-Gm-Message-State: ANhLgQ1LhPswzEybgTC/9CNQOGTyVssHtn4+AdutQPpaE8JDYlGgYJtI
        Tep2U9TbA8qwIJNco030sLI=
X-Google-Smtp-Source: ADFU+vs52XevfPd9CkY0BV9JYSO6seOfVzZW44RXdhegYSDfeenNv5HyilGu6Apa5KTT1UUA1bGFJg==
X-Received: by 2002:a17:90a:3547:: with SMTP id q65mr14334577pjb.118.1585542064032;
        Sun, 29 Mar 2020 21:21:04 -0700 (PDT)
Received: from Gentoo ([103.231.90.174])
        by smtp.gmail.com with ESMTPSA id a13sm8629785pgi.77.2020.03.29.21.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 21:21:03 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:50:50 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.6 ..build..compile...booted without fuss
Message-ID: <20200330042047.GA28105@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wi9ZT7Stg-uSpX0UWQzam6OP9Jzz6Xu1CkYu1cicpD5OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9ZT7Stg-uSpX0UWQzam6OP9Jzz6Xu1CkYu1cicpD5OA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:51 Sun 29 Mar 2020, Linus Torvalds wrote:
>So I'll admit to vacillating between doing this 5.6 release and doing
>another -rc.
>
>This has a bit more changes than I'd like, but they are mostly from
>davem's networking fixes pulls, and David feels comfy with them. And I
>looked over the diff, and none of it looks scary. It's just slightly
>more than I'd have preferred at this stage - not doesn't really seem
>worth delaying a release over.
>
>So about half the diff from the final week is network driver fixlets,
>and some minor core networking fixes. Another 20% is tooling - mostly
>bpf and netfilter selftests (but also some perf work).
>
>The rest is "misc" - mostly random drivers (gpio, rdma, input) and DTS
>files. With a smattering of fixes elsewhere (a couple of afs fixes,
>some vm fixes, etc).
>
>The shortlog is appended, nothing really looks all that exciting, and
>most of the discussions I've seen are already about things for the
>next merge window.
>
>Which obviously opens now as of the release, and I'll start doing
>pulls tomorrow. I already have a couple of pull requests in pending in
>my inbox - thank you.
>
>And while I haven't really seen any real sign of kernel development
>being impacted by all the coronavirus activity - I suspect a lot of us
>work from home even normally, and my daughter laughed at me and called
>me a "social distancing champ" the other day - it may be worth just
>mentioning: I think we're all reading the news and slightly
>distracted.  I'm currently going by the assumption that we'll have a
>fairly normal 5.7 release, and there doesn't seem to be any signs
>saying otherwise, but hey, people may have better-than-usual reasons
>for missing the merge window. Let me know if you know of some
>subsystem that ends up being affected.
>
>So we'll play it by ear and see what happens. It's not like the merge
>window is more important than your health, or the health of people
>around you.
>
>                  Linus
>
>--

Well, it build,compile and boot without fuss. Here is a snippet below :


[    3.263882] ext4 filesystem being mounted at /root supports
timestamps until 2038 (0x7fffffff)
[    3.265251] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.278166] devtmpfs: mounted
[    3.291559] Freeing unused decrypted memory: 2040K
[    3.353686] Freeing unused kernel image (initmem) memory: 1568K
[    3.354249] Write protecting the kernel read-only data: 26624k
[    3.357966] Freeing unused kernel image (text/rodata gap) memory:
2040K
[    3.359775] Freeing unused kernel image (rodata/data gap) memory:
1040K
[    3.360650] rodata_test: all tests were successful
[    3.361080] Run /sbin/init as init process
[    3.376695] tsc: Refined TSC clocksource calibration: 2194.919 MHz
[    3.377471] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x1fa372fc492, max_idle_ns: 440795285018 ns
[    3.378444] clocksource: Switched to clocksource tsc
[    3.461879] process '/bin/busybox' started with executable stack
[    3.623982] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.624762] ext4 filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator... [    4.717083] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting network: [    4.829816] random: crng init done
OK

Welcome to Buildroot
buildroot login: root
# uname -a
Linux buildroot 5.6.0-Gentoo #1 SMP Mon Mar 30 08:06:35 IST 2020 x86_64
GNU/Linux


~Bhaskar







-
>
>Alain Volmat (1):
>      i2c: st: fix missing struct parameter description
>
>Alan Maguire (1):
>      selftests/net: add definition for SOL_DCCP to fix compilation
>errors for old libc
>
>Andre Przywara (1):
>      net: phy: mdio-bcm-unimac: Fix clock handling
>
>Andrew Duggan (1):
>      Input: synaptics-rmi4 - set reduced reporting mode only when request=
ed
>
>Andrii Nakryiko (2):
>      bpf: Initialize storage pointers to NULL to prevent freeing
>garbage pointer
>      bpf: Fix cgroup ref leak in cgroup_bpf_inherit on out-of-memory
>
>Aneesh Kumar K.V (1):
>      mm/sparse: fix kernel crash with pfn_section_valid check
>
>Anson Huang (1):
>      clk: imx8mp: Correct IMX8MP_CLK_HDMI_AXI clock parent
>
>Anup Patel (1):
>      RISC-V: Only select essential drivers for SOC_VIRT config
>
>Arnaldo Carvalho de Melo (1):
>      tools headers uapi: Update linux/in.h copy
>
>Arthur Demchenkov (1):
>      ARM: dts: N900: fix onenand timings
>
>Arthur Kiyanovski (4):
>      net: ena: fix incorrect setting of the number of msix vectors
>      net: ena: fix request of incorrect number of IRQ vectors
>      net: ena: avoid memory access violation by validating req_id properly
>      net: ena: fix continuous keep-alive resets
>
>Arun Easi (1):
>      scsi: qla2xxx: Fix I/Os being passed down when FC device is being de=
leted
>
>Atish Patra (1):
>      RISC-V: Move all address space definition macros to one place
>
>Avraham Stern (1):
>      iwlwifi: mvm: take the required lock when clearing time event data
>
>Aya Levin (4):
>      net/mlx5e: Enhance ICOSQ WQE info fields
>      net/mlx5e: Fix missing reset of SW metadata in Striding RQ reset
>      net/mlx5e: Fix ICOSQ recovery flow with Striding RQ
>      net/mlx5e: Do not recover from a non-fatal syndrome
>
>Borislav Petkov (1):
>      x86/ioremap: Fix CONFIG_EFI=3Dn build
>
>Bruno Meneguele (1):
>      net/bpfilter: fix dprintf usage for /dev/kmsg
>
>Chen-Yu Tsai (4):
>      ARM: dts: sun8i: a83t: Fix incorrect clk and reset macros for EMAC d=
evice
>      ARM: dts: sun8i: r40: Move AHCI device node based on address order
>      ARM: dts: sun8i: r40: Fix register base address for SPI2 and SPI3
>      ARM: dts: sun8i: r40: Move SPI device nodes based on address order
>
>Chris Packham (3):
>      Revert "net: mvmdio: avoid error message for optional IRQ"
>      net: mvmdio: avoid error message for optional IRQ
>      i2c: pca-platform: Use platform_irq_get_optional
>
>Christophe JAILLET (1):
>      dmaengine: ti: k3-udma-glue: Fix an error handling path in
>'k3_udma_glue_cfg_rx_flow()'
>
>Chuhong Yuan (1):
>      i2c: hix5hd2: add missed clk_disable_unprepare in remove
>
>Cong Wang (3):
>      net_sched: hold rtnl lock in tcindex_partial_destroy_work()
>      net_sched: keep alloc_hash updated after hash allocation
>      net_sched: cls_route: remove the right filter from hashtable
>
>Corentin Labbe (2):
>      dt-bindings: crypto: add new compatible for A33 SS
>      ARM: dts: sun8i: a33: add the new SS compatible
>
>Damien Le Moal (1):
>      zonfs: Fix handling of read-only zones
>
>Dan Carpenter (3):
>      Input: raydium_i2c_ts - fix error codes in raydium_i2c_boot_trigger()
>      tee: amdtee: out of bounds read in find_session()
>      NFC: fdp: Fix a signedness bug in fdp_nci_send_patch()
>
>Dave Jiang (1):
>      dmaengine: idxd: fix off by one on cdev dwq refcount
>
>David Hildenbrand (1):
>      drivers/base/memory.c: indicate all memory blocks as removable
>
>David Howells (7):
>      rxrpc: Abstract out the calculation of whether there's Tx space
>      rxrpc: Fix call interruptibility handling
>      rxrpc: Fix sendmsg(MSG_WAITALL) handling
>      afs: Fix some tracing details
>      afs: Fix handling of an abort from a service handler
>      afs: Fix client call Rx-phase signal handling
>      afs: Fix unpinned address list during probing
>
>Dirk Mueller (1):
>      scripts/dtc: Remove redundant YYLOC global declaration
>
>Dmitry Torokhov (2):
>      Input: move the new KEY_SELECTIVE_SCREENSHOT keycode
>      Input: fix stale timestamp on key autorepeat events
>
>Doug Berger (3):
>      Revert "net: bcmgenet: use RGMII loopback for MAC reset"
>      net: bcmgenet: keep MAC in reset until PHY is up
>      net: bcmgenet: always enable status blocks
>
>Edward Cree (2):
>      netfilter: flowtable: populate addr_type mask
>      genirq: Fix reference leaks on irq affinity notifiers
>
>Edwin Peer (1):
>      bnxt_en: fix memory leaks in bnxt_dcbnl_ieee_getets()
>
>Eli Cohen (1):
>      net/mlx5: Clear LAG notifier pointer after unregister
>
>Emil Renner Berthing (1):
>      net: stmmac: dwmac-rk: fix error path in rk_gmac_probe
>
>Eric Dumazet (2):
>      tcp: ensure skb->dev is NULL before leaving TCP stack
>      tcp: repair: fix TCP_QUEUE_SEQ implementation
>
>Eugene Syromiatnikov (1):
>      Input: avoid BIT() macro usage in the serio.h UAPI header
>
>Florian Fainelli (1):
>      net: dsa: Fix duplicate frames flooded by learning
>
>Florian Westphal (3):
>      geneve: move debug check after netdev unregister
>      tcp: also NULL skb->dev when copy was needed
>      selftests: netfilter: add nfqueue test case
>
>Fugang Duan (1):
>      clk: imx8mp: Correct the enet_qos parent clock
>
>Golan Ben Ami (1):
>      iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
>
>Greentime Hu (2):
>      riscv: uaccess should be used in nommu mode
>      riscv: fix the IPI missing issue in nommu mode
>
>Greg Kroah-Hartman (2):
>      bpf: Explicitly memset the bpf_attr structure
>      bpf: Explicitly memset some bpf info structures declared on the stack
>
>Grigore Popescu (1):
>      soc: fsl: dpio: register dpio irq handlers after dpio create
>
>Grygorii Strashko (1):
>      net: phy: dp83867: w/a for fld detect threshold bootstrapping issue
>
>Guilherme G. Piccoli (1):
>      net: ena: Add PCI shutdown handler to allow safe kexec
>
>Haishuang Yan (2):
>      netfilter: flowtable: reload ip{v6}h in nf_flow_nat_ip{v6}
>      netfilter: flowtable: reload ip{v6}h in nf_flow_tuple_ip{v6}
>
>Hamdan Igbaria (1):
>      net/mlx5: DR, Fix postsend actions write length
>
>Hangbin Liu (2):
>      selftests/net: add missing tests to Makefile
>      selftests/net/forwarding: define libs as TEST_PROGS_EXTENDED
>
>Hans de Goede (4):
>      gpiolib: acpi: Correct comment for HP x2 10 honor_wakeup quirk
>      gpiolib: acpi: Rework honor_wakeup option into an ignore_wake option
>      gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 BYT +
>AXP288 model
>      gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT +
>AXP288 model
>
>He Zhe (1):
>      KVM: LAPIC: Mark hrtimer for period or oneshot mode to expire in
>hard interrupt context
>
>Heiner Kallweit (2):
>      r8169: re-enable MSI on RTL8168c
>      r8169: fix PHY driver check on platforms w/o module softdeps
>
>Helge Deller (1):
>      parisc: Fix defconfig selection
>
>Ian Rogers (1):
>      perf parse-events: Fix reading of invalid memory in event parsing
>
>Ido Schimmel (3):
>      mlxsw: reg: Increase register field length to 31 bits
>      mlxsw: pci: Only issue reset when system is ready
>      mlxsw: spectrum_mr: Fix list iteration in error path
>
>Ilan Peer (2):
>      iwlwifi: mvm: Fix rate scale NSS configuration
>      cfg80211: Do not warn on same channel at the end of CSA
>
>Ilie Halip (2):
>      perf python: Fix clang detection when using CC=3Dclang-version
>      arm64: alternative: fix build with clang integrated assembler
>
>Ilya Dryomov (2):
>      ceph: check POOL_FLAG_FULL/NEARFULL in addition to OSDMAP_FULL/NEARF=
ULL
>      libceph: fix alloc_msg_with_page_vector() memory leaks
>
>Jason A. Donenfeld (5):
>      wireguard: selftests: test using new 64-bit time_t
>      wireguard: queueing: account for skb->protocol=3D=3D0
>      wireguard: receive: remove dead code from default packet type case
>      wireguard: noise: error out precomputed DH during handshake
>rather than config
>      crypto: arm64/chacha - correctly walk through blocks
>
>Jason Gunthorpe (4):
>      RDMA/odp: Fix leaking the tgid for implicit ODP
>      RDMA/nl: Do not permit empty devices names during
>RDMA_NLDEV_CMD_NEWLINK/SET
>      RDMA/core: Fix missing error check on dev_set_name()
>      RDMA/mad: Do not crash if the rdma device does not have a umad inter=
face
>
>Jisheng Zhang (1):
>      net: mvneta: Fix the case where the last poll did not process all rx
>
>Joe Perches (1):
>      parse-maintainers: Do not sort section content by default
>
>Johannes Berg (6):
>      wlcore: remove stray plus sign
>      nl80211: fix NL80211_ATTR_CHANNEL_WIDTH attribute type
>      ieee80211: fix HE SPR size calculation
>      mac80211: drop data frames without key on encrypted links
>      mac80211: mark station unauthorized before key removal
>      mac80211: set IEEE80211_TX_CTRL_PORT_CTRL_PROTO for nl80211 TX
>
>John Fastabend (1):
>      bpf, sockmap: Remove bucket->lock from sock_{hash|map}_free
>
>Jouni Malinen (1):
>      mac80211: Check port authorization in the ieee80211_tx_dequeue() case
>
>Kai-Heng Feng (1):
>      i2c: nvidia-gpu: Handle timeout correctly in gpu_i2c_check_status()
>
>Kaike Wan (1):
>      IB/rdmavt: Free kernel completion queue when done
>
>Larry Finger (1):
>      rtlwifi: rtl8188ee: Fix regression due to commit d1d1a96bdb44
>
>Leon Romanovsky (3):
>      net/mlx5_core: Set IB capability mask1 to fix ib_srpt connection fai=
lure
>      MAINTAINERS: Clean RXE section and add Zhu as RXE maintainer
>      RDMA/mlx5: Fix access to wrong pointer while performing flush due to=
 error
>
>Leonard Crestez (2):
>      clk: imx: Align imx sc clock msg structs to 4
>      clk: imx: Align imx sc clock parent msg structs to 4
>
>Linus Torvalds (2):
>      MAINTAINERS: fix bad file pattern
>      Linux 5.6
>
>Linus Walleij (2):
>      gpiolib: Fix irq_disable() semantics
>      arm64: dts: Fix leftover entry-methods for PSCI
>
>Luca Coelho (5):
>      iwlwifi: check allocated pointer when allocating conf_tlvs
>      iwlwifi: dbg: don't abort if sending DBGC_SUSPEND_RESUME fails
>      iwlwifi: cfg: use antenna diversity with all AX101 devices
>      MAINTAINERS: update web URL for iwlwifi
>      iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detection
>
>Luis Henriques (1):
>      ceph: fix memory leak in ceph_cleanup_snapid_map()
>
>Lukas Bulwahn (2):
>      MAINTAINERS: rectify the INTEL IADX DRIVER entry
>      ionic: make spdxcheck.py happy
>
>Luke Nelson (2):
>      bpf, x32: Fix bug with JMP32 JSET BPF_X checking upper bits
>      selftests: bpf: Add test for JMP32 JSET BPF_X with upper bits set
>
>Luo bin (5):
>      hinic: fix a bug of waitting for IO stopped
>      hinic: fix the bug of clearing event queue
>      hinic: fix out-of-order excution in arm cpu
>      hinic: fix wrong para of wait_for_completion_timeout
>      hinic: fix wrong value of MIN_SKB_LEN
>
>Madalin Bucur (3):
>      net: fsl/fman: treat all RGMII modes in memac_adjust_link()
>      arm64: dts: ls1043a-rdb: correct RGMII delay mode to rgmii-id
>      arm64: dts: ls1046ardb: set RGMII interfaces to RGMII_ID mode
>
>Madhuparna Bhowmik (1):
>      ipv6: xfrm6_tunnel.c: Use built-in RCU list checking
>
>Maor Gottlieb (1):
>      RDMA/mlx5: Block delay drop to unprivileged users
>
>Marco Felsch (1):
>      ARM: dts: imx6: phycore-som: fix arm and soc minimum voltage
>
>Marek Szyprowski (2):
>      ARM: dts: exynos: Fix regulator node aliasing on Midas-based boards
>      soc: samsung: chipid: Fix return value on non-Exynos platforms
>
>Marek Vasut (1):
>      net: ks8851-ml: Fix IO operations, again
>
>Mark Zhang (1):
>      RDMA/mlx5: Fix the number of hwcounters of a dynamic counter
>
>Markus Fuchs (1):
>      net: stmmac: platform: Fix misleading interrupt error msg
>
>Martin K. Petersen (1):
>      scsi: sd: Fix optimal I/O size for devices that change reported valu=
es
>
>Martin KaFai Lau (3):
>      bpf: Return better error value in delete_elem for struct_ops map
>      bpf: Do not allow map_freeze in struct_ops map
>      bpf: Sanitize the bpf_struct_ops tcp-cc name
>
>Masami Hiramatsu (3):
>      tools: Let O=3D makes handle a relative path with -C option
>      perf probe: Fix to delete multiple probe event
>      perf probe: Do not depend on dwfl_module_addrsym()
>
>Mauro Carvalho Chehab (4):
>      docs: dmaengine: provider.rst: get rid of some warnings
>      net: phy: sfp-bus.c: get rid of docs warnings
>      net: core: dev.c: fix a documentation warning
>      i2c: fix a doc warning
>
>Michael Chan (3):
>      bnxt_en: Fix Priority Bytes and Packets counters in ethtool -S.
>      bnxt_en: Return error if bnxt_alloc_ctx_mem() fails.
>      bnxt_en: Free context memory after disabling PCI in probe error path.
>
>Michal Kubecek (5):
>      netlink: allow extack cookie also for error messages
>      netlink: add nl_set_extack_cookie_u32()
>      ethtool: reject unrecognized request flags
>      netlink: check for null extack in cookie helpers
>      ethtool: fix reference leak in some *_SET handlers
>
>Mike Marciniszyn (2):
>      IB/hfi1: Ensure pq is not left on waitlist
>      RDMA/core: Ensure security pkey modify is not lost
>
>Mina Almasry (1):
>      hugetlb_cgroup: fix illegal access to memory
>
>Mordechay Goodstein (2):
>      iwlwifi: consider HE capability when setting LDPC
>      iwlwifi: yoyo: don't add TLV offset when reading FIFOs
>
>Naohiro Aota (1):
>      mm/swapfile.c: move inode_lock out of claim_swapfile
>
>Nick Desaulniers (1):
>      KVM: VMX: don't allow memory operands for inline asm that modifies SP
>
>Nick Hudson (1):
>      ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
>
>Nick Reitemeyer (3):
>      dt-bindings: vendor-prefixes: Add Coreriver vendor prefix
>      dt-bindings: input: add Coreriver TC360 binding
>      Input: tm2-touchkey - add support for Coreriver TC360 variant
>
>Nicolas Dichtel (1):
>      vti[6]: fix packet tx through bpf_redirect() in XinY cases
>
>Nicolas Saenz Julienne (1):
>      ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations
>
>Oliver Hartkopp (1):
>      slcan: not call free_netdev before rtnl_unlock in slcan_open
>
>Ondrej Jirman (3):
>      ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesn't like such a high volta=
ge
>      ARM: dts: sun8i-a83t-tbs-a711: Fix USB OTG mode detection
>      bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit rea=
ds
>
>Pablo Neira Ayuso (4):
>      netfilter: nf_tables: Allow set back-ends to report partial
>overlaps on insertion
>      netfilter: nft_fwd_netdev: validate family and chain type
>      netfilter: nft_fwd_netdev: allow to redirect to ifb via ingress
>      net: Fix CONFIG_NET_CLS_ACT=3Dn and CONFIG_NFT_FWD_NETDEV=3D{y, m} b=
uild
>
>Paolo Bonzini (2):
>      KVM: x86: remove bogus user-triggerable WARN_ON
>      KVM: SVM: document KVM_MEM_ENCRYPT_OP, let userspace detect if
>SEV is available
>
>Paul Blakey (2):
>      net/sched: act_ct: Fix leak of ct zone template on replace
>      netfilter: flowtable: Fix flushing of offloaded flows on free
>
>Pawel Dembicki (1):
>      net: qmi_wwan: add support for ASKEY WWHC050
>
>Petr Machata (2):
>      net: ip_gre: Separate ERSPAN newlink / changelink callbacks
>      net: ip_gre: Accept IFLA_INFO_DATA-less configuration
>
>Qian Cai (1):
>      ipv4: fix a RCU-list lock in inet_dump_fib()
>
>Quentin Monnet (1):
>      mailmap: Update email address
>
>Raed Salem (1):
>      xfrm: handle NETDEV_UNREGISTER for xfrm device
>
>Rahul Lakkireddy (2):
>      cxgb4: fix throughput drop during Tx backpressure
>      cxgb4: fix Txq restart check during backpressure
>
>Rajat Jain (1):
>      Input: allocate keycode for "Selective Screenshot" key
>
>Raju Rangoju (1):
>      cxgb4/ptp: pass the sign of offset delta in FW CMD
>
>Rayagonda Kokatanur (1):
>      net: phy: mdio-mux-bcm-iproc: check clk_prepare_enable() return value
>
>Ren=C3=A9 van Dorst (1):
>      net: dsa: mt7530: Change the LINK bit to reflect the link status
>
>Roger Quadros (2):
>      ARM: dts: dra7: Add bus_dma_limit for L3 bus
>      ARM: dts: omap5: Add bus_dma_limit for L3 bus
>
>Roman Gushchin (1):
>      mm: fork: fix kernel_stack memcg stats for various stack implementat=
ions
>
>Sebastian Hense (1):
>      net/mlx5e: Fix endianness handling in pedit mask
>
>Shahjada Abul Husain (1):
>      cxgb4: fix delete filter entry fail in unload path
>
>Shane Francis (3):
>      drm/prime: use dma length macro when mapping sg
>      drm/amdgpu: fix scatter-gather mapping with user pages
>      drm/radeon: fix scatter-gather mapping with user pages
>
>Stefano Brivio (3):
>      netfilter: nft_set_pipapo: Separate partial and complete overlap
>cases on insertion
>      netfilter: nft_set_rbtree: Introduce and use nft_rbtree_interval_sta=
rt()
>      netfilter: nft_set_rbtree: Detect partial overlaps on insertion
>
>Stephen Boyd (1):
>      clk: Pass correct arguments to __clk_hw_register_gate()
>
>Sungbo Eo (1):
>      ARM: dts: oxnas: Fix clear-mask property
>
>Taehee Yoo (5):
>      hsr: use rcu_read_lock() in hsr_get_node_{list/status}()
>      hsr: add restart routine into hsr_get_node_list()
>      hsr: set .netnsok flag
>      vxlan: check return value of gro_cells_init()
>      hsr: fix general protection fault in hsr_addr_is_self()
>
>Takashi Iwai (6):
>      net: caif: Use scnprintf() for avoiding potential buffer overflow
>      net: mlx4: Use scnprintf() for avoiding potential buffer overflow
>      net: nfp: Use scnprintf() for avoiding potential buffer overflow
>      net: ionic: Use scnprintf() for avoiding potential buffer overflow
>      net: sfc: Use scnprintf() for avoiding potential buffer overflow
>      net: netdevsim: Use scnprintf() for avoiding potential buffer overfl=
ow
>
>Tariq Toukan (2):
>      net/mlx5e: kTLS, Fix TCP seq off-by-1 issue in TX resync flow
>      net/mlx5e: kTLS, Fix wrong value in record tracker enum
>
>Tom Lendacky (1):
>      KVM: SVM: Issue WBINVD after deactivating an SEV guest
>
>Tony Lindgren (4):
>      ARM: dts: Fix dm814x Ethernet by changing to use rgmii-id mode
>      bus: ti-sysc: Fix quirk flags for lcdc on am335x
>      clk: ti: am43xx: Fix clock parent for RTC clock
>      ARM: dts: omap4-droid4: Fix lost touchscreen interrupts
>
>Torsten Hilbrich (1):
>      vti6: Fix memory leak of skb if input policy check fails
>
>Vadym Kochan (1):
>      selftests/net/forwarding: add Makefile to install tests
>
>Vasundhara Volam (1):
>      bnxt_en: Reset rings if ring reservation fails during open()
>
>Vinod Koul (1):
>      dmaengine: move .device_release missing log warning to debug level
>
>Vladimir Oltean (1):
>      net: dsa: tag_8021q: replace dsa_8021q_remove_header with __skb_vlan=
_pop
>
>Wanpeng Li (2):
>      KVM: LAPIC: Also cancel preemption timer when disarm LAPIC timer
>      KVM: X86: Narrow down the IPI fastpath to single target IPI
>
>Weihang Li (1):
>      MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER
>
>Willem de Bruijn (2):
>      net/packet: tpacket_rcv: avoid a producer race condition
>      macsec: restrict to ethernet devices
>
>Xin Long (3):
>      xfrm: fix uctx len check in verify_sec_ctx_len
>      xfrm: add the missing verify_sec_ctx_len check in xfrm_add_acquire
>      esp: remove the skb from the chain when it's enqueued in cryptd_wq
>
>Xu Wang (1):
>      qlcnic: Fix bad kzalloc null test
>
>Yintian Tao (1):
>      drm/scheduler: fix rare NULL ptr race
>
>Yonghong Song (2):
>      bpf: Fix deadlock with rq_lock in bpf_send_signal()
>      selftests/bpf: Add send_signal_sched_switch test
>
>Yoshiki Komachi (2):
>      bpf/btf: Fix BTF verification of enum members in struct/union
>      selftests/bpf: Add test for the packed enum member in struct/union
>
>Yubo Xie (1):
>      clocksource/drivers/hyper-v: Make sched clock return nanoseconds cor=
rectly
>
>YueHaibing (2):
>      wireguard: selftests: remove duplicated include <sys/types.h>
>      xfrm: policy: Fix doulbe free in xfrm_policy_timer
>
>Yussuf Khalil (1):
>      Input: synaptics - enable RMI on HP Envy 13-ad105ng
>
>Zh-yuan Ye (1):
>      net: cbs: Fix software cbs to consider packet sending time
>
>Zheng Wei (1):
>      net: vxge: fix wrong __VA_ARGS__ usage
>
>Zhou Wang (1):
>      MAINTAINERS: Add maintainer for HiSilicon DMA engine driver
>
>disconnect3d (1):
>      perf map: Fix off by one in strncpy() size argument

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl6Bc5wACgkQsjqdtxFL
KRXL/Af/Rb3BakecJ2Jr519IhTZSglFiuiVmMSI3rRY8hk00Ad8/HgiDrjGqMMXd
UWv9uZeH86ihOFGx/BH1tbm3SqFIc5m11WosNtG0o088YL35/dktYsi6E2g5F5FT
+gpgJMRg2YABn64NsH3LpfgPOXhLU5p6CGaCt89vzPyICI+cTxEmjEfWgGc4DmlT
Gh3UIGUAYrKlcrYyAh9+mU6RGEzCumP/wijaJsm6kMUlQ8qqIWA7lRCaKKp136dg
sDwCVu9sqgBcqxcIP0K9uAKctyyybrqBhx7IWR9ygJtGxaQraX+OCKJTeqf6H4i6
zUilxtqSCsIHN8vr3GFXBptx3UqUUg==
=dW4z
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
