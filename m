Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE53BC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDAD20644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255372;
	bh=o5+VVv/NdrgfdXFjKKdDinBsvD48G4NvcvDVyOKNL5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GElDJ8o27iEJU69Mwa9TRlmUJ8cfbonXxsoVcuxP8HMosWOclY48XXW4PASDJsid9
	 RSr12CZji1aPTCQg64NmJ/8Bcdc4GD0GjEoEPFNka4VrJMGr5lxgpc1W6f6yTfhQWy
	 3DwCtSo2uDDeahCVHp3QKMlo67yjvacO871eqa4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgDGKXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgDGKXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:23:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE0E2074B;
        Tue,  7 Apr 2020 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255013;
        bh=o5+VVv/NdrgfdXFjKKdDinBsvD48G4NvcvDVyOKNL5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bY+/aXK2fOJwV93C8f92q9mskGDANNoEKakgxYDn1L3/r61L5xjKnbJ+ARzCZ5sbP
         Wkq8GyCjwSaxsSvlBEmU8kvoOCpnDpVhXdCl5uMispPzALdP5Xvy22l8zQkwm0I8f2
         YBxcao73dlsejg36e4LWk1Q2f/shIQ7e5OtOJmv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 5.4 31/36] rxrpc: Fix sendmsg(MSG_WAITALL) handling
Date:   Tue,  7 Apr 2020 12:22:04 +0200
Message-Id: <20200407101458.244820493@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101454.281052964@linuxfoundation.org>
References: <20200407101454.281052964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 498b577660f08cef5d9e78e0ed6dcd4c0939e98c upstream.

Fix the handling of sendmsg() with MSG_WAITALL for userspace to round the
timeout for when a signal occurs up to at least two jiffies as a 1 jiffy
timeout may end up being effectively 0 if jiffies wraps at the wrong time.

Fixes: bc5e3a546d55 ("rxrpc: Use MSG_WAITALL to tell sendmsg() to temporarily ignore signals")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rxrpc/sendmsg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -58,8 +58,8 @@ static int rxrpc_wait_for_tx_window_wait
 
 	rtt = READ_ONCE(call->peer->rtt);
 	rtt2 = nsecs_to_jiffies64(rtt) * 2;
-	if (rtt2 < 1)
-		rtt2 = 1;
+	if (rtt2 < 2)
+		rtt2 = 2;
 
 	timeout = rtt2;
 	tx_start = READ_ONCE(call->tx_hard_ack);


