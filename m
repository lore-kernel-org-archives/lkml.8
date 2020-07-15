Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE80C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A5F2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGODPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:15:04 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48396 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgGODPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:15:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=cooper.qu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U2lnJE7_1594782897;
Received: from L-X0CGLVDL-0840.local(mailfrom:cooper.qu@linux.alibaba.com fp:SMTPD_---0U2lnJE7_1594782897)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Jul 2020 11:14:58 +0800
Subject: Re: [PATCH v3 2/2] riscv: Enable per-task stack canaries
To:     Palmer Dabbelt <palmerdabbelt@google.com>, guoren@kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, keescook@chromium.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
References: <mhng-1f027fd5-a558-4bf4-8168-59a75f36caac@palmerdabbelt-glaptop1>
From:   cooper <cooper.qu@linux.alibaba.com>
Message-ID: <54bdad8c-cb15-f334-5a9b-7e693ea00399@linux.alibaba.com>
Date:   Wed, 15 Jul 2020 11:14:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-1f027fd5-a558-4bf4-8168-59a75f36caac@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/15 上午5:37, Palmer Dabbelt wrote:
> On Fri, 10 Jul 2020 09:19:58 PDT (-0700), guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> This enables the use of per-task stack canary values if GCC has
>> support for emitting the stack canary reference relative to the
>> value of tp, which holds the task struct pointer in the riscv
>> kernel.
>>
>> After compare arm64 and x86 implementations, seems arm64's is more
>> flexible and readable. The key point is how gcc get the offset of
>> stack_canary from gs/el0_sp.
>>
>> x86: Use a fix offset from gs, not flexible.
>>
>> struct fixed_percpu_data {
>>     /*
>>      * GCC hardcodes the stack canary as %gs:40.  Since the
>>      * irq_stack is the object at %gs:0, we reserve the bottom
>>      * 48 bytes of the irq stack for the canary.
>>      */
>>     char            gs_base[40]; // :(
>>     unsigned long   stack_canary;
>> };
>>
>> arm64: Use -mstack-protector-guard-offset & guard-reg
>>     gcc options:
>>     -mstack-protector-guard=sysreg
>>     -mstack-protector-guard-reg=sp_el0
>>     -mstack-protector-guard-offset=xxx
>>
>> riscv: Use -mstack-protector-guard-offset & guard-reg
>>     gcc options:
>>     -mstack-protector-guard=tls
>>     -mstack-protector-guard-reg=tp
>>     -mstack-protector-guard-offset=xxx
>>
>> Here is riscv gcc's work [1].
>>
>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-July/549583.html
>>
>> In the end, these codes are inserted by gcc before return:
>>
>> *  0xffffffe00020b396 <+120>:   ld      a5,1008(tp) # 0x3f0
>> *  0xffffffe00020b39a <+124>:   xor     a5,a5,a4
>> *  0xffffffe00020b39c <+126>:   mv      a0,s5
>> *  0xffffffe00020b39e <+128>:   bnez a5,0xffffffe00020b61c 
>> <_do_fork+766>
>>    0xffffffe00020b3a2 <+132>:   ld      ra,136(sp)
>>    0xffffffe00020b3a4 <+134>:   ld      s0,128(sp)
>>    0xffffffe00020b3a6 <+136>:   ld      s1,120(sp)
>>    0xffffffe00020b3a8 <+138>:   ld      s2,112(sp)
>>    0xffffffe00020b3aa <+140>:   ld      s3,104(sp)
>>    0xffffffe00020b3ac <+142>:   ld      s4,96(sp)
>>    0xffffffe00020b3ae <+144>:   ld      s5,88(sp)
>>    0xffffffe00020b3b0 <+146>:   ld      s6,80(sp)
>>    0xffffffe00020b3b2 <+148>:   ld      s7,72(sp)
>>    0xffffffe00020b3b4 <+150>:   addi    sp,sp,144
>>    0xffffffe00020b3b6 <+152>:   ret
>>    ...
>> *  0xffffffe00020b61c <+766>:   auipc   ra,0x7f8
>> *  0xffffffe00020b620 <+770>:   jalr    -1764(ra) # 
>> 0xffffffe000a02f38 <__stack_chk_fail>
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: cooper <cooper.qu@linux.alibaba.com>
>
> IIRC we're required to use full names here.  I'm assuming that's meant 
> to be
> "Signed-off-by: Cooper Qu ...", and I know it's a bit procedural but I 
> can't
> make that change.
>
> Otherwise these two look good, the first one is on for-next.  I can 
> boot with a
> defconfig ammended with CONFIG_STACKPROTECTOR=y,
> Thanks!
>
Hi Palmer,

That's ok to change it to full names as follows.

Signed-off-by: Cooper Qu <cooper.qu@linux.alibaba.com>


Best Regards,

Cooper

