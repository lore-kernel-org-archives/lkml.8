Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA55C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862662080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v9LPHmj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgCXOZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgCXOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BjuFbwXCXjsGFf/yKNz82zlPTTh+u+uBacKL0meRtkY=; b=v9LPHmj7TTb3xkhGiVcWVLLBOy
        XzxrDb+UE98Z9xpLgUEpkX4njI5bNTwEFq8nvJgRAY3Y6meKsQ7dngqNPHJAZRbw36iFC0puvLm3a
        DB4nJaqIIl5BILlETpKlAkPRCUdK5iJ43VQNGgrkOR71UShsBnNyy45F0HPkCFIKOWVSBIKtRzW++
        wRbX6Owok4nsdQOoqzKgeFO6yd+rDPOSx6q44C0i31Ho/2/FdmciRdk1CoIYddOhaYWsvZ53HEMnv
        2KYGhPT1MpTTt13NxXFbEgQ4dGY2HLV3P9e8YYuu3hRp27s9INDFz8W/W8W30s1fvxZZGaTEHUEbB
        35rTbYcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTv-0003ok-3J; Tue, 24 Mar 2020 14:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D9C830785A;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01998286C13AF; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142245.571450580@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 05/17] compiler.h: Make __ADDRESSABLE() symbol truly unique
References: <20200324135603.483964896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
symbol which has a unique name.  However, if the macro is used multiple
times from within another macro, the line number will always be the
same, resulting in duplicate symbols.

Make the temporary symbols truly unique by using __UNIQUE_ID instead of
__LINE__.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -299,7 +299,7 @@ unsigned long read_word_at_a_time(const
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(.discard.addressable) __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer


