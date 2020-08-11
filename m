Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D02065C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WcGZoU5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHKKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgHKKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:38:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phuSQTyOsMMj+YYoUn41/VtyZh3faVfNjBlSMB4YUww=; b=WcGZoU5zZ2MtTWjOsUh8QPJH0u
        eOTkqh5SntAUSb9R5gR68k1pGHG8qXKgEnLNDsZHx3ic2zKcd7om0T4RKCxBVOFJtlqmf7E2lFCM/
        +qQznmZdNbSVGXQ/JzT9dLYyrRksmFroBrkSYMMO3//V2FoJ8a3udLa3aFgIWQvuIda/tUByCmkPz
        Drj3io9M/O2hVPS5350ZDM4HpOWXrPhZW2t1IMuLY6wUvQl+WhIrAWxVAKuBvlBjCcbEAAuPOUWmn
        Qq4amIQ5LHxiuJZ0gJ+XjPNXwyxjoM13QuuQ3uxT6sKSWgeAafLKa6ItAsCwDdImnaPAJ1hFyjpJs
        53pU9URQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Rg4-0005pK-QK; Tue, 11 Aug 2020 10:38:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C9003060AE;
        Tue, 11 Aug 2020 12:38:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62D4020BFC4E4; Tue, 11 Aug 2020 12:38:41 +0200 (CEST)
Date:   Tue, 11 Aug 2020 12:38:41 +0200
From:   peterz@infradead.org
To:     Will Deacon <will@kernel.org>
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep splat ("possible circular locking dependency detected")
 with PL011 on 5.8
Message-ID: <20200811103841.GC2674@hirez.programming.kicks-ass.net>
References: <20200811101313.GA6970@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811101313.GA6970@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:13:13AM +0100, Will Deacon wrote:
> Hi,
> 
> Using magic-sysrq via a keyboard interrupt over the serial console results in
> the following lockdep splat with the PL011 UART driver on v5.8. I can reproduce
> the issue under QEMU with arm64 defconfig + PROVE_LOCKING.
> 
> Any chance somebody could take a look, please? It's a little annoying,
> because it means when I uses magic-sysrq to increase the loglevel prior
> to testing something else, lockdep gets disabled as a result.
> 

Going by msm_serial, the thing to do is something like this:


diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8efd7c2a34fe..1717790ece2b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -308,8 +308,9 @@ static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
  */
 static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 {
-	u16 status;
 	unsigned int ch, flag, fifotaken;
+	int sysrq;
+	u16 status;
 
 	for (fifotaken = 0; fifotaken != 256; fifotaken++) {
 		status = pl011_read(uap, REG_FR);
@@ -344,10 +345,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				flag = TTY_FRAME;
 		}
 
-		if (uart_handle_sysrq_char(&uap->port, ch & 255))
-			continue;
+		spin_unlock(&uap->port.lock);
+		sysrq = uart_handle_sysrq_char(&uap->port, ch & 255);
+		spin_lock(&uap->port.lock);
 
-		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
+		if (!sysrq)
+			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
 	}
 
 	return fifotaken;
