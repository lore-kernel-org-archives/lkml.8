Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C991C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACAD2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="elw5HISj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgH0RXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:23:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51521 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0RXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:23:46 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07RHNJFu175188
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 27 Aug 2020 10:23:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07RHNJFu175188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020082401; t=1598549000;
        bh=HtKzMWcGf0eTXP3nJrlnaKLERUTkD4jutWMdC6a19wE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=elw5HISjayV8InOzrwCGHVkYEeyFbkAEIbIW3Ja9hxd4XomdZ3BWLNS6L5gb4gZRd
         mT2SzU9Ns+67w3ccqJxsOsZxGN0nF0y5Sz4RyRqdyO/orz3qnI0ZuK2sh8nlRHi018
         10DGvz6Ry8TDcxzUcb/sttlL3P0xMvqwzSpsmPoBbP04AMiIWTHdnqjpOkms1IT5tS
         RUlfhzpWJSxsoAJcuAjmSblqPyTHoxtxJi317fISNrYyNNYR8e0e0lj6FU+uIiIhj4
         fB963XgC4Fc6mgJev6zrG+MphBIg9ShF/43lXtzy40o8ttlY+9cHCkFx5vDJbFwo1l
         nJkXy6zfNvG7A==
Subject: Re: [PATCH] x86: Use XORL r32,r32 in __get_user_asm
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <20200827164905.88235-1-ubizjak@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5a0def3d-f8cf-5ee4-62c7-be61c4022401@zytor.com>
Date:   Thu, 27 Aug 2020 10:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827164905.88235-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 09:49, Uros Bizjak wrote:
> Use XORL r32,r32 for all operand sizes. x86_64 zero extends 32bit
> operations, so for 64bit operands, XORL r32,r32 is functionally
> equal to XORL r64,r64, but avoids a REX prefix byte when legacy
> registers are used.

Please make it clear that this refers specifically to the use case of both
registers being the same, for zeroing. This could otherwise be misread.

"xorl r64,r64" is nonsensical: you're referring to xorq.

The apparent visual mix here between Intel and gas syntax is also confusing.

I would explicily say, using gcc inline syntax:

xorl %0,%0 is equivalent to xorq %0,%0 as both will zero the entire register.


> 32bit operation also avoids 0x66 size prefix for 16bit operands
> and REX prefix when %sil, %dil and %bpl 8bit registers are used.
> 
> As a bonus, 32bit XORL breaks register dependency chains, avoiding
> potential partial register stalls with 8 and 16bit operands.

Please make it clear that zeroing the full register is OK in this use case
(which it is.)

> The patch lowers the size of .fixup section by 20 bytes.

	-hpa


