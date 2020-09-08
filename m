Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9379A20578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaDSFrEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgIHTnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbgIHPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D60EC061258
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WSc8H+DU5ZkqNcokJmKPoYzJ+ZdTLFtz8w7HeaUMdCM=; b=FaDSFrEh7wJYLwU2f1dpcXlups
        Pohkjz35EdUwL7AgLaB/Wlm2WG9rG8N97vRAAxnWSkbSnd/NuchBBTEmJNMaggfc36XD5PWj6pyic
        qnk4CvDrVogCQrE2MfHV48nlHdky8ir1s8qhVZxci++3n6+upM3jwZKKpMWycvlj74A051I7SYWWe
        K1AI9moXJdEHmRWyPo2XY5mAgzn6G8KyqUyzatfyw7bL7SfdycJGsVpNQ2bnQq6QsygiID7HzYZq/
        n7PFTBXQaBx3HHwIvCjI4bQx/VX7SQanccEbC66LAuJQ84VXzX+Z5xqtgqfyF6X0jyb0NY0PJt74d
        lsJbbVAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFfkv-0005lq-2P; Tue, 08 Sep 2020 15:42:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DA363010D2;
        Tue,  8 Sep 2020 17:41:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 694542B4AF769; Tue,  8 Sep 2020 17:41:57 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:41:57 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
Subject: [PATCH] sparc64: Fix irqtrace warnings on Ultra-S
Message-ID: <20200908154157.GV1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
 <20200902042137.GA163925@roeck-us.net>
 <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
 <20200902091247.GX35926@hirez.programming.kicks-ass.net>
 <559ff09a-275b-21bf-15f1-daa0d02d1c76@roeck-us.net>
 <20200908142215.GU1362448@hirez.programming.kicks-ass.net>
 <b52cdc64-bb37-077a-eb8b-9615e341d069@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52cdc64-bb37-077a-eb8b-9615e341d069@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:40:23AM -0700, Guenter Roeck wrote:
> qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
>     -initrd rootfs.cpio \
>     -kernel arch/sparc/boot/image -no-reboot \
>     -append "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" \
>     -nographic -monitor none

Thanks I got it. Also enabling DEBUG_LOCKDEP helps (-:

---
Subject: sparc64: Fix irqtrace warnings on Ultra-S

Recent changes in Lockdep's IRQTRACE broke Ultra-S.

In order avoid redundant IRQ state changes, local_irq_restore() lost the
ability to trace a disable. Change the code to use local_irq_save() to
disable IRQs and then use arch_local_irq_restore() to further disable
NMIs.

This result in slightly suboptimal code, but given this code uses a
global spinlock, performance cannot be its primary purpose.

Fixes: 044d0d6de9f5 ("lockdep: Only trace IRQ edges")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
A possible alternative would be:

	local_save_flags(flags);
	arch_local_irq_restore((unsigned long)PIL_NMI);
	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS))
		trace_hardirqs_off();

which generates optimal code, but is more verbose.

 arch/sparc/prom/p1275.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d8..e22233fcf741 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -37,16 +37,15 @@ void p1275_cmd_direct(unsigned long *args)
 {
 	unsigned long flags;
 
-	local_save_flags(flags);
-	local_irq_restore((unsigned long)PIL_NMI);
+	local_irq_save(flags);
+	arch_local_irq_restore((unsigned long)PIL_NMI);
 	raw_spin_lock(&prom_entry_lock);
 
 	prom_world(1);
 	prom_cif_direct(args);
 	prom_world(0);
 
-	raw_spin_unlock(&prom_entry_lock);
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&prom_entry_lock, flags);
 }
 
 void prom_cif_init(void *cif_handler, void *cif_stack)
