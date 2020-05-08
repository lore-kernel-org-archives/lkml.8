Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F194C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D6724957
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943623;
	bh=pnh/ll8ERzz4v1Jqn1vEW7QrDYbv7ESzpKqHvw/5Nlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GobC6XhYzdZi+4up8YQqjiBAcho1QRe3B/bdJT7/WVZKsHmxsIvoMsmeQJYS0OBL8
	 ClxgQB3qwbuG3es4ttHlA9FcHIm+j6VJPkVTGjtDxkyIAXgjz6YdQS3WERiSswWfGI
	 PzEes/YKzreQGbIPFBMAnMGA9bB0kIkp430UAvDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgEHMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbgEHMrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0873224969;
        Fri,  8 May 2020 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942056;
        bh=pnh/ll8ERzz4v1Jqn1vEW7QrDYbv7ESzpKqHvw/5Nlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cx2lucbFz2mGl0rSFfOwj7rUIR/Mz4Rm8Nel+ZJL2jdjw52AsgExKo2QNVYrIVSj7
         z497+N3MtHOLQiRnrWA8teAbTuyp4Hg4H+7GAqTkWj6hf1pwJPqZ+nV53so5/H7g9H
         XTbK3adbYl2ZvdF77RKm2StKughz+JeYfVlRRfoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 272/312] bnxt: add a missing rcu synchronization
Date:   Fri,  8 May 2020 14:34:23 +0200
Message-Id: <20200508123143.565452279@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit e5f6f564fd191d365fcd775c06a732a488205588 upstream.

Add a missing synchronize_net() call to avoid potential use after free,
since we explicitly call napi_hash_del() to factorize the RCU grace
period.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Acked-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4250,6 +4250,10 @@ static void bnxt_del_napi(struct bnxt *b
 		napi_hash_del(&bnapi->napi);
 		netif_napi_del(&bnapi->napi);
 	}
+	/* We called napi_hash_del() before netif_napi_del(), we need
+	 * to respect an RCU grace period before freeing napi structures.
+	 */
+	synchronize_net();
 }
 
 static void bnxt_init_napi(struct bnxt *bp)


