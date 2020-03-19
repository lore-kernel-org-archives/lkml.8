Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ABFC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9F20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623713;
	bh=HoeQ4lDKHXj6lw1McrN/AYs92QY7yOxv7D8eaxGfLmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JU+Xp9AuMMHaLeVCPBgpxjxCzxrvnv4xm3KwRRf+tZfTonKZBP6hMViA/ava5gWND
	 bvGzuS7eBEgc/njUNKpVFdWNmCoj58ZkkYV13Fj9kb8c9apnG3hqc8t1RwdSdvOo1/
	 8h1+a+3H1jat174l9WTF0Sjmap1Ii8Nsj6VthuqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgCSNPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbgCSNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219C621556;
        Thu, 19 Mar 2020 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623708;
        bh=HoeQ4lDKHXj6lw1McrN/AYs92QY7yOxv7D8eaxGfLmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1q+KWQvQlDU/oGHJz0TnyPjcbpULkDr39WGlj5kStEntC+7Ii92kmxo3XhyPbg401
         qhJnKvjycWW0ozna3p/RrATdg+EGQupZLlBsoVAEw+0umjbiciHaP21GyyGVt0WyLh
         BqmUfCSPne2qBaKv0g9eIJxbatHUFDo8hsr8/P5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 26/99] nfc: add missing attribute validation for SE API
Date:   Thu, 19 Mar 2020 14:03:04 +0100
Message-Id: <20200319123949.668326452@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
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
@@ -55,6 +55,7 @@ static const struct nla_policy nfc_genl_
 	[NFC_ATTR_LLC_SDP] = { .type = NLA_NESTED },
 	[NFC_ATTR_FIRMWARE_NAME] = { .type = NLA_STRING,
 				     .len = NFC_FIRMWARE_NAME_MAXSIZE },
+	[NFC_ATTR_SE_INDEX] = { .type = NLA_U32 },
 	[NFC_ATTR_SE_APDU] = { .type = NLA_BINARY },
 	[NFC_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
 


