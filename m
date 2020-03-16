Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E5CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A8420674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOgrjRmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgCPJTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:19:16 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:42285 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:19:16 -0400
Received: by mail-pg1-f169.google.com with SMTP id h8so9397744pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mSvkpLYrNWDDO0UH2bBEH6UwOyNUVmkRKlMvYGWAHBI=;
        b=YOgrjRmXh4V8Fyza3n1jRS+w1GVhQFdMTcTlYDHmwImoxlmWSw4mPNGYOB2vg4kdZo
         Se/cGBxBr7A89aspxUDVsva6MEXKBHy3jLTIBbMNUHdZMLKYfcXet6XnYBOWnWY+kEmS
         +ASJLWYylYn/J1D6pYs+ISZZJKVBwsFl+dhP8OcJsMMr4KaHM0IZK++JpTdX+M2JoapO
         lYip9CXcxlYJK1MaITQAelsoynL0/JaljYQQSPmxNGOkD+p0T1rDK1jp/f1xf/DPjxGC
         PBwEJrQtkMdFm7hSxDkyLQdSg6ibVGF/EzpA2DoYzE13cTWZ2dOAS3hI82UgyqK4Kq7Z
         VWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mSvkpLYrNWDDO0UH2bBEH6UwOyNUVmkRKlMvYGWAHBI=;
        b=bDlBDubktTJjHBvt5A6EquOwXRzuVHsvwYBJYrDDY61I+NUASSPzCe3kqfYOIlHP02
         Bi/d/69DtrlG0Ya6V88Rvjd8VbXi7Nkm9ULqz4CCi9MtzscEhICOVCHpdU8VeLGNP29a
         qE1x5wUTZIaZlr5aKdT1PFeOH6IXt71Zp1skehemLPw0xd8ZyLsHVPL5nCGmTMJUIbox
         g4Gt44Ili2YSzh83hb5k5WmqopV45GpwxVhBVYZCaJA453HafCp7w2yh/fcy02oROzcE
         imhIO6VqYjovUh4tQicihospGNcGmK53x3dqTNmRE6VdQIaMpjHoK2+VsdqcUiAPKn8e
         y5HQ==
X-Gm-Message-State: ANhLgQ2g5ZeGPbNr1Y6SuAMvF3PcRbTC2QsbVijywCSibGYbQNaVduMC
        usMKq6NPtpQ+5zZ5PnQeupY=
X-Google-Smtp-Source: ADFU+vsFcvYhEFrz6sXchZxXXd8adHYF9wZXIROwt9rn4Dobr/PU5N8D+iAOj8Y3ZenTcq0dceqWug==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr27178831pgn.251.1584350353143;
        Mon, 16 Mar 2020 02:19:13 -0700 (PDT)
Received: from Slackware ([103.231.90.173])
        by smtp.gmail.com with ESMTPSA id i131sm45158462pgc.18.2020.03.16.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:19:11 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:48:57 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.6-rc6 ..built...compile..boot without fuss!
