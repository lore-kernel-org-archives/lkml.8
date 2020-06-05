Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6017B2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360180;
	bh=+tWFxojbwbjTLS/ezsp1cuaZ8C8To3S6VWEHd9iuCno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fZ+vaKKKE+5hQsrAZuc/vtf6fFB/4UVTm0kvdf3rdVkrYkoxtErQiF14t7vPYP0Hb
	 wH5Dl3Nu942/uhyWWXOnu9nnPb142KOt65vwLfDMq+b2ANxTYn5sRqj81zYOqO1of4
	 X/e85SJI9u6I+Qw49JRGq4+pbv2SkVd2oF4MDRaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgFEM3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFEMZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFA920897;
        Fri,  5 Jun 2020 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359948;
        bh=+tWFxojbwbjTLS/ezsp1cuaZ8C8To3S6VWEHd9iuCno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcsNz1obQpQK5k8fG9V4pR2E1MLW4Cgq7g4hc6gWwHk6qcDQGw8+/zBY+TogdiQnA
         Qpx5Tswy1QH8wpGnCXlHVMed+/COJuF1QlMCabp2xhu7itUUD9NLksfYuRtInJvpOm
         bGBmA2aD2WZv6JlzbhELz6gzrpuIAiO3fZgjhdAA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/14] net: usb: qmi_wwan: add Telit LE910C1-EUX composition
Date:   Fri,  5 Jun 2020 08:25:32 -0400
Message-Id: <20200605122540.2882539-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122540.2882539-1-sashal@kernel.org>
References: <20200605122540.2882539-1-sashal@kernel.org>
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
index 4bb8552a00d3..4a2c7355be63 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1324,6 +1324,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
-- 
2.25.1

