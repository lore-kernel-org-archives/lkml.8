Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22466C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97FB207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538682;
	bh=OOz54nURBDJ/FlpVR17jC8frzVSg3np+p40nJdQ06H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JCAuC5GW7+lf4pVLi+4s32YZfteNcSsb7ca/eaaYeWNA/sCH2/t0hRHaIDatcFcYy
	 SZ8gGMdIaAXxX11loPrhI98lo3FSG4f3tv+QmgrK3FS9ohB47Mra7PCtIZKCVduy5J
	 E406x5PGE7fxeIXsy5JBLeHKWnCmuqQVU1tg5RR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgF3RiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbgF3Rh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:37:58 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6B02077D;
        Tue, 30 Jun 2020 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538677;
        bh=OOz54nURBDJ/FlpVR17jC8frzVSg3np+p40nJdQ06H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miSjsYRjo4dD94F5c3hmtaHZKtmJAskq64XZNSRLmXY8Cz1K9PwWV/Nqdd+kbIN76
         WmQgbQS50TH/dWHsmkcqmcS2v0CMoVVXHAm3cWFrnLguGiq8X0DAgftmMXZ5NxtFNb
         6PWw5KOdAwT9+dDoFosqYwadzVFMn4zwXq4/27w4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH 03/18] asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
Date:   Tue, 30 Jun 2020 18:37:19 +0100
Message-Id: <20200630173734.14057-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meat and potatoes of READ_ONCE() is defined by the __READ_ONCE()
macro, which uses a volatile casts in an attempt to avoid tearing of
byte, halfword, word and double-word accesses. Allow this to be
overridden by the architecture code in the case that things like memory
barriers are also required.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 92cc2f223cb3..f9dfa88fc04d 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -33,7 +33,9 @@
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
+#ifndef __READ_ONCE
 #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#endif
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-- 
2.27.0.212.ge8ba1cc988-goog

