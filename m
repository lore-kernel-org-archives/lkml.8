Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138A120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/y+2B/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgG3Mkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:40:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgG3Mkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596112853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=657ZXaavlZsnMYk6AbzdWXyxefEdWI1VRZPYAY+0IGo=;
        b=X/y+2B/Ub4H+dDH7udXThFm45FMVbiss9r5PDwIRZNEqkvQB+MBfAK3OL7qwqwZdKYq4s/
        RPr6rYmR9pa1C9f/Sw5Ikd3B+Lt4dsUoU4z5c09Mv6PPcmwFapsvmbWbyeKNrwSxqD/P79
        IAd1A8HyoaqbLsiHAAxCD2gMgmf6aOg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-VRQzHyBdNTersSSQZt0RNw-1; Thu, 30 Jul 2020 08:40:52 -0400
X-MC-Unique: VRQzHyBdNTersSSQZt0RNw-1
Received: by mail-wr1-f70.google.com with SMTP id t3so6860808wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=657ZXaavlZsnMYk6AbzdWXyxefEdWI1VRZPYAY+0IGo=;
        b=lsTysGMNKAqh0CzJejPHH9tvUSnTLtBOos+Ai1kTu4+u6ir8AG3iuHdmFiaX9LPVok
         talrDi6SZlSpaUsqmoj+6bzKG2YVKtUqRptrEpOuknIB3GWbwmJmnD0GkTbQXLpUD3A/
         dpRoXX8ebUMZT2xbl6con9Lf6SMP0M0XjZRBGLcPGd2JuOXg+0O4R2BkaLfpRLfKo1+T
         dgadF32Mt9rTuL6gNCd0Tx0DrdZ2cMw/puOmG+EUsbmzkyn5sfBEQFPOqusWGmRuFadN
         QGZBi9595Wl2i0PvGeIijBQ4BrlRn/6+WG0nejCnvWpcD3esPrj/nzex3E5G1TQgkwnK
         xHeA==
X-Gm-Message-State: AOAM5333A0dkI+4e8AzT0tkusT2MDTxGqwDJggX67/i0EReSDK3jt0wQ
        dT7RYgKSB8VgHyqW0EkDKJiugXGhxwCrjRV4FdOsl+JT+D90yyn4XwjFIXjvc+TeedQuIpIz1Dr
        /OI0ovGuENxNjudpCqC85A5qW
X-Received: by 2002:adf:9561:: with SMTP id 88mr2576235wrs.240.1596112849874;
        Thu, 30 Jul 2020 05:40:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsufODdjaQyvSGTcsWHAVUb3c6QWjRkY5FU1oIcl8SgiGVFniSa/5/C7Xj4h24FpHoPIzlqg==
X-Received: by 2002:adf:9561:: with SMTP id 88mr2576220wrs.240.1596112849710;
        Thu, 30 Jul 2020 05:40:49 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id f15sm8309487wmj.39.2020.07.30.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 05:40:49 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of
 instruction structure
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-5-jthierry@redhat.com>
 <20200730100304.GI2655@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <e4e239ad-120e-bd8f-4128-6976146c8512@redhat.com>
Date:   Thu, 30 Jul 2020 13:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730100304.GI2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 11:03 AM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 10:41:43AM +0100, Julien Thierry wrote:
>> One orc_entry is associated with each instruction in the object file,
>> but having the orc_entry contained by the instruction structure forces
>> architectures not implementing the orc subcommands to provide a dummy
>> definition of the orc_entry.
>>
>> Avoid that by having orc_entries in a separate list, part of the
>> objtool_file.
>>
> 
>> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
>> index 66fd56c33303..00f1efd05653 100644
>> --- a/tools/objtool/orc_gen.c
>> +++ b/tools/objtool/orc_gen.c
>> @@ -9,18 +9,33 @@
>>   #include "check.h"
>>   #include "warn.h"
>>   
>> +struct orc_data {
>> +	struct list_head list;
>> +	struct instruction *insn;
>> +	struct orc_entry orc;
>> +};
>> +
>>   int create_orc(struct objtool_file *file)
>>   {
>>   	struct instruction *insn;
>>   
>>   	for_each_insn(file, insn) {
>> -		struct orc_entry *orc = &insn->orc;
>>   		struct cfi_reg *cfa = &insn->cfi.cfa;
>>   		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
>> +		struct orc_entry *orc;
>> +		struct orc_data *od;
>>   
>>   		if (!insn->sec->text)
>>   			continue;
>>   
>> +		od = calloc(1, sizeof(*od));
>> +		if (!od)
>> +			return -1;
>> +		od->insn = insn;
>> +		list_add_tail(&od->list, &file->orc_data_list);
>> +
>> +		orc = &od->orc;
>> +
>>   		orc->end = insn->cfi.end;
>>   
>>   		if (cfa->base == CFI_UNDEFINED) {
> 
> This will dramatically increase the amount of allocation calls, what, if
> anything, does this do for the performance of objtool?
> 

I guess I forgot about the usecase of running objtool on vmlinux...

On a kernel build for x86_64 defconfig, the difference in time seems to 
be withing the noise.

But I agree the proposed code is not ideal and on the other we've tried 
avoiding #ifdef in the code. Ideally I'd have an empty orc_entry 
definition when SUBCMD_ORC is not implemented.

Would you have a suggested approach to do that?

Thanks,

-- 
Julien Thierry

