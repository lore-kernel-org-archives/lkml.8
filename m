Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E8820672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSAzepY+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPnziurF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgG0Nfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:35:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0Nfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:35:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595856945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eG1kw9cByLDLba+9JXhHfz3Jq5+C2noEAEOZxdZDOEk=;
        b=zSAzepY+nxICGlsy0aLvGhyY5To3CUHknHJ+PYLwz3xhhDjTn/M/t5l0PHdLorbbFiSjuE
        l3rYTa+u9l9omHyIKN1yvGLxgL54UhdTHBxyeJpMy3RR/XYF1kr7gC1vnVIPc3biZJOZ84
        AyJK7KR3dhWCZ10aS2NQWCerLL2D+ILCgxkqSd9TKPltc5uibBxgZxWxRjwDeQfGNsBO+j
        u+ibZY7AchpxvcI+aQVKu2Po5+iQD64ITqEoSM1N7gpRkMbTomfy5I+xTfkZwaAdE75upb
        oizpDHlIyMuSUnkBtqfvNlxn+5ZQAXrfssVOgXGqSaw+UgF+o2N1KBJpWgyUng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595856945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eG1kw9cByLDLba+9JXhHfz3Jq5+C2noEAEOZxdZDOEk=;
        b=JPnziurFtgLjN9iHatLlqALT8UOFEdyfw7cnRhaokIoLIZppTqDerD6CLISSjJ2RBfECW7
        qFNPAjxy7f19vQBg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Keeping <john@metanate.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ben Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] genirq/affinity: Handle affinity setting on inactive interrupts correctly
In-Reply-To: <875zabyeyo.wl-maz@kernel.org>
References: <87k0z2s2q3.fsf@nanos.tec.linutronix.de> <877dv2rv25.fsf@nanos.tec.linutronix.de> <20200724182422.27ddced6.john@metanate.com> <87h7twu1cp.fsf@nanos.tec.linutronix.de> <875zabyeyo.wl-maz@kernel.org>
Date:   Mon, 27 Jul 2020 15:35:44 +0200
Message-ID: <874kptcc7j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Marc Zyngier <maz@kernel.org> writes:
> On Fri, 24 Jul 2020 21:03:50 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Right. My brain tricked me to believe that we made activation mandatory,
>> but that's not.
>> 
>> I have some ideas for a trivial generic way to solve this without
>> undoing the commit in question and without going through all the irq
>> chip drivers. So far everything I came up with is butt ugly. Maybe Marc
>> has some brilliant idea.
>
> Not really. We have contradicting behaviours here, where some
> interrupts want to see the set_affinity early (the above case), and
> some cannot handle that (x86 vectors and the GICv3 ITS). We could key
> it on the presence of an activate callback, but it feels fragile.

Yes, I thought about that briefly, but yeah, it's fragile and bound to
break in weird ways.

That said, we should make activate mandatory and actually set up the
affinity during activation correctly.

Thanks,

        tglx
