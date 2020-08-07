Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76875C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F492065E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cMXt9s/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHGQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:12:36 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.108]:49716 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgHGQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:12:35 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 60FA02E1CA5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:12:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 44yskWjrhXp2A44yskws49; Fri, 07 Aug 2020 11:12:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6up/JMIolI+wenx9BcFdojlYDQlQMQG5E+IbFWuYMgg=; b=cMXt9s/yW+SxXLjUBDSOT5iZfU
        mZYughJ4iw5AErfhQVBMLUrVVmN5ELTzk7iu3q4BaNLYOLmYC0bnAzlBc6jyJzwc8/TOJh5/as38M
        OtbgrKZtDryUf7XZH3oPz8ZK+cMTvpBjw2Up5LCNnSW2uMPBYkK8JIb9df3WpfmEqWvpvTfdykUMJ
        oLfYRZ/uNOf/yFb9rUj/0A246OY0veDmh0MC1HcRmNQoWvB4IYy0+1P7gNOIdKRbBE3MIIvuB3/6B
        M5gbx8P4ePo6GHT7b92ThslzlDMIBJ2aqJYyXUNZUzSyTwQzlFEMgbIAISOVBtHmhcMzFxE0/Ymft
        rCg8YcDA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:35412 helo=[192.168.15.2])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k44yr-003As7-UI; Fri, 07 Aug 2020 11:12:29 -0500
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20200806220342.25426-1-efremov@linux.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [RFC PATCH] coccinelle: misc: add flexible_array.cocci script
Message-ID: <ba11ddd9-8bd0-456d-26d3-b8157eedcdb5@embeddedor.com>
Date:   Fri, 7 Aug 2020 11:18:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806220342.25426-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k44yr-003As7-UI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.2]) [187.162.31.110]:35412
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

Thanks a lot for working on this. Please, see some comments below...

On 8/6/20 17:03, Denis Efremov wrote:
> Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
> arrays") marks one-element and zero-length arrays as deprecated. Kernel
> code should always use "flexible array members" instead.
> 
> The script warns about one-element and zero-length arrays in structs.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> 
> Currently, it's just a draft. I've placed a number of questions in the
> script and marked them as TODO. Kees, Gustavo, if you could help me with
> my questions I think that this rule will be enough to close:
> https://github.com/KSPP/linux/issues/76
> 
> BTW, I it's possible to not warn about files in uapi folder if
> this is relevant. Do I need to do it in the script?
> 

I think the script should warn about new additions of zero-length/one-element
arrays in UAPI.

>  scripts/coccinelle/misc/flexible_array.cocci | 158 +++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/flexible_array.cocci
> 
> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
> new file mode 100644
> index 000000000000..1e7165c79e60
> --- /dev/null
> +++ b/scripts/coccinelle/misc/flexible_array.cocci
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Zero-length and one-element arrays are deprecated, see
> +/// Documentation/process/deprecated.rst
> +/// Flexible-array members should be used instead.
> +///
> +//
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual report
> +virtual org
> +virtual patch
> +
> +@r depends on !patch@
> +identifier name, size, array;
> +// TODO: We can additionally restrict size and array to:
> +// identifier size =~ ".*(num|len|count|size|ncpus).*";
> +// identifier array !~ ".*(pad|reserved).*";
> +// Do we need it?
> +type TS, TA;
> +position p;
> +@@
> +
> +(
> +  // This will also match: typedef struct name { ...
> +  // However nested structs are not matched, i.e.:
> +  //   struct name1 { struct name2 { int s; int a[0]; } st; int i; }
> +  // will not be matched. Do we need to handle it?

It's fine. I think this would be a different script. One that
exclusively look for all three: zero-length, one-element arrays
and flexible array members in nested structures because
"A structure containing a flexible array member, or a union
containing such a structure (possibly recursively), may not be
a member of a structure or an element of an array. (However
these uses are permitted by GCC as extensions.)"[1]

> +  struct name {
> +    ...      // TODO: Maybe simple ... is enough? It will match structs with a

Yep; simple is always better at first. :)

> +    TS size; // single field, e.g.
> +    ...      // https://elixir.bootlin.com/linux/v5.8/source/arch/arm/include/uapi/asm/setup.h#L127
> +(
> +*    TA array@p[0];
> +|
> +     // TODO: It seems that there are exception cases for array[1], e.g.
> +     //  https://elixir.bootlin.com/linux/v5.8/source/arch/powerpc/boot/rs6000.h#L152
> +     //  https://elixir.bootlin.com/linux/v5.8/source/include/uapi/linux/cdrom.h#L292
> +     //  https://elixir.bootlin.com/linux/v5.8/source/drivers/net/wireless/ath/ath6kl/usb.c#L108
> +     // We could either drop array[1] checking from this rule or
> +     // restrict array name with regexp and add, for example, an "allowlist"
> +     // with struct names where we allow this code pattern.
> +     // TODO: How to handle: u8 data[1][MAXLEN_PSTR6]; ?
> +*    TA array@p[1];
> +)
> +  };
> +|
> +  struct {
> +    ...
> +    TS size;
> +    ...
> +(
> +*    TA array@p[0];
> +|
> +*    TA array@p[1];
> +)
> +  };
> +|
> +  // TODO: do we need to handle unions?

Yep; we should warn about this in unions, too.

However, I think unions cannot have members with
incomplete type, so we should not suggest the use
of flexible-array members in unions, because
flexible arrays have incomplete type.

> +  union name {
> +    ...
> +    TS size;
> +    ...
> +(
> +*    TA array@p[0];
> +|
> +*    TA array@p[1];
> +)
> +  };
> +|
> +  union {
> +    ...
> +    TS size;
> +    ...
> +(
> +*    TA array@p[0];
> +|
> +*    TA array@p[1];
> +)
> +  };
> +)
> +
> +// FIXME: Patch mode doesn't work as expected.
> +// Coccinelle handles formatting incorrectly.
> +// Patch mode in this rule should be disabled until
> +// proper formatting will be supported.
> +@depends on patch exists@
> +identifier name, size, array;
> +type TS, TA;
> +@@
> +
> +(
> +  struct name {
> +    ...
> +    TS size;
> +    ...
> +(
> +-    TA array[0];
> +|
> +-    TA array[1];
> +)
> ++    TA array[];
> +  };
> +|
> +  struct {
> +    ...
> +    TS size;
> +    ...
> +(
> +-    TA array[0];
> +|
> +-    TA array[1];
> +)
> ++    TA array[];
> +  };
> +|
> +  union name {
> +    ...
> +    TS size;
> +    ...
> +(
> +-    TA array[0];
> +|
> +-    TA array[1];
> +)
> ++    TA array[];
> +  };
> +|
> +  union {
> +    ...
> +    TS size;
> +    ...
> +(
> +-    TA array[0];
> +|
> +-    TA array[1];
> +)
> ++    TA array[];

This is not allowed, neither is GCC[2] nor in Clang[3].

> +  };
> +)
> +
> +@script: python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: use flexible-array member instead"
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: use flexible-array member instead"
> +coccilib.org.print_todo(p, msg)
> 

I wonder if it might be worth it to also point people to
the documentation in deprecated.rst (commit 68e4cd17e218
("docs: deprecated.rst: Add zero-length and one-element arrays")),
once helpdesk generates the official documentation for 5.9-rc1.

Thanks
--
Gustavo

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://godbolt.org/z/Kajd7e
[3] https://godbolt.org/z/dvKMYb
