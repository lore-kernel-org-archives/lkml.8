Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07B7206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gWX3bduA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgEVFBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:01:48 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:60272 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEVFBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:01:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49SvV33FnHz9vBtF
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IqlKsBo8SALh for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 00:01:47 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49SvV31dDkz9vBtB
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:01:47 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49SvV31dDkz9vBtB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49SvV31dDkz9vBtB
Received: by mail-il1-f200.google.com with SMTP id m17so7630017ilq.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PKNUiHK9Hb2/cZzi/FocwTzEpdCaBMxhZnTs6WEbQRc=;
        b=gWX3bduAFtQnUWf4ap1h8sk1OX5aCUOFhenEC65fDEcuw0mzrWt7+M/2t9/aT6ngJx
         FPG41a5BJlAn4XgSJhybY1ScsSJlTC0GDZle/ROvDwB4jLLlaIpbrS0WfOuK49m/5RUf
         dL/SFr5MUX4bccLA4bq0cI/6bCIXHTU6ex/XQVljmGEA1fe1uHs5NXGgRZ4TSRTOYWru
         /jWxkuujky6gBYrdUGVqAnS41Rfl/XB7aUQtyGjb24wyvsP8oDqkupEaI4IlkGrR1s/z
         2pyACcHa65CN2/L2UzLNFDS0b/EFgy6C2DSUXk0GBahpk05QffxLGjb7mMkhsd3vuoJG
         QwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PKNUiHK9Hb2/cZzi/FocwTzEpdCaBMxhZnTs6WEbQRc=;
        b=jlM+Yzc2GBeUNGfIJc3dzUagOmMkcJwFQX30Pf+uCK/w41M/4JcgBnsgxlsJleQFsd
         uvagFbiGa4+R5huYXB8XrWtfoLwamlB3e6fVdLsEj4m2NOyD7y3ieMR+Pgh0xqVCVNlT
         PmEWbrMXKDZgKU8U5SmPPbgX5AiMqKxgtnVyNDZmtYSa36IkrrhBagve69a+E1RBvl7P
         asl40US37auR8ASmNEuge3P0rneyi1z1XjIbUlLgywFbYVwFUr/l3RC0981mIKnn7xBP
         BTRsotSiGtmo6CImXjQPrIbLPgKAVRhBZvRqasKVfBZoCi5wrB6/VvbU+L8sRqC/T39N
         /LKw==
X-Gm-Message-State: AOAM5312VCYRSLSKCvmsC13mg65t6uS5nl56Gbq4kmdRBVH6Q237JNdm
        CPVuyiP9gyHutD3mzLtL/Eb4TU2VHoIRH12s4aLS1VFYUQztDHgVu9pBKyZvN/mFKPJBt2E7uIr
        lRYNzvRP756C5n44OE19SquRuasvj
X-Received: by 2002:a02:54ca:: with SMTP id t193mr7008001jaa.26.1590123706718;
        Thu, 21 May 2020 22:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJwmNLYhrE/pUNUnqwv/haakA9gU7GWmulh8h6dkVQOIh2qLlZbtTntT/fT/VGWj/bte33nA==
X-Received: by 2002:a02:54ca:: with SMTP id t193mr7007970jaa.26.1590123706362;
        Thu, 21 May 2020 22:01:46 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id l16sm3998886ils.64.2020.05.21.22.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 22:01:45 -0700 (PDT)
From:   wu000273@umn.edu
To:     dhowells@redhat.com
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] rxrpc: fix a memory leak bug.
Date:   Fri, 22 May 2020 00:01:29 -0500
Message-Id: <20200522050129.30148-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function rxkad_verify_response(), pointer "ticket" is not released,
when function rxkad_decrypt_ticket() returns an error, causing a
memory leak bug.

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

