Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2161CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8072084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607443;
	bh=oDOR3nIjgOc1MJbGlBKDQMZunaN6N06rFE3HEbc8H3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvZ8x0/c1To9mc/p+bcWUnxEzwCJ6mkeovZ1WvV1spniLLO8vbAmKJ/fPw8n2P1Sy
	 btUZlLkXdjQ3Ag3EqyPU8v5pzuI01P8sBFps5rIPeG+1NGxbJSD3+eNKeol+eU1fUQ
	 9SgMzwAW6nkqhIa1NUvGFxIUY9qOGSoHa3ZatDnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgDKMRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgDKMRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE6520787;
        Sat, 11 Apr 2020 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607438;
        bh=oDOR3nIjgOc1MJbGlBKDQMZunaN6N06rFE3HEbc8H3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0euV8sRDp40v6TIl/0E403/TZZKhk0/uooXcatH2a5GygAhU+LaiAAZpsXf3xkDne
         09Wo3S1OP2+uVVaUUwrkcG+W/P25th9NTo86jat8rEkIuJ29D60tnMiuavdi6NhgnK
         YchVJNiIyLSmYzlrWIL1N2Lgy0Tc6IrIkijfizb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herat Ramani <herat@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 02/41] cxgb4: fix MPS index overwrite when setting MAC address
Date:   Sat, 11 Apr 2020 14:09:11 +0200
Message-Id: <20200411115504.288266729@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herat Ramani <herat@chelsio.com>

[ Upstream commit 41aa8561ca3fc5748391f08cc5f3e561923da52c ]

cxgb4_update_mac_filt() earlier requests firmware to add a new MAC
address into MPS TCAM. The MPS TCAM index returned by firmware is
stored in pi->xact_addr_filt. However, the saved MPS TCAM index gets
overwritten again with the return value of cxgb4_update_mac_filt(),
which is wrong.

When trying to update to another MAC address later, the wrong MPS TCAM
index is sent to firmware, which causes firmware to return error,
because it's not the same MPS TCAM index that firmware had sent
earlier to driver.

So, fix by removing the wrong overwrite being done after call to
cxgb4_update_mac_filt().

Fixes: 3f8cfd0d95e6 ("cxgb4/cxgb4vf: Program hash region for {t4/t4vf}_change_mac()")
Signed-off-by: Herat Ramani <herat@chelsio.com>
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3032,7 +3032,6 @@ static int cxgb_set_mac_addr(struct net_
 		return ret;
 
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
-	pi->xact_addr_filt = ret;
 	return 0;
 }
 


