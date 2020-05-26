Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41754C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3C320873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519743;
	bh=Cu0VYQZsfxVZA1WqJJmbBtZ+lFPCpOyAmwNLV/tSejI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ck2fU4TLfGxDCmXEs/5xtjoY2Y2dHGc/dR4Z3m8V/J9IrqiXH1L+k55JxhMff5ASg
	 nLJN7trxzMwSfo9D5YFeHGVT7XETipSPYAOW/u91EX7WSDYgY7UNUVN2bIP5dvj1xm
	 fC3YT/lfxSrr0DUNIjN/3teNDTtHRbHiYTmQjcm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbgEZTCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391068AbgEZTCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:02:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505FF20849;
        Tue, 26 May 2020 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519736;
        bh=Cu0VYQZsfxVZA1WqJJmbBtZ+lFPCpOyAmwNLV/tSejI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaTx20TdjzwtkBEKg58/me6oMr5RUZQQzY964EkVDyu+NGKETmkC/g1P9u+2dzOTZ
         xfKQ4LUynzHdeidYV8ULNZvCl6eNAumFOKikT4Yg+sQjkGxbjKxxg7xAAloNC9ubgi
         I51uADPkqaMEcWI7gypJPSXUd2Urvc+Nm0IhBNnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        David Howells <dhowells@redhat.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 4.14 56/59] rxrpc: Fix a memory leak in rxkad_verify_response()
Date:   Tue, 26 May 2020 20:53:41 +0200
Message-Id: <20200526183923.994507252@linuxfoundation.org>
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

From: Qiushi Wu <wu000273@umn.edu>

commit f45d01f4f30b53c3a0a1c6c1c154acb7ff74ab9f upstream.

A ticket was not released after a call of the function
"rxkad_decrypt_ticket" failed. Thus replace the jump target
"temporary_error_free_resp" by "temporary_error_free_ticket".

Fixes: 8c2f826dc3631 ("rxrpc: Don't put crypto buffers on the stack")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rxrpc/rxkad.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1111,7 +1111,7 @@ static int rxkad_verify_response(struct
 	ret = rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free_resp;
+		goto temporary_error_free_ticket;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
@@ -1193,7 +1193,6 @@ protocol_error:
 
 temporary_error_free_ticket:
 	kfree(ticket);
-temporary_error_free_resp:
 	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as


