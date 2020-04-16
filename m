Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A8F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044593;
	bh=waxjwsUxMpAJQV3TodVhI9ljrf0utE6GoyP7N1UZFnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rlcmj/tkp2iSWdhah67BkaKYg/kg7zdsg9V1cGMTNWp1Z1g7Bn69/v2QI2K0PAw0f
	 L9iqeqHGHmR2JaOwz/fwVVMMTFaWINzL/n18sMZQxLWB+6RA11UMbYkgmaet5FSCzj
	 eE2HBDw88vjGIFwrWKc65fCrGCjF/it3jTqSarpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgDPNnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896718AbgDPNdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C36208E4;
        Thu, 16 Apr 2020 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044017;
        bh=waxjwsUxMpAJQV3TodVhI9ljrf0utE6GoyP7N1UZFnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocN7UUon5Lvmm/eFzSRwwVQx289JBpfuAlFS4mywgSSTyPptC2z0lngkU1ZZFDXBr
         kpOD0eKgZu7o0gLGs2zgTKTOwyP27r9oniCOdN2/B2Qz/IWB8Klnb1KxcbWR9RPwWO
         K8AexPoC+hz0epq8I+gmQVGMgJeSZDUD7wb4wMyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ajay Gupta <ajayg@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 030/257] usb: ucsi: ccg: disable runtime pm during fw flashing
Date:   Thu, 16 Apr 2020 15:21:21 +0200
Message-Id: <20200416131329.714855676@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Gupta <ajayg@nvidia.com>

[ Upstream commit 57a5e5f936be583d2c6cef3661c169e3ea4bf922 ]

Ucsi ppm is unregistered during fw flashing so disable
runtime pm also and reenable after fw flashing is completed
and ppm is re-registered.

Signed-off-by: Ajay Gupta <ajayg@nvidia.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20200217144913.55330-3-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 3370b3fc37b10..bd374cea3ba6c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1032,6 +1032,7 @@ static int ccg_restart(struct ucsi_ccg *uc)
 		return status;
 	}
 
+	pm_runtime_enable(uc->dev);
 	return 0;
 }
 
@@ -1047,6 +1048,7 @@ static void ccg_update_firmware(struct work_struct *work)
 
 	if (flash_mode != FLASH_NOT_NEEDED) {
 		ucsi_unregister(uc->ucsi);
+		pm_runtime_disable(uc->dev);
 		free_irq(uc->irq, uc);
 
 		ccg_fw_update(uc, flash_mode);
-- 
2.20.1



