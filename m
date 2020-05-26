Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CFC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520076;
	bh=J7uV9nvaboK0dfMn3PziHprNy+pfNzX7Mjny4qZ2sSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WahXNnsv3fPBHtQaDWcqGHCr7SBc9KFs3ZXqqWYXQZLHdXDfOIQ5eSJnMuhzuk4nr
	 ocFOIWbiPw5ASkyACCUsSPFzWxIUWHfr6WuW66l0TPn/FXtDGwwDY/479a9boMGITG
	 5rtH0uys9Z8q3pK1mMEtXDfUNITzqIBQl3X8m55o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbgEZTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391735AbgEZTHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:07:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DE3208A7;
        Tue, 26 May 2020 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520071;
        bh=J7uV9nvaboK0dfMn3PziHprNy+pfNzX7Mjny4qZ2sSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqxY2p6rqEX2mdWBBo4JofZ1NjuobRZt3PPMn0I4px/fUmXmwzTpjjaeuoAcDd4PT
         sQqF/rIPs32cLa+NanIRp7/7IFz7Wg+SbxnUUYCCfk3I7ypAL8+AFg3Gv1GgLD2TX/
         iPGYaBBdggNL7vb9VKvXjBtP4MnFgOVnJVgFZ5Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/111] net/ena: Fix build warning in ena_xdp_set()
Date:   Tue, 26 May 2020 20:52:48 +0200
Message-Id: <20200526183935.653888540@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Shan <gshan@redhat.com>

[ Upstream commit caec66198d137c26f0d234abc498866a58c64150 ]

This fixes the following build warning in ena_xdp_set(), which is
observed on aarch64 with 64KB page size.

   In file included from ./include/net/inet_sock.h:19,
      from ./include/net/ip.h:27,
      from drivers/net/ethernet/amazon/ena/ena_netdev.c:46:
   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function         \
   ‘ena_xdp_set’:                                                    \
   drivers/net/ethernet/amazon/ena/ena_netdev.c:557:6: warning:      \
   format ‘%lu’                                                      \
   expects argument of type ‘long unsigned int’, but argument 4      \
   has type ‘int’                                                    \
   [-Wformat=] "Failed to set xdp program, the current MTU (%d) is   \
   larger than the maximum allowed MTU (%lu) while xdp is on",

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index dc02950a96b8..28412f11a9ca 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -68,7 +68,7 @@
  * 16kB.
  */
 #if PAGE_SIZE > SZ_16K
-#define ENA_PAGE_SIZE SZ_16K
+#define ENA_PAGE_SIZE (_AC(SZ_16K, UL))
 #else
 #define ENA_PAGE_SIZE PAGE_SIZE
 #endif
-- 
2.25.1



