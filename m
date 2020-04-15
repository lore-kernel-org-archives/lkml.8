Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E1AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8624520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635342AbgDOHty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:49:54 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:45180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635311AbgDOHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F013918015D9D;
        Wed, 15 Apr 2020 07:49:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice76_900e1bed61f58
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 07:49:49 +0000 (UTC)
Message-ID: <e9b90677b2d97c556c400e3744518942e0b58d41.camel@perches.com>
Subject: Re: [PATCH] Bitmap: Optimized division operation to shift operation
From:   Joe Perches <joe@perches.com>
To:     Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Wed, 15 Apr 2020 00:47:39 -0700
In-Reply-To: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
References: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 15:27 +0800, Wang Qing wrote:
> On some processors, the / operate will call the compiler`s div lib,
> which is low efficient. Bitmap is performance sensitive, We can
> replace the / operation with shift.

Seems more like bad compilers than useful code changes
unless you can specify what compilers and what processors.

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
[]
> @@ -337,7 +337,7 @@ static inline int bitmap_equal(const unsigned long *src1,
>  		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>  	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
>  	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
> -		return !memcmp(src1, src2, nbits / 8);
> +		return !memcmp(src1, src2, nbits >> 3);


