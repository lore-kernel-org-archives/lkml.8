Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F79C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4FC24681
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197434;
	bh=Ph4Sj2DWmZ+09srvo7BvwZuzQCcypt5DJZ8oPDkcdOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4ppcdKEIMRwlJ+pSK4EChtzJL9EZISjwt5O/VoDYxjusp4RZjc3T7P9L23YjW6Oa
	 k+/SDiqsS8mx0hUc+6pbAovMedBiRs6d9UHWtB2k50ckb97Bqo9zKoIxujFQ/yGLEw
	 ebQYNahXcqw/F2VT/VxmL+GnNyUZzXD65Bg+GrtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394472AbgAPR5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393965AbgAPRnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5023E24718;
        Thu, 16 Jan 2020 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196619;
        bh=Ph4Sj2DWmZ+09srvo7BvwZuzQCcypt5DJZ8oPDkcdOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EnK0Hw2LyyfEQJAmCONc/jJ5jkcy4ahBTSJN1SvNZhbZM4eru+6jhcZYgT32mmmS
         ZM6nvnO8Cy+KtGrm/nLYJwl+Fi7nSgL/qEL8riJo3GZlrTWRYZkrAC90/hXPJQrT9A
         KXzkR/JxwbNHdzjIiiYsw8qfuwXJPBzOpishe+IE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 036/174] tty: ipwireless: Fix potential NULL pointer dereference
Date:   Thu, 16 Jan 2020 12:40:33 -0500
Message-Id: <20200116174251.24326-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
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
index ad7031a4f3c4..454cdc6f2c05 100644
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

