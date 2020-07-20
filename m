Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9361C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74A92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jP93GE6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgGTQnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:43:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37650 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbgGTQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:43:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KGhSoS033897;
        Mon, 20 Jul 2020 11:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595263408;
        bh=IhQglFTuHMFx3Wmu6u79WQ8Np7iv2tLYaEeJlwjbcSw=;
        h=From:To:Subject:Date;
        b=jP93GE6w7hi4lPU+yHZKbBdgM8MqhNdScpSBMPfMdqyka57tIwBKjs/Y7VvxD6nof
         kTlqvUH6/sc78K7TVOFJdMPII9Rtle7J8DW3x/hLJuMhDLVYGD6G/IkhSR1Q0cHfA1
         QhqBuwMpwWX6ltqwhhLHHVfrVWW0giKb51N6bjw4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06KGhSdR113392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 11:43:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 11:43:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 11:43:27 -0500
Received: from uda0868495.fios-router.home (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KGhROP013493;
        Mon, 20 Jul 2020 11:43:27 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: hsr: check for return value of skb_put_padto()
Date:   Mon, 20 Jul 2020 12:43:27 -0400
Message-ID: <20200720164327.16977-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_put_padto() can fail. So check for return type and return NULL
for skb. Caller checks for skb and acts correctly if it is NULL.

Fixes: 6d6148bc78d2 ("net: hsr: fix incorrect lsdu size in the tag of HSR frames for small frames")

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index e42fd356f073..1ea17752fffc 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -120,15 +120,17 @@ static struct sk_buff *frame_get_stripped_skb(struct hsr_frame_info *frame,
 	return skb_clone(frame->skb_std, GFP_ATOMIC);
 }
 
-static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
-			 struct hsr_port *port, u8 proto_version)
+static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
+				    struct hsr_frame_info *frame,
+				    struct hsr_port *port, u8 proto_version)
 {
 	struct hsr_ethhdr *hsr_ethhdr;
 	int lane_id;
 	int lsdu_size;
 
 	/* pad to minimum packet size which is 60 + 6 (HSR tag) */
-	skb_put_padto(skb, ETH_ZLEN + HSR_HLEN);
+	if (skb_put_padto(skb, ETH_ZLEN + HSR_HLEN))
+		return NULL;
 
 	if (port->type == HSR_PT_SLAVE_A)
 		lane_id = 0;
@@ -147,6 +149,8 @@ static void hsr_fill_tag(struct sk_buff *skb, struct hsr_frame_info *frame,
 	hsr_ethhdr->hsr_tag.encap_proto = hsr_ethhdr->ethhdr.h_proto;
 	hsr_ethhdr->ethhdr.h_proto = htons(proto_version ?
 			ETH_P_HSR : ETH_P_PRP);
+
+	return skb;
 }
 
 static struct sk_buff *create_tagged_skb(struct sk_buff *skb_o,
@@ -175,9 +179,10 @@ static struct sk_buff *create_tagged_skb(struct sk_buff *skb_o,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
 
-	hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
-
-	return skb;
+	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
+	 * that case
+	 */
+	return hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
 }
 
 /* If the original frame was an HSR tagged frame, just clone it to be sent
-- 
2.17.1

