Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A14C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383220722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623109;
	bh=52y55w0rqNYpPUljx483CSkXB9D/bZmyrc6yu2+pbtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZU4HkLZeNy2ZrGyKDuJhEHZ24mGVJRuLvHo6s/A0RLCk4f0a+wqSt0AEQl1u0s5nH
	 hddZZXebtxL8p32eMhjOAlqQkfdvoS34xyeSjG63B8GSB7UxL+SEsHmT0zdwyd6Tr9
	 EhneEvReRFj6yc8bQ/oz3Prto20IhFdBtzMUtJ9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCSNFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgCSNFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:05:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4991920739;
        Thu, 19 Mar 2020 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623105;
        bh=52y55w0rqNYpPUljx483CSkXB9D/bZmyrc6yu2+pbtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpZUdKw6LNZGc3J8IHmScNQ0iKZOl4g6V488dOIOQ+pz6Qg02xaYlNDVqxsLI2ze7
         +Jrh7FqJIl3QsP4NCw6oM27cIjM+ZWK9xB9glrH2145nQ3BfpSdzZEM7DOTU0u3pUC
         csQ7hyogpfgDxcV888x8I5wtnPFls36BP9rvUS0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 10/93] nfc: add missing attribute validation for SE API
Date:   Thu, 19 Mar 2020 13:59:14 +0100
Message-Id: <20200319123928.205006265@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 361d23e41ca6e504033f7e66a03b95788377caae ]

Add missing attribute validation for NFC_ATTR_SE_INDEX
to the netlink policy.

Fixes: 5ce3f32b5264 ("NFC: netlink: SE API implementation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/netlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -62,6 +62,7 @@ static const struct nla_policy nfc_genl_
 	[NFC_ATTR_LLC_SDP] = { .type = NLA_NESTED },
 	[NFC_ATTR_FIRMWARE_NAME] = { .type = NLA_STRING,
 				     .len = NFC_FIRMWARE_NAME_MAXSIZE },
+	[NFC_ATTR_SE_INDEX] = { .type = NLA_U32 },
 	[NFC_ATTR_SE_APDU] = { .type = NLA_BINARY },
 	[NFC_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
 


