Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E8C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="NqliLYf9";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="nDT0A7RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgGMNqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:46:46 -0400
Received: from smtp115.iad3b.emailsrvr.com ([146.20.161.115]:54193 "EHLO
        smtp115.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgGMNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:46:46 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 09:46:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594647682;
        bh=EOOEcwVnNhrB2zlBpKV9mQ6iQCCp9r/JpMUMZn/KjxE=;
        h=Subject:To:From:Date:From;
        b=NqliLYf9GgJ/eJP5i4hL8VnW0BPztK6ipsf2UCAjGEJ7qZfnaO9sBVSNYCkNDFsU3
         hpBleevxHXz2pWxSK0XbWEK9ErZ2vQOlFBkGBMKSojp4EEdPWT4x0U/SPQwoC+DJF1
         l0aSCYMJff2ZRlNVXDfaE+CEjzgpeSH+yGUBBGQ0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594647682;
        bh=EOOEcwVnNhrB2zlBpKV9mQ6iQCCp9r/JpMUMZn/KjxE=;
        h=Subject:To:From:Date:From;
        b=nDT0A7RUR/VY8HEqxRCvMnOSaEJvCACk4R5PdWr43T9amIFmpBmNJKFitXxOboTv5
         C87MlOnQmrWKz7+bmhSSEmpNDL7tTsIWUxfKhG89jXteSRH/hngRBlySSz02uPOHeJ
         un+FVtvZbHOiWDJq/9lUnVwEkMA9Ti2gehZQU6vs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4A9BEA019E;
        Mon, 13 Jul 2020 09:41:21 -0400 (EDT)
Subject: Re: [PATCH] Staging: comedi: driver: Remove condition with no effect
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <20200712070628.GA18340@saurav>
 <20200713133438.GA3122574@kroah.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <7653a794-d5ed-5d9f-95af-745a88769092@mev.co.uk>
Date:   Mon, 13 Jul 2020 14:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713133438.GA3122574@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: ab442396-f12e-4f1d-b74c-5c5ca72d8073-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 14:34, Greg KH wrote:
> On Sun, Jul 12, 2020 at 12:36:28PM +0530, Saurav Girepunje wrote:
>> Remove below warning in das1800.c
>> WARNING: possible condition with no effect (if == else)
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/comedi/drivers/das1800.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
>> index f16aa7e9f4f3..7ab72e83d3d0 100644
>> --- a/drivers/staging/comedi/drivers/das1800.c
>> +++ b/drivers/staging/comedi/drivers/das1800.c
>> @@ -1299,12 +1299,6 @@ static int das1800_attach(struct comedi_device *dev,
>>   			outb(DAC(i), dev->iobase + DAS1800_SELECT);
>>   			outw(0, dev->iobase + DAS1800_DAC);
>>   		}
>> -	} else if (board->id == DAS1800_ID_AO) {
>> -		/*
>> -		 * 'ao' boards have waveform analog outputs that are not
>> -		 * currently supported.
>> -		 */
>> -		s->type		= COMEDI_SUBD_UNUSED;
> 
> What gave that warning?  The comment should show you why this is good to
> keep as-is, right?

One option is to move the comment into the '} else {' part that follows 
this part.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
