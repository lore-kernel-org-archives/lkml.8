Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED4C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F013206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1Rhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:37:43 -0400
Received: from mx.sdf.org ([205.166.94.20]:58571 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Rhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 13:37:42 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SHbC9e005749
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 17:37:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SHbC1h016215;
        Sat, 28 Mar 2020 17:37:12 GMT
Date:   Sat, 28 Mar 2020 17:37:12 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Maciej Zenczykowski <maze@google.com>
Cc:     Kernel hackers <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux NetDev <netdev@vger.kernel.org>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 18/50] net/ipv6/addrconf.c: Use prandom_u32_max
 for rfc3315 backoff time computation
Message-ID: <20200328173712.GB5859@SDF.ORG>
References: <202003281643.02SGhD4n009959@sdf.org>
 <CANP3RGean6M7PuTMXKJrXSdU+2RgzqsoEvnQK5C0RFoXGfFwBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANP3RGean6M7PuTMXKJrXSdU+2RgzqsoEvnQK5C0RFoXGfFwBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:56:58AM -0700, Maciej ?enczykowski wrote:
>>         /* multiply 'initial retransmission time' by 0.9 .. 1.1 */
>> -       u64 tmp = (900000 + prandom_u32() % 200001) * (u64)irt;
>> -       do_div(tmp, 1000000);
>> -       return (s32)tmp;
>> +       s32 range = irt / 5;
>> +       return irt - (s32)(range/2) + (s32)prandom_u32_max(range);
> 
> The cast on range/2 looks entirely spurious

You're absolutely right; sorry about that.  I was trying to
preserve the previous code's mixture of signed and unsigned types
and managed to confuse myself.

(I think I got distracted researching whether the inputs could be
negative.)

>>         /* multiply 'retransmission timeout' by 1.9 .. 2.1 */
>> -       u64 tmp = (1900000 + prandom_u32() % 200001) * (u64)rt;
>> -       do_div(tmp, 1000000);
>> -       if ((s32)tmp > mrt) {
>> +       s32 range = rt / 5;
>> +       s32 tmp = 2*rt - (s32)(range/2) + (s32)prandom_u32_max(range);
> 
> Here as well.  Honestly the cast on prandom might also not be
> necessary, but that at least has a reason.

The whole thing should go.   How about just doing it all in unsigned:

static inline s32 rfc3315_s14_backoff_init(s32 irt)
{
	/* multiply 'initial retransmission time' by 0.9 .. 1.1 */
	u32 range = irt / 5u;
	return irt - range/2 + prandom_u32_max(range);
}

static inline s32 rfc3315_s14_backoff_update(s32 rt, s32 mrt)
{
	/* multiply 'retransmission timeout' by 1.9 .. 2.1 */
	 u32 range = rt / 5u;
	 u32 tmp = 2u*rt - range/2 + prandom_u32_max(range);
	 if (tmp > mrt) {
		 /* multiply 'maximum retransmission time' by 0.9 .. 1.1 */
		  range = mrt / 5u;
		  tmp = mrt - range/2 + prandom_u32_max(range);
	}
	return tmp;
}

That lets "range/2" be implemented as a 1-bit shift.

An interesting question for the latter is whether
"prandom_u32_max(range) - range/2" can be considered a common
subexpression, or is they have to be *independent* random values.
