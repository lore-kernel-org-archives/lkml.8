Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6ACC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A271206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599299296;
	bh=q9hHeNfdmmBESDQ+NBQkYcYrFydynelEFh0AsG82ahc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bQo8IQuoJqnP138dMzOfk8/+2YTB67keFKaJxdN61G0k3iVeZY0TKBV5LRz9p6XBC
	 W8BUa3cA4H+ldFdDfBB/xiaemOh3hlVro4yrpqwBe9Lnt9h606P4nuxRRSdZBQSlll
	 gT9lNsF5fIchxe6PsIA25bg0rLzkuQyKDU9L8ibw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgIEJsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIEJsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 05:48:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C5220757;
        Sat,  5 Sep 2020 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599299291;
        bh=q9hHeNfdmmBESDQ+NBQkYcYrFydynelEFh0AsG82ahc=;
        h=From:To:Cc:Subject:Date:From;
        b=rYVW4QOww5raXKMYefedzZI4wFFYt9tMjdQ+LttdoVS/EENTgJPc2OSHBKMsCXacm
         Kj3pKfQQ/SzOxIQvUsB+3mfgwQ1jtQlO+tuJwJfmOtnLDaLJUqYDMZ4Qhj2lSFsr2y
         +EIzGUJ3cB6bwMBeimapJsXSjQJP3LIEkl6QjAvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.63
Date:   Sat,  5 Sep 2020 11:48:29 +0200
Message-Id: <159929930931111@kroah.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.63 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt |   32 ++++
 Makefile                                                       |    2 
 arch/arm64/boot/dts/nvidia/tegra186.dtsi                       |   20 +--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                       |   15 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi                       |   20 +--
 arch/arm64/include/asm/kvm_arm.h                               |    3 
 arch/arm64/include/asm/kvm_asm.h                               |   43 ++++++
 arch/arm64/kernel/vmlinux.lds.S                                |    8 +
 arch/arm64/kvm/hyp/entry.S                                     |   15 +-
 arch/arm64/kvm/hyp/hyp-entry.S                                 |   65 ++++++----
 arch/arm64/kvm/hyp/switch.c                                    |   39 +++++-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                       |   60 ++++++++-
 drivers/gpu/drm/etnaviv/state_blt.xml.h                        |    2 
 drivers/gpu/drm/scheduler/sched_main.c                         |    7 -
 drivers/hid/hid-core.c                                         |   15 ++
 drivers/hid/hid-input.c                                        |    4 
 drivers/hid/hid-multitouch.c                                   |    2 
 drivers/mmc/host/sdhci-tegra.c                                 |    2 
 drivers/target/target_core_user.c                              |   15 +-
 include/linux/hid.h                                            |   42 ++++--
 tools/perf/Documentation/perf-record.txt                       |    4 
 tools/perf/Documentation/perf-stat.txt                         |    4 
 22 files changed, 328 insertions(+), 91 deletions(-)

Andrey Grodzovsky (1):
      drm/sched: Fix passing zero to 'PTR_ERR' warning v2

Bodo Stroesser (2):
      scsi: target: tcmu: Fix size in calls to tcmu_flush_dcache_range
      scsi: target: tcmu: Optimize use of flush_dcache_page

Greg Kroah-Hartman (1):
      Linux 5.4.63

James Morse (3):
      KVM: arm64: Add kvm_extable for vaxorcism code
      KVM: arm64: Survive synchronous exceptions caused by AT instructions
      KVM: arm64: Set HCR_EL2.PTW to prevent AT taking synchronous exception

Kim Phillips (1):
      perf record/stat: Explicitly call out event modifiers in the documentation

Lucas Stach (1):
      drm/etnaviv: fix TS cache flushing on GPUs with BLT engine

Marc Zyngier (2):
      HID: core: Correctly handle ReportSize being zero
      HID: core: Sanitize event code and type when mapping input

Sowjanya Komatineni (6):
      dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
      arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
      arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
      arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186

