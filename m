Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73341C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFE206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEVfaAhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbgDCIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:12:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbgDCIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585901520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PHaNpy+983QDwfaUcTgQtvDFchwmBDQqNsuXGeebd8=;
        b=UEVfaAhqFvAduemYCfJ1yUlJhGUa/UpvV/1o/cb3lElR8Rd9aL82SzguQGggj79rLrpBaq
        qygMxalPuRY12qodDoTrnAaPnZMsk9wwYwf0gsKtGi/8ISzFxBQti/0Uldv6dSUiuqHa+z
        I9bXOza5fJMfWsOIOdN2qzpqQONvZa8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498--aXC1AWENeaU6P-ES7T-Kw-1; Fri, 03 Apr 2020 04:11:59 -0400
X-MC-Unique: -aXC1AWENeaU6P-ES7T-Kw-1
Received: by mail-wm1-f70.google.com with SMTP id f128so1134174wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PHaNpy+983QDwfaUcTgQtvDFchwmBDQqNsuXGeebd8=;
        b=RlQs3w26oVG6Zb9Ty/9TLCkQgWnyrdJzPWgtFwGt0QursuWgCVtnN2AA6MIaN4n/8d
         qNR731+QGns79tLRfxTiDoGYXVRYZWs4dO0Sv5KPMgIM6xiiRbU6N0sU6dm1CdHqpE1J
         mkmiWd9GWM6KQ/oB3HXeDzwoqobhNQzMy/DBK2EgYngKAXVHr24ThXia5oGiv42tR5qR
         lRbddfWy0l+hHeUZufSAmr7pyBsqtqa+umyTOa+vs6Gvj+Hy2jpUFFDKI0KXv/5mR5yJ
         P4eTAmlpCqTpaOUVtJeh0IIRDO+VplcLFdTunlf0ANXt4t52PFyUcospcBtnRNGvTMxZ
         CzHQ==
X-Gm-Message-State: AGi0Pua7FRB+XoxrH0lHD1+dEV5FDiuEP45Aqd4DDLvuagmCPPr6ytjH
        9tpT2yQXXEhlVwMLVWw72Z+NN+4PXal7Doe9uW1xmyfwoWTjHUO8yiPKq1A9IcgnBxqncA6/1pN
        sIKlcPOrVMb+CoeVdrH0kEDYJ
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr7421838wma.35.1585901518312;
        Fri, 03 Apr 2020 01:11:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLS2c3t7i5T//sRgt+XOqdSZOMSgeSIcbtsg6NJaDUMR/JgDrbvYFytbDZ80B91oF0tToS3Gw==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr7421765wma.35.1585901517379;
        Fri, 03 Apr 2020 01:11:57 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id a12sm9146807wmj.22.2020.04.03.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:11:56 -0700 (PDT)
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
Date:   Fri, 3 Apr 2020 09:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402154022.GG20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 4:40 PM, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 04:31:05PM +0100, Julien Thierry wrote:
>> My understanding is that once you find an intra-function call, either you
>> hit a return, ending the branch, so the return should undo the modification
>> the intra-function call did (whether is it a retpoline return or not).
>> Otherwise, the intra-function call branch will need to reach an end in some
>> way (e.g. hitting a CONTEXT_SWITCH instruction, calling a
>> dead_end_function).
>>
>> Am I missing something?
> 
> The thing is basically doing:
> 
> 	mov  $n, cx
> 1:	call 2f
> 2:	dec  cx
> 	jnz  1b
> 	add  8*n, sp
> 
> So it does N calls to self, then subtracts N words from the stack.
> 
> The reason being that the CPU has a return-stack-buffer for predicting
> returns, and call/ret being naturally paired, that works. The above
> is a software flush of the RSB.
> 

Ah, lovely... Maybe that's where SAVE/RESTORE unwind hints could be nice 
;) .

Otherwise, I don't really have a good suggestion for this...

-- 
Julien Thierry

