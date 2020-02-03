Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C977C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68D21775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747742;
	bh=oeW6U2MkcM5rIUI9vPpzZNq4TO61iMRDiVW1cUgizZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cdcYVSpxSrELX/fRyxVaFHjzR+8ZfLfn+cNIGqrIWZH/r9J21/n+GTyyFJ5AQusly
	 4hq6owX2D7/RgvwZjEJhs2m3Ar1Mr+HEFTgMVRAFkWloLrGHmpaIDphj8SJY94ri5/
	 mzeDo4tNhVcGeHIJl9KukbinMX2TJx5pkxsob25A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgBCQfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgBCQfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:35:39 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779C42082E;
        Mon,  3 Feb 2020 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747738;
        bh=oeW6U2MkcM5rIUI9vPpzZNq4TO61iMRDiVW1cUgizZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGMBc+xBSOKmk8c1nqJaCXJK6io5QAnI0dflsrlcbmAMY59ZFqje0SQqF+4ZjSkwI
         RV3LmOu6LTxhpDzf6VZDznbXQRkzo/O62rZP7r1UUxGagSt3llmfALwjJvSU5dWiQJ
         mLSvCa3L147HgLr+Ma62ws4Y4e78lJqwGobiSlKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 48/90] qmi_wwan: Add support for Quectel RM500Q
Date:   Mon,  3 Feb 2020 16:19:51 +0000
Message-Id: <20200203161923.816526825@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



