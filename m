Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C302F2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/h8RsFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgFPMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:08:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgFPMI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592309336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqZs+hqanGL9wIjAP1yJ+a+U37tmuYG6HORjMjf4l70=;
        b=I/h8RsFf5tArTGvUegJAYlT8jtyLXxGPRC1CZ+tMhnmiKuA9SSXE5Fs5Z7M8g7aKy4Xouv
        D6lp8F+fdoTtCRC0AsUrMbz1xGIlJA1y4tg2rdQKWwGUjL5PyEx0ydXriLn3HBGgYPgmKS
        Oy/KS6gJ5xBFuR2R3LCxVhtkA2POPss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-FVYnsTIePfeoGLtjLkklHw-1; Tue, 16 Jun 2020 08:08:53 -0400
X-MC-Unique: FVYnsTIePfeoGLtjLkklHw-1
Received: by mail-wm1-f70.google.com with SMTP id u15so865424wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqZs+hqanGL9wIjAP1yJ+a+U37tmuYG6HORjMjf4l70=;
        b=fzCKSyFqB2AzN1Z3+bmUjIRWVYXtagNKQKERtu/QBI+nCFrtqibkbM56YHRRHg7IN8
         l5e8Oq6fdR4Rdu3IvdoSdPUPAa4b/rMUHnLZqLWQ+TPperwrYOGQWvlzcSCNIZgk4JNr
         uaJwL4HEqRQJljp3uQv6PlMMbE9K79t4qrM62X26y5eWdArL9nheivT7y4Zm1dBhfkuk
         T8vamkvY+h4ksmxbq2LKKTot0pk1zvHSgOI+T0TRmZGvbNJTQWt02STLt7vUUPcUaGqo
         pHae5TJhJ1+PDdgA3M8gf+83tzsGn/SKJ3rGnIosdRuXFG/iS3uOi/27rz9OVbx7ojLp
         2o8w==
X-Gm-Message-State: AOAM5304sHMx0eX5T6bzAU7vCKeQ92OfxO8r1W3LJiS67y8xFmtQcmoh
        7yUmkxAz2BeUeAmbug6d2iLsp3Aai0zOHzrvCpNsr00E0DXnwxsKojhajXbFCz2Jsw1NPZmvRT8
        Ctkd5lV6FuyUiZrqhWOStgMSO
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2896939wmb.90.1592309331968;
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCcM0xA8rD4IpmIFhk1JYlN8RaP69+JBsyEA1C5OCkZnr0VhIH2DGhRBeLEKEWZqRRDvjmWQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2896914wmb.90.1592309331627;
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.88.161])
        by smtp.gmail.com with ESMTPSA id z12sm31645155wrg.9.2020.06.16.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
Date:   Tue, 16 Jun 2020 14:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/20 21:07, Bird, Tim wrote:
>> Note: making the plan line required differs from TAP13 and TAP14. I
>> think it's the right choice, but we should be clear.

As an aside, where is TAP14?

> With regards to making it optional or not, I don't have a strong
> preference.  The extra info seems helpful in some circumstances.
> I don't know if it's too onerous to make it a requirement or not.
> I'd prefer if it was always there (either at the beginning or the end),
> but if there is some situation where it's quite difficult to calculate,
> then it would be best not to mandate it. I can't think of any impossible
> situations at the moment.

I think making the plan mandatory is a good idea.  "Late plans" work
very well for cases where you cannot know in advance the number of tests
(for example in filters that produce TAP from other output), and provide
an additional safety net.

>> "Bail out!" to be moved to "optional" elements, since it may not appear.
>> And we should clarify TAP13 and TAP14's language to say it should only
>> appear when the test is aborting without running later tests -- for this
>> reason, I think the optional "description" following "Bail out!" should
>> be made required. I.e. it must be: "Bail out! $reason"
> 
> I'll make sure this is listed as optional.
> I like adding a mandatory reason.

