Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC002206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHKCTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:19:01 -0400
Received: from mail.loongson.cn ([114.242.206.163]:39364 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgHKCTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:19:01 -0400
Received: from [10.130.0.187] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf8cMADJf5CwHAA--.687S3;
        Tue, 11 Aug 2020 10:18:53 +0800 (CST)
Subject: Re: [PATCH] tools/objtool: Fix unnecessary jumps
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1597032374-7936-1-git-send-email-tangyouling@loongson.cn>
 <bbe25938-479d-7a84-b1ee-941ad8088a1c@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <212704d1-792a-069c-c1f6-11eff5d19af5@loongson.cn>
Date:   Tue, 11 Aug 2020 10:18:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bbe25938-479d-7a84-b1ee-941ad8088a1c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxf8cMADJf5CwHAA--.687S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fAr18XrWrCFy3KryfWFg_yoWDZrX_W3
        4vvF97WrZ5XFWIy3WDKFWFgr4kKF43ua15uFW0vr47J3WfJF15JF92krnI9rs8tF9YkF43
        u348Za47Ars29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j2T5dUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply and suggestions, I will remove

the "out" label code.

Thanks,
Youling


On 08/10/2020 08:57 PM, Kamalesh Babulal wrote:
> On 10/08/20 9:36 am, Youling Tang wrote:
>> There is no need to jump to the "out" tag when "ret < 0", just return
>> directly to "ret".
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   tools/objtool/check.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index e034a8f..94b166d 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
> [snip]
>
>>   	if (file.elf->changed) {
>>   		ret = elf_write(file.elf);
>>   		if (ret < 0)
>> -			goto out;
>> +			return ret;
>>   	}
>>
>>   out:
> the out label code is no more required with this change, so remove
> it and return 0 for warnings for now.  Previously cleanup() function
> was called under the out label for both fatal errors (ret < 0) and
> warnings.  Now that cleanup() function is removed, the out label is
> no longer required.
>

