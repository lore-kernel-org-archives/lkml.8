Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34186C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B59E2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHWWHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:07:49 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:58002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgHWWHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:07:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 256A0180A7FF5;
        Sun, 23 Aug 2020 22:07:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw46_5206e912704e
X-Filterd-Recvd-Size: 2585
Received: from XPS-9350 (unknown [172.58.43.36])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Aug 2020 22:07:42 +0000 (UTC)
Message-ID: <a6763ea3eba3cbcf27ffd4584d4daf9cc1759d35.camel@perches.com>
Subject: Re: [PATCH 0/8] drivers: phy: Constify static phy_ops structs
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Seungwon Jeon <essuuj@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Date:   Sun, 23 Aug 2020 15:07:39 -0700
In-Reply-To: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 00:00 +0200, Rikard Falkeborn wrote:
> This series constifies all static phy_ops structs in drivers/phy.
> Typically the only usage is to pass the address of it to devm_phy_create()
> which takes a const pointer. The lone exception is in
> drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c where the address of the
> structs is assigned to the data-field in of_device_id, which is a const
> void pointer.
> 
> Making the structs const allows the compiler to put them in read-only
> memory.
> 
> The patches are all independent of each other, and have been
> compile-tested only.

Perhaps add phy_ops to scripts/const_structs.checkpatch too
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index e9df9cc28a85..cd45cb3c2b04 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -39,6 +39,7 @@ nlmsvc_binding
 nvkm_device_chip
 of_device_id
 pci_raw_ops
+phy_ops
 pipe_buf_operations
 platform_hibernation_ops
 platform_suspend_ops


