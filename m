Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92D8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEDB2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxnvebkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgAUMuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:50:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgAUMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579611014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u+aNCzOBVungikO7RcpOytmRG3Ie/4OtPBspKlfTPE=;
        b=UxnvebkQ1d4T2VGbir9rUxJIahsG/SEGMgNm6w2rZeC9jq9q0jkTSpFO4nICfDrG/6/zhf
        xzFJpLbmg958gnjAWxB0nfxAGHtIgWp4FSJSfqkzaF7KlIvnyV+NAX3MauD0YDXoSPST6P
        6V75BzbPzUdhh1+evR3O4qgFsWZDT4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-llc0_N6CObuBHsMi73hPTg-1; Tue, 21 Jan 2020 07:50:11 -0500
X-MC-Unique: llc0_N6CObuBHsMi73hPTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80CF100E2E6;
        Tue, 21 Jan 2020 12:50:10 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D09BC19757;
        Tue, 21 Jan 2020 12:50:08 +0000 (UTC)
Subject: Re: [PATCH] selftests: KVM: AMD Nested SVM test infrastructure
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200117173753.21434-1-eric.auger@redhat.com>
 <87pnfeflgb.fsf@vitty.brq.redhat.com>
 <a288001b-56a6-363b-18c0-18a1e1876ccc@redhat.com>
 <f156e2e0-6c75-30c2-c295-b87ee1b36600@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <06c0cb50-75f4-2c25-c064-37e0709575c4@redhat.com>
Date:   Tue, 21 Jan 2020 13:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f156e2e0-6c75-30c2-c295-b87ee1b36600@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly, Paolo,

On 1/21/20 1:17 PM, Paolo Bonzini wrote:
> On 21/01/20 12:12, Auger Eric wrote:
>>>> +
>>>> +static struct test tests[] = {
>>>> +	/* name, supported, custom setup, l2 code, exit code, custom check, finished */
>>>> +	{"vmmcall", NULL, NULL, l2_vmcall, SVM_EXIT_VMMCALL},
>>>> +	{"vmrun", NULL, NULL, l2_vmrun, SVM_EXIT_VMRUN},
>>>> +	{"CR3 read intercept", NULL, prepare_cr3_intercept, l2_cr3_read, SVM_EXIT_READ_CR3},
>>>> +};
>>> selftests are usualy not that well structured :-) E.g. we don't have
>>> sub-tests and a way to specify which one to run so there is a single
>>> flow when everything is being executed. I'd suggest to keep things as
>>> simple as possibe (especially in the basic 'svm' test).
>> In this case the differences between the tests is very tiny. One line on
>> L2 and one line on L1 to check the exit status. I wondered whether it
>> deserves to have separate test files for that. I did not intend to run
>> the subtests separately nor to add many more subtests but rather saw all
>> of them as a single basic test. More complex tests would be definitively
>> separate.
> 
> I would just leave this deeper kind of test to kvm-unit-tests and keep
> selftests for API tests.  So this would mean basically only keep (and
> inline) the vmmcall test.

OK this makes sense. I implemented those 3 basic tests as a proof of
concept but this definitively overlaps with kvm-unit-tests coverage. I
will focus on new tests and leverage the kselftest framework instead.

Thanks

Eric
> 
> Paolo
> 

