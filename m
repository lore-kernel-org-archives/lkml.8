Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FF520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgDXOKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:10:42 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:57869 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgDXOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:10:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B8F5A3000467A;
        Fri, 24 Apr 2020 16:10:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9335B70E94E; Fri, 24 Apr 2020 16:10:37 +0200 (CEST)
Date:   Fri, 24 Apr 2020 16:10:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        vilhelm.gray@gmail.com, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424141037.ersebbfe7xls37be@wunner.de>
References: <20200424122521.GA5552@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424122521.GA5552@syed>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> +static inline void bitmap_set_value(unsigned long *map,
> +				    unsigned long value,
> +				    unsigned long start, unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +	const unsigned long space = ceiling - start;
> +
> +	value &= GENMASK(nbits - 1, 0);
> +
> +	if (space >= nbits) {
> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> +		map[index] |= value << offset;
> +	} else {
> +		map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +		map[index] |= value << offset;
> +		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +		map[index + 1] |= (value >> space);
> +	}
> +}

Sorry but what's the advantage of using this complicated function
as a replacement for the much simpler bitmap_set_value8()?

The drivers calling bitmap_set_value8() *know* that 8-bit accesses
are possible and take advantage of that knowledge by using a small,
speed-optimized function.  Replacing that with a more complicated
(potentially less performant) function doesn't seem to be a step
forward.

Thanks,

Lukas