Message-ID: <20200316091857.GA27510@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whcVTGVPtvdb9SdCcjLawG6tLvbNWfWB_Y6=QhovFy2rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAHk-=whcVTGVPtvdb9SdCcjLawG6tLvbNWfWB_Y6=QhovFy2rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:19 Sun 15 Mar 2020, Linus Torvalds wrote:
>Another week, another rc.
>
>Things look normal - all the stats look like they usually do at this point.
>
>The full patch is about 60% driver changes (gpu, networking, s390
>stand out, but there's noise all over), with the rest being tooling
>(mainly perf), networking, arch updates (mainly x86, but some arc,
>mips and s390 too), and misc core updates.
>
>Diffstat looks normal, and the number of commits is right in the
>middle of the usual range too. And I don't think any of the commits
>look all that strange either - it's all pretty small.
>
>So please test,
>
>            Linus
>


Well, it built,compile and booted without fuss! Take a peek at dead end
below:


[    3.103124] EXT4-fs (sda): recovery complete
[    3.109505] EXT4-fs (sda): mounted filesystem with ordered data mode.
Opts: (null)
[    3.111031] ext4 filesystem being mounted at /root supports
timestamps until 2038 (0x7fffffff)
[    3.111953] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.125388] devtmpfs: mounted
[    3.135268] Freeing unused decrypted memory: 2040K
[    3.194353] Freeing unused kernel image (initmem) memory: 1568K
[    3.195229] Write protecting the kernel read-only data: 26624k
[    3.199142] Freeing unused kernel image (text/rodata gap) memory:
2040K
[    3.200798] Freeing unused kernel image (rodata/data gap) memory:
1040K
[    3.201638] rodata_test: all tests were successful
[    3.202033] Run /sbin/init as init process
[    3.244008] process '/bin/busybox' started with executable stack
[    3.333309] tsc: Refined TSC clocksource calibration: 2194.918 MHz
[    3.333856] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x1fa37202099, max_idle_ns: 440795206796 ns
[    3.334647] clocksource: Switched to clocksource tsc
[    3.435414] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.436007] ext4 filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator... [    4.489653] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting network: OK

Welcome to Buildroot
buildroot login: root[    9.292919] random: crng init done

# uname -a
Linux buildroot 5.6.0-rc6 #1 SMP Mon Mar 16 11:34:58 IST 2020 x86_64
GNU/Linux


~Bhaskar




