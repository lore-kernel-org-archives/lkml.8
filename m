Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC564C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32C22073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262152;
	bh=VdVyY6ajQASi1w84rj2mr2Dr1KheJ7ziIiNolP7mMCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqlCUBkFuBmOPkkOCTZ/UiiJ7ys9npTVyHVhmWpQwqNRubdEYXwPlvx/XE9DBXrrq
	 ZGV6NCRg6LqKm0zapqVg0ORNv1DDED0UjNfVxEYZm3i/Uy3rNG/B9ghmt/FCrCHOQy
	 deFUMAV5rWcLqvnqJUsLr7P64C95lRtylPcz9upA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgGTQWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733074AbgGTQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86FD2065E;
        Mon, 20 Jul 2020 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261201;
        bh=VdVyY6ajQASi1w84rj2mr2Dr1KheJ7ziIiNolP7mMCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGZeP0RWxpcZkSRtozVHD/f0A653xvW7XdAbjETAMptKzVwly+zNPBu9QVMufbbps
         bINmWH1Kx2l8aLlM5LeV47vvjepnekI9RSaENtNqASa9KJFqcZSPmvFCU7R7XpPqG1
         rxbEyGckxaUm5jcXHsJvrfvFsvqvae+aFOx3g1bY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+42a07faa5923cfaeb9c9@syzkaller.appspotmail.com,
        Christoph Paasch <cpaasch@apple.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 029/244] mptcp: fix DSS map generation on fin retransmission
Date:   Mon, 20 Jul 2020 17:35:00 +0200
Message-Id: <20200720152827.250329081@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9c29e36152748fd623fcff6cc8f538550f9eeafc ]

The RFC 8684 mandates that no-data DATA FIN packets should carry
a DSS with 0 sequence number and data len equal to 1. Currently,
on FIN retransmission we re-use the existing mapping; if the previous
fin transmission was part of a partially acked data packet, we could
end-up writing in the egress packet a non-compliant DSS.

The above will be detected by a "Bad mapping" warning on the receiver
side.

This change addresses the issue explicitly checking for 0 len packet
when adding the DATA_FIN option.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Reported-by: syzbot+42a07faa5923cfaeb9c9@syzkaller.appspotmail.com
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -449,9 +449,9 @@ static bool mptcp_established_options_mp
 }
 
 static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
-				 struct mptcp_ext *ext)
+				 struct sk_buff *skb, struct mptcp_ext *ext)
 {
-	if (!ext->use_map) {
+	if (!ext->use_map || !skb->len) {
 		/* RFC6824 requires a DSS mapping with specific values
 		 * if DATA_FIN is set but no data payload is mapped
 		 */
@@ -503,7 +503,7 @@ static bool mptcp_established_options_ds
 			opts->ext_copy = *mpext;
 
 		if (skb && tcp_fin && subflow->data_fin_tx_enable)
-			mptcp_write_data_fin(subflow, &opts->ext_copy);
+			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret = true;
 	}
 


