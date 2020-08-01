Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E24120838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2zU1ARa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHAAuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgHAAuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 20:50:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DAFC06174A;
        Fri, 31 Jul 2020 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pmbux88pVKWkzDF5CoLemvUabl6Do5Ss7ygzNM343eo=; b=t2zU1ARan2TOmBIWK+063fvmPe
        988W/bs9yNnojIsrPuFogqc+Yndi3Qy4cnpIDN+8F1JiWIWgz/Qb3WbL4K5z9LaT7JAiljl37BgxG
        5C5uwQ8w89wXVrKiUPryzl2+jWlStwqTgRse+IJ4mfBUpLDCfjGvHLOA+eloFEXZ0WfhyfF9No8wX
        raAkYbM9PMT9O3rSmUN8cET5h45nIbg8lIOJgby1LxSxdtla1GXFK7AMCNFfS4R5ayDgfzojYez9X
        HIVLQXRThxeQ0g4fwm9BnJVvbwp6BJbbDoTD8mD1n/yvIfqjr7+GI/ONafSEGhap8X9bfoTwkqTxr
        mrJaiUZQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1fjZ-0005kF-Dq; Sat, 01 Aug 2020 00:50:46 +0000
Subject: Re: linux-next: Tree for Jul 31 (net/decnet/ & FIB_RULES)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        Brian Vazquez <brianvv@google.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20200731211909.33b550ec@canb.auug.org.au>
 <4c6abcd0-e51b-0cf3-92de-5538c366e685@infradead.org>
 <20200801103507.03ae069b@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97853126-c3fb-fced-547f-6dd7d5c89ca9@infradead.org>
Date:   Fri, 31 Jul 2020 17:50:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801103507.03ae069b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/20 5:35 PM, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Fri, 31 Jul 2020 08:53:09 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> on i386:
>>
>> ld: net/core/fib_rules.o: in function `fib_rules_lookup':
>> fib_rules.c:(.text+0x16b8): undefined reference to `fib4_rule_match'
>> ld: fib_rules.c:(.text+0x16bf): undefined reference to `fib4_rule_match'
>> ld: fib_rules.c:(.text+0x170d): undefined reference to `fib4_rule_action'
>> ld: fib_rules.c:(.text+0x171e): undefined reference to `fib4_rule_action'
>> ld: fib_rules.c:(.text+0x1751): undefined reference to `fib4_rule_suppress'
>> ld: fib_rules.c:(.text+0x175d): undefined reference to `fib4_rule_suppress'
>>
>> CONFIG_DECNET=y
>> CONFIG_DECNET_ROUTER=y
>>
>> DECNET_ROUTER selects FIB_RULES.
> 
> I assume that CONFIG_IP_MULTIPLE_TABLES was not set for that build?

Correct.

> Caused by commit
> 
>   b9aaec8f0be5 ("fib: use indirect call wrappers in the most common fib_rules_ops")
> 
> from the net-next tree.

thanks.

-- 
~Randy

