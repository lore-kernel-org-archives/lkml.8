Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC6620717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgGUBrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:47:21 -0400
Received: from out28-196.mail.aliyun.com ([115.124.28.196]:34555 "EHLO
        out28-196.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGUBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:47:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09037068|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0898497-0.00457316-0.905577;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=maochenxi@eswin.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.I54Ds6m_1595296035;
Received: from 10.1.56.17(mailfrom:maochenxi@eswin.com fp:SMTPD_---.I54Ds6m_1595296035)
          by smtp.aliyun-inc.com(10.194.98.253);
          Tue, 21 Jul 2020 09:47:16 +0800
Subject: Re: [PATCH 1/1] riscv: Enable ARCH_HAS_FAST_MULTIPLIER for RV64I
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenxi.mao2013@gmail.com
References: <mhng-e8fe18f0-e6d7-4ee2-8a9b-a00dbf0b338b@palmerdabbelt-glaptop1>
From:   Chenxi Mao <maochenxi@eswin.com>
Message-ID: <7ad95929-039f-9760-fc30-e89e02424361@eswin.com>
Date:   Tue, 21 Jul 2020 09:47:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-e8fe18f0-e6d7-4ee2-8a9b-a00dbf0b338b@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer:

Thanks for your reply.

Frankly, I didn't test ARCH_HAS_FAST_MULTIPLIER on RV32,

so I cannot put it in RISCV platform.

I am trying to comparing ARM64 with Riscv to find out more optimization

configurations.

I suggest to enable ARCH_HAS_FAST_MULTIPLIER on RV64 first.

If someone else evaluate this on RV32, we could move it to RISCV platform.


Chenxi


On 2020/7/21 上午9:17, Palmer Dabbelt wrote:
> On Wed, 08 Jul 2020 22:19:22 PDT (-0700), maochenxi@eswin.com wrote:
>> Enable ARCH_HAS_FAST_MULTIPLIER on RV64I
>> which works fine on GCC-9.3 and GCC-10.1
>>
>> PS2: remove ARCH_SUPPORTS_INT128 because of RV64I already enabled.
>>
>> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
>> ---
>>  arch/riscv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 128192e14ff2..84e6777fecad 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -202,6 +202,7 @@ config ARCH_RV64I
>>      bool "RV64I"
>>      select 64BIT
>>      select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
>> +    select ARCH_HAS_FAST_MULTIPLIER
>>      select HAVE_DYNAMIC_FTRACE if MMU
>>      select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>      select HAVE_FTRACE_MCOUNT_RECORD
>
> Ah, thanks -- this one didn't show up when I was looking at the last one.  I
> think we can put the fast multiplier on rv32 and rv64, there shouldn't be any
> difference there.  I guess in theory we should be sticking this all in some
> sort of "platform type" optimization flags, but that's probably bit much for
> now.
