Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399DF2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494476;
	bh=ANCtn+AqrVoqXK8gIeKZzyV4OK17LI5KeXkQ+B1zwmg=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=U7SzkATPk86/O2oUJGkEk/KPveBVTdLx8LMtKpDqmNJYTZfrv4ma9yUIzbe9EGXDF
	 JP4upUXebXsbYIZP5A0gN107utxPpILGFz6xRBq2/6bZOYrAL0rqsyv6D+Fa7yo9v7
	 qhkXcSmAFNpEUe55RFaaSHNga0uFInWilpxiW9KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgIGQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbgIGQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:00:18 -0400
Received: from mail.kernel.org (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7153A21897;
        Mon,  7 Sep 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494379;
        bh=ANCtn+AqrVoqXK8gIeKZzyV4OK17LI5KeXkQ+B1zwmg=;
        h=From:To:Cc:Subject:Date:From;
        b=i3JR/5AnCkvxkXl9IzkDKNpONVXnsOYFK5jkLYMIYUjlLlEmwjI1z5DuvQC4zi/fv
         K3NBAVFqx4Tut3AvaRAqlfaeelZTtNmkL4tcUrQ9FD0CJCuLLCiDHxFQT0ckP/rTpD
         h07kQhVqEuQGpHoF59zQFBEQ6nyjoElL4tD0OIEg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFJYP-00ATuf-3b; Mon, 07 Sep 2020 17:59:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>, Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v2 00/11] Add USB support for Hikey 970
Date:   Mon,  7 Sep 2020 17:59:24 +0200
Message-Id: <cover.1599493845.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PHY layer for Hikey 970 and a misc driver that it is
required for the USB hub to work. The same USB hub is needed
by Hikey 960. 

That's the second version, addressing the points raised by
Mark on the RFC version and adding an extra patch in order for
it to use the dwc3-of-simple driver. Such binding is required,
as using dwc3 directly causes an Serror on ARM.

-

PS.: I'll be sending the dts bindings later on. We need first to
add a small quirk to dwc3:

    https://patchwork.kernel.org/patch/10909965/

I'll be sending a newer version of this specific patch probably
tomorrow.

Mauro Carvalho Chehab (8):
  phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
  phy: hisilicon: phy-hi3670-usb3: fix coding style
  phy: hisilicon: phy-hi3670-usb3: change some DT properties
  dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
  MAINTAINERS: add myself as maintainer for Kirin 970 USB PHY
  misc: hisi_hikey_usb: add support for Hikey 970
  dwc3-of-simple: add support for Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

Yu Chen (3):
  phy: hisilicon: add USB physical layer for Kirin 3670
  phy: hisilicon: phy-hi3670-usb3: fix some issues at the init code
  misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on
    Hikey960

 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  72 ++
 MAINTAINERS                                   |  16 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 102 +++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 274 +++++++
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c             |   4 +-
 11 files changed, 1216 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c

-- 
2.26.2


