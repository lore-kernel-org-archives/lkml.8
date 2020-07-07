Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70033C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C74020738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594145686;
	bh=uD2w603wgU0bU7XLH2y1Ntci6dAVVpbixOgMNfmbeas=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EfA+RDP2OEAOyd80cAxlvBvsvLsnrBOX5MNQgl1/0Ss0+v7m1FRnyWytaXUJQvPOd
	 drB06UcYNBD4Yfz8UqVxOKqWHp1TZOBA1Aua62DOythELGYwGHDj/bOgscRrAy3sah
	 spdAw9YUlpuAsxPAcUJ8ZQXcV4VDB23Du1mkxeF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGGSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgGGSOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:14:42 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74F92065F;
        Tue,  7 Jul 2020 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594145682;
        bh=uD2w603wgU0bU7XLH2y1Ntci6dAVVpbixOgMNfmbeas=;
        h=Date:From:To:Cc:Subject:From;
        b=RwJ3LiHsX5bikASuTHCgtD+BwMWe7tD8wJ9BzgYPDgL8VRca8j5L35IZw2bxdEWcd
         aFljhWi1gYx0Ne4A9lKHr3HqXIMqn48Iz2FjdcbrJY+zi3+fZvnc5W7BK7KaTxAViD
         J054kC/aCUOCAfOfLTi60DKHwXvyOwMVR4gV75y4=
Date:   Tue, 7 Jul 2020 13:20:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] staging: rtl8188eu: Use fallthrough pseudo-keyword
Message-ID: <20200707182008.GA341@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    |    2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c      |    2 +-
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8d035f67ef61..414f1834657a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4133,7 +4133,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 			ptable->func = &OnAuth;
 		else
 			ptable->func = &OnAuthClient;
-		/* fall through */
+		fallthrough;
 	case WIFI_ASSOCREQ:
 	case WIFI_REASSOCREQ:
 	case WIFI_PROBEREQ:
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 16a57b31a439..114638f6f719 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1728,7 +1728,7 @@ void rtw_hal_get_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 	switch (variable) {
 	case HW_VAR_BASIC_RATE:
 		*((u16 *)(val)) = Adapter->HalData->BasicRateSet;
-		/* fall through */
+		fallthrough;
 	case HW_VAR_TXPAUSE:
 		val[0] = usb_read8(Adapter, REG_TXPAUSE);
 		break;
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 3cd6da1f843d..a80c7f3b86d1 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -400,7 +400,7 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		case -ENODEV:
 		case -ESHUTDOWN:
 			adapt->bSurpriseRemoved = true;
-			/* fall through */
+			fallthrough;
 		case -ENOENT:
 			adapt->bDriverStopped = true;
 			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,

