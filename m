Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016A220578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690705;
	bh=9Z4upJ0AkAAW6Tc4QqIbxpu4zOCZcHSXdTtefvlZoxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=twpOoso60Y/xtKqCdlAJaoG14cVSNOOxxwEGpxtMRH62ShlOr0Id9PekypCe6ETlp
	 SqcUy7IHA50OXfyA2+LfM0gCkXC0Z1XQf0wLMcuoOiFQEcYHyiOsJ/oIJ2TxKWZFgt
	 +gKF+jPhTMRWckkO3zlJ+GjfOeoSngWIKwoMSPzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbgHQS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbgHQPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF8320789;
        Mon, 17 Aug 2020 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679380;
        bh=9Z4upJ0AkAAW6Tc4QqIbxpu4zOCZcHSXdTtefvlZoxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJB8oxFDFmr2Nn9JXAKe+lau/bqH2d9PzA0puVLZX1HejQEKUG5HrFI3KZGE0+Oe9
         ufkNW+ZjoABmc500tCZKJ3Gcy/U8nfZp/lsYyhjmvf+LZ2YeOpHQApw1TdN/cZgpHQ
         4M5LUAevibeV9PO4aqX2H4jgZ/ohkfYUy/6HBZK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 161/393] net: atlantic: MACSec offload statistics checkpatch fix
Date:   Mon, 17 Aug 2020 17:13:31 +0200
Message-Id: <20200817143827.427055382@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Starovoytov <mstarovoitov@marvell.com>

[ Upstream commit 3a8b44546979cf682324bd2fd61e539f428911b4 ]

This patch fixes a checkpatch warning.

Fixes: aec0f1aac58e ("net: atlantic: MACSec offload statistics implementation")

Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 7241cf92b43a5..446c59f2ab448 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -123,21 +123,21 @@ static const char aq_macsec_stat_names[][ETH_GSTRING_LEN] = {
 	"MACSec OutUnctrlHitDropRedir",
 };
 
-static const char *aq_macsec_txsc_stat_names[] = {
+static const char * const aq_macsec_txsc_stat_names[] = {
 	"MACSecTXSC%d ProtectedPkts",
 	"MACSecTXSC%d EncryptedPkts",
 	"MACSecTXSC%d ProtectedOctets",
 	"MACSecTXSC%d EncryptedOctets",
 };
 
-static const char *aq_macsec_txsa_stat_names[] = {
+static const char * const aq_macsec_txsa_stat_names[] = {
 	"MACSecTXSC%dSA%d HitDropRedirect",
 	"MACSecTXSC%dSA%d Protected2Pkts",
 	"MACSecTXSC%dSA%d ProtectedPkts",
 	"MACSecTXSC%dSA%d EncryptedPkts",
 };
 
-static const char *aq_macsec_rxsa_stat_names[] = {
+static const char * const aq_macsec_rxsa_stat_names[] = {
 	"MACSecRXSC%dSA%d UntaggedHitPkts",
 	"MACSecRXSC%dSA%d CtrlHitDrpRedir",
 	"MACSecRXSC%dSA%d NotUsingSa",
-- 
2.25.1



