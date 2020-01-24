Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C235C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064E20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876549;
	bh=oeW6U2MkcM5rIUI9vPpzZNq4TO61iMRDiVW1cUgizZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eS3dRUFgal8flm2JuL357chTU7lTRCRMav8Oc3iNpOtCagucelV73g+qzARg5MgIm
	 Po2GbLInh5NYMIAkDde2sF5sKcDSv8y7+am3SwqhabmoOhDrnd0T6DppmMJ2NlT01j
	 9lR78TYh5E0NWokfsm3Uiq+TURU8EV/HVtr/B9yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392773AbgAXOfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391673AbgAXOT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8940221556;
        Fri, 24 Jan 2020 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875568;
        bh=oeW6U2MkcM5rIUI9vPpzZNq4TO61iMRDiVW1cUgizZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcWUxSfbN1pNWtwMh5zEVeqKfQP4HmrhmG3GuNq3SryGsWkjr40Cjb8zj9jzVb1zn
         tYXmWkeAx8sHMQZGsI5CH4Nc85lytPVX75Q98QFmkB4Up3RomCUF5eukAj9bl40cRn
         oB24fBm/TtKOFEP+CDlwGQ3MzZgLF+f8AKtdoAU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kristian Evensen <kristian.evensen@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 061/107] qmi_wwan: Add support for Quectel RM500Q
Date:   Fri, 24 Jan 2020 09:17:31 -0500
Message-Id: <20200124141817.28793-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristian Evensen <kristian.evensen@gmail.com>

[ Upstream commit a9ff44f0e61d074f29770413fef6a5452be7b83e ]

RM500Q is a 5G module from Quectel, supporting both standalone and
non-standalone modes. The normal Quectel quirks apply (DTR and dynamic
interface numbers).

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 4196c0e327403..9485c8d1de8a3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1062,6 +1062,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_QUECTEL_DYNCFG(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_QUECTEL_DYNCFG(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
 	{QMI_QUIRK_QUECTEL_DYNCFG(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */
+	{QMI_QUIRK_QUECTEL_DYNCFG(0x2c7c, 0x0800)},	/* Quectel RM500Q-GL */
 
 	/* 3. Combined interface devices matching on interface number */
 	{QMI_FIXED_INTF(0x0408, 0xea42, 4)},	/* Yota / Megafon M100-1 */
-- 
2.20.1

