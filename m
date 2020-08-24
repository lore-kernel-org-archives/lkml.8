Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4262074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjgdgI31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHXNNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:13:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgHXNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598274794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3sp5HeiSrgOhqJfi4HssybU/jSQO1GIn85W057WAgg=;
        b=TjgdgI31/QVn3pF2ZP+iFvzYG0rr4gMhwLkOQPEYUvskH+sQqDUTvk6wo9xWr9pLXZP6fh
        DrOTpx4xNy99O2jkkU1NFu1B9Xc76rAzA7n6YEunOui20xqr110C0MbvX4k1pbBkyJxCyW
        vMUoWzZQblYrSYVg3JHUC1hxNiTZvSM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-pb3U3_R-Nv6JfZZd8nqdhg-1; Mon, 24 Aug 2020 09:13:12 -0400
X-MC-Unique: pb3U3_R-Nv6JfZZd8nqdhg-1
Received: by mail-qt1-f197.google.com with SMTP id f11so2197732qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M3sp5HeiSrgOhqJfi4HssybU/jSQO1GIn85W057WAgg=;
        b=ZKOEsJqbj9gFwoNtQCENQzeHTNvSBbiYikpyXDhXwVmhI/Vhe7Vor44DPY1lJpWrMs
         f7wUvDU+pa4cUxmyL6vs1LNwW5tuZJO2vOpPJZbQh0IILOzQUjJcqSPOkNcdsiLDU2UA
         /f2H8ilcQak/nwsV724Ixm871FpBPOdtzFGtO8VBARMs6vyAMEo16z+i/uiJos1obDQp
         E+cDvusLpHk6gb0SMlKWUUkHh5Lu7HWITl1AQwaO4zpMdRvLAMktIefEKOSvKBo77Cz8
         TlVCzczxGeyJlhr9Nu3OtQgQInxZtGq4kXG64mhZcwDI/3MKh/mPYsWuqT5N0RgRWTsw
         mkow==
X-Gm-Message-State: AOAM532d/UBFQU16/99M8A+FlEiyu2DyxZkbcuN2sjE1+O2A0/PkPOsW
        cy/lUaW+DSOJoeUoQwtIP58FA0uRNIt53I4VgBLJBXovqwGFJtu9M9xBH/rG0+uzWXVflkMkBP8
        TbXRHVs+0VAnZnCPyUlv7d21l
X-Received: by 2002:ad4:4cc3:: with SMTP id i3mr4785572qvz.17.1598274791876;
        Mon, 24 Aug 2020 06:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSPtSwrwYTNDJdpHYixdyM9NxjZZRNyv5Uo1DAak/YtpD6YHO0BZWLW524k0+CXgmnBGugKw==
X-Received: by 2002:ad4:4cc3:: with SMTP id i3mr4785551qvz.17.1598274791593;
        Mon, 24 Aug 2020 06:13:11 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p34sm11806050qte.79.2020.08.24.06.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 06:13:11 -0700 (PDT)
Subject: Re: [PATCH] usb: storage: initialize variable
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20200822211839.5117-1-trix@redhat.com>
 <20200823004903.GB292576@rowland.harvard.edu>
From:   Tom Rix <trix@redhat.com>
Message-ID: <34834bbc-12e5-3fe1-7bb3-7a4c03acb03f@redhat.com>
Date:   Mon, 24 Aug 2020 06:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200823004903.GB292576@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/20 5:49 PM, Alan Stern wrote:
> On Sat, Aug 22, 2020 at 02:18:39PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis reports this representative problem
>>
>> transport.c:495:15: warning: Assigned value is garbage or
>>   undefined
>>         length_left -= partial;
>>                    ^  ~~~~~~~
>> partial is set only when usb_stor_bulk_transfer_sglist()
>> is successful.
>>
>> So initialize to partial to 0.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/usb/storage/transport.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
>> index 238a8088e17f..ce920851b1f2 100644
>> --- a/drivers/usb/storage/transport.c
>> +++ b/drivers/usb/storage/transport.c
>> @@ -461,7 +461,7 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>>  int usb_stor_bulk_srb(struct us_data* us, unsigned int pipe,
>>  		      struct scsi_cmnd* srb)
>>  {
>> -	unsigned int partial;
>> +	unsigned int partial = 0;
>>  	int result = usb_stor_bulk_transfer_sglist(us, pipe, scsi_sglist(srb),
>>  				      scsi_sg_count(srb), scsi_bufflen(srb),
>>  				      &partial);
>> @@ -484,7 +484,7 @@ int usb_stor_bulk_transfer_sg(struct us_data* us, unsigned int pipe,
>>  		void *buf, unsigned int length_left, int use_sg, int *residual)
>>  {
>>  	int result;
>> -	unsigned int partial;
>> +	unsigned int partial = 0;
>>  
>>  	/* are we scatter-gathering? */
>>  	if (use_sg) {
> Yes, this is a bug.  But the right way to fix it is to change 
> usb_stor_bulk_transfer_sglist(): Make it store 0 to *act_len at the 
> start.
>
> That way you change only one localized piece of code, instead of 
> changing multiple callers and leaving a possibility of more errors being 
> added in the future.

I'll respin the patch.

It will exchange the compile time initialization fix for a run time if-check fix.

> Alan Stern
>

