Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C92DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300EA2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360086;
	bh=1WM09S5iLkOvXHTcT5E+vaRwB6LeKHGo6lTKWkxoJ70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ojpSDduD1NV709yH5anw0Puottl8fuIVwYoVbegWmdgnYZNgcDcmscP/Dhm28J5RQ
	 Ax8d4giD1tM+L8I1v7MdNGWHo44eI0VtsnKl0A1uNZGMYrTUO+3VSjR9/I33oBmccI
	 06JS6jloPc5cWyvBWbwvdHdk/5ARKtfW4d2VYS6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgFEM0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:26:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3293B20897;
        Fri,  5 Jun 2020 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359975;
        bh=1WM09S5iLkOvXHTcT5E+vaRwB6LeKHGo6lTKWkxoJ70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by7T+qD7v6+KJmN0bUz0OAYfUNqHa/D5uJ8HA9W0UI/GJZ36UCj1G2I0nCU53GGTY
         l6jIlKJPi3ZiroWGQj+cAA7E6IaOqrQtNjPsqpi6A0cCu8y25c46lyUstToCLgfuUI
         yGOu+ZkAUuVx/O4Ucx0z91i1jGvVlhckmdf7wrlM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/8] net: usb: qmi_wwan: add Telit LE910C1-EUX composition
Date:   Fri,  5 Jun 2020 08:26:05 -0400
Message-Id: <20200605122609.2882841-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122609.2882841-1-sashal@kernel.org>
References: <20200605122609.2882841-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 591612aa578cd7148b7b9d74869ef40118978389 ]

Add support for Telit LE910C1-EUX composition

0x1031: tty, tty, tty, rmnet
Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 820feeda1f35..32ce50f11907 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1249,6 +1249,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
-- 
2.25.1

