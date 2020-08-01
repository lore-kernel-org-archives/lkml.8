Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234DBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DE120836
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="koeUikLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHADwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgHADwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 23:52:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987BFC06174A;
        Fri, 31 Jul 2020 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Gnn9lbsi+QeiyHza8FsKfu17u4FjzzG+2+QxHKbvkV0=; b=koeUikLM4YRg0XyDmY1BhwjSlF
        uor/b+viYycgrcVXM4guo6CwQeLIHEQxmH4CguPqoRNS+l4qsDN/2PmO8M2FxWgLjyHjgjLENGqNr
        iT/GuKtmO5h6TH29C4GDiXSa0w8yZgN95XONwaxD52KbEb70ReRnZoxHp6g7jiqfRYf9vtJAy56sr
        6CL/s96LlsZw6RGuqg/iwyB42lheEbryt0uA0AVDWDCT7RGfp2+RWThBjuwsVaGh3aivdUtH6Sbb3
        FZL2tGXhLopnbwsqjbGDFyfocKIduTC6u1sS9/o/RS1kLbm+9ziQrzgQ3bNMX+ZzFh/TmzAit9517
        taP6gV3A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1iZV-0005AU-5K; Sat, 01 Aug 2020 03:52:33 +0000
Subject: Re: [PATCH net-next] fib: fix another fib_rules_ops indirect call
 wrapper problem
To:     Brian Vazquez <brianvv@google.com>,
        Brian Vazquez <brianvv.kernel@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200801030110.747164-1-brianvv@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55292447-c426-8421-3147-ef7fa6e4b471@infradead.org>
Date:   Fri, 31 Jul 2020 20:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801030110.747164-1-brianvv@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/20 8:01 PM, Brian Vazquez wrote:
> It turns out that on commit 41d707b7332f ("fib: fix fib_rules_ops
> indirect calls wrappers") I forgot to include the case when
> CONFIG_IP_MULTIPLE_TABLES is not set.
> 
> Fixes: 41d707b7332f ("fib: fix fib_rules_ops indirect calls wrappers")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brian Vazquez <brianvv@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  net/core/fib_rules.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index fce645f6b9b10..a7a3f500a857b 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -17,10 +17,16 @@
>  #include <linux/indirect_call_wrapper.h>
>  
>  #ifdef CONFIG_IPV6_MULTIPLE_TABLES
> +#ifdef CONFIG_IP_MULTIPLE_TABLES
>  #define INDIRECT_CALL_MT(f, f2, f1, ...) \
>  	INDIRECT_CALL_INET(f, f2, f1, __VA_ARGS__)
>  #else
> +#define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
> +#endif
> +#elif CONFIG_IP_MULTIPLE_TABLES
>  #define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
> +#else
> +#define INDIRECT_CALL_MT(f, f2, f1, ...) f(__VA_ARGS__)
>  #endif
>  
>  static const struct fib_kuid_range fib_kuid_range_unset = {
> 


-- 
~Randy
