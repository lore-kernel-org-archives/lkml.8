Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECAC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6F2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443344;
	bh=QQ129eu6WhXBVL86aVphaEF5TJnd8BZqbt1aZgE+7Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfW75sf1I3fP8p0zCUq/jUPGKw54LFk8ely+OjdY3uuYjPHbJCbeoczSdco6GD+iK
	 0hurPAkUGMmMTmb0MAMzLoPITdavlkj9xpeqU3atSuupW7tOXpNkpuLw8D2nP7H6Ab
	 gkFYtiHxIbkA4YEwAA6TCz2j0rv4FeWGdr7O4RZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgCQLJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgCQLI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAFC205ED;
        Tue, 17 Mar 2020 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443338;
        bh=QQ129eu6WhXBVL86aVphaEF5TJnd8BZqbt1aZgE+7Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwIUT1EHax54WbwYDk8H4BFjdiUoXQ6YE+IaM0Je2AiKN1M8s9gnych1TyAWUsS+U
         HU/UPB4eyw2I+a+HiQLlqiIibU7djD9HxOhEfMqpz05L9kwY8XiVwXqBAgdI4DLvRR
         a8il07+p02KDMi2kh+iNhKM9JQis9AWPshHnuKm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 049/151] nl802154: add missing attribute validation
Date:   Tue, 17 Mar 2020 11:54:19 +0100
Message-Id: <20200317103330.075068394@linuxfoundation.org>
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
@@ -21,6 +21,11 @@ const struct nla_policy ieee802154_polic
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


