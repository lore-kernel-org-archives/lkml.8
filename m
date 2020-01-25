Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD96C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB7220674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3XdHpls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAYMPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 07:15:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46765 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAYMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 07:15:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so1906048pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 04:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEOUVkLXF88QHPCVWTmHvz1cvdcTGgdnYVNwsG5Ic3U=;
        b=R3XdHplspJIK9YorbtxOvVLVxQn8l7IuQv49jLjx674YmL77omkKpvhYHp2giCRmaM
         WeexnnaD41DaB8Qmv4wooPp/hRHiCAEJLaw/6Iz8kBzH2vtXG6H2OkxqchHoM/BQDtro
         UE1oeEOf0+0p07Dn46pgxiv1oi6QRxWVocc/bV1omL0LeP8Vk6AaRPcgIg1XadFfwNxQ
         a4A3Nj9TQ6v7XevbOesi8PUeMrJNFLymqjRuRT8AAFyIkYI8YhcvES0gHiBj5VmXbiTC
         tjwpanPKXmij/wYgWOFyZZm/9ZqDu6/hf2bUQbCZ4giQtu+mfcKmdFZ9U82lUCNdb8lN
         cFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEOUVkLXF88QHPCVWTmHvz1cvdcTGgdnYVNwsG5Ic3U=;
        b=j/scgDFDR6ZpX49UZcFSgNfSQDNp4kk2gSE7jZCooaqB2Q/0DWIIe8c3nzKC8PJmHU
         YofWANNyB7g1uFkgPKs6em2sxinfonf6/8BEQ7+4UlNXSa8LoLk2A5molFYKQXIDPJXf
         5H1VVqpLm711iNPZ4Ey0tRS10W8zdUrqls0hz2iRzr5ydyhm2SK8urSa3xrRbM5YaP/K
         U4Nc/XNOeaLcsH16rElisARisazl4P6SoGTfL90fxRTjl/OJHx+LaOAsjGA88wldtPKL
         gNzF+Z+AcSYonqA9n0uu5OKke1MWvEThHyCzTvMrIqRBn0c2Yggbz2NocI7NRqefnc+N
         2HUQ==
X-Gm-Message-State: APjAAAUoxmixvQWHJmqYZUQVY+gyCCsgZA4PndZym3nbTn+A/NRA7K3p
        Sh7DKHTFkWCbDabZK1UWl7TyyOo5xHs=
X-Google-Smtp-Source: APXvYqy+cbTY0Q6JBerzREdEGLEN3f86F65GORk03GMDQsayFdLYQinBFacdkOmA5/tQs1BY+5oL9g==
X-Received: by 2002:a17:90a:23a3:: with SMTP id g32mr952116pje.134.1579954506543;
        Sat, 25 Jan 2020 04:15:06 -0800 (PST)
Received: from google.com ([123.201.163.7])
        by smtp.gmail.com with ESMTPSA id f81sm9369124pfa.118.2020.01.25.04.15.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 04:15:05 -0800 (PST)
Date:   Sat, 25 Jan 2020 17:44:59 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     vireshk@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: bootrom: fix uninitialized variables
Message-ID: <20200125121459.GA2792@google.com>
References: <20200125084403.GA3386@google.com>
 <20200125100011.GK8375@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200125100011.GK8375@localhost>
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/20 11:00 +0100, Johan Hovold wrote:
>On Sat, Jan 25, 2020 at 02:14:03PM +0530, Saurav Girepunje wrote:
>> fix uninitialized variables issue found using static code analysis tool
>
>Which tool is that?
>
>> (error) Uninitialized variable: offset
>> (error) Uninitialized variable: size
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/greybus/bootrom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
>> index a8efb86..9eabeb3 100644
>> --- a/drivers/staging/greybus/bootrom.c
>> +++ b/drivers/staging/greybus/bootrom.c
>> @@ -245,7 +245,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>>   	struct gb_bootrom_get_firmware_request *firmware_request;
>>   	struct gb_bootrom_get_firmware_response *firmware_response;
>>   	struct device *dev = &op->connection->bundle->dev;
>> -	unsigned int offset, size;
>> +	unsigned int offset = 0, size = 0;
>>   	enum next_request_type next_request;
>>   	int ret = 0;
>
>I think this has come up in the past, and while the code in question is
>overly complicated and confuses static checkers as well as humans, it
>looks correct to me.
>
>Please make sure to verify the output of any tools before posting
>patches based on them.
>
>Johan
I used cppcheck tool .
