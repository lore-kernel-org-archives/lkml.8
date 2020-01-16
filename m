Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC892C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58C246AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196216;
	bh=G80E6DG/Xdhyn3QL8jhCTGhx/edP9krCWxwJu0H8Ch4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceZJPKSDEcsxvWgQdD9OQWXVA3mueB2XfJMgfcr4fVTCrrZm8hy/Uxj9/Yf7QQwt8
	 w5EFLiGipg/BeW1SzOEN1B8qZYCN/5UHFhU5G4+KTYNP8qPlU3J1M6BRbJcd1jsiUV
	 aBfvZgO0O2J5PEGO1/8K8c/eiCimmhokzSxsY3ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405239AbgAPRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405218AbgAPRgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:36:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F37B246C9;
        Thu, 16 Jan 2020 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196212;
        bh=G80E6DG/Xdhyn3QL8jhCTGhx/edP9krCWxwJu0H8Ch4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmGCfBzSKnlSxXSWopw4sovhvZU7lGaZy8DbdzJZIefVSqdkUuA6lOgl3MgPAwrjs
         uNHiVZlDPKhdFtTbh+//6qY4hQSG1m95JOaiJVOkKbWWkOf31q++ZBRshZEQ/24n7d
         o9DjO6AR4nhsgujG7xbU9NLX/+jiJ6KqyHXEYi7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 048/251] tty: ipwireless: Fix potential NULL pointer dereference
Date:   Thu, 16 Jan 2020 12:33:17 -0500
Message-Id: <20200116173641.22137-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index df0204b6148f..4417f7568422 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1515,6 +1515,8 @@ static void ipw_send_setup_packet(struct ipw_hardware *hw)
 			sizeof(struct ipw_setup_get_version_query_packet),
 			ADDR_SETUP_PROT, TL_PROTOCOLID_SETUP,
 			TL_SETUP_SIGNO_GET_VERSION_QRY);
+	if (!ver_packet)
+		return;
 	ver_packet->header.length = sizeof(struct tl_setup_get_version_qry);
 
 	/*
-- 
2.20.1

