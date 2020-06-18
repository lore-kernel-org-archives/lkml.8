Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B126C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C132220C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445129;
	bh=YbQ/ve/xaN0TaYECh2pWFCVmv0cZDtl6sWpM00QVo+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbUmAollBwPSvYrbt53d7g4EGDg2i5xoclxJEI7rbI3pvTy3j1T3GJuPLuCdwUuoK
	 KYiF//mScw+tY2M83H+p6vBCFCTcOnTzMQrNiVZMHelbf2VbWRYQqpFjvvGRiBRyFk
	 GkC8U32YtlqCrG84DKfQJ6kRcMfeClWg8pyy1UP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgFRBwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbgFRB0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42D320897;
        Thu, 18 Jun 2020 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443610;
        bh=YbQ/ve/xaN0TaYECh2pWFCVmv0cZDtl6sWpM00QVo+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKk2aBzGhKoE6nNNpahLilCXDz+1HE9xx4iYMSaLC4fXBLcPZX6byL5T8tvoro+Wx
         yfY8XP0obFRjefk329E9ZlL3Nu1Sa0x3K3P5ytKPnuuAu/otBq6Ihzf/HLWYDgyS6c
         Crgn0r/PqeeatPeTeHrhkow4CP/3jAy4KZG2cexo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 038/108] staging: rtl8712: fix multiline derefernce warnings
Date:   Wed, 17 Jun 2020 21:24:50 -0400
Message-Id: <20200618012600.608744-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aiman Najjar <aiman.najjar@hurranet.com>

[ Upstream commit 269da10b1477c31c660288633c8d613e421b131f ]

This patch fixes remaining checkpatch warnings
in rtl871x_xmit.c:

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->PrivacyKeyIndex'
636: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:636:
+					      (u8)psecuritypriv->
+					      PrivacyKeyIndex);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
643: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:643:
+						   (u8)psecuritypriv->
+						   XGrpKeyid);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
652: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:652:
+						   (u8)psecuritypriv->
+						   XGrpKeyid);

Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/98805a72b92e9bbf933e05b827d27944663b7bc1.1585508171.git.aiman.najjar@hurranet.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index eda2aee02ff8..06e2377092fe 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -601,7 +601,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 	addr_t addr;
 	u8 *pframe, *mem_start, *ptxdesc;
 	struct sta_info		*psta;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct security_priv	*psecpriv = &padapter->securitypriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
@@ -644,15 +644,13 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 				case _WEP40_:
 				case _WEP104_:
 					WEP_IV(pattrib->iv, psta->txpn,
-					       (u8)psecuritypriv->
-					       PrivacyKeyIndex);
+					       (u8)psecpriv->PrivacyKeyIndex);
 					break;
 				case _TKIP_:
 					if (bmcst)
 						TKIP_IV(pattrib->iv,
 						    psta->txpn,
-						    (u8)psecuritypriv->
-						    XGrpKeyid);
+						    (u8)psecpriv->XGrpKeyid);
 					else
 						TKIP_IV(pattrib->iv, psta->txpn,
 							0);
@@ -660,8 +658,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 				case _AES_:
 					if (bmcst)
 						AES_IV(pattrib->iv, psta->txpn,
-						    (u8)psecuritypriv->
-						    XGrpKeyid);
+						    (u8)psecpriv->XGrpKeyid);
 					else
 						AES_IV(pattrib->iv, psta->txpn,
 						       0);
-- 
2.25.1

