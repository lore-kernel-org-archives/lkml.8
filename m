Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114CBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D177F24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699604;
	bh=a+oUUi/Eq9wtmJ0uC2kz39yWnHxwcBFNJ1IY5b5Ires=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ociK7G4vZ1W0XLlQhKaduzcB5QyoHUKlbfE86RGFMRRvKmF3bvt9uB9sqWqbPey7y
	 HSLwrQlu51Y90Hx8rNEyl4R66lgwqwHRWO6Xm+3OLsoOZOd8AoQrjBJUQql44MPYTW
	 +v/E2anpFvs5Yk4MHYdvgbzqdKIrfm5Shpk5NalM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgAVN0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgAVN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:26:41 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11212467B;
        Wed, 22 Jan 2020 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699600;
        bh=a+oUUi/Eq9wtmJ0uC2kz39yWnHxwcBFNJ1IY5b5Ires=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdoCXVTNFVw9gBdf+8GCF0dmV2C6OgUlkwW5802HCDqTH8vLrJDDlNjkhdDQI10BF
         8PLP9Gj88SGp9QKa68SjYDLnyimEoX5sWCAxxNujaCGnaikxYX0fDM2OAsUwaAdQfv
         jl8N/OkneTqRYKE7DgWTWe/zA5XKRIKlDQ/fdajE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 155/222] net: dsa: tag_gswip: fix typo in tagger name
Date:   Wed, 22 Jan 2020 10:29:01 +0100
Message-Id: <20200122092844.817186226@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@dlink.ru>

[ Upstream commit ad32205470919c8e04cdd33e0613bdba50c2376d ]

The correct name is GSWIP (Gigabit Switch IP). Typo was introduced in
875138f81d71a ("dsa: Move tagger name into its ops structure") while
moving tagger names to their structures.

Fixes: 875138f81d71a ("dsa: Move tagger name into its ops structure")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_gswip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -104,7 +104,7 @@ static struct sk_buff *gswip_tag_rcv(str
 }
 
 static const struct dsa_device_ops gswip_netdev_ops = {
-	.name = "gwsip",
+	.name = "gswip",
 	.proto	= DSA_TAG_PROTO_GSWIP,
 	.xmit = gswip_tag_xmit,
 	.rcv = gswip_tag_rcv,


