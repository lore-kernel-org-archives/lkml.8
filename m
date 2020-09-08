Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29BAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC1A21D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599549668;
	bh=xVxVAtIHJcO6KUDLBsqaTImTwuMgwUwnIEbsGDNDDvI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0r+2VztUuJ9ouWEsQwTxgjRvH+nxHGA4kVDtup4PT+U0HD04RNngRgpyqr47FJ764
	 3EkGevyE9elkSpzivEPHVH0XLulmVy618PM5merWMOWMUmFO5pSWfVwX4mGhW7sNLl
	 NEMezEf6pD+2uox7A9etcJ6MZJhWaZxMYtPZ6Ptg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgIHHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgIHHVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:21:04 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6900521D42;
        Tue,  8 Sep 2020 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599549664;
        bh=xVxVAtIHJcO6KUDLBsqaTImTwuMgwUwnIEbsGDNDDvI=;
        h=From:To:Cc:Subject:Date:From;
        b=gDattiwIJ9kvnvaLvHyrlCjlIfTNE+KPZ4aOsRzrTCFUNLAQPPy8TNnVyaOZesMwU
         2LLhi/WXS/z3H2/+9KwI3tXFP53gpc4/bEAIX3V1awgpGiIcQJA0hFyXulDNWcRq6a
         HXkY9rjBpYYfFuGtKXD8g0i3XqL7Q0HunpYj/H2E=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFXw5-00Axvl-3g; Tue, 08 Sep 2020 09:21:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/2] Add a quirk for dwc3 driver, requred for Hikey 970 USB to work
Date:   Tue,  8 Sep 2020 09:20:55 +0200
Message-Id: <cover.1599549364.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series add a new quirk for the dwc3 driver. The first patch
was submitted previously to the USB mailing list:

	https://patchwork.kernel.org/patch/10909965/

This quirk is also present at the official Linaro's tree for Hikey 970.

Without that, the URBs produced by the USB HID driver returns -EPROTO
errors, causing an endless reset loop, on every 0.5 seconds.

Please notice that I don't have any documentation about Synopsys
dwc3 driver. So, I tried my best to document this quirk at patch 2,
but I can't add anything more specifics, as I don't have any datasheets
from such IP.

Mauro Carvalho Chehab (1):
  dt-bindings: document a new quirk for dwc3

Yu Chen (1):
  usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc

 .../devicetree/bindings/usb/dwc3.txt          |  3 +++
 drivers/usb/dwc3/core.c                       | 25 +++++++++++++++++++
 drivers/usb/dwc3/core.h                       |  7 ++++++
 3 files changed, 35 insertions(+)

-- 
2.26.2


