Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F288C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C00820866
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXU/ovLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHZKRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgHZKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:17:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4eLAdOv3FI1lBHbOBS+5I59id8uj4O0VoOm0YOWkXQQ=; b=NXU/ovLD1wZshSvr1GLYnnKiJQ
        WduEx4BRcZp7dWKGywo9s8Bu9R1ntMrWPAjljySA7Bhd80PUzJ24bIh2SB4ET4SXl9HkmcVEPhQ2u
        KurAsLjYslUb+/wOH2tXdIBZaQARn9jVfTBdVp/+sxk9nQqN+FoJ6avE9U20G9rPUer9shXO6B/C3
        Vuio3SjoNMW/ecEIy39MJxSNsAMNCYYLAbPNVMII4KQ0Q3VjzRokiOq/9v+S5zAg8OECjTFfGrYMe
        cEbZsrCYEn28HVTmAW/li4IzzTLKDOTPk+m61vfKX2KqLwXulI+/Y3HvvHl8aIde7gvENAca5GbKC
        AAxpFrfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAsUD-00065Y-4W; Wed, 26 Aug 2020 10:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0744E301A66;
        Wed, 26 Aug 2020 12:16:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D957F2BFE5A17; Wed, 26 Aug 2020 12:16:53 +0200 (CEST)
Date:   Wed, 26 Aug 2020 12:16:53 +0200
From:   peterz@infradead.org
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 12/11] mips: Implement arch_irqs_disabled()
Message-ID: <20200826101653.GE1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821084738.508092956@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/irqflags.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -137,6 +137,11 @@ static inline int arch_irqs_disabled_fla
 	return !(flags & 1);
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 #endif /* #ifndef __ASSEMBLY__ */
 
 /*
