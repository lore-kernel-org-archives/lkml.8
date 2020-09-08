Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718F4208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589917;
	bh=qcY164/4W/DBptoaByAIm5DT2JpzRcBh8egnBejCHwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgZ6PAnX2vdeNzG4TnjHcLsiK1RlT4/CjnZkJlPuGDZKT3GHBM2XftT/1hShniS1z
	 T+KT7xHu6YLgX6I+maMhzP9cIz3aCt14mBRVbDjWuTI8AajYcX/9j8SyJgKrpQmPoS
	 y/a1CJpchgl8mWHIwyuXOilUrdFono9ZTPzn1Luk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgIHSbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbgIHQJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55C724199;
        Tue,  8 Sep 2020 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580189;
        bh=qcY164/4W/DBptoaByAIm5DT2JpzRcBh8egnBejCHwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULnYm20ODdlCS8NwQOKJvsKwDsq2oWVvA2Jyo1FBSULhPM4rWoHw7XuuUoOa4MJu+
         EF/marR0QL7AVXL+mXXfSSoOGLSlYFWvIXqxqIvEBokIMmC4t8/2K0HjZw4xKIM0fw
         RFcXPJYGjbOrOp3J2H27k559gfwGPUV71vMyLGog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rogan Dawes <rogan@dawes.za.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 65/88] usb: qmi_wwan: add D-Link DWM-222 A2 device ID
Date:   Tue,  8 Sep 2020 17:26:06 +0200
Message-Id: <20200908152224.372450889@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rogan Dawes <rogan@dawes.za.net>

[ Upstream commit 7d6053097311643545a8118100175a39bd6fa637 ]

Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 41fbb8669845e..af58bf54aa9b6 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1227,6 +1227,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e16, 3)},	/* D-Link DWM-221 */
 	{QMI_FIXED_INTF(0x2001, 0x7e19, 4)},	/* D-Link DWM-221 B1 */
 	{QMI_FIXED_INTF(0x2001, 0x7e35, 4)},	/* D-Link DWM-222 */
+	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
 	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
-- 
2.25.1



