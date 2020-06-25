Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAA5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF66A2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404924AbgFYNU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:20:56 -0400
Received: from out20-109.mail.aliyun.com ([115.124.20.109]:57173 "EHLO
        out20-109.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403941AbgFYNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:20:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437085|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.018693-0.000393809-0.980913;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.HsKfs8N_1593091249;
Received: from 192.168.181.130(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.HsKfs8N_1593091249)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 25 Jun 2020 21:20:50 +0800
Subject: Re: [RFC v2] Reed-Solomon Code: Update no_eras to the actual number
 of errors
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20200625073621.4919-1-aiden.leong@aibsd.com>
 <20200625130624.GC1036@mail-personal>
From:   Aiden Leong <aiden.leong@aibsd.com>
Message-ID: <8809849e-832c-d268-bda1-807157e92e5b@aibsd.com>
Date:   Thu, 25 Jun 2020 06:20:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625130624.GC1036@mail-personal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You are right. I forgot the return value is number of errors rather than 
status code.

Sorry to bother you.

On 6/25/20 6:06 AM, Ferdinand Blomqvist wrote:
> Hi!
>
> On 2020-06-25 00:36:01, Aiden Leong wrote:
>> Corr and eras_pos are updated to actual correction pattern and erasure
>> positions, but no_eras is not.
>>
>> When this library is used to recover lost bytes, we normally memset the
>> lost trunk of bytes to zero as a placeholder. Unfortunately, if the lost
>> byte is zero, b[i] is zero too. Without correct no_eras, users won't be
>> able to determine the valid length of corr and eras_pos.
>>
>> Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
>
> I'm not sure I understand what you try to do. decode_rs* already returns
> the number of errors correted (or something negative upon failure). So
> your last statment is false. The lengt of corr and eras_pos is returned
> by the function. So this change is unnecessary. More comments inline.
>
>>
>> diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
>> index 805de84ae83d..44136ea33d16 100644
>> --- a/lib/reed_solomon/decode_rs.c
>> +++ b/lib/reed_solomon/decode_rs.c
>> @@ -24,6 +24,7 @@
>>     int count = 0;
>>     int num_corrected;
>>     uint16_t msk = (uint16_t) rs->nn;
>> +    int no_eras_local = no_eras ? *no_eras : 0;
>>
>>     /*
>>      * The decoder buffers are in the rs control struct. They are
>> @@ -106,11 +107,11 @@
>>     memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
>>     lambda[0] = 1;
>>
>> -    if (no_eras > 0) {
>> +    if (no_eras_local > 0) {
>>         /* Init lambda to be the erasure locator polynomial */
>>         lambda[1] = alpha_to[rs_modnn(rs,
>>                     prim * (nn - 1 - (eras_pos[0] + pad)))];
>> -        for (i = 1; i < no_eras; i++) {
>> +        for (i = 1; i < no_eras_local; i++) {
>>             u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
>>             for (j = i + 1; j > 0; j--) {
>>                 tmp = index_of[lambda[j - 1]];
>> @@ -129,8 +130,8 @@
>>      * Begin Berlekamp-Massey algorithm to determine error+erasure
>>      * locator polynomial
>>      */
>> -    r = no_eras;
>> -    el = no_eras;
>> +    r = no_eras_local;
>> +    el = no_eras_local;
>>     while (++r <= nroots) {    /* r is the step number */
>>         /* Compute discrepancy at the r-th step in poly-form */
>>         discr_r = 0;
>> @@ -158,8 +159,8 @@
>>                 } else
>>                     t[i + 1] = lambda[i + 1];
>>             }
>> -            if (2 * el <= r + no_eras - 1) {
>> -                el = r + no_eras - el;
>> +            if (2 * el <= r + no_eras_local - 1) {
>> +                el = r + no_eras_local - el;
>>                 /*
>>                  * 2 lines below: B(x) <-- inv(discr_r) *
>>                  * lambda(x)
>> @@ -312,14 +313,21 @@
>>                 eras_pos[j++] = loc[i] - pad;
>>             }
>>         }
>> +        if (no_eras)
>> +            *no_eras = j;
> At this point j will be equal to num_corrected. So why return this
> information in no_eras, when it is already returned by the function?
>
>>     } else if (data && par) {
>>         /* Apply error to data and parity */
>> +        j = 0;
>>         for (i = 0; i < count; i++) {
>>             if (loc[i] < (nn - nroots))
>>                 data[loc[i] - pad] ^= b[i];
>>             else
>>                 par[loc[i] - pad - len] ^= b[i];
>> +            if (b[i])
>> +                j++;
>>         }
>> +        if (no_eras)
>> +            *no_eras = j;
>
> Same as above.
>
>> 2.25.1
>>
>
> Best,
> Ferdinand
>
