Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4D207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662251;
	bh=2yd/yHxwxoWbnp4z/oeQpkoW63o4SqIYFSieOWHEH28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAzV18fXFlAZsZX5nwzkeyWIKmUJq+DYNKLiyXkaStDw8Z/rmO9OBL+qh8Q5cog5e
	 ffG4MnllJtwwCgw63yW4JKHUl6RbeXfKVPbhoujmGBzMhghmoKT2SeP+wQuviRCTOs
	 AFQiGLbFNE98P0ak0rl2grR7b44o7XRrjMP1FwoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgFIAYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbgFHXRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3052E2078D;
        Mon,  8 Jun 2020 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658231;
        bh=2yd/yHxwxoWbnp4z/oeQpkoW63o4SqIYFSieOWHEH28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6QvUgUH5EDSSXJCRVRWnMf+928dAMAxiAdW5q0qPJyJVZjOZrOIqLEnptDZNWEKK
         HqfvYnLnanlvHCFKzbOHfpCnmJ7eKUKZ84kg/8bTiq9aYz3DcmkXUD9wY6edEUAptC
         knUg3bEzRVZHz9CjAD5SN4wTiPVYsK4JPZakDQdY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 244/606] net/tls: free record only on encryption error
Date:   Mon,  8 Jun 2020 19:06:09 -0400
Message-Id: <20200608231211.3363633-244-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
 net/tls/tls_sw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 34684b98c792..8c2763eb6aae 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -800,9 +800,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
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
@@ -828,9 +829,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
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
-- 
2.25.1

