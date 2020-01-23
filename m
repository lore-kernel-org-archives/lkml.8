Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EF920661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQq4RbV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAWNqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:46:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24251 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726771AbgAWNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579787165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtZifEes/xPS0tX2V6FJysZYwcxBaACzo8UdIegQS8I=;
        b=SQq4RbV4hCSRrzwwgSrlWgldR15TSA0QknjEFZ3Lo8wC49yUPhfKEmRh41gA1ZSYJ+cIyN
        wYuH+ZiM34kIFvim7cVDGt6etQzPGf9TG2JXEQ+/aegtXU2LQcONndntfIOSDL/E1EKdpe
        KmV2yBpWuLQ6hJH6dF/Zz6DE0fFuURU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-_qRnomWSPO2bhjyDD_RAPQ-1; Thu, 23 Jan 2020 08:46:03 -0500
X-MC-Unique: _qRnomWSPO2bhjyDD_RAPQ-1
Received: by mail-wm1-f70.google.com with SMTP id s25so611256wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtZifEes/xPS0tX2V6FJysZYwcxBaACzo8UdIegQS8I=;
        b=GWOD6K45Yz2wqUggP2imufJrT5ICSABdloUMrtG6J9GAxjZi6w6F0nepzmO3sRLwuX
         M/GDNWZpr43brU4RlCBLyBDQK8ulnqo/V+v/GfeYGGZ5E+Ji7hi+IqAlgUJnv4Q5WZRS
         11z8IZjJBBZu94nRZjI4ZikZS4nG67GSlol+ScrwRd79dYgnLsMyerd7+GKbncoS2Qb9
         b8hTSkJ+LDEAQN8iyXsDOaI24oCKDpprrrJ2QApAyPvUKbW1Vz4/qC7bTNmLb8r4i1u+
         tcpykCq+db+nzbc/rSZ5oGg2u9dEEhvUkKprP9w5FUbqprYZNCtU7ZsTWs/+8718vkwQ
         085g==
X-Gm-Message-State: APjAAAWDjIdpw0vej5zFBN/VzIQBOW5f16YVJb/RJCjTa/nJlFSFBpFy
        8tZn9ckzpsiMDit52dZb3QXc2eKrJshuHbzl0pQLWr7lh/LoynxugW7O9aBq5bUVjhLQUaERxlU
        K7/KVT1MEcde3zV5Ynkz5WlF4
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr3280711wme.141.1579787162465;
        Thu, 23 Jan 2020 05:46:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwAtcy2+OVcrCE6/tOfXs/OQbjMwjI+6j59QafTu+Mi1s5U7hfolm3QkEabmC9Ir6oE+U5Etg==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr3280703wme.141.1579787162301;
        Thu, 23 Jan 2020 05:46:02 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id f12sm2527135wmj.10.2020.01.23.05.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:46:01 -0800 (PST)
Subject: Re: [RFC v5 47/57] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-48-jthierry@redhat.com>
 <20200121103005.GA11154@willie-the-truck>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <66b1746b-c77b-a4d3-846b-cecdc5a15357@redhat.com>
Date:   Thu, 23 Jan 2020 13:45:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121103005.GA11154@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 10:30 AM, Will Deacon wrote:
> On Thu, Jan 09, 2020 at 04:02:50PM +0000, Julien Thierry wrote:
>> From: Raphael Gault <raphael.gault@arm.com>
>>
>> Some functions don't have standard stack-frames but are intended
>> this way. In order for objtool to ignore those particular cases
>> we add a macro that enables us to annotate the cases we chose
>> to mark as particular.
>>
>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   include/linux/frame.h | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/frame.h b/include/linux/frame.h
>> index 02d3ca2d9598..1e35e58ab259 100644
>> --- a/include/linux/frame.h
>> +++ b/include/linux/frame.h
>> @@ -11,14 +11,31 @@
>>    *
>>    * For more information, see tools/objtool/Documentation/stack-validation.txt.
>>    */
>> +#ifndef __ASSEMBLY__
>>   #define STACK_FRAME_NON_STANDARD(func) \
>>   	static void __used __section(.discard.func_stack_frame_non_standard) \
>>   		*__func_stack_frame_non_standard_##func = func
>> +#else
>> +	/*
>> +	 * This macro is the arm64 assembler equivalent of the
>> +	 * macro STACK_FRAME_NON_STANDARD define at
>> +	 * ~/include/linux/frame.h
>> +	 */
>> +	.macro	asm_stack_frame_non_standard	func
>> +	.pushsection ".discard.func_stack_frame_non_standard"
>> +	.quad	\func
>> +	.popsection
>> +	.endm
>>
>> +#endif /* __ASSEMBLY__ */
>>   #else /* !CONFIG_STACK_VALIDATION */
>>
>> +#ifndef __ASSEMBLY__
>>   #define STACK_FRAME_NON_STANDARD(func)
>> -
>> +#else
>> +	.macro	asm_stack_frame_non_standard	func
>> +	.endm
>> +#endif /* __ASSEMBLY__ */
> 
> Hmm. Given that we're currently going through the exercise of converting
> a bunch of ENTRY/ENDPROC macros to use the new SYM_{CODE,FUNC}_{START,END}
> macros, I would much prefer for this to be a new flavour of those.
> 
> In fact, can you just use SYM_CODE_* for this?
> 

You mean to not introduce the STACK_FRAME_NON_STANDARD() macro and just 
mark the asm callable symbols that don't set up a stackframe as SYM_CODE_* ?

-- 
Julien Thierry

