Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306FB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519641;
	bh=LsS3+PSIvW8Kau/n+6pr/cwnVZ7ma7hnw6/ulEOkfCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z6RlT28e5DORCDpAbi2li0vX/QIjjL45F9ehgnUztci8gWIKf6wQ9tIr4NDPF+q9Q
	 hbY967z/bq87dd+7sX2nFaE1w80uo7k1l0Rh2Lff+nDxwf00sNniE/ok+U+mFrldqR
	 xe1h5x0OGBIjuq1F/pxB7YM4vvLbbkUG2DytqNnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgEZTAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389533AbgEZTAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737042084C;
        Tue, 26 May 2020 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519635;
        bh=LsS3+PSIvW8Kau/n+6pr/cwnVZ7ma7hnw6/ulEOkfCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0Sk+nD5khnplevED6DjMTEP+pm53EvLJJV8taNRQnxPV7SEoVg+F2crrw3ArYsEP
         ugjmnZhW8eYniN4JeYlNPTXPnSmXAWlpqqRHgBsPDgk2m/ahrHLSCmMyr+UtvKJr07
         3k/xXcObZeXzKSRCUSiAgutcBpnZYnl7ehu6xwPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/59] vhost/vsock: fix packet delivery order to monitoring devices
Date:   Tue, 26 May 2020 20:53:02 +0200
Message-Id: <20200526183913.796883425@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
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
index 834e88e20550..3f2f34ebf51f 100644
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



