Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF410C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F985207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724908;
	bh=YUQ3zE6gHknWLZQ8cWA+ZL/A4ox6L2Wm10Hf9XSjg5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AG7fjVc0NrsfLAPyNn0YIeBmOBYbJ2xDVrYFFQtCNSx+WvaMpfWldkexm2WkWs3fY
	 uvAymvEXTAw5pyqAnBAKvGtl8bMRP0pMhT0507Qs6eKFdKTVh7Hp8pyFJWnyx7xsIV
	 koaFkm/3tVo+K0ELCQFuzvJgDRkH79Q8ee8YBdMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgFIRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbgFIRsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:48:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A4B20812;
        Tue,  9 Jun 2020 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724894;
        bh=YUQ3zE6gHknWLZQ8cWA+ZL/A4ox6L2Wm10Hf9XSjg5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNxUHBkIGRNvBqKRc2p2B/Bo+g7jas+Ay0jTIBJtPLxww/O123NhqUbWDH6A8/RMn
         cAw0eWTS9TEuodPHkvfDcdNVntp0XMiVYfpvKlMP3idHq1L6c34yLEb46RVgMPh3D9
         43fpIbX2tKy6Tdg3owaZLVgEsObjWZ3JwfKq8D2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/42] NFC: st21nfca: add missed kfree_skb() in an error path
Date:   Tue,  9 Jun 2020 19:44:31 +0200
Message-Id: <20200609174018.230484510@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 3decabdc714ca56c944f4669b4cdec5c2c1cea23 ]

st21nfca_tm_send_atr_res() misses to call kfree_skb() in an error path.
Add the missed function call to fix it.

Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/st21nfca/dep.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -184,8 +184,10 @@ static int st21nfca_tm_send_atr_res(stru
 		memcpy(atr_res->gbi, atr_req->gbi, gb_len);
 		r = nfc_set_remote_general_bytes(hdev->ndev, atr_res->gbi,
 						  gb_len);
-		if (r < 0)
+		if (r < 0) {
+			kfree_skb(skb);
 			return r;
+		}
 	}
 
 	info->dep_info.curr_nfc_dep_pni = 0;


