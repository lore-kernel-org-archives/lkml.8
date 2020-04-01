Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B9AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF07214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758216;
	bh=IAoZwNTw/LJYfeiRAw+x03kYdpq+o+xNOD7CYcRqTAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVT4l5WAZVhk+IVP3U9TfTQwG3SsHwoY9eeW/OcDvViw5TTB0mUOTvUM3lRt9bPi0
	 iIKxa7NxquWWJ1VOVnVH8aqFpPPjK0sSrPFoy1I26f3fCUnrZVmmOg+ogLxMJ6Ck0F
	 GAj7QcUOwgzO4OKtI8LbSSIBExZRcm1pOpFwTYz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgDAQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbgDAQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:23:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6A6212CC;
        Wed,  1 Apr 2020 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758211;
        bh=IAoZwNTw/LJYfeiRAw+x03kYdpq+o+xNOD7CYcRqTAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v0l2XCgeaypnrteW1ljHhFKYjbyKgTv7JtH31t0J1pBiaxN1ibv5fzkLbFgKKc4yx
         DQ+K0gYMyWDlQ8aCqoZoyvku2UeHpOdqW2EJZy/5yjSikAxCFxJ6ONGdkZsx5e0IH5
         wmgKue3APSWn3nkjMazR9b/lfhzNcVLBzkOCywpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/116] NFC: fdp: Fix a signedness bug in fdp_nci_send_patch()
Date:   Wed,  1 Apr 2020 18:16:35 +0200
Message-Id: <20200401161544.727136967@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 0dcdf9f64028ec3b75db6b691560f8286f3898bf ]

The nci_conn_max_data_pkt_payload_size() function sometimes returns
-EPROTO so "max_size" needs to be signed for the error handling to
work.  We can make "payload_size" an int as well.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/fdp/fdp.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -192,7 +192,7 @@ static int fdp_nci_send_patch(struct nci
 	const struct firmware *fw;
 	struct sk_buff *skb;
 	unsigned long len;
-	u8 max_size, payload_size;
+	int max_size, payload_size;
 	int rc = 0;
 
 	if ((type == NCI_PATCH_TYPE_OTP && !info->otp_patch) ||
@@ -215,8 +215,7 @@ static int fdp_nci_send_patch(struct nci
 
 	while (len) {
 
-		payload_size = min_t(unsigned long, (unsigned long) max_size,
-				     len);
+		payload_size = min_t(unsigned long, max_size, len);
 
 		skb = nci_skb_alloc(ndev, (NCI_CTRL_HDR_SIZE + payload_size),
 				    GFP_KERNEL);


