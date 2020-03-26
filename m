Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA873C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7257B20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WZc/z+v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgCZPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:44:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgCZPoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:44:46 -0400
Received: from zn.tnic (p200300EC2F0A4900B0CADCDCA21F3A81.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:b0ca:dcdc:a21f:3a81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26BA31EC071C;
        Thu, 26 Mar 2020 16:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585237484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BVDvZvAIdAd5udwvrbCE2Gbrcj5a3svG6cMRE7bieos=;
        b=WZc/z+v2GxCi59DQxlLF+LBFExumKRfJvedtq7+8ji2GBHEqlCeI1WwRJ9c8H4ZM0O/ES0
        r0Dtd6tJXIeGiSMxnSedbKaKUEe3qWt6gK9NSJ6UbE9el1k1QGNZpq1aXbdDh/M0LJrQzP
        OrZfg8O+d/qd+nkEU9iGYZNDAMN3HEY=
Date:   Thu, 26 Mar 2020 16:44:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 11/17] static_call: Simple self-test
Message-ID: <20200326154439.GD11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.940973110@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324142245.940973110@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:14PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig         |    6 ++++++
>  kernel/static_call.c |   28 ++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Should we say something?

---
diff --git a/kernel/static_call.c b/kernel/static_call.c
index b7b7fb58afce..2f27cebd5abf 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -10,6 +10,9 @@
 #include <linux/processor.h>
 #include <asm/sections.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) "static_call: " fmt
+
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
 
@@ -381,6 +384,8 @@ DEFINE_STATIC_CALL(sc_selftest, func_a);
 
 static int __init test_static_call_init(void)
 {
+	pr_info("Running static_call selftest... \n");
+
 	WARN_ON(static_call(sc_selftest)(2) != 3);
 	static_call_update(sc_selftest, &func_b);
 	WARN_ON(static_call(sc_selftest)(2) != 4);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
