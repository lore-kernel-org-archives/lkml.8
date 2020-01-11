Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F1C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D85D2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgAKFGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 00:06:43 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37793 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgAKFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 00:06:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TnNYIC5_1578719194;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TnNYIC5_1578719194)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jan 2020 13:06:39 +0800
Subject: Re: [PATCH v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
 <91abb141-57b8-7659-25ec-8080e290d846@web.de>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com>
Date:   Sat, 11 Jan 2020 13:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <91abb141-57b8-7659-25ec-8080e290d846@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/11 12:35 上午, Markus Elfring wrote:
>> +@initialize:python@
> …
>> +def filter_out_safe_constants(str):
> …
>> +def construct_warnings(str, suggested_fun):
> 
> * I suggest once more to adjust the dependency specifications for the usage
>    of these functions by SmPL rules.
> 

Most of the functions here are for all operation modes.


> * Can the local variable “msg” be omitted?
> 
> 
>> +coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))
> 
> I suggest again to move the prefix “div64_” into the string literal
> of the function implementation.
> 

“div64_ul” indicates the function name we recommend.
As shown in the patch:

+def construct_warnings(suggested_fun):
+    msg="WARNING: do_div() does a 64-by-32 division, please consider 
using %s instead."
+    return  msg % suggested_fun
...
+coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))

If we delete the prefix "div64_", it may reduce readability.

> 
> The SmPL code for two disjunctions could become shorter.
> 

You may suggest to modify it as follows:
+@@
+*do_div(f, \( l \| ul \| ul64 \| sl64 \) );

We agree with Julia:
I don't se any point to this.  The code matched will be the same in both
cases.  The original code is quite readable, without the ugly \( etc.

--
Regards，
Wen

> Regards,
> Markus
> 
