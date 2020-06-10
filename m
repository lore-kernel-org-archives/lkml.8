Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C168020656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hYeA7maS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFJVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFJVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:48:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366CFC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:48:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so904751pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lqq2SqvcCq2mUx2FIpqozpsurS1CyxZsch8dOA0a4hs=;
        b=hYeA7maSY98GNKcEpgCaA2nDzq4Nu88P3KOy9wNdovKUcxwkoGcifhKXEC5uSAjeOW
         VfBEZ1Qn1sgSizdsAQFZLwXzkMMDLCz1DdyaMaljGCbQpheK6krycJ/tDafzMI9GAtae
         01hZMTXAez6QT3jNZ/mZwZPE6zgIq1vL/TGpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lqq2SqvcCq2mUx2FIpqozpsurS1CyxZsch8dOA0a4hs=;
        b=aElz1ZJakTczK4oq7SgntsoPfCCixLpYAWKl/ulzNEWjntFko+aQQcUlaBV8JNk0oE
         uqf63K0TQLdtI+/8PNzgxKDWp/UsD0+Jl/ydsEctB/iF0j2owYmeuU8+atIznhO1kEBX
         DrSOu2kKOqMluAmwc85hwlklzlcjrnEFqFMjBdc55ZuUo0vgo62oFfDM0OYTyCCxZzOi
         5/dkBp1CaT2MahadUWyV5mJ6nnNE5GuAhP5J2NE6X9VUrn5S0dqcWKj/2f64SI0c9vo2
         cy7qRFNBdwMx/znriLQZta62n4UmEIb4qyo5Uc9mdDFmUv29j+m6E6coYxn7btksmlMq
         YioA==
X-Gm-Message-State: AOAM532x0UpP9zmeMQFrwvWgOCnqQU9ZVe9XuoNb4eNSlXwJDnxKWXTh
        89LtMCtfthQaTEnZSlKAQHgsTfIJza8qx/qGJJzhjTIhE8WdgpUl6Ez+zs/0P1AfAcJDBlBlKTU
        IKKicXwowYJIf9YWq+Yr4JFbMTEwvftP8dWznLGtWwltBLQgR2TI+DDG5xsCik6dvV/5Sh8bCEv
        BLEXndmbDkTQE=
X-Google-Smtp-Source: ABdhPJyi60avsYEkp4lQcjSHu771fhAGnVohE7tCFIvXTWOJIe4ouMWNsYfRBPhKm3gybESKivNioA==
X-Received: by 2002:aa7:8141:: with SMTP id d1mr4657001pfn.209.1591825691979;
        Wed, 10 Jun 2020 14:48:11 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l83sm869633pfd.150.2020.06.10.14.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 14:48:11 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: ignore CamelCase for inttypes.h format
 specifiers
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20200610203307.9344-1-scott.branden@broadcom.com>
 <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <a3d5f2c5-40fb-c97d-8365-423213926e89@broadcom.com>
Date:   Wed, 10 Jun 2020 14:48:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-10 2:09 p.m., Joe Perches wrote:
> On Wed, 2020-06-10 at 13:33 -0700, Scott Branden wrote:
>> Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
>> (ex. PRIx32 for uint32_t).
> Personally, I don't like those.
Checkpatch is run against a lot of code outside of the linux kernel but 
following linux coding style.
There is nothing personal about this, they are the format specifiers in 
inttypes.h for fixed width types .
>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   scripts/checkpatch.pl | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 899e380782c0..9fa90457b270 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -5157,6 +5157,8 @@ sub process {
>>   			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
>>   #Ignore Page<foo> variants
>>   			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
>> +#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
>> +			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&
>>   #Ignore SI style variants like nS, mV and dB
>>   #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>>   			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

