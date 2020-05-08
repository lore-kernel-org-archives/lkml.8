Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E23206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942873;
	bh=cd+7HMZN8OT6QdNF6oEqC5venb6bwQLXWhuMV7hGVTM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=twmgOCC8pRrVKfK466K1aTsCvDdtvV53A/I3/eIN78TVwyPMJLcTsvqh8tnpBGezw
	 cyW1kyfXN8gvv4FJQHoNGwODUjfuR0SiLwQ084WEgVQPN0jmBB8FkKL1PEgKMRKLyX
	 pkM1xqndTicSHq1ZOJBKSnRMwX/RD4RvzRcqmBeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgEHNBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbgEHMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:52:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A5D218AC;
        Fri,  8 May 2020 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942325;
        bh=cd+7HMZN8OT6QdNF6oEqC5venb6bwQLXWhuMV7hGVTM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ffz2trp6hGxIsGogZmkwZgvqXbR3/H3YSIuCBi76rZ04ISM9B+q9cegMpMUzZ8XTo
         FC+vB6Ph21UO+6IZilG4hI1r7F8kBQ4leVH3hMrzBvpFqaQWmK8kOaKp1CsMuiNEgW
         jrpwb1dik5VYWJ1+fNn+9EQ5A22lS7d7l3i/KTpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/32] 4.19.122-rc1 review
Date:   Fri,  8 May 2020 14:35:13 +0200
Message-Id: <20200508123034.886699170@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.122-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.122-rc1
X-KernelTest-Deadline: 2020-05-10T12:30+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.122 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 10 May 2020 12:29:44 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.122-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.122-rc1

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/atomic: Take the atomic toys away from X

Jiri Slaby <jslaby@suse.cz>
    cgroup, netclassid: remove double cond_resched

Thomas Pedersen <thomas@adapt-ip.com>
    mac80211: add ieee80211_is_any_nullfunc()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: GPD pocket fan: Fix error message when temp-limits are out of range

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Match both PCI ID and SSID for driver blacklist

Nick Desaulniers <ndesaulniers@google.com>
    hexagon: define ioremap_uc

Christoph Hellwig <hch@lst.de>
    hexagon: clean up ioremap

Tuowen Zhao <ztuowen@gmail.com>
    mfd: intel-lpss: Use devm_ioremap_uc for MMIO

Tuowen Zhao <ztuowen@gmail.com>
    lib: devres: add a helper function for ioremap_uc

Aaron Ma <aaron.ma@canonical.com>
    drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event

Jere Leppänen <jere.leppanen@nokia.com>
    sctp: Fix SHUTDOWN CTSN Ack in the peer restart case

Doug Berger <opendmb@gmail.com>
    net: systemport: suppress warnings on failed Rx SKB allocations

Doug Berger <opendmb@gmail.com>
    net: bcmgenet: suppress warnings on failed Rx SKB allocations

Nathan Chancellor <natechancellor@gmail.com>
    lib/mpi: Fix building for powerpc with clang

Jeremie Francois (on alpha) <jeremie.francois@gmail.com>
    scripts/config: allow colons in option strings for sed

Philipp Rudo <prudo@linux.ibm.com>
    s390/ftrace: fix potential crashes when switching tracers

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: protect updating server->dstaddr with a spinlock

Matthias Blankertz <matthias.blankertz@cetitec.com>
    ASoC: rsnd: Fix "status check failed" spam for multi-SSI

Matthias Blankertz <matthias.blankertz@cetitec.com>
    ASoC: rsnd: Don't treat master SSI in multi SSI setup as parent

Julien Beraud <julien.beraud@orolia.com>
    net: stmmac: Fix sub-second increment

Julien Beraud <julien.beraud@orolia.com>
    net: stmmac: fix enabling socfpga's ptp_ref_clock

Xiyu Yang <xiyuyang19@fudan.edu.cn>
    wimax/i2400m: Fix potential urb refcnt leak

Sandeep Raghuraman <sandy.8925@gmail.com>
    drm/amdgpu: Correctly initialize thermal controller for GPUs with Powerplay table v0 (e.g Hawaii)

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: codecs: hdac_hdmi: Fix incorrect use of list_for_each_entry

Matthias Blankertz <matthias.blankertz@cetitec.com>
    ASoC: rsnd: Fix HDMI channel mapping for multi-SSI mode

Matthias Blankertz <matthias.blankertz@cetitec.com>
    ASoC: rsnd: Fix parent SSI start/stop in multi-SSI mode

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Properly set maxpacket limit

Sebastian Reichel <sebastian.reichel@collabora.com>
    ASoC: sgtl5000: Fix VAG power-on handling

Tyler Hicks <tyhicks@linux.microsoft.com>
    selftests/ipc: Fix test failure seen after initial test run

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: topology: Check return value of pcm_new_ver

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/pci/of: Parse unassigned resources

Jia He <justin.he@arm.com>
    vhost: vsock: kick send_pkt worker once device is started


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/hexagon/include/asm/io.h                      | 12 ++---
 arch/hexagon/kernel/hexagon_ksyms.c                |  2 +-
 arch/hexagon/mm/ioremap.c                          |  2 +-
 arch/powerpc/kernel/pci_of_scan.c                  | 12 ++++-
 arch/s390/kernel/diag.c                            |  2 +-
 arch/s390/kernel/smp.c                             |  4 +-
 arch/s390/kernel/trace.c                           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  3 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  | 26 +++++++++++
 drivers/gpu/drm/drm_ioctl.c                        |  7 ++-
 drivers/mfd/intel-lpss.c                           |  2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  3 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  9 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 12 +++--
 drivers/net/wimax/i2400m/usb-fw.c                  |  1 +
 drivers/platform/x86/gpd-pocket-fan.c              |  2 +-
 drivers/usb/dwc3/core.h                            |  4 ++
 drivers/usb/dwc3/gadget.c                          | 52 +++++++++++++++++-----
 drivers/vhost/vsock.c                              |  5 +++
 fs/cifs/connect.c                                  |  2 +
 include/linux/ieee80211.h                          |  9 ++++
 include/linux/io.h                                 |  2 +
 lib/devres.c                                       | 19 ++++++++
 lib/mpi/longlong.h                                 | 34 +++++++-------
 net/core/netclassid_cgroup.c                       |  4 +-
 net/mac80211/mlme.c                                |  2 +-
 net/mac80211/rx.c                                  |  8 ++--
 net/mac80211/status.c                              |  5 +--
 net/mac80211/tx.c                                  |  2 +-
 net/sctp/sm_make_chunk.c                           |  6 ++-
 scripts/config                                     |  5 ++-
 sound/pci/hda/hda_intel.c                          |  9 ++--
 sound/soc/codecs/hdac_hdmi.c                       |  6 +--
 sound/soc/codecs/sgtl5000.c                        | 34 ++++++++++++++
 sound/soc/codecs/sgtl5000.h                        |  1 +
 sound/soc/sh/rcar/ssi.c                            | 11 ++++-
 sound/soc/sh/rcar/ssiu.c                           |  2 +-
 sound/soc/soc-topology.c                           |  4 +-
 tools/testing/selftests/ipc/msgque.c               |  2 +-
 41 files changed, 250 insertions(+), 86 deletions(-)


