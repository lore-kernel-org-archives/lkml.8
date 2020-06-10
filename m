Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E752C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303F720656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMnP6Aek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgFJSW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:22:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgFJSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591813376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSjai+DFDzFrxMEYWRAg/j6/ardpz/bet/R5ZQH8NOQ=;
        b=LMnP6Aekzfxar0qSobyAcOZT/WPLopkEOC6fUfW/1rL92SbEnO3yx6RRe+dcZtkUTmK+kb
        EVi2hGYlINAK8o+xPxKf4Rdbt3pXTE5aYoQRS/hp4euEAq9q6o31A7bepNydY7SHxi37Vh
        3Go4NYByod4zpmyhin9E/U/UMSN0YyQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-B8iv--w7N9-1-nzHXiHxmA-1; Wed, 10 Jun 2020 14:22:55 -0400
X-MC-Unique: B8iv--w7N9-1-nzHXiHxmA-1
Received: by mail-wr1-f71.google.com with SMTP id s7so1427528wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSjai+DFDzFrxMEYWRAg/j6/ardpz/bet/R5ZQH8NOQ=;
        b=NCRc6eUmnabZMblYpyu85dL4aiTN1mAs0VfzguuyqhUAGJmrsYXbyMCkdWhFg7Rt3v
         2GL/9/tkXqcxCqXrSLedtlqgUNZMnmF8lHdEDjGO5gCLmi/ihC4u46W6CxtixvKGBMMV
         BmkXS3nHhS3tZqw1xMwIZCbOwK6IDfnfGCItn4s6Det5o2PnMPaa1FXobrl6LSGw5wMs
         z66bD3IvDY1o9WBaAETFRJz8jpdP/IjqDutPIVP/VqDOLEh+JlHKwEz5Y+BnLHAQq2kM
         4g5tw9S3cfXMCriF+L6ajZwzcb5XclFUo5/QgQufdHUxubbVuwTWrTa9iQUp9G1EfNNH
         yglQ==
X-Gm-Message-State: AOAM532Z/ZBc6tPqPBc52oHfiFuRzFiJLu2DvQGMub8zZsmERBspwKPj
        7cAeEDulZsgN8DLp7u1VyDAz1PreDVdGN289Q91u8V+TPpZbfdfqsF4hjmxy/peIbDQXODQJJyW
        bHPusnDkOibFM2HJBYURKDcyh
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5459681wru.118.1591813373334;
        Wed, 10 Jun 2020 11:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL+HRgXUT5dVlw53IXZIty7joPl0qkXidchmFCFVFqHTrz1BuekJ/juSrrBdN78oDX42KGJw==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5459653wru.118.1591813373088;
        Wed, 10 Jun 2020 11:22:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b5a1:606f:4d92:f4e1? ([2001:b07:6468:f312:b5a1:606f:4d92:f4e1])
        by smtp.gmail.com with ESMTPSA id n23sm593760wmc.21.2020.06.10.11.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:22:52 -0700 (PDT)
Subject: Re: [PATCH] kselftest: runner: fix TAP output for skipped tests
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20200610154447.15826-1-pbonzini@redhat.com>
 <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
 <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6461f067-0fea-4419-dd56-2661c44a803a@redhat.com>
Date:   Wed, 10 Jun 2020 20:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 19:43, Bird, Tim wrote:
>>>   		(rc=$?;	\
>>>   		if [ $rc -eq $skip_rc ]; then	\
>>> -			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>>> +			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> 
> This is a pretty big change, and might break upstream CIs that have come to
> rely on kselftest's existing behavior.  I know it's going to break Fuego's parsing
> of results.

Do you have a pointer to this code?

> kselftest has a few conventions that are different from the TAP spec, 
> and a few items it does that are extensions to the TAP spec.

Yes, there are extensions to directives are not a problem and parsers
might raise an error on them.  That can be an issue, but it's a separate
one (and it's easier to ignore it as long as test pass...).

> IMHO, the TAP spec got this one wrong, but I could be convinced
> otherwise.

Here the TAP spec says that a skip starts with "ok" and has a "SKIP"
directive, and anyone can parse it to treat as it as a failure if
desirable.  But doing something else should be treated simply as a
violation of the spec, it's not a matter of "right" or "wrong".

So, if you want to use "not ok ... # SKIP", don't call it TAP.

However, I noticed now that there is another instance of "not ok.*SKIP"
in testing/selftests/kselftest.h (and also one in a comment).  So they
should all be fixed at the same time, and I'm okay with holding this patch.

Paolo

> But I think we should discuss this among CI users of
> kselftest before making the change.
> 
> I started work quite a while ago on an effort to document the
> conventions used by kselftest (particularly where it deviates
> from the TAP spec),  but never submitted it.
> 
> I'm going to submit what I've got as an RFC now, for discussion,
> even though it's not finished.  I'll do that in a separate thread.
> 
> 
>>>   		elif [ $rc -eq $timeout_rc ]; then \
>>>   			echo "#"
>>>   			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>>>
>>
>> Thanks. I will pull this in for Linux 5.8-rc2
> Shuah - can you hold off on this until we discuss it?
> 
> Thanks,
>  -- Tim
> 

