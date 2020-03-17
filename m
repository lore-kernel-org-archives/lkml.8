Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDCC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F39205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443493;
	bh=VADgBsvI7K3ZYVfzgJ0+CCHZcdARdax0xxTPahZk/Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVVXTNAxx6y3Xl2I/M2ToSrAbxV9oudI/5q95AT+kVisWRa5QGSIF/3GIdkjQ0IUP
	 MngWZYztKSGHiVVnvnlnc8kubDCAzQxveDRwZ7Y3gtNI4DxNazuXvHUd36rssPKVWh
	 ag77s2RjyrZket2WK2lmAXCJRkhaiV0S/wnVkWpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgCQLLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgCQLLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:11:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F63205ED;
        Tue, 17 Mar 2020 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443482;
        bh=VADgBsvI7K3ZYVfzgJ0+CCHZcdARdax0xxTPahZk/Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCZHMzSLQwWPZjcLenccoy4LkqecuFq8Wt/XK7Y3qLX3YLHGq6CoaZ0xJogi+TlEK
         sLqRaD/oXjnQ0lWmAOKKgSJQXP/Oemd9+cHxEtNY6Y9UgePAmbQKkLGpZ9/paHuj2W
         1IFFR8ycQ/S3KkNqd6QiizB9Tnal/QAZ010Ujvlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 060/151] nfc: add missing attribute validation for deactivate target
Date:   Tue, 17 Mar 2020 11:54:30 +0100
Message-Id: <20200317103330.804509445@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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


