Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23726C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54CD206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623717;
	bh=g4N6libNPpBEVVYAsslQki2XBh+u0Xx98ZwpV4Q+6Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4zwUHT+WyP9ByZ61Bw9HB9RV7oAn+sL4D906AJMxcSUW32d7wS0/uUCnIJuBRWbx
	 c2g1uhrqslGf75crJx5HHrFEoGOg6J0RjPHdM3a0FTphk9BAvn1VRoCaqGcVP8qUlN
	 3IeeGjWpNgK5/fxsDvdAdLLQZUveBV4WScRrinXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgCSNPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgCSNPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9966720724;
        Thu, 19 Mar 2020 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623711;
        bh=g4N6libNPpBEVVYAsslQki2XBh+u0Xx98ZwpV4Q+6Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AynsI1TuN85pe08/m2ADecX/KrD9uHq5dznaaDJq1C7b6hWwv4awzkviu3FReuYCR
         Ph+Hp5KD4AtulgHEuJA6RR36Sx+rEywbKTlSIGaEmzLMIDgfe0OmldnedIXuwcFv2b
         3aPjBPAv1JosOArfwN4zAX+3iXcchWBISTsSdDJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 27/99] nfc: add missing attribute validation for vendor subcommand
Date:   Thu, 19 Mar 2020 14:03:05 +0100
Message-Id: <20200319123949.999040284@linuxfoundation.org>
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

[ Upstream commit 6ba3da446551f2150fadbf8c7788edcb977683d3 ]

Add missing attribute validation for vendor subcommand attributes
to the netlink policy.

Fixes: 9e58095f9660 ("NFC: netlink: Implement vendor command support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -57,6 +57,8 @@ static const struct nla_policy nfc_genl_
 				     .len = NFC_FIRMWARE_NAME_MAXSIZE },
 	[NFC_ATTR_SE_INDEX] = { .type = NLA_U32 },
 	[NFC_ATTR_SE_APDU] = { .type = NLA_BINARY },
+	[NFC_ATTR_VENDOR_ID] = { .type = NLA_U32 },
+	[NFC_ATTR_VENDOR_SUBCMD] = { .type = NLA_U32 },
 	[NFC_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
 
 };


