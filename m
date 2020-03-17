Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C0C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26D32071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442964;
	bh=VADgBsvI7K3ZYVfzgJ0+CCHZcdARdax0xxTPahZk/Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKKZ3B44bpVqxOSR12mIH9wYTvf10YthoHxH0oxsWoh711JDyborZwwFrKrDzJzns
	 Jt/KCrAPKun2AjjNBKbT6aCc9ujMrDoVRYfXpeQLEa/kLDbiQb/UNFWG/D0Cx0VNdU
	 Rt+J3x3LSFur04FpzYSY4Ot48pEV3HqDi/Gef2Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCQLCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgCQLCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:02:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26143205ED;
        Tue, 17 Mar 2020 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442960;
        bh=VADgBsvI7K3ZYVfzgJ0+CCHZcdARdax0xxTPahZk/Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7dWT/LCDHS/mCZN9CIwIq8/JytB7Igk6EViTb2tonuve4vLIRX3Ro6Kv37b+0bm5
         0PMJM0kpvn168dK4TYQT/2ny5Yf8KoFtVaknwH2whFlPbmw7rohrK9YGf8LQVMUUwf
         XJLj+vqnm7cK2e0u8ppuEvEngCT7Ak4jO8ftHMAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 049/123] nfc: add missing attribute validation for deactivate target
Date:   Tue, 17 Mar 2020 11:54:36 +0100
Message-Id: <20200317103312.747559154@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 88e706d5168b07df4792dbc3d1bc37b83e4bd74d ]

Add missing attribute validation for NFC_ATTR_TARGET_INDEX
to the netlink policy.

Fixes: 4d63adfe12dd ("NFC: Add NFC_CMD_DEACTIVATE_TARGET support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/netlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -32,6 +32,7 @@ static const struct nla_policy nfc_genl_
 	[NFC_ATTR_DEVICE_NAME] = { .type = NLA_STRING,
 				.len = NFC_DEVICE_NAME_MAXSIZE },
 	[NFC_ATTR_PROTOCOLS] = { .type = NLA_U32 },
+	[NFC_ATTR_TARGET_INDEX] = { .type = NLA_U32 },
 	[NFC_ATTR_COMM_MODE] = { .type = NLA_U8 },
 	[NFC_ATTR_RF_MODE] = { .type = NLA_U8 },
 	[NFC_ATTR_DEVICE_POWERED] = { .type = NLA_U8 },