+1.

>> TAP13/14 makes description optional, are we making it required (I think
>> we should). There seems to be a TAP13/14 "convention" of starting
>> <description> with "- ", which I'm on the fence about it. It does make
>> parsing maybe a little easier.
> 
> I would like the description to be required.
> I don't have a strong opinion on the dash.  I'm OK with either one (dash
> or no dash), but we should make kselftest and KUnit consistent.

I think no mandatory dash is better (or even mandatory no-dash!).  We
can suggest removing it when formatting TAP output.

>>> Finally, it is possible to use a test directive to indicate another
>>> possible outcome for a test: that it was skipped.  To report that
>>> a test case was skipped, the result line should start with the
>>> result "not ok", and the directive "# SKIP" should be placed after
>>> the test description. (Note that this deviates from the TAP13
>>> specification).

How so?  The description comes first, but there can be a description of
the directive.

     not ok 4 - Summarized correctly # TODO Not written yet

>>> It is usually helpful if a diagnostic message is emitted to explain
>>> the reasons for the skip.  If the message is a single line and is
>>> short, the diagnostic message may be placed after the '# SKIP'
>>> directive on the same line as the test result.  However, if it is
>>> not on the test result line, it should precede the test line (see
>>> diagnostic data, next).
>>>
>>> Bail out!
>>> ---------
>>> If a line in the test output starts with 'Bail out!', it indicates
>>> that the test was aborted for some reason.  It indicates that
>>> the test is unable to proceed, and no additional tests will be
>>> performed.
>>>
>>> This can be used at the very beginning of a test, or anywhere in the
>>> middle of the test, to indicate that the test can not continue.
>>
>> I think the required syntax should be:
>>
>> Bail out! <reason>
>>
>> And to make it clear that this is optionally used to indicate an early
>> abort. (Though with a leading plan line, a parser should be able to
>> determine this on its own.)

True.  However, "Bail out!" allow to distinguish issues with the harness
(such as ENOSPC) from test aborts.

>>>  - TODO directive
>>
>> Agreed: SKIP should cover everything TODO does.

XFAIL/XPASS are different from SKIP.  I personally don't have a need for
them, but kselftests includes XFAIL/XPASS exit codes and they aren't
reflected into selftests/kselftest/runner.sh.

Likewise, kselftest.h has ksft_inc_xfail_cnt but not
ksft_test_result_xfail/ksft_test_result_xpass.

It's important to notice in the spec that the TODO directive inverts the
direction of ok/not-ok (i.e. XFAIL, the "good" result, is represented by
"not ok # TODO").

>>>  - test identifier
>>>     - multiple parts, separated by ':'
>>
>> This is interesting... is the goal to be able to report test status over
>> time by name?

What about "/" instead?

>>> Finally,
>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
>>> See https://testanything.org/tap-version-13-specification.html
>>
>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
>> should be "ok"? I guess we should change it to "ok".

See above for XFAIL.

I initially raised the issue with "SKIP" because I have a lot of tests
that depend on hardware availability---for example, a test that does not
run on some processor kinds (e.g. on AMD, or old Intel)---and for those
SKIP should be considered a success.

Paolo

> I have the same initial impression.  In my mind, a skip is "not ok", since
> the test didn't run. However, a SKIP and should be treated differently
> from either "ok" or "not ok" by the results interpreter, so I don't think it
> matters.  Originally I was averse to changing the SKIP result to "ok"
> (as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial to
> change the parser in Fuego, and it would make the kernel results format
> match the TAP13 spec.  I don't see a strong reason for us to be different
> from TAP13 here.
> 
> I raised this issue on our automated testing conference call last week
> (which includes people from the CKI, Fuego, KernelCI and LKFT projects), and
> so people should be chiming in if their parser will have a problem with this change.)
> 
> [1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.com/T/
> 
> Thanks very much for the feedback.
>  -- Tim
> 

