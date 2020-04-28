Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C858C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602FD20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099436;
	bh=JHaBNosCj1zG89vJZojwMlcYslKrzJGKsmuORnY+RAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=siD/3F5cNVkyRbr5HDQeorAQp+BcLra2a0IfpHZH54ErkYOyQvMo2w5pj57Qzeq+v
	 oLf/kvG1J6v7ndst/faRbPRfYx8VuI7cNg26ZorIDmlce0X0mL0Fhoi4PLXYFHdX0R
	 mFX1we/SiqH2Z5Jx10bXGlemx6UiZq2FRO33d2eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgD1Snz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731308AbgD1Snx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:43:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E14120730;
        Tue, 28 Apr 2020 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099432;
        bh=JHaBNosCj1zG89vJZojwMlcYslKrzJGKsmuORnY+RAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/MOFL4/lAVvBdjEywzdXLLUanhXKF+pEF/OF92iCwFOXxdSU7XRa5SpVTkd4HUvO
         Irzkx+tHfJu930vdVLKovZ9QVkpCgHopb17FkAIW66Hlzb1aVCB5/kSTjT5zSx9hhO
         OTuffFecoOf+sQwQOc/cVGWKRtWgc3ElSbyINMZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 5.4 149/168] fpga: dfl: pci: fix return value of cci_pci_sriov_configure
Date:   Tue, 28 Apr 2020 20:25:23 +0200
Message-Id: <20200428182250.362259288@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

commit 3c2760b78f90db874401d97e3c17829e2e36f400 upstream.

pci_driver.sriov_configure should return negative value on error and
number of enabled VFs on success. But now the driver returns 0 on
success. The sriov configure still works but will cause a warning
message:

  XX VFs requested; only 0 enabled

This patch changes the return value accordingly.

Cc: stable@vger.kernel.org
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/fpga/dfl-pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -248,11 +248,13 @@ static int cci_pci_sriov_configure(struc
 			return ret;
 
 		ret = pci_enable_sriov(pcidev, num_vfs);
-		if (ret)
+		if (ret) {
 			dfl_fpga_cdev_config_ports_pf(cdev);
+			return ret;
+		}
 	}
 
-	return ret;
+	return num_vfs;
 }
 
 static void cci_pci_remove(struct pci_dev *pcidev)


