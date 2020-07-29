Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F130DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F232084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlonqerR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/0PcZWm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgG2Ixf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:53:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgG2Ixb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:53:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596012808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pQaj97fsOJ3H+Osv6qlrM9fYlqURwvN/eVEUt3eeEY=;
        b=zlonqerRO3EuudUBo4ZqqTjTLmbZL9UAwX4u4O/WFqAcNGnV9/aDOU6RzS7XPqyUDQ+YkM
        EmU+KftHBBuKtuk4ygsxsulwl0rLRN/dD9hpFRDVvsSdSM1KTt7vNpg0EpsTBf6NEoNkKi
        TUgS0Fta0+g7CxR/YFu0NXJcg6dAOYjmcfdk31aeBU2JD98HMlLR6T2WxkykaN68HCa6YP
        QjzbqRJ1viyzep9wygDm9ce6DtOuxwQ25N2AjfSlUbw+LPS9vFv+hPoBP/Sj4CS4/6XaD2
        XcSLnlpivUov0Yw0eLtT8ugSDIzS4ARwMacrCLera/EDRujqRb+J5KqpxBff3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596012808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pQaj97fsOJ3H+Osv6qlrM9fYlqURwvN/eVEUt3eeEY=;
        b=/0PcZWm8Pxx+OSiaPyt+9k/9V7huKe18t4rblEbA8yB9k9izDz9vPRxKFW2nSw6jpttp/P
        W86B7FdFEkM6xTCA==
To:     kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        x86@kernel.org
Subject: x86/i8259: Use printk_deferred() to prevent deadlock
In-Reply-To: <20200728090216.GE23458@shao2-debian>
References: <20200728090216.GE23458@shao2-debian>
Date:   Wed, 29 Jul 2020 10:53:28 +0200
Message-ID: <87365abt2v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day reported a possible circular locking dependency:

Chain exists of:
  &irq_desc_lock_class --> console_owner --> &port_lock_key

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(&irq_desc_lock_class);

The reason for this is a printk() in the i8259 interrupt chip driver
which is invoked with the irq descriptor lock held, which reverses the
lock operations vs. printk() from arbitrary contexts.

Switch the printk() to printk_deferred() to avoid that.

Reported-by: kernel test robot <lkp@intel.com>                                                                                                                                                                                                                                 
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/i8259.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -207,7 +207,7 @@ static void mask_and_ack_8259A(struct ir
 		 * lets ACK and report it. [once per IRQ]
 		 */
 		if (!(spurious_irq_mask & irqmask)) {
-			printk(KERN_DEBUG
+			printk_deferred(KERN_DEBUG
 			       "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
