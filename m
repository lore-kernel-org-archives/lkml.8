Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E021E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943079;
	bh=awXmuQ5KCsqVGoO+4913frSZiqVN48x2wCnuIBVIZew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N3wkkywlebi8llGjHK2O6MZZrNiDGqbkLKAMi6gkH3Yx8dqim+F60J9MfoXVc8AzH
	 OBwTaQBJP9Ls6ta8jIbgCzDMS3d89d9pNWJ42WTleXMVNt3u75oXaCmAkb0Yay5phK
	 SIxIf4zgX3z4johe8hdQq9ihVzIULI0dq9VsAW5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgEHMsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHMsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BFD206D6;
        Fri,  8 May 2020 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942125;
        bh=awXmuQ5KCsqVGoO+4913frSZiqVN48x2wCnuIBVIZew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYBD+YXsMPick8TRbGJtbcki1YNlIY3wAdoQRqfJo1qysrI1bkhe8jSxl8+WD+GWm
         A4yGj1ENXvOiJzjnxLusYnqgoFL65rdpfXKRXT6mLvu6Dl0pq3yMCGSkIdmwU85Om/
         ZE1RtUAJOQvGgFqVvGld3fyB4EhMtI07yvh8NYYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 306/312] bna: add missing per queue ethtool stat
Date:   Fri,  8 May 2020 14:34:57 +0200
Message-Id: <20200508123146.010360965@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Vecera <ivecera@redhat.com>

commit 2835d2d9e366a2985b24051d228333bfba82f3a7 upstream.

Commit ba5ca784 "bna: check for dma mapping errors" added besides other
things a statistic that counts number of DMA buffer mapping failures
per each Rx queue. This counter is not included in ethtool stats output.

Fixes: ba5ca784 "bna: check for dma mapping errors"
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -31,7 +31,7 @@
 #define BNAD_NUM_TXF_COUNTERS 12
 #define BNAD_NUM_RXF_COUNTERS 10
 #define BNAD_NUM_CQ_COUNTERS (3 + 5)
-#define BNAD_NUM_RXQ_COUNTERS 6
+#define BNAD_NUM_RXQ_COUNTERS 7
 #define BNAD_NUM_TXQ_COUNTERS 5
 
 #define BNAD_ETHTOOL_STATS_NUM						\
@@ -658,6 +658,8 @@ bnad_get_strings(struct net_device *netd
 				string += ETH_GSTRING_LEN;
 				sprintf(string, "rxq%d_allocbuf_failed", q_num);
 				string += ETH_GSTRING_LEN;
+				sprintf(string, "rxq%d_mapbuf_failed", q_num);
+				string += ETH_GSTRING_LEN;
 				sprintf(string, "rxq%d_producer_index", q_num);
 				string += ETH_GSTRING_LEN;
 				sprintf(string, "rxq%d_consumer_index", q_num);
@@ -678,6 +680,9 @@ bnad_get_strings(struct net_device *netd
 					sprintf(string, "rxq%d_allocbuf_failed",
 								q_num);
 					string += ETH_GSTRING_LEN;
+					sprintf(string, "rxq%d_mapbuf_failed",
+						q_num);
+					string += ETH_GSTRING_LEN;
 					sprintf(string, "rxq%d_producer_index",
 								q_num);
 					string += ETH_GSTRING_LEN;


