Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED4C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851A820735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BsqWiVno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbgCLCs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:48:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37605 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbgCLCs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:48:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id 6so5459662wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QLA/ZeP5E+/XKg+thdAk/GAfXLemsbPUzfmLzefR4iU=;
        b=BsqWiVnoFjNmsxzp4AMqJLWxCydHypxZEk71wcYFG27kREUTPwDKA+TuKbuksONw83
         7BIxQtqhyuhbbvnWcUlW2QTX6z0kA8Uuj3OdRXcEgiZjqcCphd2yCSuKLAe7oRpWri16
         ueq6XSYxnckqKM1gfXhDBXGP/9INNfN7En+dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QLA/ZeP5E+/XKg+thdAk/GAfXLemsbPUzfmLzefR4iU=;
        b=KWB0J6hTkaWEs4DAoXFaRdDm0hAFz63lxCuFFAEz85YIW2bX3GpIqG7Q02b+MyGycx
         uCBY4JrSSKqcAK7zEMW8t+LgolzqYYdxUpDzU/o1/HXaXUdAc7FS4Srvxs0YKPI/hFSB
         2tjDaBxsRu3syLmAV5ftslH7U0BAsafd7/BIOnzlvPEuTQ0FlIbpehbGP9/rQC9gtsTl
         u2uORBOEIJhxNqUN/kiu4b3Lwc74t9J28A0eb2otdctV7pooq4Mr134iKkvf3IlnzISG
         gXOx9Mwu0UqIFRTfqEGdIkUTQTSnd4NH4KzGaRe8lxg9ioqeAVHU15s86goXhv0rtZTI
         ga/A==
X-Gm-Message-State: ANhLgQ23T8Ieu9pVf94XcWc/BNtj3xQjxbgXKcTOj7g+RrbWzhibKAQT
        q6dKzLf0cFzDQeYHWMDyQXsoGQ==
X-Google-Smtp-Source: ADFU+vtOfWTBwVMeozjXM01zS5SS3/RA91m9EmLIxJQG8dUujJybcBR1lLn/EeOLLDsnZPgFqeoAYw==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr7667756wra.126.1583981336263;
        Wed, 11 Mar 2020 19:48:56 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 9sm10759451wmx.32.2020.03.11.19.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 19:48:55 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: always allow C99 SPDX License Identifer
 comments
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200311191128.7896-1-scott.branden@broadcom.com>
 <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
Date:   Wed, 11 Mar 2020 19:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2020-03-11 7:26 p.m., Joe Perches wrote:
> On Wed, 2020-03-11 at 12:11 -0700, Scott Branden wrote:
>> Always allow C99 comment styles if SPDK-License-Identifier is in comment
>> even if C99_COMMENT_TOLERANCE is specified in the --ignore options.
> Why is this useful?
This is useful because if you run checkpatch with 
--ignore=C99_COMMENT_TOLERANCE
right now it will warn on almost every .c file in the linux kernel due 
to the decision to
use // SPDX-License-Identifier: at the start of every c file

With this change checkpatch will stop complaining about this single 
outlier // in the file
and allow you to enforce no other C99 // style comments in the patch.

It would have been a lot nicer if /* SPDX-License-Identifier: xxxx */ 
was used instead...
>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   scripts/checkpatch.pl | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index a63380c6b0d2..c8b429dd6b51 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -3852,8 +3852,8 @@ sub process {
>>   			}
>>   		}
>>   
>> -# no C99 // comments
>> -		if ($line =~ m{//}) {
>> +# no C99 // comments except for SPDX-License-Identifier
>> +		if ($line =~ m{//} && $rawline !~ /SPDX-License-Identifier:/) {
>>   			if (ERROR("C99_COMMENTS",
>>   				  "do not use C99 // comments\n" . $herecurr) &&
>>   			    $fix) {

