Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13255C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1791208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519804;
	bh=Dgq3p6bbhPKRPAoq7iflPSQKnWlh1GWu+U2jg9fzKQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6qTmo2aIwuTZLG84loDKlwNVrgrs6Nz34cv/yF12yHz6BMZI+kyCUM1bXrVLp+/O
	 nRDsErw+7v4L8BzHNMkBjk1y4F9Bdg+p3Zj7hueoYyMfZ8DYXID0bKKP4rJ8zuBGGM
	 2Bu7UNakKSChpBu73wwLHX1+c3Oskx56UgHRIawc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbgEZTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390271AbgEZTDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77418208A7;
        Tue, 26 May 2020 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519799;
        bh=Dgq3p6bbhPKRPAoq7iflPSQKnWlh1GWu+U2jg9fzKQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SqIAYXcReQiGzR3+nOXNDMxsU1QDBF+B2NTo7aYrUAS6swY1xXETZ8u59h8JGKVd
         yz5HD5JJEknRptEp5t31WCAwMI/hiGKMNdx4SJmdxSCui2xkdY20pmbZDgaujrOT8P
         pS5pR+tdpgGgat7E0U4CC1M+GLc16CbKU+CPNDHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/81] vhost/vsock: fix packet delivery order to monitoring devices
Date:   Tue, 26 May 2020 20:52:57 +0200
Message-Id: <20200526183929.430407142@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 107bc0766b9feb5113074c753735a3f115c2141f ]

We want to deliver packets to monitoring devices before it is
put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bac1365cc81b..7891bd40ebd8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -182,14 +182,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
-		added = true;
-
-		/* Deliver to monitoring devices all correctly transmitted
-		 * packets.
+		/* Deliver to monitoring devices all packets that we
+		 * will transmit.
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
 
+		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		added = true;
+
 		pkt->off += payload_len;
 		total_len += payload_len;
 
-- 
2.25.1



