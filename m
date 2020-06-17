Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2653C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886CE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seuRBQQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFQWCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:02:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0296C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:02:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so4264031eju.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4GQU+Ak6vDeugqH+L9eb4VI0/sz8RT+gMEBBpPLtPc=;
        b=seuRBQQg3oh6kPnVvkEqvGbnbS+7+UJwfKkgBUO0KiZDLOMu4MUGmqGcZaQl31zaCK
         /PiPTLnZsBb306sehvPFLhX4ZaRl6iP/qWk5B1VnRFLbbby6ejt0I2yaEwOhCeIJbTT3
         KC0PGnDugKOFnQIBpKZIiPoA1jB7Hb2BxmausqwezphnfAf/WpcWtjoRplHr2g31D1Pb
         SxwYEQXFMGe1AXsmnEAI05FULpBZ5jDP3N/L26eYfPTwYy05VXGo9EMNTOu+hQiCU89x
         U/l6xmVHbdQPkczfFvScC6sYtbY+c5YEku1TWjcJm4s1H3D2ooGzGooSvQdYj02omibM
         3TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4GQU+Ak6vDeugqH+L9eb4VI0/sz8RT+gMEBBpPLtPc=;
        b=ZFBxo3c4W+HdBKj0p/jD6B8rVArMsGKs5t8FnZ2dbGDabYHQqvWAWj7mzSagcIrn3o
         O+dvF+1ynX7ZGSsh5RV/CohC654MTSuz4HXWExZ/5as1f3WIlOgCcBxX8WFU6AxDLtPq
         mOhxY9yhukbxTkSGjwDTx9uSoIzl9okc5P3ExcdxEH2i8jW18ICWzyr3WC7Sya55rTQd
         3G2yZBLzGw8DOUp2/mjEoWa1CLOt++bFtXM/aImk8rGOhb4cBlQ+6EnMzbIIewAkHwBh
         IsUkD+4k+m4YwNqsb19VJBD1UXz4UX2ejFwEqbV802/6qxVPEzg8CysMB+87eE+IXmZb
         B3Dg==
X-Gm-Message-State: AOAM531qNmJ+VUwnPT2FBCcH9fn/H38ctH3Pi42GraB6hr1w9mDJ2Q0L
        ilB5UtsWDW74zjI1PJFqm/w20P+U
X-Google-Smtp-Source: ABdhPJxRaGev9w7pQ8uhq0yndevhqTw9lG6OrHysnUhpmfRcsxeOQsdmz32LEoMs+sv9Wque8AXg6Q==
X-Received: by 2002:a17:906:3745:: with SMTP id e5mr1170455ejc.19.1592431351484;
        Wed, 17 Jun 2020 15:02:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4d22:7f40:3ec9:4c8f])
        by smtp.gmail.com with ESMTPSA id n35sm610361edc.11.2020.06.17.15.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:02:30 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: use identifiers to define address spaces
Date:   Thu, 18 Jun 2020 00:02:26 +0200
Message-Id: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, address spaces in warnings are displayed as
'<asn:X>' with 'X' replaced with the address space's number.
But since v0.6.0-rc1 (late December 2018), Sparse allows
to define the address spaces using an identifier instead of
a number. This identifier is then directly used in the warnings.

So, use the identifiers '__user', '__iomem', '__percpu' & '__rcu'
for the corresponding address spaces. The default address space,
__kernel, being not displayed in warnings, stays defined as '0'.

With this change, warnings used to be displayed as:
	cast removes address space '<asn:1>' of expression
	... void [noderef] <asn:2> *
will now be displayed as:
	cast removes address space '__user' of expression
	... void [noderef] __iomem *

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 21aed0981edf..e368384445b6 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -5,20 +5,20 @@
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
-# define __user		__attribute__((noderef, address_space(1)))
 # define __kernel	__attribute__((address_space(0)))
+# define __user		__attribute__((noderef, address_space(__user)))
 # define __safe		__attribute__((safe))
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
-# define __iomem	__attribute__((noderef, address_space(2)))
+# define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
-# define __percpu	__attribute__((noderef, address_space(3)))
-# define __rcu		__attribute__((noderef, address_space(4)))
+# define __percpu	__attribute__((noderef, address_space(__percpu)))
+# define __rcu		__attribute__((noderef, address_space(__rcu)))
 # define __private	__attribute__((noderef))
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
-- 
2.27.0