>---
>
>Al Viro (2):
>      gfs2_atomic_open(): fix O_EXCL|O_CREAT handling on cold dcache
>      cifs_atomic_open(): fix double-put on late allocation failure
>
>Amir Goldstein (2):
>      ovl: fix lock in ovl_llseek()
>      ovl: fix some xino configurations
>
>Amol Grover (2):
>      iommu/vt-d: Fix RCU list debugging warnings
>      net: caif: Add lockdep expression to RCU traversal primitive
>
>Andrea Parri (1):
>      workqueue: Document (some) memory-ordering properties of
>{queue,schedule}_work()
>
>Andrew Lunn (2):
>      net: dsa: Don't instantiate phylink for CPU/DSA ports unless needed
>      net: dsa: mv88e6xxx: Add missing mask of ATU occupancy register
>
>Anson Huang (1):
>      clk: imx8mn: Fix incorrect clock defines
>
>Arnaldo Carvalho de Melo (5):
>      perf tests bp_account: Make global variable static
>      perf env: Do not return pointers to local variables
>      perf parse-events: Use asprintf() instead of strncpy() to read
>tracepoint files
>      perf bench: Share some global variables to fix build with gcc 10
>      perf symbols: Don't try to find a vmlinux file when looking for
>kernel modules
>
>Artem Savkov (1):
>      ftrace: Return the first found result in lookup_rec()
>
>Ben Chuang (1):
>      mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x
>
>Can Guo (1):
>      scsi: ufs: Fix possible unclocked access to auto hibern8 timer regis=
ter
>
>Charles Keepax (2):
>      pinctrl: core: Remove extra kref_get which blocks hogs being freed
>      pinctrl: madera: Add missing call to pinctrl_unregister_mappings
>
>Chris Packham (1):
>      net: mvmdio: avoid error message for optional IRQ
>
>Chris Wilson (5):
>      drm/i915: Actually emit the await_start
>      drm/i915: Return early for await_start on same timeline
>      drm/i915/execlists: Enable timeslice on partial virtual engine deque=
ue
>      drm/i915/gt: Close race between cacheline_retire and free
>      drm/i915: Defer semaphore priority bumping to a workqueue
>
>Christian Borntraeger (1):
>      KVM: s390: Also reset registers in sync regs for initial cpu reset
>
>Christian Brauner (1):
>      pid: make ENOMEM return value more obvious
>
>Christoph Hellwig (1):
>      driver code: clarify and fix platform device DMA mask allocation
>
>Colin Ian King (1):
>      net: systemport: fix index check to avoid an array out of bounds acc=
ess
>
>Corey Minyard (1):
>      pid: Fix error return value in some cases
>
>Cyril Hrubis (1):
>      sys/sysinfo: Respect boottime inside time namespace
>
>Dajun Jin (1):
>      drivers/of/of_mdio.c:fix of_mdiobus_register()
>
>Dan Carpenter (1):
>      net: nfc: fix bounds checking bugs on "pipe"
>
>Dan Moulding (1):
>      iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
>
>Daniel Drake (1):
>      iommu/vt-d: Ignore devices with out-of-spec domain number
>
>Davide Caratti (1):
>      tc-testing: add ETS scheduler to tdc build configuration
>
>Dmitry Bogdanov (2):
>      net: macsec: update SCI upon MAC address change.
>      net: macsec: invoke mdo_upd_secy callback when mac address changed
>
>Dmitry Yakunin (2):
>      inet_diag: return classid for all socket types
>      cgroup, netclassid: periodically release file_lock on classid updati=
ng
>
>Dominik Czarnota (1):
>      sxgbe: Fix off by one in samsung driver strncpy size arg
>
>Edward Cree (1):
>      sfc: detach from cb_page in efx_copy_channel()
>
>Edwin Peer (1):
>      bnxt_en: fix error handling when flashing from file
>
>Eric Biggers (1):
>      fscrypt: don't evict dirty inodes after removing key
>
>Eric Dumazet (5):
>      slip: make slhc_compress() more robust against malicious packets
>      bonding/alb: make sure arp header is pulled before accessing it
>      gre: fix uninit-value in __iptunnel_pull_header
>      ipvlan: do not use cond_resched_rcu() in ipvlan_process_multicast()
>      net: memcg: fix lockdep splat in inet_csk_accept()
>
>Eugeniy Paltsev (1):
>      ARC: define __ALIGN_STR and __ALIGN symbols for ARC
>
>Felix Fietkau (1):
>      mt76: fix array overflow on receiving too many fragments for a packet
>
>Florian Westphal (2):
>      netfilter: nf_tables: free flowtable hooks on hook register error
>      netfilter: nf_tables: fix infinite loop when expr is not available
>
>Geert Uytterhoeven (2):
>      ARC: Replace <linux/clk-provider.h> by <linux/of_clk.h>
>      of: clk: Make of_clk_get_parent_{count,name}() parameter const
>
>Gustavo A. R. Silva (1):
>      auxdisplay: charlcd: replace zero-length array with flexible-array m=
ember
>
>H. Nikolaus Schaller (2):
>      MIPS: DTS: CI20: fix PMU definitions for ACT8600
>      MIPS: DTS: CI20: fix interrupt for pcf8563 RTC
>
>Haiwei Li (1):
>      KVM: SVM: Fix the svm vmexit code for WRMSR
>
>Halil Pasic (2):
>      virtio-blk: fix hw_queue stopped on arbitrary error
>      virtio-blk: improve virtqueue error to BLK_STS
>
>Hamish Martin (1):
>      i2c: gpio: suppress error on probe defer
>
>Hangbin Liu (5):
>      net/ipv6: use configured metric when add peer route
>      net/ipv6: need update peer route when modify metric
>      net/ipv6: remove the old peer route if change it to a new one
>      selftests/net/fib_tests: update addr_metric_test for peer route test=
ing
>      ipv6/addrconf: call ipv6_mc_up() for non-Ethernet interface
>
>Hans de Goede (3):
>      iommu/vt-d: dmar: replace WARN_TAINT with pr_warn + add_taint
>      iommu/vt-d: dmar_parse_one_rmrr: replace WARN_TAINT with pr_warn
>+ add_taint
>      iommu/vt-d: quirk_ioat_snb_local_iommu: replace WARN_TAINT with
>pr_warn + add_taint
>
>Hauke Mehrtens (1):
>      phylink: Improve error message when validate failed
>
>Hawking Zhang (1):
>      drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
>
>Heiner Kallweit (2):
>      net: phy: avoid clearing PHY interrupts twice in irq handler
>      net: phy: fix MDIO bus PM PHY resuming
>
>Hersen Wu (1):
>      drm/amdgpu/powerplay: nv1x, renior copy dcn clock settings of
>watermark to smu during boot up
>
>Hillf Danton (1):
>      workqueue: don't use wq_select_unbound_cpu() for bound works
>
>Ian Rogers (1):
>      tools: Fix off-by 1 relative directory includes
>
>Jacob Keller (1):
>      devlink: remove trigger command from devlink-region.rst
>
>Jakub Kicinski (26):
>      devlink: validate length of param values
>      devlink: validate length of region addr/len
>      fib: add missing attribute validation for tun_id
>      nl802154: add missing attribute validation
>      nl802154: add missing attribute validation for dev_type
>      can: add missing attribute validation for termination
>      macsec: add missing attribute validation for port
>      openvswitch: add missing attribute validation for hash
>      net: fq: add missing attribute validation for orphan mask
>      net: taprio: add missing attribute validation for txtime delay
>      team: add missing attribute validation for port ifindex
>      team: add missing attribute validation for array index
>      tipc: add missing attribute validation for MTU property
>      nfc: add missing attribute validation for SE API
>      nfc: add missing attribute validation for deactivate target
>      nfc: add missing attribute validation for vendor subcommand
>      netfilter: cthelper: add missing attribute validation for cthelper
>      netfilter: nft_payload: add missing attribute validation for
>payload csum flags
>      netfilter: nft_tunnel: add missing attribute validation for tunnels
>      MAINTAINERS: remove bouncing pkaustub@cisco.com from enic
>      MAINTAINERS: update cxgb4vf maintainer to Vishal
>      nl80211: add missing attribute validation for critical protocol indi=
cation
>      nl80211: add missing attribute validation for beacon report scanning
>      nl80211: add missing attribute validation for channel switch
>      net: fec: validate the new settings in fec_enet_set_coalesce()
>      MAINTAINERS: remove Sathya Perla as Emulex NIC maintainer
>
>Jann Horn (1):
>      afs: Use kfree_rcu() instead of casting kfree() to rcu_callback_t
>
>Jarkko Nikula (1):
>      i2c: designware-pci: Fix BUG_ON during device removal
>
>Jason A. Donenfeld (2):
>      crypto: x86/curve25519 - support assemblers with no adx support
>      KVM: fix Kconfig menu text for -Werror
>
>Jens Axboe (1):
>      io_uring: ensure RCU callback ordering with rcu_barrier()
>
>Jian Shen (4):
>      net: hns3: fix a not link up issue when fibre port supports autoneg
>      net: hns3: fix VF VLAN table entries inconsistent issue
>      net: hns3: fix RMW issue for VLAN filter switch
>      net: hns3: clear port base VLAN when unload PF
>
>Jiang Lidong (1):
>      veth: ignore peer tx_dropped when counting local rx_dropped
>
>Jiri Wiesner (1):
>      ipvlan: do not add hardware address of master to its unicast filter =
list
>
>John Garry (1):
>      perf jevents: Fix leak of mapfile memory
>
>Jonas Gorski (1):
>      net: phy: bcm63xx: fix OOPS due to missing driver name
>
>Jonathan Neusch=C3=A4fer (2):
>      docs: networking: net_failover: Fix a few typos
>      rhashtable: Document the right function parameters
>
>Julian Wiedmann (6):
>      s390/qeth: don't reset default_out_queue
>      s390/qeth: handle error when backing RX buffer
>      s390/qeth: cancel RX reclaim work earlier
>      s390/qeth: use page pointers to manage RX buffer pool
>      s390/qeth: refactor buffer pool code
>      s390/qeth: implement smarter resizing of the RX buffer pool
>
>Juliet Kim (1):
>      ibmvnic: Do not process device remove during device reset
>
>Karsten Graul (1):
>      net/smc: cancel event worker during device removal
>
>Kim Phillips (1):
>      perf/amd/uncore: Replace manual sampling check with CAP_NO_INTERRUPT=
 flag
