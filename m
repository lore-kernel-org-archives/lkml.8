Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A34C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716B820738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RPyx5VKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgEVRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:02:01 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:51556 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgEVRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:02:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49TCT42jLrz9vcjp
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 17:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E6GyK1Vwh4Gd for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 12:02:00 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49TCT413kJz9vck1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:02:00 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49TCT413kJz9vck1
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49TCT413kJz9vck1
Received: by mail-il1-f199.google.com with SMTP id h19so9063343ilo.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcvktWzuf/YXJY7B0r0fkd4cBPlRZYMazd1bG7Knz0c=;
        b=RPyx5VKZg01nlilTUwX5Cmiq3CYO1XGWWWpwNXEK7NinUgy+CEPWCAB5Rw0fQ2MW/h
         v7yt5WyOEyoMtST0NTAnPyD5sZq8NKBky5hEKpu3vgfPED3qBNYzj4oiUl4G6nNihcBC
         ZWbHrKs/Q6vCDck4adYyE2HOAaxtk926rpEE+Tq/QmCMsY5mF2WJFm1vNwV5IyL2E6ta
         s9Ldm4IsuP1H+9FLCOeIlLdCTrojz8RMifIsyzprSlJRpRQI0J6ucIVsJqPFigBC5pxM
         if5hJaBJ7AReU8zY8tiCuZiIosqLxKqu+6mnps6NZBcZU35Rx8/t49wNIcHQSkCbHo/A
         BvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcvktWzuf/YXJY7B0r0fkd4cBPlRZYMazd1bG7Knz0c=;
        b=F/RMbp6x91glQ65HC0WLTAtMZRFpvxI0USjSQpf2F00j0PAoCFv226rtwEcNfFQtq5
         17Ywudb1sCBQCqTTiHnjM3OWADifqWDslLADiVIUzRUQZ27mzTVHql7q/BitAVT0U8bK
         yjKJYqmXJJq8AU3V5hyd/DxeLdlemwQD9NcU0R2e1wc4xJ0mL+BoJexx926oe1xc4iaw
         dK9DVByQrVhnWRxYdRnziL3pjrCauhwiZbNF6fg8l07U8MEQBsyQY3+PvesV5eT/6gRY
         i3T6CagOLHh38ce3i/TQbcQ05wGhnS4dtYW/Z+6IFYQgyW71+mshwAd0DnAr6t3cNGQn
         i4eg==
X-Gm-Message-State: AOAM530D2LCmR28/0JTTkxayJqDlIYP0D4VpPC/bgUDKoFFK16klZwjq
        LXGUPw+EBAAVrthQo0vdH3z6Vjc4nz+eYgfuLnrRQQkvFisMjmajlpNfvF2HjgukzogsUOv+nO+
        FvuZGobGFNHYMWGg6/KuHf5PgcU86
X-Received: by 2002:a92:5acb:: with SMTP id b72mr14247792ilg.76.1590166918954;
        Fri, 22 May 2020 10:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKXeudn5JD/jVIbjuH9rx5TwDU+GyZP+kgSPDsbHyJXtF9ElTagjdAhKOHLdsLYAK1IWG6hw==
X-Received: by 2002:a92:5acb:: with SMTP id b72mr14247737ilg.76.1590166918456;
        Fri, 22 May 2020 10:01:58 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id o70sm2427477ilb.86.2020.05.22.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:01:57 -0700 (PDT)
From:   wu000273@umn.edu
To:     dhowells@redhat.com
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH v2] rxrpc: fix a memory leak bug.
Date:   Fri, 22 May 2020 12:01:27 -0500
Message-Id: <20200522170127.23033-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

A ticket was not released after a call of the function
“rxkad_decrypt_ticket” failed. Thus replace the jump target
“temporary_error_free_resp” by “temporary_error_free_ticket”.

Fixes: 8c2f826dc3631 ("rxrpc: Don't put crypto buffers on the stack")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 net/rxrpc/rxkad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 098f1f9ec53b..52a24d4ef5d8 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1148,7 +1148,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free_resp;
+		goto temporary_error_free_ticket;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
@@ -1230,7 +1230,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 temporary_error_free_ticket:
 	kfree(ticket);
-temporary_error_free_resp:
 	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as
-- 
2.17.1

