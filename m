Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CCD2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh3+ownS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAWLps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728811AbgAWLps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579779947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snyDmTf7CBCw1wnH6HPrXaSpHlhW2BCaG6gTHi350h0=;
        b=Nh3+ownS9nOpT0YSJcJNbmSRXFyz1MIcYR7rkPNLwRJSQqtoLi1yESCCsp1P9XY3ELuW4W
        erc6LO8eWgkVrE634dtJ/cBuVhfU/jCQBaQBlkvgCBczVnY/PWHZ3Ubd2tSSNB0FZT4I34
        AmCUB6uiFDtgkGxcg0E1Pkw5sTE1AvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-7MMngTKEOPGTrdxofsnv9A-1; Thu, 23 Jan 2020 06:45:45 -0500
X-MC-Unique: 7MMngTKEOPGTrdxofsnv9A-1
Received: by mail-wm1-f69.google.com with SMTP id q26so471270wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snyDmTf7CBCw1wnH6HPrXaSpHlhW2BCaG6gTHi350h0=;
        b=AkI+6yRFPmdLNGz5Q9b/3Titx7wkK2I/nI8KMdLXcRuWU4UmJXckGJ2XlKFgdzifEo
         8IWHP+BGzpOKpkaFb79qZNCGTtY9xG2uaB8tio0l1pfabFiCQGbEeuU7sANV5jW6iWvT
         TPmmWWZTI3k8wlqA/fdIe+pX8IiPgDEmAEzJhCdxFTXxYDYI3yylQLs8UMzM3zNihojg
         Lj00hl6Hqvy62TpDy1KOQrwXDDI1pWjq4oFb4SaCx/SWNEg16JoFOzxVYWoEB+1OfGrG
         8+s27C4oSIiewRtQFNt/In9BDU8V86XZqTnm6Oe7mXScFHWplawYW6HQT7XeqY4X3+uo
         Ug5w==
X-Gm-Message-State: APjAAAXllM1G4MIsh5aB+cyPDAUM3QeyXBRLGcdkYQ5NqObTSflJ5DXO
        TNiffugGI2piqRjzNNdcZlukmGHPJbsl6YrNfsWQ0nLMjRzPCsQincb1GHpdHJd/RCyQYo7AmdF
        CGtE88dv9MzblMBBpirpKhGeB
X-Received: by 2002:a05:600c:48a:: with SMTP id d10mr3806696wme.87.1579779944252;
        Thu, 23 Jan 2020 03:45:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwo5inKTgvBc+mV0kyUUFtWKnKpn/c8kgV9a7x3qOk7KCsOT9oh7insLR6xbWgPYU9HP5HyOQ==
X-Received: by 2002:a05:600c:48a:: with SMTP id d10mr3806671wme.87.1579779944005;
        Thu, 23 Jan 2020 03:45:44 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id u18sm2739453wrt.26.2020.01.23.03.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 03:45:43 -0800 (PST)
Subject: Re: [RFC v5 04/57] objtool: check: Ignore empty alternative groups
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-5-jthierry@redhat.com>
 <20200121163011.tk5koyg24gzuhoaa@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <35333a67-cf5b-450f-0f9b-c75ae1f9be8b@redhat.com>
Date:   Thu, 23 Jan 2020 11:45:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121163011.tk5koyg24gzuhoaa@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 4:30 PM, Josh Poimboeuf wrote:
> On Thu, Jan 09, 2020 at 04:02:07PM +0000, Julien Thierry wrote:
>> Atlernative section can contain entries for alternatives with no
>> instructions. Objtool will currently crash when handling such an entry.
>>
>> Just skip that entry, but still give a warning to discourage useless
>> entries.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/check.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 5968e6f08891..27e5380e0e0b 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -866,6 +866,13 @@ static int add_special_section_alts(struct objtool_file *file)
>>   		}
>>   
>>   		if (special_alt->group) {
>> +			if (!special_alt->orig_len) {
>> +				WARN("empty alternative entry at %s+0x%lx",
>> +				     orig_insn->sec->name,
>> +				     orig_insn->offset);
>> +				continue;
>> +			}
>> +
> 
> I think WARN_FUNC() can be used here instead.
> 

I'll do that.

Thanks,

-- 
Julien Thierry

