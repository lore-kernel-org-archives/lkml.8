Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1F2469A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220616;
	bh=YZLADUzilRnKC5VLz8IhvxJ7ESSyJZQ/OY/DrWNqeQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sU8FfkDkaO8/rs8IGHdjyRCw4FKyOyPnEGQsYVrHg9ZCFVoTsUj0jh0Z4G6lBXDfn
	 AkqqYxTYKbi9o9GeJK+CTKMtIddRa8IvOnma08nkqPUf/6S8OjbwJFskEvqAnBnu/s
	 1u/F+cpxyhIB8E+lDDAtxnxW6FnWunCcn1GLDots=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgA1OKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgA1OKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C5224681;
        Tue, 28 Jan 2020 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220609;
        bh=YZLADUzilRnKC5VLz8IhvxJ7ESSyJZQ/OY/DrWNqeQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0afKengd0gL5sb4K79xoReKrKndvFdSo/On9qQpk7WsnuIfyUlkdTq5/Z8CJnD5k
         aW6O3TNmZgr7xOwTizcJhSUM8PeXeNaVVstwvdmmR3j97GrWfdWMOwt9UaNwzPQaZL
         oKOrzi+KUyFkCp175/dfgvoOKYGOtmBoKfb+qdU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 038/183] tty: ipwireless: Fix potential NULL pointer dereference
Date:   Tue, 28 Jan 2020 15:04:17 +0100
Message-Id: <20200128135833.829417645@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ad7031a4f3c4d..454cdc6f2c05e 100644
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



