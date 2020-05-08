Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F0C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6232A2495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588947546;
	bh=loYZ0ETfyzFzT1Li0r8PdjuUJW+Y7T3jq5s2CY+tliY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZKO/lJmffKgRSZIreQ4iI5h9obKk980ieU6lMkofWF9XVjLqqhn4TQanAVK9eJUdM
	 wCAcggrC4Ou5Cgp94KIC4C2hsEQWJZ6rtaiwI79Toql6gJqypS7iQEDDGqZU2nC5cB
	 IA+qBay86jKo0pFVEVLFrWpOrvHCX+lTJBFcyWyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEHOTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgEHOTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:19:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBB024957;
        Fri,  8 May 2020 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947544;
        bh=loYZ0ETfyzFzT1Li0r8PdjuUJW+Y7T3jq5s2CY+tliY=;
        h=Date:From:To:Cc:Subject:From;
        b=z/7EL+iv6lkU1ikd4fO20PLfeqIK7Sts29YEcHooTBIaAn+Ppl+cR1fYXDZD9C1kO
         oFlEcTFMFErJnXVFXlU4mkBZXfNRYz3rCzl6kGavFHlVO9BL3Nc9prITDK9JMWvr5S
         wHcRjK/W8LKU3RK8aZ+BlYHI3AL9eRZeOHF0nTJU=
Date:   Fri, 8 May 2020 16:19:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.7-rc5
Message-ID: <20200508141902.GA360776@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc5

for you to fetch changes up to f0e1d3ac2d7c16a5d2c9d67f5a61133db7681af8:

  bus: mhi: core: Fix channel device name conflict (2020-05-05 16:59:54 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.7-rc5

Here are some small driver fixes for 5.7-rc5 that resolve a number of
minor reported issues:
	- mhi bus driver fixes found as people actually use the code
	- phy driver fixes and compat string additions
	- most driver fix due to link order changing when the core moved
	  out of staging
	- mei driver fix
	- interconnect build warning fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bjorn Andersson (1):
      phy: qualcomm: usb-hs-28nm: Prepare clocks in init

ChenTao (1):
      interconnect: qcom: Move the static keyword to the front of declaration

Christian Gromm (1):
      most: core: use function subsys_initcall()

Dan Carpenter (1):
      bus: mhi: core: Fix a NULL vs IS_ERR check in mhi_create_devices()

Greg Kroah-Hartman (1):
      Merge tag 'phy-for-5.7-rc' of git://git.kernel.org/.../phy/linux-phy into char-misc-linus

Jeffrey Hugo (5):
      bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
      bus: mhi: core: Remove link_status() callback
      bus: mhi: core: Offload register accesses to the controller
      bus: mhi: core: Fix typo in comment
      bus: mhi: core: Fix channel device name conflict

John Stultz (1):
      phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string

Kishon Vijay Abraham I (1):
      MAINTAINERS: Add Vinod Koul as Generic PHY co-maintainer

Manivannan Sadhasivam (1):
      bus: mhi: Fix parsing of mhi_flags

Thierry Reding (1):
      phy: tegra: Select USB_COMMON for usb_get_maximum_speed()

Tomas Winkler (1):
      mei: me: disable mei interface on LBG servers.

 MAINTAINERS                                 |  3 ++-
 drivers/bus/mhi/core/init.c                 |  7 +++----
 drivers/bus/mhi/core/internal.h             |  3 ---
 drivers/bus/mhi/core/main.c                 | 18 +++++-----------
 drivers/bus/mhi/core/pm.c                   |  6 +++++-
 drivers/interconnect/qcom/osm-l3.c          |  4 ++--
 drivers/interconnect/qcom/sdm845.c          | 16 +++++++--------
 drivers/misc/mei/hw-me.c                    |  8 ++++++++
 drivers/misc/mei/hw-me.h                    |  4 ++++
 drivers/misc/mei/pci-me.c                   |  2 +-
 drivers/most/core.c                         |  2 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c       |  7 +++++++
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c | 32 +++++++++++++++++++----------
 include/linux/mhi.h                         | 16 +++++++++------
 14 files changed, 77 insertions(+), 51 deletions(-)
