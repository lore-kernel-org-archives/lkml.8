Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C514C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05BE20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443356;
	bh=wZGiYHCie/oqYiX23thrKo+o5XdcTh1Cwmi0mi8Ajj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sSfgwQ+kdic/yY8R14eAFbRBn5iDDW2YQM9/2JLbRidhmTdAPlINy7A4ar0IRrv/M
	 Nna2gvJI7Mr8mK+WE0rhqe37nMqWzDbW3GvWRK/mM/05LiIQeNvRFAPvLp1aa3SV61
	 EiKXOJ6l9e7r1wr36DD8UZa3NRxKQlmbmzPNMpHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgCQLJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgCQLJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4581F20658;
        Tue, 17 Mar 2020 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443352;
        bh=wZGiYHCie/oqYiX23thrKo+o5XdcTh1Cwmi0mi8Ajj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdauaEkpMlBplie7enTEp0jbVbpUM+9wpH25kc0Felcb+ZPtRM5bwoi1VxZptOs/D
         9HDbW2uZlUb/9icKrUMQdSt7s8t0QZGQIWhIi3Q0yEtdax6aEJQGADMCABFIW9qR8H
         /FAMdeJH6WWztghxb1qU/nr++WWfCJuwRHlYYvaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Greg Rose <gvrose8192@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 053/151] openvswitch: add missing attribute validation for hash
Date:   Tue, 17 Mar 2020 11:54:23 +0100
Message-Id: <20200317103330.341693247@linuxfoundation.org>
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

[ Upstream commit b5ab1f1be6180a2e975eede18731804b5164a05d ]

Add missing attribute validation for OVS_PACKET_ATTR_HASH
to the netlink policy.

Fixes: bd1903b7c459 ("net: openvswitch: add hash info to upcall")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Greg Rose <gvrose8192@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -647,6 +647,7 @@ static const struct nla_policy packet_po
 	[OVS_PACKET_ATTR_ACTIONS] = { .type = NLA_NESTED },
 	[OVS_PACKET_ATTR_PROBE] = { .type = NLA_FLAG },
 	[OVS_PACKET_ATTR_MRU] = { .type = NLA_U16 },
+	[OVS_PACKET_ATTR_HASH] = { .type = NLA_U64 },
 };
 
 static const struct genl_ops dp_packet_genl_ops[] = {


