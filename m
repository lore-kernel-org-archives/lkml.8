Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF447C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61B22072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582322109;
	bh=+mAUREOIHQwn2N/zVPuH0U43QCGlpcGypzfp/5SEQoY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IIxpS7OLhNHBU/7YmPVelmqb0nylMiCx3LJnLlYBeWzuvALTyjtLvnBYZsr1PG8ms
	 8rqcVXveIid/GUDTFN/CNPqk8I9qfY7Y/S21HKcOlRTqsd8bCkqL4r1/Gz1OrM5F7c
	 MmZZPTLUfpi53aCIT+6sHleGrPWn8gNJClsBx1uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBUVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:55:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39276 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:55:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so146021oij.6;
        Fri, 21 Feb 2020 13:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L0qLsi8ILOq4kINyXNbO2zWbE0zr6+y+owQgTraSZ40=;
        b=ZNXyOWY3N6Z5hck73aS5kfmR+oFlUPVUtM85vUmXZ4rwrlR4eQfZoh4DcdUhGtfSY5
         AkXQbr/4tXlQQYKPF3oX+I1CxxmuaBl1zB1IG3wS70d4XEHQRCTnPMd5hgVYtfN3Hz3r
         VXRK52MGU1B3JpeTWJjLpRxBiSIctD6K2j2Qn59AsvUoCcB2xjDrXzk2XBWhQMGW1Waj
         Q/MSFi/oq4zHiOYzU5aqm9NgsF4mH+8ugEqdKiy+rMnHEs975PtMDJsvKKle3+jWL+ng
         UDrCNmSICkLFedpX40FSwjh8qaSZq2baKJWln+oCp9CM5O3JJk+t6ncLx8SswWY6dFgg
         iZXA==
X-Gm-Message-State: APjAAAXu5Sc7liUUeVh4Bki52fviYRAFy8bG0m2NVC+pG8PwMdB7Gcrk
        XOecZjZWo5DENm78DuNKBQ==
X-Google-Smtp-Source: APXvYqwqREhpY0NmIv7IV7c2medvJ/hjN0SYZUUclDdLrtr7UCt9bj55fLCg9BURNa6eVRSzwCt0AQ==
X-Received: by 2002:a05:6808:4d3:: with SMTP id a19mr3594865oie.119.1582322106157;
        Fri, 21 Feb 2020 13:55:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm1331155oih.54.2020.02.21.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:55:04 -0800 (PST)
Received: (nullmailer pid 27971 invoked by uid 1000);
        Fri, 21 Feb 2020 21:55:03 -0000
Date:   Fri, 21 Feb 2020 15:55:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.6, part 2
Message-ID: <20200221215503.GA26346@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes for 5.6.

Rob

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-2

for you to fetch changes up to 854bdbae9058bcf09b0add70b6047bc9ca776de2:

  dt-bindings: media: csi: Fix clocks description (2020-02-19 19:03:44 -0600)

----------------------------------------------------------------
Devicetree fixes for 5.6, part 2:

A handful of fixes in DT bindings for MDIO bus, Allwinner CSI, OMAP
HSMMC, and Tegra124 EMC.

----------------------------------------------------------------
Grygorii Strashko (1):
      dt-bindings: net: mdio: remove compatible string from example

Maxime Ripard (2):
      dt-bindings: media: csi: Add interconnects properties
      dt-bindings: media: csi: Fix clocks description

Thierry Reding (1):
      dt-bindings: memory-controller: Update example for Tegra124 EMC

Tomas Paukrt (1):
      dt-bindings: mmc: omap-hsmmc: Fix SDIO interrupt

 .../bindings/media/allwinner,sun4i-a10-csi.yaml    | 40 +++++++++++++++-------
 .../memory-controllers/nvidia,tegra124-emc.yaml    | 20 ++++++-----
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  2 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |  1 -
 4 files changed, 41 insertions(+), 22 deletions(-)
