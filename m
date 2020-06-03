Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EFD2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="ShRdjmyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFCIPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:15:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:16762 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCIPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:15:02 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 04:15:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591172101;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=SMtbScWM+JGPqXIY91ce2dI3CfZP51GyTspyQruYuIs=;
        b=ShRdjmyA0jM/NQOZ6A8bKp3VH12GfnI5Uz+EvmBAy6OHGQYa/zU3TFcnbwAuRzknCr
        KoUZwWxpJ+JkQo380VKPk6Cd94DE60dxnPK2hN1Uvrr5N69bgmmNhRudB2OIRt0eMUzn
        IQgJyHRme1xyVKbzFZENheiORGgxWPKlzghiSlqrBzfU28uxJ1lj9XowjnjIrAc8w1fu
        mBKVu6kbTFZnsoAmPPMSSfVa5YPKiIzBW91iP7LadFZp8qX5oNnOhFeTx2hH7TbV6a53
        TSjQD4hIAQhtqj4WhDVLqtcViaNksqFy0gkaZZUcXNolaL8Yw+yWIy5BYCl4KLKV4KTQ
        U9+A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJPSf9iic"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.9.1 DYNA|AUTH)
        with ESMTPSA id I05374w5388v0vu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 3 Jun 2020 10:08:57 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>
Subject: [PATCH] crypto: DRBG - always try to free Jitter RNG instance
Date:   Wed, 03 Jun 2020 10:08:56 +0200
Message-ID: <2583872.mvXUDI8C0e@positron.chronox.de>
In-Reply-To: <0000000000002a280b05a725cd93@google.com>
References: <0000000000002a280b05a725cd93@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Jitter RNG is unconditionally allocated as a seed source follwoing
the patch 97f2650e5040. Thus, the instance must always be deallocated.

Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com
Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B ...")
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 37526eb8c5d5..33d28016da2d 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1631,6 +1631,9 @@ static int drbg_uninstantiate(struct drbg_state *drbg)
 	if (drbg->random_ready.func) {
 		del_random_ready_callback(&drbg->random_ready);
 		cancel_work_sync(&drbg->seed_work);
+	}
+
+	if (drbg->jent) {
 		crypto_free_rng(drbg->jent);
 		drbg->jent = NULL;
 	}
-- 
2.26.2




