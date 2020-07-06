Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB734C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C45206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6kyJxi+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBmG99bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgGFJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:51:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52192 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGFJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:51:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594029103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idMyt0zMxIsqOF8K/ij3lsH8cZlgJZkP4HDjfREuFeM=;
        b=H6kyJxi+nIkRJjAYt1xNX71pvdXKsQbHFHS4MJaMym0HuzH1er15mvd1rHgrpL9sYVWJCT
        yat/SygAuBl79j72kj+T7AZsekbOL74VKDRKpdHOWCJRj95+i3/lXSliCgkFzcOvbooVO9
        q3TXl+z04rBOYlEmoKAtUKArUN1U8toDJz0ND1d2mCdOFsdt9Irjt9Bm/kAehb2CbTKxDk
        GysVE1rZeMMheW1gDhivFPdQjXl6DJU3P6Zrk7dkyEC+9x7dhwpZXArk4sojO0pEJiowIN
        4dJz94jsmOkFKcPtFryoG0NvuPzZNxOz3EQg47zqknv8gueI138QEFL7uwRW1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594029103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idMyt0zMxIsqOF8K/ij3lsH8cZlgJZkP4HDjfREuFeM=;
        b=TBmG99bLvY1drtwKnLy0A2tF0nL3tg04/NqnRLXWAgwjHbU9aLu5+CbqmgDNrvp8uCSaXx
        bJgvoyvTm+7K6hCA==
To:     Paolo Bonzini <bonzini@gnu.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT pull resend] x86/entry for v5.8
In-Reply-To: <8fe756fb-7461-2583-b358-1a31a44d23fd@gnu.org>
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de> <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de> <8fe756fb-7461-2583-b358-1a31a44d23fd@gnu.org>
Date:   Mon, 06 Jul 2020 11:51:43 +0200
Message-ID: <878sfxrmxc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <bonzini@gnu.org> writes:
> On 13/06/20 00:05, Thomas Gleixner wrote:
>>    - KVM
>> 
>>      KVM is inconsistent as well. Patches have been posted, but they have
>>      not yet been commented on or picked up by the KVM folks.
>
> Hi Thomas,
>
> which patches are these?  I must have missed them, and I would like to
> pick them up for either 5.8 or 5.9.

Let me resend them.
