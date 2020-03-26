Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE565C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9871F20772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kV505Pb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZAyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgCZAyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=sFRjjoH1TaX/TpIMNdRaMXoanl8L7cg7e+pjh63UFg8=; b=kV505Pb9/3kHyi3ZBfB+olALX5
        2iaXUsqSr3CO33DPy4hDQxyAzfMiy0kPKt+kkB8yMot7ZYLbf3VZgzsk2AeMgRrdpQ4U3UVVDSJek
        TcJY5n0mv3Y8NHyhrM46u0nIDbt0EkUbnAXLfYbyhdck+9Jva67ltlNonTZYpedqbZlptLWVF+ZH/
        VbPr0dy01IQ8gcTDOHAVu66pi25CCS7RvBEm6TDklObwKgetvrWQHmtJni6HBz7JleE48F29h+UjB
        n5tBgPEUK7BMyjR6zjH0D3c/Sav2lgIwSb6uo1M7wTkl5lttb/HSP9usLtpEdmJcXpAFFXuuRiqqn
        v2zljKzQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHGnK-0003Zk-6K; Thu, 26 Mar 2020 00:54:50 +0000
Subject: Re: KASAN: stack-out-of-bounds Write in mpol_to_str
To:     Entropy Moe <3ntr0py1337@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, Dmitry Vyukov <dvyukov@google.com>
References: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
 <9e699198-d1e4-f285-f4ed-15fbf8a8c16e@infradead.org>
 <CALzBtj+8AYASaYW2fqgmgthCgeAJ2N0Q+ey2wqgEKjBtH34Vcg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <110bb9ab-9765-1c5b-39c6-3644cb1b99a4@infradead.org>
Date:   Wed, 25 Mar 2020 17:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALzBtj+8AYASaYW2fqgmgthCgeAJ2N0Q+ey2wqgEKjBtH34Vcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 1:36 AM, Entropy Moe wrote:
> Hello Randy,
> please see attached POC for the vulnerability.
> 

Hi Moe,

Do you have anything to do with the syzkaller source code generation? (POC; reproducers)

I don't expect it to be beautiful, but it could be a lot easier to read in a few places.

E.g., the POC that you provided sets a tmpfs mount option string to
"mpol=prefer:,", which is probably purposely malformed (OK), but it does
so in an unreadable manner: (I added the // comments.)

memcpy((void*)0x20000340, "mpol", 4);
*(uint8_t*)0x20000344 = 0x3d; // =
memcpy((void*)0x20000345, "prefer", 6);
*(uint8_t*)0x2000034b = 0x3a; // :
*(uint8_t*)0x2000034c = 0x2c; // ,
*(uint8_t*)0x2000034d = 0;


That kind of obfuscation just helps slow down debugging. :(

-- 
~Randy

