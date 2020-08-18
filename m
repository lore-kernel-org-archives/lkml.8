Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D70FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D259C207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762798;
	bh=j3f7WJfp8SurLGvi2nn0r3BHGS0p/oeGbNNKAllTuzY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uA3+zw0LWlvfWa+NlIVHB9Rmv2ByVSEiqrD5Clx1Y7DHC4tUwy3NEijc7vv6tIllc
	 IGlEce3bLuNUrRtscDiShjG8jo65NgzpuLILXBUF1gyjpZBRBfUYyCOwXoa4d8F/Xc
	 ndOTHbiSbvr7ip0hHuyOAm12rCEjPMFHYX3Kbttc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHRO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgHRO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:05 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E71C2083B;
        Tue, 18 Aug 2020 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=j3f7WJfp8SurLGvi2nn0r3BHGS0p/oeGbNNKAllTuzY=;
        h=From:To:Cc:Subject:Date:From;
        b=Vwfl1v+G1X9K1M69UD+cfTSCEQF79Q0U+2pl4ZJZ3Et2M9+qwmMHy6wxIk2dZC0WW
         JBZZ2ycyfF1DLX94PmN2EEurYyKgnAHjgly5XQxeVbN0Qu1sEKxa07dTltZH21cGfv
         Eyyppm78qNMlINE4pXEBcAHi0US/oGqAoQ27G3+c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAa-03; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 0/6] Do some cleanups at the HiSilicon 6421 regulator
Date:   Tue, 18 Aug 2020 16:58:52 +0200
Message-Id: <cover.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Patch 1 contains  a Kconfig fixup, addressing the problem you noticed
when building those drivers;

Patches 2 to 4 addresses some issues at the device tree,  pointed by
Rob's review.

Patch 5 adds the DT documentation. As requested, I moved those
also to the staging dir.

Patch 6 adds an entry at MAINTAINERS. I changed the ML to point
to the devel ML.

Thanks!
Mauro


Mauro Carvalho Chehab (6):
  staging: hikey9xx: fix Kconfig dependency chain
  staging: mfd: hi6421-spmi-pmic: get rid of interrupt properties
  staging: spmi: hisi-spmi-controller: change compatible string
  staging: mfd: hi6421-spmi-pmic: Simplify the compatible string
  dt: document HiSilicon SPMI controller and mfd/regulator properties
  MAINTAINERS: add an entry for HiSilicon 6421v600 drivers

 MAINTAINERS                                   |   6 +
 drivers/staging/hikey9xx/Kconfig              |   4 +-
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   |  82 +++------
 .../staging/hikey9xx/hisi-spmi-controller.c   |   3 +-
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 159 ++++++++++++++++++
 .../hisilicon,hisi-spmi-controller.yaml       |  62 +++++++
 include/linux/mfd/hi6421-spmi-pmic.h          |  15 --
 7 files changed, 253 insertions(+), 78 deletions(-)
 create mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml

-- 
2.26.2


