Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA84C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BA22067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI7fjXzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHXVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:31:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24945 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgHXVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598304666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo3LWlCNiIOFoCmxEjwdUemS1sJZBLVfxAMsdk/Iu6M=;
        b=YI7fjXzAFzydzivjbhZTh5mhuOuIUWksKJTslmxIkT5/13qqckiKgJucIefYg5qinlu2OU
        6nzMJQbPFOlSF48qgKXElUfSNalZGSV5fuQzZBhp8lUAyxfg2Jt3o97+Nk0zDLe2IcnmjR
        9MH4KkHKXnaJ/UHgIvODaRhdm97AJ2A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-poCKiVx5OXKm-1XVn1RNng-1; Mon, 24 Aug 2020 17:31:04 -0400
X-MC-Unique: poCKiVx5OXKm-1XVn1RNng-1
Received: by mail-qt1-f199.google.com with SMTP id r24so7879510qtu.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mo3LWlCNiIOFoCmxEjwdUemS1sJZBLVfxAMsdk/Iu6M=;
        b=cWEf8M5o1OiuffaY+/v3XOd/OdrpkuiystSDyPWp5bP27kJghXTZ5Fu+gP43cCx+rG
         vLEgBg4tGn2mVivInU8j8Ct+sO0C1iZUfb4PocmVHtc+dGUHgSPbu0zAxdCawQ0tuk2t
         O/RL4fVZKmo0oSbXPemX9EfrGe5so6S2cK8Z2w5BMEUJpATengl78GRixh4plmx8ZJVn
         pXPn+/+OY9X3gZbGXbae/XXP8G1ZZf2eoqryYo928AobndfEgUh44kCjFmqNGTW0VFSf
         ufnUI7ZMatFDrT4FgIM2JtFIce0fbog/GI9F2aJJPCMAGS/z5U5uRL6p4BeSiNgVmlrP
         lupg==
X-Gm-Message-State: AOAM5321JsKM6YsDNpfyhpZQwNaUdNKdsTgbjuSRDr3uDpi4ZAgGPpjO
        +ttUEYuNXWSA9yW4yrtaY4Y6vNZycQbjqYrwK9ioV7SCXh/8kzpNysFkXobi+8RaCjdpjDMkyI9
        j4mbeaVjkX4J9yDCI8WnESeqU
X-Received: by 2002:ac8:1349:: with SMTP id f9mr6839917qtj.24.1598304664002;
        Mon, 24 Aug 2020 14:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8RcZgt0TQyB0V/DUGdZj5UKHWK+5mR9NF506RVPbUZd9Y4USNfgfG3wOPaqhv+HbOrb76jw==
X-Received: by 2002:ac8:1349:: with SMTP id f9mr6839890qtj.24.1598304663686;
        Mon, 24 Aug 2020 14:31:03 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r5sm136684qtd.87.2020.08.24.14.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 14:31:03 -0700 (PDT)
Subject: Re: [PATCH v2] usb: storage: initialize variable
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
References: <20200824211027.11543-1-trix@redhat.com>
 <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c9c4fca2-d04a-1bf9-e90e-9476392c1662@redhat.com>
Date:   Mon, 24 Aug 2020 14:31:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/24/20 2:18 PM, Vito Caputo wrote:
> On Mon, Aug 24, 2020 at 02:10:27PM -0700, trix@redhat.com wrote:
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
>> So set partial on entry to 0.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/usb/storage/transport.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
>> index 238a8088e17f..044429717dcc 100644
>> --- a/drivers/usb/storage/transport.c
>> +++ b/drivers/usb/storage/transport.c
>> @@ -414,6 +414,9 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>>  {
>>  	int result;
>>  
>> +	if (act_len)
>> +		*act_len = 0;
>> +
>>  	/* don't submit s-g requests during abort processing */
>>  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
>>  		return USB_STOR_XFER_ERROR;
> At a glance this seems odd to me.  If the caller insists on ignoring
> the return value, shouldn't it just initialize partial to zero?
>
> In my experience it's generally frowned upon for functions to store
> results in error paths.

Then maybe v1 is more appropriate.

Else i can spin a v3.

My preference is v1 as it doesn't add any runtime if-checks.

Tom

> Regards,
> Vito Caputo
>

