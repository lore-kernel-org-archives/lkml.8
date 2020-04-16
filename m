Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42F3206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049578;
	bh=veCBmgdRybGO47FNkFF3zVpn19J+P2jgtZGRswXSyFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UabEIYjr86KtINZSKnyWmvavkBGSmUrQzmbd9Mklo2dPabkiP1BOtwNJbJkhMD1Nx
	 kX+6KFzKcgOt1vgYMfqnO1c7OLf5Mx6c++cDOzM87V2Baci3topQLa1xW6I90uKapD
	 H+vNtEB0Deg7MQ7JxU/1HUDHLP/qn1PUhaLbTYGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgDPPGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408845AbgDPNwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:52:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 838DB2063A;
        Thu, 16 Apr 2020 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045139;
        bh=veCBmgdRybGO47FNkFF3zVpn19J+P2jgtZGRswXSyFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfpmeoJ7ZMdCYTYk2+5zxTBuHfteLaSonV+RmXXQvkKPAf+Gr6T+y8Q2IvsrkbFUO
         tADAPyorkOlq9VpxMy1eeF3HdfMfX/EGZYIcIoHPEQFzWLR10h3IjnRYnjAFO+DwiS
         3ybLVJXwx3yIXVSJBodgmEhfiK1AkaKKCNeBpT64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 005/254] staging: wilc1000: avoid double unlocking of wilc->hif_cs mutex
Date:   Thu, 16 Apr 2020 15:21:34 +0200
Message-Id: <20200416131326.408558425@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

[ Upstream commit 6c411581caef6e3b2c286871641018364c6db50a ]

Possible double unlocking of 'wilc->hif_cs' mutex was identified by
smatch [1]. Removed the extra call to release_bus() in
wilc_wlan_handle_txq() which was missed in earlier commit fdc2ac1aafc6
("staging: wilc1000: support suspend/resume functionality").

[1]. https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/NOEVW7C3GV74EWXJO3XX6VT2NKVB2HMT/

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Link: https://lore.kernel.org/r/20200221170120.15739-1-ajay.kathat@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/wlan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wlan.c
index 601e4d1345d24..05b8adfe001da 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -572,7 +572,6 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 				entries = ((reg >> 3) & 0x3f);
 				break;
 			}
-			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 		} while (--timeout);
 		if (timeout <= 0) {
 			ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x0);
-- 
2.20.1



