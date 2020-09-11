Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD512C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B89206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfhw29QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIKQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgIKQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:19:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407EFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:19:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so12036391wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w1V/6tHjZ1NtUvI5vv0MkTufp8n0QRJxDeDd70OdYyw=;
        b=Tfhw29QGXarXdouwsB/57WAsUhFtYcqhXgIUhICtddCyqRmUkGdAHYMDQujJx8+MiQ
         TlGUpADT4u4+S2GpWDMA/+rGRKlh903aGRAhRzNVK6NmnBvEncQ6Jlo5GmpprMXh50V9
         2VCf1Bd3RdjLTFkdEllDjKGRE3BEOiFXmo6p6KS/89Fudg6i9O11hmKNlTJ9Qkzs1BB2
         JSs8Ny1auzF602nVZaKGaY83GS7OK6KZnXDAwur6nvZrCzR5fdx+ldvZB/JCXSvHRW3A
         J/yCA/mPF94VS0mGZPe65dXflZNf4wUnFinjzPLfjRzuoM7JWejtSrKbLpORd5LzC9E9
         EgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w1V/6tHjZ1NtUvI5vv0MkTufp8n0QRJxDeDd70OdYyw=;
        b=iTsfwom3mOjq+rWqaZOYaQdz8g35tVzVqMO+DMtAK5ogipedp3oYX8DBN81VWeZCR/
         yTilWjPfpVQwez93gZfaV/Ucf1M30pb4cbxHbX68X3mbngqkYOalwUVYDqo4MA/GnX8a
         fplT7ySvpsBKK0TBGJAmLIBzMXoLD681UINI2O+eyV/kCaQbcc/iiKEM9gWdb/Q2J84a
         9Lvcg2Cu5dld8kc1AbzklPbo/XbScErku0p3izcYiST/Y/jtMHbyctlsg5cRoLDFJLnp
         h6B9TU9EuG8Dgl2yF6TLfGgl8NxQP7Sx/sBVaEoglTjB7gCUiu4ElG3ELsS3sieWeBW4
         Rr9w==
X-Gm-Message-State: AOAM533pIEDVTJsBQ7NYnlE6Nhk7HatfuxY2tV0Oaqn31GwloyXy+bRq
        vhwBjXbFXfaqkXP/lL1Nk7kr0Ht3FhhHi4eR
X-Google-Smtp-Source: ABdhPJzp43YfOLo6jV1ZtFBCqvOBufenR2xsV1jzYJAYStJ2/OggQv6jtZxhqyyIws001n3c642jNg==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr3044280wrn.66.1599841194808;
        Fri, 11 Sep 2020 09:19:54 -0700 (PDT)
Received: from [192.168.0.18] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id t22sm6521738wmt.1.2020.09.11.09.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 09:19:54 -0700 (PDT)
Subject: Re: [PATCH] scripts: kzfree.cocci: Deprecate use of kzfree
To:     efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200911134956.60910-1-alex.dewar90@gmail.com>
 <1486f777-23d9-19c4-d26d-bba1d8704660@linux.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <7045abd9-0512-4274-a368-e80fe04b1e9d@gmail.com>
Date:   Fri, 11 Sep 2020 17:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1486f777-23d9-19c4-d26d-bba1d8704660@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-11 17:08, Denis Efremov wrote:
> Hi,
>
> same patch
> https://lkml.org/lkml/2020/8/11/130
>
> Julia, I've send all the patches to fix existing kfree_sensitive/kvfree_sensitive reports.
>
> https://lkml.org/lkml/2020/8/27/168
> https://lkml.org/lkml/2020/8/27/93
>
> Thanks,
> Denis
Sorry for yet more noise!
>
> On 9/11/20 4:49 PM, Alex Dewar wrote:
>> kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
>> treewide: rename kzfree() to kfree_sensitive()"). It is currently just a
>> legacy alias for kfree_sensitive(), which achieves the same thing.
>>
>> Update kzfree.cocci accordingly:
>> 1) Replace instances of kzfree with kfree_sensitive
>> 2) Merge different rules for memset/memset_explicit as kzfree and
>>     kfree_sensitive are now equivalent
>> 3) Rename script to kfree_sensitive.cocci
>>
>> In addition:
>> 4) Move the script to the free/ subfolder, where it would seem to fit
>>     better
>>
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>>   .../kfree_sensitive.cocci}                    | 38 +++++--------------
>>   1 file changed, 10 insertions(+), 28 deletions(-)
>>   rename scripts/coccinelle/{api/kzfree.cocci => free/kfree_sensitive.cocci} (59%)
>>
>> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/free/kfree_sensitive.cocci
>> similarity index 59%
>> rename from scripts/coccinelle/api/kzfree.cocci
>> rename to scripts/coccinelle/free/kfree_sensitive.cocci
>> index 33625bd7cec9..a87f93f2ed5c 100644
>> --- a/scripts/coccinelle/api/kzfree.cocci
>> +++ b/scripts/coccinelle/free/kfree_sensitive.cocci
>> @@ -1,13 +1,13 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   ///
>> -/// Use kzfree, kvfree_sensitive rather than memset or
>> -/// memzero_explicit followed by kfree
>> +/// Use k{,v}free_sensitive rather than memset or memzero_explicit followed by
>> +/// k{,v}free
>>   ///
>>   // Confidence: High
>>   // Copyright: (C) 2020 Denis Efremov ISPRAS
>>   // Options: --no-includes --include-headers
>>   //
>> -// Keywords: kzfree, kvfree_sensitive
>> +// Keywords: kfree_sensitive, kvfree_sensitive
>>   //
>>   
>>   virtual context
>> @@ -18,7 +18,7 @@ virtual report
>>   @initialize:python@
>>   @@
>>   # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
>> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
>> +filter = frozenset(['kmalloc_oob_in_memset', 'kfree_sensitive', 'kvfree_sensitive'])
>>   
>>   def relevant(p):
>>       return not (filter & {el.current_element for el in p})
>> @@ -53,34 +53,16 @@ position m != cond.ok;
>>   type T;
>>   @@
>>   
>> +(
>>   - memzero_explicit@m((T)E, size);
>> -  ... when != E
>> -      when strict
>> -// TODO: uncomment when kfree_sensitive will be merged.
>> -// Only this case is commented out because developers
>> -// may not like patches like this since kzfree uses memset
>> -// internally (not memzero_explicit).
>> -//(
>> -//- kfree(E)@p;
>> -//+ kfree_sensitive(E);
>> -//|
>> -- \(vfree\|kvfree\)(E)@p;
>> -+ kvfree_sensitive(E, size);
>> -//)
>> -
>> -@rp_memset depends on patch@
>> -expression E, size;
>> -position p : script:python() { relevant(p) };
>> -position m != cond.ok;
>> -type T;
>> -@@
>> -
>> +|
>>   - memset@m((T)E, 0, size);
>> +)
>>     ... when != E
>>         when strict
>>   (
>>   - kfree(E)@p;
>> -+ kzfree(E);
>> ++ kfree_sensitive(E);
>>   |
>>   - \(vfree\|kvfree\)(E)@p;
>>   + kvfree_sensitive(E, size);
>> @@ -91,11 +73,11 @@ p << r.p;
>>   @@
>>   
>>   coccilib.report.print_report(p[0],
>> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
>> +  "WARNING: opportunity for k{,v}free_sensitive")
>>   
>>   @script:python depends on org@
>>   p << r.p;
>>   @@
>>   
>>   coccilib.org.print_todo(p[0],
>> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
>> +  "WARNING: opportunity for k{,v}free_sensitive")
>>

