Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1487BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623400;
	bh=tIDuFIuCHpKAC0CNL2sqNH/zangInW0CyT/NEaHTTQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmnVB1IKSCWRDS4pzsyyhs2tfy/KlE5GVlyxz4o7l49wAuoFn+CHJI31+qs4H6mkU
	 wDwugdGdmrZp+hYZpXjeL/7ALCzT96WbA//KSRuFsQn6sSTpa1s704l8NfQ8Ufhh8l
	 6dAVeh+nFkzEOaoYRURDUAxmpwx0YyMhbx6tRdBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgCSNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgCSNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:09:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2340E208D6;
        Thu, 19 Mar 2020 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623397;
        bh=tIDuFIuCHpKAC0CNL2sqNH/zangInW0CyT/NEaHTTQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkIOsiknAI4Ducfk+xaNgipLArCFaapH2kKvGk29EU+rmh5czJWcqTRQW+JleK21z
         35Z531HWUqoHJs0hhlH0JuFg2lvpbP5/Fmpf5YdrB66yE7+ZISu1EEVduMthzjpVjv
         hP2Dwj0tBRlgtOAZCg9OZ+PuK4QNjmgN73JlPWmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/90] nl802154: add missing attribute validation for dev_type
Date:   Thu, 19 Mar 2020 13:59:35 +0100
Message-Id: <20200319123932.815020180@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit b60673c4c418bef7550d02faf53c34fbfeb366bf ]

Add missing attribute type validation for IEEE802154_ATTR_DEV_TYPE
to the netlink policy.

Fixes: 90c049b2c6ae ("ieee802154: interface type to be added")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/nl_policy.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ieee802154/nl_policy.c
+++ b/net/ieee802154/nl_policy.c
@@ -36,6 +36,7 @@ const struct nla_policy ieee802154_polic
 	[IEEE802154_ATTR_BAT_EXT] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_COORD_REALIGN] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_PAGE] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_DEV_TYPE] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_COORD_SHORT_ADDR] = { .type = NLA_U16, },
 	[IEEE802154_ATTR_COORD_HW_ADDR] = { .type = NLA_HW_ADDR, },
 	[IEEE802154_ATTR_COORD_PAN_ID] = { .type = NLA_U16, },


