Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D641C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D0420658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443051;
	bh=GwI3gY1sXrC3gZXxwYXmVKTzAnQwUmakGOz+AjeK0GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLaW7yuqaRtWhfy3dGH8a6d5mnfVOTKKrZ7OEajQxMP1G0y8zwu1Q+LdxVxRWUoZt
	 TRrRU/L7YxzZ3NWPgZ1uIPjbdi8hrci9g7UuaOcKUBwo22S8nPyg/sk1drFcN+XWQ/
	 LI3ZIif4GDnc5UWjYwgRf4n0HKPV5Hsqv/HWZJo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgCQLEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgCQLEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:04:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED99920714;
        Tue, 17 Mar 2020 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443046;
        bh=GwI3gY1sXrC3gZXxwYXmVKTzAnQwUmakGOz+AjeK0GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9pfkmKqsptCNdAzyEfbK/oeeUh7XSSzqug/FxHRlWsbHAetdYPuAhpX8Ybj5prYL
         NhBbDyn+PrSVjEouT4YDtAhe+OugnjlAb/6spJMvcp4sqXOHc9ANqmXHcvEjc9mLEE
         LyFlWYHHko+VUfRQ39Pn2jWg+SnChlywlDJPGs/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 040/123] nl802154: add missing attribute validation for dev_type
Date:   Tue, 17 Mar 2020 11:54:27 +0100
Message-Id: <20200317103311.975080702@linuxfoundation.org>
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
@@ -27,6 +27,7 @@ const struct nla_policy ieee802154_polic
 	[IEEE802154_ATTR_BAT_EXT] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_COORD_REALIGN] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_PAGE] = { .type = NLA_U8, },
+	[IEEE802154_ATTR_DEV_TYPE] = { .type = NLA_U8, },
 	[IEEE802154_ATTR_COORD_SHORT_ADDR] = { .type = NLA_U16, },
 	[IEEE802154_ATTR_COORD_HW_ADDR] = { .type = NLA_HW_ADDR, },
 	[IEEE802154_ATTR_COORD_PAN_ID] = { .type = NLA_U16, },


