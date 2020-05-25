Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7F2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIpFkyqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390956AbgEYOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:43:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF16C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:43:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so20714695ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2r86WacDGnUCOO6WwYKfUAcxSZc3UkZYsl//tDZGyco=;
        b=TIpFkyqrsZozNMDnMDecOEO1Kwr52zfLkT29smqMJ458sFuesfF+NlDp8nWPP3iKNY
         iQ3pbZI56DUArWx6cGULkb9ds6Oa41l7CgEefz/eLpkX9rciOtBx0bMMNFFdtMgz01qA
         XZ6BuMg7m+ExGPHJuMbQXEZJtbtyykWN3zO3IxAZDIV73FdChDTKS5XkvKXdUw67xleK
         fOt5TzJh/hm1anIY79rREZTfdiZdVAbcojzu8+j29dLxFIHqhWXOagMeGOpi3VyugB/k
         qiIw823HQEve7OEBJaZwp1cwzLrYXLMLTn1kBdxESnkAgT7EsRROvebutkd4YLhfWez8
         vfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2r86WacDGnUCOO6WwYKfUAcxSZc3UkZYsl//tDZGyco=;
        b=Mwp2f/Ey5JHQZmwSkYaEt3FnJozGX8K3MSdQ9hdupL2rIP5wVcItEyfmvS4hdQ8uAy
         dZqI9cJm3JIlsULy8S2sEZPj5Yx2fi55EmokDJURw6lvEphgnf59ePbnsEpmVDvHt0gs
         VRQMKhqLurZ3MLY6Ik0ag3aVPD8DY8Pz/r+8g0gRIyV1lEPtP7GDrxca/d9KvtidrWSR
         LSwlerEbU9FQiklwXnuVzMj1A6Z2D+T/kCR2aAgtqzu670XE1TVd6IFDg3HSzycRtJ1i
         9uTezwxZy5PlByHPNTJD4zSu3oDjfi4LoeO1MrrtNMbiRYQoJpdqAgqLKmDrXFkvXL9/
         Ff+g==
X-Gm-Message-State: AOAM533CEMFkuvaBPOjXhk6Jp+xgt0KCLEvV2YitNHyoPBdSyE6grQAD
        d/Bir/OOooV+UVsltumc1D4=
X-Google-Smtp-Source: ABdhPJwAnyYJCFxXY/QFwaXxT5pa85gzlaago7+k2z9kTK1twyb8XgigApjgp6Zyygkhuxar8UMa4g==
X-Received: by 2002:a17:906:4e87:: with SMTP id v7mr18526978eju.384.1590417794085;
        Mon, 25 May 2020 07:43:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h25sm15826846ejx.7.2020.05.25.07.43.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:43:13 -0700 (PDT)
Date:   Mon, 25 May 2020 14:43:12 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-ID: <20200525144312.mbw2z3ydncyasvss@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
 <20200525091458.GK1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525091458.GK1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 12:14:58PM +0300, Andy Shevchenko wrote:
>On Sun, May 24, 2020 at 12:35:51PM +0000, Wei Yang wrote:
>> These two cases could be unified into one.
>
>Care to provide a test case which supports your change?
>

Hmm.. where should I put the test? tools/testing/selftests/ ?

>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  include/linux/bitops.h | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>> index 9acf654f0b19..5b5609e81a84 100644
>> --- a/include/linux/bitops.h
>> +++ b/include/linux/bitops.h
>> @@ -206,10 +206,7 @@ static inline int get_count_order_long(unsigned long l)
>>  {
>>  	if (l == 0UL)
>>  		return -1;
>> -	else if (l & (l - 1UL))
>> -		return (int)fls_long(l);
>> -	else
>> -		return (int)fls_long(l) - 1;
>> +	return (int)fls_long(--l);
>>  }
>
>-- 
>With Best Regards,
>Andy Shevchenko
>

-- 
Wei Yang
Help you, Help me
