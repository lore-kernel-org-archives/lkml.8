Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB7CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8220754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442633;
	bh=crAqJyoagg8GitwByqJaPF+YkVcw17OpzZ34+rgPKAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MW5xpf/ld+Eh5DCbF/w6741kvRUyjU4391FnRrwqLsoQRNoUNWrudW/es9z6h2prt
	 uqM3KJ53iebZPDt/HflZUK5aJ6Guqt5vL/VS3F5vdyFRGv4me8zO40ahkVgUy42r+W
	 xSrKs6Y+URk+/TdNaLJEQI0aYz6xmPzLdeWg5Pg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCQK5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgCQK5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEB520736;
        Tue, 17 Mar 2020 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442625;
        bh=crAqJyoagg8GitwByqJaPF+YkVcw17OpzZ34+rgPKAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwF9gbYtNTS1dkbetPSCEEam3268Ppji+9I85wJMP+xD041pGw4iZg7zFUD8TqU3U
         SRgYHIpe0v0YOspSloEK2YLeXZBk6rmBdMYKG1OblLJqckrnqz76ZlBWtuXi7ynBQP
         dUFIPL+wi08xngUH3t9ZjEhedcXFtbIad8WPO4LQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 26/89] nl802154: add missing attribute validation
Date:   Tue, 17 Mar 2020 11:54:35 +0100
Message-Id: <20200317103302.919329860@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 9322cd7c4af2ccc7fe7c5f01adb53f4f77949e92 ]

Add missing attribute validation for several u8 types.

Fixes: 2c21d11518b6 ("net: add NL802154 interface for configuration of 802.15.4 devices")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/nl_policy.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ieee802154/nl_policy.c
+++ b/net/ieee802154/nl_policy.c
@@ -30,6 +30,11 @@ const struct nla_policy ieee802154_polic
 	[IEEE802154_ATTR_HW_ADDR] = { .type = NLA_HW_ADDR, },
 	[IEEE802154_ATTR_PAN_ID] = { .type = NLA_U16, },
 	[IEEE802154_ATTR_CHANNEL] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_BCN_ORD] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_SF_ORD] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_PAN_COORD] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_BAT_EXT] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_COORD_REALIGN] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_PAGE] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_COORD_SHORT_ADDR] = { .type = NLA_U16, },
 	[IEEE802154_ATTR_COORD_HW_ADDR] = { .type = NLA_HW_ADDR, },


