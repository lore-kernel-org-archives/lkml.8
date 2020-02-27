Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A836C7659E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D524688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814169;
	bh=AZscq8XeHW3FWrGVDBy12fTxu1hh2A8Mmnm4Zl5o8jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+zLn3Pqo9UJlfuU2yvznAw6PLc4IxaFO8wcy7R0ypwB/4PB+yaCKPWH6DTuQjsRW
	 CJWCQTzdfmNR5NXvqvUeZJYg4pZ1JELiKtTZW6VkGfAffHC5TO3faWW7wrh8u/g+Wb
	 RZbT2PFj3Vkxwjok61kfJERMY7hlp0GjU1ijxQ0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgB0N7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732422AbgB0N7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:59:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD3E24656;
        Thu, 27 Feb 2020 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811958;
        bh=AZscq8XeHW3FWrGVDBy12fTxu1hh2A8Mmnm4Zl5o8jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yv9su0/oIviQuHDT+626+oCuKZ73M3H3jFhJCwkL2ft95wvjgSsXdAHdFjry6+q/4
         Hon/1PhblavzHb00eItj1EGctOCaKc9B8u7r42/H+cHwXcCPKzaUOibLgzvsXfsPyR
         3x20BM/Abz+c4vKon7fUR+NTA5qcVDPs3dtlhJWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Per Forlin <perfn@axis.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 168/237] net: dsa: tag_qca: Make sure there is headroom for tag
Date:   Thu, 27 Feb 2020 14:36:22 +0100
Message-Id: <20200227132308.817526332@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Per Forlin <per.forlin@axis.com>

[ Upstream commit 04fb91243a853dbde216d829c79d9632e52aa8d9 ]

Passing tag size to skb_cow_head will make sure
there is enough headroom for the tag data.
This change does not introduce any overhead in case there
is already available headroom for tag.

Signed-off-by: Per Forlin <perfn@axis.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_qca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -41,7 +41,7 @@ static struct sk_buff *qca_tag_xmit(stru
 	struct dsa_slave_priv *p = netdev_priv(dev);
 	u16 *phdr, hdr;
 
-	if (skb_cow_head(skb, 0) < 0)
+	if (skb_cow_head(skb, QCA_HDR_LEN) < 0)
 		return NULL;
 
 	skb_push(skb, QCA_HDR_LEN);


