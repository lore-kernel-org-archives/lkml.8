Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF80EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3692077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034860;
	bh=/1aoE7TQlcktPcUnXVgbfRYbQl0UDGuNM3KVfIf8iV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=grGQsfFfUihWiOoNw+rL0YlVGbVz2OP+Ziv4tyTZuFg19+64iidFER9kh78DWzlS+
	 kN2YJ4EZrOdEPxNMGvp7Cn+JiZ+ZYd/CckvjS0seaUTlFeRHi31WGFqS5igG0tIAhP
	 6R6pbq0CgwNcZzd8VTR3XCCoAPwpOx7dFHm9lZ44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgFASHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgFASHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:07:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60532068D;
        Mon,  1 Jun 2020 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034820;
        bh=/1aoE7TQlcktPcUnXVgbfRYbQl0UDGuNM3KVfIf8iV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTvFn2gQLrOBxgNdGcmxVcTcjjfJunH089MRZJjBbhVR/MZ1XkcP8qc3pZ8lZWrNg
         p9GQftAQ7EKnV3IVOt92RpckWYTLPqu6pQXg7Pgp3iIROGmoXRxCtvWZaaTMKLDBJa
         89BGgg3lmI1A87J6siVD4vh7sWJ2hgi74CscsuiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 028/142] net/tls: free record only on encryption error
Date:   Mon,  1 Jun 2020 19:53:06 +0200
Message-Id: <20200601174040.824690106@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Fedorenko <vfedorenko@novek.ru>

commit 635d9398178659d8ddba79dd061f9451cec0b4d1 upstream.

We cannot free record on any transient error because it leads to
losing previos data. Check socket error to know whether record must
be freed or not.

Fixes: d10523d0b3d7 ("net/tls: free the record on encryption error")
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tls/tls_sw.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -797,9 +797,10 @@ static int bpf_exec_tx_verdict(struct sk
 	psock = sk_psock_get(sk);
 	if (!psock || !policy) {
 		err = tls_push_record(sk, flags, record_type);
-		if (err && err != -EINPROGRESS) {
+		if (err && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
+			err = -sk->sk_err;
 		}
 		if (psock)
 			sk_psock_put(sk, psock);
@@ -825,9 +826,10 @@ more_data:
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
-		if (err && err != -EINPROGRESS) {
+		if (err && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
+			err = -sk->sk_err;
 			goto out_err;
 		}
 		break;


