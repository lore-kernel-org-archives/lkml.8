Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A7AC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816F12137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758673;
	bh=JJOM3HjLV6LrQLoIliOpDZuu/rXCRNIy89pDV+AUuIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KuSEnL4exC0f5rj0L75mHHv9WZPf0xApHJWD9mPRQlarzTlrRrdt+IN97d6OAzi2S
	 NqUYg97qGGSBChfXhjVsxNsLG38iIIfuOaeGTKKABSMYaNisIWle/H26xhCXiigr82
	 QrZxYbWPWCTO8xhm/qgaJC5SCGr6ETGyt0nrKAJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgDAQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387811AbgDAQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF262137B;
        Wed,  1 Apr 2020 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758668;
        bh=JJOM3HjLV6LrQLoIliOpDZuu/rXCRNIy89pDV+AUuIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eE3Mzxg25o+hCW4TXD1++I7qCr0eeocJ4HTaKXot3oAguo5Wf/aNkEW6dYGrif0T7
         RQnP8etmheuWgc0suaMtR1smKEshnPymuBWr3pD3X/Cunma7qVFtdqoXFXIZ1ovEjz
         qa37EdZwY7iWFkAVCb38WhOpFc+0xzStYe2VamAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 38/91] NFC: fdp: Fix a signedness bug in fdp_nci_send_patch()
Date:   Wed,  1 Apr 2020 18:17:34 +0200
Message-Id: <20200401161527.174558949@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
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
@@ -191,7 +191,7 @@ static int fdp_nci_send_patch(struct nci
 	const struct firmware *fw;
 	struct sk_buff *skb;
 	unsigned long len;
-	u8 max_size, payload_size;
+	int max_size, payload_size;
 	int rc = 0;
 
 	if ((type == NCI_PATCH_TYPE_OTP && !info->otp_patch) ||
@@ -214,8 +214,7 @@ static int fdp_nci_send_patch(struct nci
 
 	while (len) {
 
-		payload_size = min_t(unsigned long, (unsigned long) max_size,
-				     len);
+		payload_size = min_t(unsigned long, max_size, len);
 
 		skb = nci_skb_alloc(ndev, (NCI_CTRL_HDR_SIZE + payload_size),
 				    GFP_KERNEL);


