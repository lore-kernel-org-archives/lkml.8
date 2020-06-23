Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C99721789
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945216;
	bh=59jA0oNncv0x0JQccgTKX289yT7ZzuYlpsORMXSLXkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZbiCpx98rqTT3nmDGnNUlLqFSRiZMgoCL3Gpiy3L1V5WcECtsGl49f9a/EPydO+Pk
	 8ydNykQQODWe3RhABHirWQ5o8BhpNWUNkVQail4wwj4hNyp3Y/hs36EDpK/jZ8f/a+
	 tRt+tXFJbvm8z7TpBwnLu+k6KZIgMviJBy5edAT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbgFWUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390467AbgFWUqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378AC2098B;
        Tue, 23 Jun 2020 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945198;
        bh=59jA0oNncv0x0JQccgTKX289yT7ZzuYlpsORMXSLXkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdpEcFKDMnWMjDkumBTZVPt/tNFuNSX/mudSCSM7VRUWuI9Se1eCM9MLIVIj2DJSm
         e3nsH+8taKGwwKay0rpGlciMv5+lWUVvrI0VKXnHO1oLNOjsAR1Exgh59qONpWO5Mn
         NesAORC06DsB+tqLIkkaRnZ6+acjtcR3wplh9heY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/136] scsi: ufs-qcom: Fix scheduling while atomic issue
Date:   Tue, 23 Jun 2020 21:58:54 +0200
Message-Id: <20200623195307.630309589@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 3be60b564de49875e47974c37fabced893cd0931 ]

ufs_qcom_dump_dbg_regs() uses usleep_range, a sleeping function, but can be
called from atomic context in the following flow:

ufshcd_intr -> ufshcd_sl_intr -> ufshcd_check_errors ->
ufshcd_print_host_regs -> ufshcd_vops_dbg_register_dump ->
ufs_qcom_dump_dbg_regs

This causes a boot crash on the Lenovo Miix 630 when the interrupt is
handled on the idle thread.

Fix the issue by switching to udelay().

Link: https://lore.kernel.org/r/20200525204125.46171-1-jeffrey.l.hugo@gmail.com
Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index f2b8de195d8af..ee3589ac64abf 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1649,11 +1649,11 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 
 	/* sleep a bit intermittently as we are dumping too much data */
 	ufs_qcom_print_hw_debug_reg_all(hba, NULL, ufs_qcom_dump_regs_wrapper);
-	usleep_range(1000, 1100);
+	udelay(1000);
 	ufs_qcom_testbus_read(hba);
-	usleep_range(1000, 1100);
+	udelay(1000);
 	ufs_qcom_print_unipro_testbus(hba);
-	usleep_range(1000, 1100);
+	udelay(1000);
 }
 
 /**
-- 
2.25.1



