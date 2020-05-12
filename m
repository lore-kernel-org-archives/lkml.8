Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB5C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF28206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jVaQIBsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgELKmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:42:08 -0400
Received: from ozlabs.org ([203.11.71.1]:49809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgELKmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:42:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49LvWJ4rq4z9sRf;
        Tue, 12 May 2020 20:42:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589280125;
        bh=irXY0vtb9zPvMX2q8c25NXhSXgzVaOoD927epiNXh70=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jVaQIBsA9/RvJnWQmp6Engcr92niJPir1oeJaEEd7rimbfWX8KTC7gMirQsjqBUab
         dtmzfksFEKiKvtXOI47pWgU/CjF6XP9nuiLgAuI+fwywpzGuqmQkHIwqpirlIeiwF+
         d/iFl6RbsFFh3d+OBNoEVMUtaQxSOzYfG59/OZVCtVdQQkzuQ4SRq9XpN3ly97V7Sl
         szVGU3QoI8Ge4GZnZepSuK19bE2UI0UTc966yfM/9VhdHhDtycOUKrRLvqR1WtOFqx
         G0miMHvi9gdP4EZalGKz1uQoXKo5ulZ8ue6cUpjCLBHCiYDm8WbZi8sKl+kw9zA/2w
         cy8aYJSKkZtkQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, peterz@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
In-Reply-To: <20200409002726.GA5135@blackberry>
References: <20200401000020.590447-1-leonardo@linux.ibm.com> <871rp6t9di.fsf@mpe.ellerman.id.au> <02e74be19534ab1db2f16a0c89ecb164e380c12a.camel@linux.ibm.com> <1585895551.7o9oa0ey62.astroid@bobo.none> <fb98f346a4d6a9d689ae64dae33cbd45d2f8b0df.camel@linux.ibm.com> <87v9majhh2.fsf@mpe.ellerman.id.au> <20200409002726.GA5135@blackberry>
Date:   Tue, 12 May 2020 20:42:21 +1000
Message-ID: <87mu6dbfjm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:
> On Wed, Apr 08, 2020 at 10:21:29PM +1000, Michael Ellerman wrote:
>> 
>> We should be able to just allocate the rtas_args on the stack, it's only
>> ~80 odd bytes. And then we can use rtas_call_unlocked() which doesn't
>> take the global lock.
>
> Do we instantiate a 64-bit RTAS these days, or is it still 32-bit?

No, yes.

> In the old days we had to make sure the RTAS argument buffer was
> below the 4GB point.

Yes you're right, that's still true.

I was thinking we were on the emergency stack, but we may not be.

> If that's still necessary then perhaps putting rtas_args inside the
> PACA would be the way to go.

Yeah I guess. Allocating a struct within the RMO for each CPU is not
that simple vs just putting it in the paca.

cheers
