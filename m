Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633C3206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=leaflabs-com.20150623.gappssmtp.com header.i=@leaflabs-com.20150623.gappssmtp.com header.b="AFwEOdJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbgEYTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:50:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:50:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v79so8339027qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leaflabs-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBPda5NA99jy1A5gbIBXWbIi5pPJWudA4hi9ywStCK8=;
        b=AFwEOdJXx9pmke4TFlrGLvTobL3pkHPcTeYy1VQ/+NvoFFCp6uirMXgQ82v8Zl8lNw
         dSUO3wm4ySpmHP4HelChS2Nh3NbDfp5DUqxcKyw+YzzMm1mPA39vsq8fTKmDauRWXz80
         dKj6Lw74fKNBb2AZSPqrJdEiv9X3fj8XpYj5nI9ETulqC7pEvJ8nNt1tiUsajsT9xhUK
         /2Pw9Z1aKCLtkn4jCV7lj1Qem68tYBkGTKk32B4gIMIO84gkwXe5YW+zoaTaV8zKNBKP
         lygN2dgGZJH5JDESQd1/jbD8os9LxmYezSp25v318vJiJeTvo0XVOtJTfuYRxfsK5DgP
         iUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBPda5NA99jy1A5gbIBXWbIi5pPJWudA4hi9ywStCK8=;
        b=HmJ6z4f77RFZSwqROeMBzuWrYNNcQeCO8lRZOwYu8+icBDdnjZpJE21kEgclh1Ax+L
         GRQINs9o8Wm3VREt1DMc0qObSTX/eiNdpfusL4oTg5yugJ/ikv+Qm887KOBvx7s5rXuz
         gXrB9n7+k+pe/7mjatJG8+syf6OCDxzpddnJbq1wBWk7Xc9tA1+8BzpM6M2bH+GDTu+B
         IwO2cYDqYJ/0X4Oiu4Oj61l0vR/gdECJ/jN52GPaXQ4jRAYeQZBlVJIAqwI/6wsivcty
         0VxBKfH/jtcyXtVUvGhlFGJmzJjFk5S9nuYB93RwpPvz+FNbq6sUkxkXtjjLw22+CX70
         /YyQ==
X-Gm-Message-State: AOAM5323s846WqIm1CYXnUUzTmjMzkOjXMe977jgmP0lyYoYH9p2WFN1
        xM1Up1PSALCKCRs/MFFapYG7cw==
X-Google-Smtp-Source: ABdhPJy2ocMQraNI2+O+UyJv/WlvUwdvZdG5MF0q1EO9a6FaJj8c2aCSHVNxa636iD1znd8Fs29E6g==
X-Received: by 2002:a37:63d0:: with SMTP id x199mr24878172qkb.271.1590436248754;
        Mon, 25 May 2020 12:50:48 -0700 (PDT)
Received: from [192.168.189.130] (209-6-156-57.s56.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [209.6.156.57])
        by smtp.gmail.com with ESMTPSA id i14sm2984009qkl.105.2020.05.25.12.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:50:48 -0700 (PDT)
Subject: Re: [PATCH] staging: vchiq_arm: cast with __force as needed
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200519004531.33158-1-tasman@leaflabs.com>
 <20200522110623.GL30374@kadam>
From:   Mitchell Tasman <tasman@leaflabs.com>
Message-ID: <4dcf963f-ce9a-fa2b-09c9-c8657f407167@leaflabs.com>
Date:   Mon, 25 May 2020 15:50:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522110623.GL30374@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 7:06 AM, Dan Carpenter wrote:
> On Mon, May 18, 2020 at 08:45:31PM -0400, Mitchell Tasman wrote:
>> In several cases where a pointer marked as __user is
>> (intentionally) assigned or passed to a non-marked target,
>> cast to the target pointer type with a __force directive
>> to quiet warnings from sparse.
>>
>> Signed-off-by: Mitchell Tasman <tasman@leaflabs.com>
>> ---
>>  .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c     | 7 ++++---
>>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 +++-
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> index c18c6ca0b6c0..38a13e4618a8 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> @@ -371,14 +371,15 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>>  	pagelistinfo->scatterlist = scatterlist;
>>  	pagelistinfo->scatterlist_mapped = 0;
>>  
>> -	if (is_vmalloc_addr(buf)) {
>> +	if (is_vmalloc_addr((void __force *)buf)) {
> 
> Am I reading this correctly???
> 
> This is actually a user controlled pointer that comes from the
> vchiq_ioctl() when we do VCHIQ_IOC_QUEUE_BULK_TRANSMIT/RECEIVE.  So we
> take random pointer from user space and if it happens to point to kernel
> space then we trust it and presumably start BULK_TRANSMITing data to
> it???
> 
> LOL....  This doesn't seem safe at all.

Is additional validation of buf and its extent necessary and sufficient, e.g. perhaps access_ok(buf, count * PAGE_SIZE) somewhere along the call chain?  Or does vhciq_arm need to take a different approach in the area that Dan Carpenter flagged?

Thank you.

> 
> regards,
> dan carpenter
> 

Regards,
Mitch
