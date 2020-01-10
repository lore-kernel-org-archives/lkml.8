Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793BC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CB82072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgAJNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:12:19 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48733 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbgAJNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:12:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TnKMqhn_1578661869;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TnKMqhn_1578661869)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jan 2020 21:11:11 +0800
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2001071823060.3004@hadrien>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <a6d58a19-c49d-f72e-9576-3ca64ffd6320@linux.alibaba.com>
Date:   Fri, 10 Jan 2020 21:11:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001071823060.3004@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/8 1:25 上午, Julia Lawall wrote:
>> +@depends on context@
>> +expression f;
>> +long l;
>> +unsigned long ul;
>> +u64 ul64;
>> +s64 sl64;
>> +
>> +@@
>> +(
>> +* do_div(f, l);
>> +|
>> +* do_div(f, ul);
>> +|
>> +* do_div(f, ul64);
>> +|
>> +* do_div(f, sl64);
>> +)
> 
> This part is not really ideal.  For the reports, you filter for the
> constants, but here you don't do anything.  You can put some python code
> in the matching of the metavariables:
> 
> unsigned long ul : script:python() { whatever you want to check on ul };
> 
> Then it will only match if the condition is satisfied.
> 
> julia
> 

OK, thank you very much.
We'll fix it soon.

-- 
Best Wishes,
Wen
