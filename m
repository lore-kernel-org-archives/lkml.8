Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6460C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F79C20409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845693;
	bh=iirXMFtrjTWqvNqFNKcyiULPcJ9awiu6iFtohtrPwao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vApFXnZK/XR27kbxLqLiV4w/rtQR4IJSlnp9Z1jxBC/GRRWPfgazbosyX0QCxa16P
	 hv8CWBjze+0UlOF8dBAi/NJbm/u2caWiOpCq5pFijzpAcMQoSHNI53SV87lMsK9/9F
	 HHG83lhLv0t9y0jQM1IigL1WizYyu6NyArtwCWjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgCJNIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbgCJNIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:08:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2589A2071B;
        Tue, 10 Mar 2020 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845688;
        bh=iirXMFtrjTWqvNqFNKcyiULPcJ9awiu6iFtohtrPwao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f//htnQxkdKZcH7ULZYHm0zlBiMvwh1cVqRzcVkawqJnAYOMQQGmuGY3Ovnh6Jkny
         i3feYKxjF/EQJrbzTmgm9Ap6bgR7/BVHmKdCj2k8416Fw9oUaDT2ZRRzT7z0xyCeQI
         NOHdArKVz0/pLT97wa87ssmT11CIX6jsIhHTNydU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Qian Cai <cai@lca.pw>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/126] [PATCH] Revert "char/random: silence a lockdep splat with printk()"
Date:   Tue, 10 Mar 2020 13:41:26 +0100
Message-Id: <20200310124208.239864688@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 28820c5802f9f83c655ab09ccae8289103ce1490 which is
commit 1b710b1b10eff9d46666064ea25f079f70bc67a8 upstream.

It causes problems here just like it did in 4.19.y and odds are it will
be reverted upstream as well.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1598,9 +1598,8 @@ static void _warn_unseeded_randomness(co
 	print_once = true;
 #endif
 	if (__ratelimit(&unseeded_warning))
-		printk_deferred(KERN_NOTICE "random: %s called from %pS "
-				"with crng_init=%d\n", func_name, caller,
-				crng_init);
+		pr_notice("random: %s called from %pS with crng_init=%d\n",
+			  func_name, caller, crng_init);
 }
 
 /*


