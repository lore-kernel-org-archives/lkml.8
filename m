Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CFB22B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087967;
	bh=x9GG5gygsBiraECBSOqumUJcpCscr6B3l3sBiltVbKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d4MVHhrdIQ+39B/Jui8e+D/Ioj/+hLhpw3xTpb9/EJXqY/cl+Uqf/SqNb7xGb+HH9
	 q+hRnJScpI7Pw/Lb50aXlrkYhqwitqgrNeJXlJu8bPsriAvIOWpsE62J7xjtw/52Ko
	 +d07LWlxNWxsxONoQ3aTPIxdtJJewNHpS/Cv84S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgHJTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgHJTJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:09:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3803320885;
        Mon, 10 Aug 2020 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086575;
        bh=x9GG5gygsBiraECBSOqumUJcpCscr6B3l3sBiltVbKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBDHpePKQL5pMA+GoiBseKk0AOvwfKnhO2/n1ne3M8EiQaLZTjBmGFwA2bej1gxpb
         N8mdSuXadpCytpY3O+/XI/QPyUwmy08PB88bAQD+HZ7/3V19zm7yrXeMVIH6zUlJ1B
         FdZLT1KaS2h+cG0GZZwThoklynFZ8oWivxDeOodg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 26/64] usb: mtu3: clear dual mode of u3port when disable device
Date:   Mon, 10 Aug 2020 15:08:21 -0400
Message-Id: <20200810190859.3793319-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit f1e51e99ed498d4aa9ae5df28e43d558ea627781 ]

If not clear u3port's dual mode when disable device, the IP
will fail to enter sleep mode when suspend.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/1595834101-13094-10-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/mtu3/mtu3_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 9dd02160cca97..e3780d4d65149 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -131,8 +131,12 @@ static void mtu3_device_disable(struct mtu3 *mtu)
 	mtu3_setbits(ibase, SSUSB_U2_CTRL(0),
 		SSUSB_U2_PORT_DIS | SSUSB_U2_PORT_PDN);
 
-	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG)
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG) {
 		mtu3_clrbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
+		if (mtu->is_u3_ip)
+			mtu3_clrbits(ibase, SSUSB_U3_CTRL(0),
+				     SSUSB_U3_PORT_DUAL_MODE);
+	}
 
 	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
-- 
2.25.1

