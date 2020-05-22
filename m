Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BD3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F127D206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gQ7VoiSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgEVSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:45:28 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:34208 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgEVSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:45:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49TFmQ6gKKz9vKTr
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IwEpIpJhKK2U for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 13:45:26 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49TFmQ50xnz9vJB8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:45:26 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49TFmQ50xnz9vJB8
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49TFmQ50xnz9vJB8
Received: by mail-io1-f69.google.com with SMTP id o21so7827832ioo.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcvktWzuf/YXJY7B0r0fkd4cBPlRZYMazd1bG7Knz0c=;
        b=gQ7VoiSWNDAurX2rgbSypPcmLB7w9Jvn08mBdJMJuHb25/wtGmnfpprU+6c5L3QG3/
         bzsM9SuomxldGrYsmbNh14S+TTNHtS15CQQucWHvoC50LV9ND9hkZahbIy5y9kTK4oTM
         wsnPs27cKSJV9geYLWjU3NUMGP3vRiAbaCA7ukKMzFJUUS+iCdBe0F8vudzvwOfh6Vuj
         Bci9Gp8t5f1zdZDGWPBEl9CY3EMVnwzN3R8SE0cPrUeDObg5yX5UUGbNbrpDt1pvVQf2
         I7MFa5IVLeLpg5DqLYm2Edbm/awA8ohROq2iHKNlZAyQa6VD/u9bAKg5TEtg2Ar8KX5U
         pvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcvktWzuf/YXJY7B0r0fkd4cBPlRZYMazd1bG7Knz0c=;
        b=ALB+JFMhgtLMxiNanDPjyEAR01NwYt7S3FZ06cUlt3HYCxbw1a3TFLHyz0ZCaszKqv
         yEnZqufYOdJilLaKxMxa70w+eDrt3FaTfVXmpc4s6VwWBJbW9lor2S3dqeqj4pmdSBq1
         eOGfJhngZVqgq8NgEdiDbQxK4GzhN/31AxluaCnCgUHP9WGhd/J/00KZ+7qqi+r0Y7np
         lO8ODqFPajLwSmsQS5Yau/GSwfnR6106Q96+cR+Op/UHJ+HpXI7kFcFlsGGJkhW0c3MP
         iQ4FShu1g4xKMqQfLKXD6LwgZPkluuJufKwVYDqiT6K+Hva0vLghZmLMMW66jz8Azv/s
         Zotw==
X-Gm-Message-State: AOAM531qZnWpwkmR6UCgC5ReHXHJh6pbHfLsa10fW7ReOjH5rbpHK5oV
        xt+wTNO9O3/e8UcpX3gKAI318MEJ+GSrG9OZtoPdElXKhDkAYbrkGNL2XD5D0FWx8TbMVkcVR3c
        tsmUPa1OfccrZGXvgFC+wwLeuaWSH
X-Received: by 2002:a02:942a:: with SMTP id a39mr9335834jai.50.1590173126219;
        Fri, 22 May 2020 11:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq7xTVOmomZtExLcWH5Wmv5DCntGP0+yx8VBEomiAdvM5u/Is+jMFWSfoirA2k795Um2KKfA==
X-Received: by 2002:a02:942a:: with SMTP id a39mr9335815jai.50.1590173125861;
        Fri, 22 May 2020 11:45:25 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id 13sm4012617ioo.23.2020.05.22.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 11:45:25 -0700 (PDT)
From:   wu000273@umn.edu
To:     dhowells@redhat.com
Cc:     Markus.Elfring@web.de, davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH v3] rxrpc: fix a memory leak in rxkad_verify_response().
Date:   Fri, 22 May 2020 13:45:18 -0500
Message-Id: <20200522184518.26323-1-wu000273@umn.edu>
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

