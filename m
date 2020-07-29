Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8CC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595992772;
	bh=J0I3nVDnFszgk7mY5qj7o4ZD7d2KXmEqzORuJ7Ziyvs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kpFoh+lZnVcLkIMKjAX0sDcs89b5HUITUB1YtgOnfvi2/xUmecYSWL1qVYd2k3WiR
	 gGh9xMOjjlm5ERX4tl+FrZD/6noe8dSWx9SJgqdPiO8YEWAfr6U9k0ys4Us46jyJ96
	 nzUYyKn8AjDD0yNEA+icTJsO0yQHbmQVJszES71U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgG2DTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:19:31 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:65386 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgG2DTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:19:30 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 06T3In2l014195;
        Wed, 29 Jul 2020 12:18:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 06T3In2l014195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595992730;
        bh=Aqvte3DD/AyUCy7Xdqzd/obevCR0/al1WB3hYmo2NQY=;
        h=From:To:Cc:Subject:Date:From;
        b=y1DJo4oQH5A1nPsfamA7v4G2OFAZ5qcbBRco+DkEzPxJ+hEMkJXtX3i8WCo+PjU6J
         dVm44M0iMSf+KAgVW0c08NUwhszSEPkvx4JrBsdIoGxlEuqNjCENdUitvtaoHNUt3t
         h0PPu6lXqy+RsZ/IHRI1TT9zVK1GLPva47m/VDxGZ+8qOCTbMZ97+vH6c43QklYG2n
         mwrZYGDZZ0d45MdNQLak5v+QALWFkafD76h8IK8T3jNHVPvr+k7MnLNzZyVp5Dki/o
         lJMcZfr1jgb6U+IME5Juesj1n5cYMPFvr2s2jHliQcKJbFVQ/3deT9r4NEqIkb7nnd
         rPdkMuUquU6Sw==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] extract-cert: add static to local data
Date:   Wed, 29 Jul 2020 12:18:45 +0900
Message-Id: <20200729031845.38333-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning from sparse:

  scripts/extract-cert.c:74:5: warning: symbol 'kbuild_verbose' was not declared. Should it be static?

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/extract-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index b071bf476fea..3bc48c726c41 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -71,7 +71,7 @@ static void drain_openssl_errors(void)
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
-int kbuild_verbose;
+static int kbuild_verbose;
 
 static void write_cert(X509 *x509)
 {
-- 
2.25.1

