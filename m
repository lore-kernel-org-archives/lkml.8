Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0209C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEB1206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR1/fCpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbgDAOGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:06:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732898AbgDAOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585750012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpDftVRVsGGUYl9fXy8EOB+/FpsCFiSKXh5Wh7fX94g=;
        b=iR1/fCpwttT6Hi8teRvI5O9u+zOFGStCAK4dIrwb2iAKWxF8VwPCLryl/Nfc2+oe5sikGm
        bVpsuEBRAWIvOxnaKHWl/zF3BLKPn/Jd6IRLJU5FagvZYIgMw8uXm5hercFFJG0plKv4BE
        kuUhSIyUnKVkCf367FliGtrSF7Pr4iw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-2EQC0rPkO6yy7kwBSOBKCg-1; Wed, 01 Apr 2020 10:06:50 -0400
X-MC-Unique: 2EQC0rPkO6yy7kwBSOBKCg-1
Received: by mail-wm1-f69.google.com with SMTP id 2so25562wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpDftVRVsGGUYl9fXy8EOB+/FpsCFiSKXh5Wh7fX94g=;
        b=TWe2QU2GWWgwsqkG2GMerDXYfziaCDhPbmniQVsFw07Ah5YVedbvs5kd54+U0MuphP
         u5jjzEU0skTAgqHuvdhB5iGFnXTq9jEsx+41R9sOfakPH/OEhj07mJlY26iUgTIyY/LS
         UQLrXdntESTBS6tH5VJTPXWNywB8ZMAG5M3euC6QaY2cEHYB+iZ4HByNVDBAhU2qM8KW
         Oc+pLG8hEejtmxvWwiEwXyuzKEyRjBUqTLX4na6F0USYtkcmApc68aCPrMzRHZZJaIlr
         JKzhiHFcR7Lkb5f0hK446YOPKfEkvRj+oN+i+23wQVp1PTAR3nZD3YWbdU+gmnIi3V0K
         vILw==
X-Gm-Message-State: ANhLgQ3trcCeGJPqrXCe0OM/6PNT4N9Sk+VXi1H+U8vtZcvpiniLB4pb
        xHddBAl5Hqk+wC2LTfaX67WUv9KAHRlKE/m9WCeBSTBvLz9RCsXhEoZ19AZdONKyWqQxK0uhRm8
        81AlJ78IROMxGKAusymr4BheU
X-Received: by 2002:a5d:6992:: with SMTP id g18mr26899554wru.426.1585750008964;
        Wed, 01 Apr 2020 07:06:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsjBwSRReUw9nlfUA/cbN/E7YYFnOQ2SGW4Vq3qD2yMpVCoiQpCidE3e02w85Idf+ulovzR9A==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr26899542wru.426.1585750008806;
        Wed, 01 Apr 2020 07:06:48 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id r17sm3053067wrx.46.2020.04.01.07.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:06:47 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] objtool: check: Allow save/restore hint in non
 standard function symbols
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-8-jthierry@redhat.com>
 <alpine.LSU.2.21.2004011552290.15809@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <b5c6d9a6-02ce-dce3-952b-4d044cb63b7f@redhat.com>
Date:   Wed, 1 Apr 2020 15:06:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2004011552290.15809@pobox.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 2:54 PM, Miroslav Benes wrote:
> On Fri, 27 Mar 2020, Julien Thierry wrote:
> 
>> The kernel code base provides CODE_SYM_START/END to declare assembly
>> code sequences that don't follow function standard calling conventions.
>>
>> As non-C/non-standard code, these sequences can very much benefit from
>> unwind hints. However, when a restore unwind_hint is used in a
>> non-function code sequence, objtool will crash when looking for the
>> corresponding save hint.
>>
>> Record the code symbol an instruction belongs to and look for save hints
>> belonging to the same code symbol as the restore hint.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> 
> Looks ok, but save/restore hints are about to go away. See
> https://lore.kernel.org/lkml/20200331222703.GH2452@worktop.programming.kicks-ass.net/
> 

Ah, just as I started bringing unwind hints to the arm64 side...

I'll have to scratch my head a bit more over this then. Thanks for 
bringing it to my attention.

Thanks,

-- 
Julien Thierry

