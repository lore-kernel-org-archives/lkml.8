Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A8C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6495C206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pFwqh3po";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSWh/E8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGPOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:24:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGPOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:24:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594909460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dZSSZ7b191xeLPMSuQ9KSH0a1WHjWJlZjlBSp7H9ZM=;
        b=pFwqh3popnCl75JYfU2cVWQSeVAmoKs4YzmjhS/L2RXBR3Gq292B0SrTS9yi96XYHsg+EZ
        gruI0ruwJlXL0LrlmlIoDM8SLRIFFYduTsh106r1BNYm16PPka0wW8YvSoCPqZuKrItZSX
        q/SW5JBSI/e5pOs4RAIHRKvSujhyDnTTmhtpQcl9RjQ3epVYF/t6gKMx/g4DEIU25NjDJM
        rsvjM/FrxpDX+RwpOIV+mjj6uQDMVG6RjVOzUctzyvpeyorrcqOuAl3mtx0Yy/BIc8hLgp
        sISkcv5X5rR0idlyK2xRAwTCCBpP7sS2f8+YNYvPwPCgreTh87NgmRubGF0ROQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594909460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dZSSZ7b191xeLPMSuQ9KSH0a1WHjWJlZjlBSp7H9ZM=;
        b=rSWh/E8C3/+jZx9JuaWaBm0fNSFNP/tZQaGhgg0sDX/Nzr64gBpfa8Lvp+aUw0KimPfZm0
        CnkDgGbMGTRxPwCQ==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] timer: Preserve higher bits of expiration on index calculation
In-Reply-To: <20200715221610.GC16227@lenoir>
References: <20200714072924.6810-1-anna-maria@linutronix.de> <20200715221610.GC16227@lenoir>
Date:   Thu, 16 Jul 2020 16:24:19 +0200
Message-ID: <87r1tbtu5o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> Subject: [PATCH] timer: Preserve higher bits of expiration on index
>  calculation
>
> The higher bits of the timer expiration are cropped while calling
> calc_index() due to the implicit cast from unsigned long to unsigned int.
>
> This loss shouldn't have consequences on the current code since all the
> computation to calculate the index is done on the lower 32 bits.
>
> However we are preparing to return the actual bucket expiration from
> calc_index() in order to properly fix base->next_expiry updates.
> Preserving the higher bits is a requirement to achieve that.

Nice catch!
