Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E44C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B742081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199849;
	bh=0tf7ycelAdvsqxIAW/LQpLuzSb4Rkln2Jb86A9uToFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KR8ep64DSCUkm5Kpn1QMnS5IrpIfR07eTZ2Rl+ZXKqHqiyUwTmiELrDDyO/cl+rh
	 QSPZF4ubAGX9uBMzfrk3a2/WRJ0K3jTP/f28XMBoCXt9jCpS38rh4fCcloggJAPSy3
	 FbFKaM0lXGnTi2f1qRKksJ8uZuRz/vo7iCoKUb/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436890AbgAPSh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391657AbgAPRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98992469F;
        Thu, 16 Jan 2020 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195462;
        bh=0tf7ycelAdvsqxIAW/LQpLuzSb4Rkln2Jb86A9uToFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WM4YhO0ky/16gDmtV1Kn+53aLvSlTtIym1dvcDCRXUbn5CXSsqetL78hJb03MMf4d
         gt+qSAYe6rvkhnqToBxGw+QshisCXX/oVxuk2JKhj+voS5BiyvHbyuwCrho9rjoxG0
         FPBAr0rB6oXXYhKSn5TlJ6YVHHA7uJlfp1APuRws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 070/371] tty: ipwireless: Fix potential NULL pointer dereference
Date:   Thu, 16 Jan 2020 12:19:02 -0500
Message-Id: <20200116172403.18149-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 7dd50e205b3348dc7784efbdf85723551de64a25 ]

There is a potential NULL pointer dereference in case
alloc_ctrl_packet() fails and returns NULL.

Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/ipwireless/hardware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index a6b8240af6cd..960e9375a1a9 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1516,6 +1516,8 @@ static void ipw_send_setup_packet(struct ipw_hardware *hw)
 			sizeof(struct ipw_setup_get_version_query_packet),
 			ADDR_SETUP_PROT, TL_PROTOCOLID_SETUP,
 			TL_SETUP_SIGNO_GET_VERSION_QRY);
+	if (!ver_packet)
+		return;
 	ver_packet->header.length = sizeof(struct tl_setup_get_version_qry);
 
 	/*
-- 
2.20.1

