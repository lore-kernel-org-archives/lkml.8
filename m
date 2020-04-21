Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F08C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0392070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587482157;
	bh=ZghpLtg+aUE8swTwNguU8U5WyYDGh+3ZMbYcqMH283E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iR/6fBrTfN2QmWgFrM1zCrDzYD/w/2eQ9euf7ERsmlbWywDLAEhefDngisXx0hNhH
	 QrP7mySVrkU51qq2VL4/jC0kgU9LsXx1ZBgUs429rFXl9NwgI2waqrRupJUmwybQ02
	 zSmvXAz1VfJwfnc7JU2eRg5CpmK9GuJm5QvkmxqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDUPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgDUPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:15:54 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E753F2068F;
        Tue, 21 Apr 2020 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482154;
        bh=ZghpLtg+aUE8swTwNguU8U5WyYDGh+3ZMbYcqMH283E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojP+NfJp6c/4DxURDLiLZpMnpBqLhTnwpbcUDRjyq9c8kK4Ec5KVfoIL2DY9ui1rn
         s+0GXaVyc7I1FReEAdZcde1i9eKECOewCBjzy9V+DH98AV/oz2y6hCn/MANSbQfCBI
         uokTsJ5s0aP28yf7rZF4HVpWl0rgc5Dh7juquLMw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 03/11] net: tls: Avoid assigning 'const' pointer to non-const pointer
Date:   Tue, 21 Apr 2020 16:15:29 +0100
Message-Id: <20200421151537.19241-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tls_build_proto() uses WRITE_ONCE() to assign a 'const' pointer to a
'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
that this will give rise to a compiler warning, just like a plain old
assignment would do:

  | net/tls/tls_main.c: In function ‘tls_build_proto’:
  | ./include/linux/compiler.h:229:30: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  | net/tls/tls_main.c:640:4: note: in expansion of macro ‘smp_store_release’
  |   640 |    smp_store_release(&saved_tcpv6_prot, prot);
  |       |    ^~~~~~~~~~~~~~~~~

Drop the const qualifier from the local 'prot' variable, as it isn't
needed.

Cc: Boris Pismenny <borisp@mellanox.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/tls/tls_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 0e989005bdc2..ec10041c6b7d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -629,7 +629,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 static void tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
-	const struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct proto *prot = READ_ONCE(sk->sk_prot);
 
 	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
 	if (ip_ver == TLSV6 &&
-- 
2.26.1.301.g55bc3eb7cb9-goog

