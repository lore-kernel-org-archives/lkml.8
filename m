Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01149C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE18D20820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X3WeLdiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBIWV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:21:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=oHrGs1dGdPQbwgWos+kTCq0fC9zNrH+A9J4Jo+GOH7I=; b=X3WeLdiY3H3Xk4/9brXDgfcF5d
        J4enS0MiMJFTVJBFHXLa8uRlf7BxIswBfWdrmgNkH/GAxRIqMwOm7lMzKaymBLDdSQ629HnXlKhPn
        V2ej7HYAshEr/OZIo2tiS8WJJ5pjuVupAO2AFJ6fnvXbiEIZGDCLd9PYF2Sbj06/FVq9q6GkTvNH+
        rvauvmMa0CovD2UKseROZ4NRoL8GGQxY/h6hsYjucTWmaBwr0MuxwCZMSPWme52sqbw5ZNE6gFfZ5
        nG9jvQcINdmVWgUA99zHIrfAssCqxX4/bLVwiWAsnspJLTFuG+Jlv/v4GBNB+5BiBlTAh58WFXpnk
        xWSzFzRA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0uxf-0002Nj-O9; Sun, 09 Feb 2020 22:21:56 +0000
Subject: Re: [GIT pull] perf fixes for 5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
 <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91c5d09a-4666-e0fd-723b-ff693c89c526@infradead.org>
Date:   Sun, 9 Feb 2020 14:21:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/20 12:06 PM, Linus Torvalds wrote:
> On Sun, Feb 9, 2020 at 6:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    - Prevent am intgeer underflow in the perf mlock acounting
>>
>>    - Add a missing prototyp for arch_perf_update_userpage()
>>
>>    - Fix the perf parser so it does not delete parse event terms, which
>>      caused a regression for using perf with the ARM CoreSight as the sink
>>      confuguration was missing due to the deletion.
> 
> You've started drinking too early in the day.  But hey, I guess it was
> evening _somewhere_ in the world.
> 
> Pick out the five speeling errors in that pull request message.

to eazy.

-- 
~Randy

