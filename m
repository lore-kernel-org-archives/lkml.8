Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FDF20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsK67ak/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:40:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46327 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:40:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id f13so2822333wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQN/YbSH1U0Hdym1a0eKmIzW7Vl10c/CjDwiNW+YpC8=;
        b=rsK67ak/QIkS4dSW//qtxUdMlLEkfnTtXsElMGAefgL1zRabCq092PAXFJ6rYPp8Mf
         1ZtA8SMpgWt7ur5BK1il8bVz0DavyiJWhvyRzNBlkcRH56kL9WBOPs/TEjvaFdX8IQPp
         DpllDqyn7Wq4uOBw0e5KpJINVdRtcQGk+f8ecePPV3ogN5Q/TYOjBn3m0VonYMFliE6q
         WfhTt8Wx4MKSkcPKo61NHhbrneNzzgDrqZ3nMOXOU8qOhA6tCBPsbETAJoXfaQ9AGuOb
         ML2MWSu7+njetBcevS5hqh5Fhh1euE4SFRKY68P37FVQETyKdWKLrUxibvtNIVoRj53d
         0MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQN/YbSH1U0Hdym1a0eKmIzW7Vl10c/CjDwiNW+YpC8=;
        b=f7O2lEeifuYKVmIIH5z00Tbmns17Ch0VY1XUksxlSCAWb6YyCrry+EgLe4rJd8YbwH
         K6zqf1aeVf+LDLKA2hoenkRt1D5FuphFDHJdPW4e55ptKgYIES0xN2LjvcpHkoo7A893
         QIuGk0iIgvYRRLdgcdlkpUwvreBsEmY5fjEFlAb5BBNRkI9ZxsjfwAUtjvhruBcDLKYb
         laBpdQSxICDrngZLinHOjHVzdOHjkXkUgBUitzuCIcs+85D3Y//3/Z+K8uBQU3TTgOeo
         du1H8VMMfd05RSlzcOGiiayRFOyumPFOOXTcL255p/fFFMXWmOJtraCB1ANFrTbcLRSA
         EWTQ==
X-Gm-Message-State: AGi0PuaPX6xYRcCCDQO4gFbpTW5GveaTsdShLZh3p23qczB08j37RoNA
        9TYCcucCb+jd7e563qsGz6GkI3un
X-Google-Smtp-Source: APiQypIDNW4vIKXpG+QLg0z43/iuXFAou/wGZaok0x+1OLRghgU5g1By6zyECCQVBjFTlxOUm5wGKw==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr5486012wru.352.1586536855546;
        Fri, 10 Apr 2020 09:40:55 -0700 (PDT)
Received: from [192.168.43.227] (94.197.121.102.threembb.co.uk. [94.197.121.102])
        by smtp.gmail.com with ESMTPSA id z3sm3309100wma.22.2020.04.10.09.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 09:40:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200410112834.17490-1-oscar.carter@gmx.com>
 <20200410112834.17490-2-oscar.carter@gmx.com>
 <986e8e5e-245a-cc70-2c6f-8ac3a4a485c9@gmail.com>
 <20200410155911.GA3426@ubuntu>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <fcc434e9-9da4-4f24-19cc-bac8fc7166ec@gmail.com>
Date:   Fri, 10 Apr 2020 17:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410155911.GA3426@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2020 16:59, Oscar Carter wrote:
> On Fri, Apr 10, 2020 at 04:37:59PM +0100, Malcolm Priestley wrote:
>>
>>
>> On 10/04/2020 12:28, Oscar Carter wrote:
>>> Create a constant array with the values of the "phy->signal" for every
>>> rate. Remove all "phy->signal" assignments inside the switch statement
>>> and replace these with a single reading from the new vnt_phy_signal
>>> array.
>>>
>>> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
>>> ---
>>>    drivers/staging/vt6656/baseband.c | 101 +++++++-----------------------
>>>    1 file changed, 21 insertions(+), 80 deletions(-)
>>>
>>> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
>>> index a19a563d8bcc..47f93bf6e07b 100644
>>> --- a/drivers/staging/vt6656/baseband.c
>>> +++ b/drivers/staging/vt6656/baseband.c
>>> @@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] = {
>>>    	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
>>>    };
>>
>> Actually you don't need the second values
> 
> Great.
>>>
>>> +static const u8 vnt_phy_signal[][2] = {
>>> +	{0x00, 0x00},	/* RATE_1M  */
>> The driver would never attempt use preamble at this rate
>> so it's safe to include in with the next 3 rates
Sorry got this wrong the driver is trying to do preamble (short)
at this rate and it is not working.

So don't apply it to RATE_1M rate.

Regards

Malcolm