>
>Krzysztof Kozlowski (2):
>      ARC: Cleanup old Kconfig IO scheduler options
>      auxdisplay: Fix Kconfig indentation
>
>Leonard Crestez (1):
>      pinctrl: imx: scu: Align imx sc msg structs to 4
>
>Linus Torvalds (1):
>      Linux 5.6-rc6
>
>Linus Walleij (2):
>      pinctrl: qcom: ssbi-gpio: Fix fwspec parsing bug
>      pinctrl: qcom: Assign irq_eoi conditionally
>
>Lyude Paul (4):
>      drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less redu=
ndant
>      drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth chec=
ks
>      drm/dp_mst: Reprobe path resources in CSN handler
>      drm/dp_mst: Rewrite and fix bandwidth limit checks
>
>Madalin Bucur (4):
>      dt-bindings: net: FMan erratum A050385
>      arm64: dts: ls1043a: FMan erratum A050385
>      fsl/fman: detect FMan erratum A050385
>      dpaa_eth: FMan erratum A050385 workaround
>
>Mahesh Bandewar (3):
>      ipvlan: don't deref eth hdr before checking it's set
>      ipvlan: add cond_resched_rcu() while processing muticast backlog
>      macvlan: add cond_resched() during multicast processing
>
>Marc Zyngier (2):
>      iommu/dma: Fix MSI reservation allocation
>      irqchip/gic-v3: Workaround Cavium erratum 38539 when reading GICD_TY=
PER2
>
>Marek Szyprowski (1):
>      drm/exynos: Fix cleanup of IOMMU related objects
>
>Martin Leung (1):
>      drm/amd/display: update soc bb for nv14
>
>Masanari Iida (3):
>      linux-next: DOC: RDS: Fix a typo in rds.txt
>      ktest: Fix some typos in sample.conf
>      ktest: Fix typos in ktest.pl
>
>Mathias Kresin (1):
>      pinctrl: falcon: fix syntax error
>
>Matthew Auld (1):
>      drm/i915: be more solid in checking the alignment
>
>Megha Dey (2):
>      iommu/vt-d: Fix debugfs register reads
>      iommu/vt-d: Populate debugfs if IOMMUs are detected
>
>Michael Auchter (1):
>      misc: eeprom: at24: fix regulator underflow
>
>Michal Koutn=C3=BD (1):
>      cgroup: Iterate tasks that did not finish do_exit()
>
>Miguel Ojeda (1):
>      clang-format: Update with the latest for_each macro list
>
>Mika Westerberg (3):
>      watchdog: iTCO_wdt: Export vendorsupport
>      watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
>      i2c: i801: Do not add ICH_RES_IO_SMI for the iTCO_wdt device
>
>Mike Gilbert (1):
>      cpupower: avoid multiple definition with gcc -fno-common
>
>Miklos Szeredi (2):
>      fuse: fix stack use after return
>      ovl: fix lockdep warning for async write
>
>Ming Lei (1):
>      blk-mq: insert flush request to the front of dispatch queue
>
>Nathan Chancellor (2):
>      virtio_balloon: Adjust label in virtballoon_probe
>      dpaa_eth: Remove unnecessary boolean expression in dpaa_get_headroom
>
>Nick Desaulniers (1):
>      perf diff: Fix undefined string comparision spotted by clang's
>-Wstring-compare
>
>Nicolas Belin (1):
>      pinctrl: meson-gxl: fix GPIOX sdio pins
>
>Nicolas Cavallari (1):
>      mac80211: Do not send mesh HWMP PREQ if HWMP is disabled
>
>Nitesh Narayan Lal (1):
>      KVM: x86: Initializing all kvm_lapic_irq fields in ioapic_write_indi=
rect
>
>Pablo Neira Ayuso (3):
>      netlink: Use netlink header as base to calculate bad attribute offset
>      netfilter: nf_tables: dump NFTA_CHAIN_FLAGS attribute
>      netfilter: nft_chain_nat: inet family is missing module ownership
>
>Paolo Abeni (1):
>      mptcp: always include dack if possible.
>
>Paolo Lungaroni (1):
>      seg6: fix SRv6 L2 tunnels to use IANA-assigned protocol number
>
>Paul Cercueil (1):
>      MIPS: Fix CONFIG_MIPS_CMDLINE_DTB_EXTEND handling
>
>Peter Xu (1):
>      x86/vector: Remove warning on managed interrupt migration
>
>Peter Zijlstra (1):
>      futex: Fix inode life-time issue
>
>Qian Cai (3):
>      cgroup: fix psi_show() crash on 32bit ino archs
>      iommu/vt-d: Fix RCU-list bugs in intel_iommu_init()
>      iommu/vt-d: Silence RCU-list debugging warnings
>
>Randy Dunlap (2):
>      ARC: fix some Kconfig typos
>      atm: nicstar: fix if-statement empty body warning
>
>Remi Pommarel (1):
>      net: stmmac: dwmac1000: Disable ACS if enhanced descs are not used
>
>Robin Murphy (1):
>      iommu/io-pgtable-arm: Fix IOVA validation for 32-bit
>
>Russell King (2):
>      net: dsa: mv88e6xxx: fix lockup on warm boot
>      net: dsa: fix phylink_start()/phylink_stop() calls
>
>Scott Mayhew (4):
>      NFS: Ensure the fs_context has the correct fs_type before mounting
>      NFS: Don't hard-code the fs_type when submounting
>      NFS: Fix leak of ctx->nfs_server.hostname
>      nfs: add minor version to nfs_server_key for fscache
>
>Sean Christopherson (1):
>      KVM: VMX: Condition ENCLS-exiting enabling on CPU support for SGX1
>
>Shakeel Butt (2):
>      cgroup: memcg: net: do not associate sock with unrelated cgroup
>      net: memcg: late association of sock to memcg
>
>Shannon Nelson (1):
>      ionic: fix vf op lock usage
>
>Shin'ichiro Kawasaki (1):
>      block: Fix partition support for host aware zoned block devices
>
>Stefan Haberland (1):
>      s390/dasd: fix data corruption for thin provisioned devices
>
>Stephen Boyd (1):
>      mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
>
>Steven Rostedt (VMware) (2):
>      ktest: Make default build option oldconfig not randconfig
>      ktest: Add timeout for ssh sync testing
>
>Suman Anna (1):
>      virtio_ring: Fix mem leak with vring_new_virtqueue()
>
>Suravee Suthikulpanit (1):
>      iommu/amd: Fix IOMMU AVIC not properly update the is_run bit in IRTE
>
>Sven Eckelmann (1):
>      batman-adv: Don't schedule OGM for disabled interface
>
>Takashi Iwai (1):
>      ipmi_si: Avoid spurious errors for optional IRQs
>
>Taniya Das (2):
>      clk: qcom: videocc: Update the clock flag for video_cc_vcodec0_core_=
clk
>      clk: qcom: dispcc: Remove support of disp_cc_mdss_rscc_ahb_clk
>
>Tejun Heo (1):
>      blk-iocost: fix incorrect vtime comparison in iocg_is_idle()
>
>Thomas Bogendoerfer (1):
>      MAINTAINERS: Correct MIPS patchwork URL
>
>Thomas Gleixner (2):
>      x86/mce/therm_throt: Undo thermal polling properly on CPU offline
>      futex: Unbreak futex hashing
>
>Tina Zhang (2):
>      drm/i915/gvt: Fix emulated vbt size issue
>      drm/i915/gvt: Fix dma-buf display blur issue on CFL
>
>Tom Lendacky (1):
>      x86/ioremap: Map EFI runtime services data as encrypted for SEV
>
>Tom Zhao (1):
>      sfc: complete the next packet when we receive a timestamp
>
>Tommi Rantala (3):
>      perf top: Fix stdio interface input handling with glibc 2.28+
>      perf bench futex-wake: Restore thread count default to online CPU co=
unt
>      perf bench: Clear struct sigaction before sigaction() syscall
>
>Tony Luck (1):
>      x86/mce: Fix logic and comments around MSR_PPIN_CTL
>
>Tycho Andersen (1):
>      cgroup1: don't call release_agent when it is ""
>
>Ulf Hansson (5):
>      mmc: core: Allow host controllers to require R1B for CMD6
>      mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
>      mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>      mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BU=
SY
>      mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
>
>Vasily Averin (6):
>      cgroup-v1: cgroup_pidlist_next should update position index
>      cgroup: cgroup_procs_next should increase position index
>      netfilter: nf_conntrack: ct_cpu_seq_next should increase position in=
dex
>      netfilter: synproxy: synproxy_cpu_seq_next should increase position =
index
>      netfilter: xt_recent: recent_seq_next should increase position index
>      netfilter: x_tables: xt_mttg_seq_next should increase position index
>
>Vasundhara Volam (1):
>      bnxt_en: reinitialize IRQs when MTU is modified
>
>Vineet Gupta (2):
>      ARC: fpu: fix randconfig build error reported by 0-day test service
>      ARC: show_regs: reduce lines of output
>
>Vinicius Costa Gomes (1):
>      taprio: Fix sending packets without dequeueing them
>
>Vishal Kulkarni (1):
>      cxgb4: fix checks for max queues to allocate
>
>Vitaly Kuznetsov (3):
>      KVM: x86: clear stale x86_emulate_ctxt->intercept value
>      KVM: x86: remove stale comment from struct x86_emulate_ctxt
>      KVM: nVMX: avoid NULL pointer dereference with incorrect EVMCS GPAs
>
>Vladimir Oltean (2):
>      net: dsa: sja1105: Don't destroy not-yet-created xmit_worker
>      net: mscc: ocelot: properly account for VLAN header length when
>setting MRU
>
>Vladis Dronov (2):
>      efi: Fix a race and a buffer overflow while reading efivars via sysfs
>      efi: Add a sanity check to efivar_store_raw()
>
>Wanpeng Li (1):
>      KVM: X86: Fix dereference null cpufreq policy
>
>Wen Xiong (1):
>      scsi: ipr: Fix softlockup when rescanning devices in petitboot
>
>Willem de Bruijn (1):
>      net/packet: tpacket_rcv: do not increment ring index on drop
>
>Wolfram Sang (2):
>      macintosh: windfarm: fix MODINFO regression
>      i2c: acpi: put device when verifying client fails
>
>Yangtao Li (1):
>      auxdisplay: img-ascii-lcd: convert to devm_platform_ioremap_resource
>
>Yonghyun Hwang (1):
>      iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge page
>
>Yonglong Liu (1):
>      net: hns3: fix "tc qdisc del" failed issue
>
>You-Sheng Yang (1):
>      r8152: check disconnect status after long sleep
>
>Zhenyu Wang (1):
>      drm/i915/gvt: Fix unnecessary schedule timer when no vGPU exits
>
>Zhenzhong Duan (1):
>      iommu/vt-d: Fix the wrong printing in RHSA parsing

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl5vRHwACgkQsjqdtxFL
KRWkyAgAyob6OQ0qzBkBWG8d2R2+TtW21yvX66QgWOvIU3e9vGP+tTjqKK7+92aB
SgrcpSKdi2FfodH73l0f857+kAvkXrcCeUR5fAVzzoXpNFzfyaAFiDns4mGyt1s6
AXdqkO++KQoOefgCC25IVQDsvt7no9s8TMiXjdRGyxw3UlyU1ONqbUkR1rGeHIV2
HZpgdUe/VcbqjtSbsaWWzWtFtJkK6CgAxy/uAOFRfUdSl3ADM0/9pp7L0MFY9chY
frkkgfDKAcEhyfzh/Ogl56790UCnaVXe/w/h6QtkgUpVeRi0j66GIQXhVSE/TCkN
x8E7u7XSB2SQfPiVAUxs7O700OpVlQ==
=5miH
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
