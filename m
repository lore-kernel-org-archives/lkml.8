Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E967206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDuwFQky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGGJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:49:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgGGJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594115394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HE0YCKlLU9F99TG9T+Hhh+hBQwUhwm8N1RW6a+ShOK4=;
        b=ZDuwFQkysDQgBqEo+lepexzEwlhxXcQ/JwrNeF+H5YRLAlHdBMtcPQDB+uxm44Fd9nmKIB
        QX+WDEq8r+FzK2h1aZS5TN74ZUnU/LcLmY5BaDBJH/o+Vw5IL89Dctjlm4IkJ+H/x9ckYF
        MoeNeLt4FYlPhjzutbecAeQUt7gTNrk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-mO4XhNlbO8uVBB5TndDr2A-1; Tue, 07 Jul 2020 05:49:53 -0400
X-MC-Unique: mO4XhNlbO8uVBB5TndDr2A-1
Received: by mail-wr1-f70.google.com with SMTP id i12so47907068wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 02:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HE0YCKlLU9F99TG9T+Hhh+hBQwUhwm8N1RW6a+ShOK4=;
        b=bOxh5YZ1Au89fgKIL6VZfSoYq2mc1X4wyYwWvak3jLtzyDTxgaDIIT6RH6J7IRWW17
         GAPzs9bUNz9O+8fJ8xOWKfns5rvOFjRxerZoJnBLjF31Cvo28WDvR3tJSctLM9YqpAL6
         OElnNU1P38y42OGTgeCYNVbTgOnGm3MvPp6BwUu/30hTfxmkWN1rycGrAZOBdp+MwUj5
         qlPQPany6Bu+PwSq5T/KVxqvbGPqpn3ee42KcmH/vTvs7jLBTqLYwAxZFSdS+1x9TO+g
         xYpngpt0870HLuppeHakQufXaEmqyu/13WeZ8XLtsEyflys+h7x5zb3lPmdRZTeNOlt/
         +G0w==
X-Gm-Message-State: AOAM5322KGFKD5+Hjw8xG7piRYYBAPe48dA8Z7keV1FqQ+8DRg5TaX3h
        cJQY6aoYRCkonx8TBkOTyi/yFogR6qqC+6aky7mSBWbcy5Z0S4AS8J4UqR5+SbBdKkreKctF1Tf
        E64aM5mMufL86jSRwZsfMoAa4
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr56651325wrn.179.1594115391985;
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx833zL/K0cNEjUfxy2wssoAehJsLXM23AeWFK29RZHs/YmUnXxRgtM3f+w/l4wfBu5MefiCw==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr56651300wrn.179.1594115391755;
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id 1sm354662wmf.21.2020.07.07.02.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
 <20200623204441.phngiwlj2idonpe6@wittgenstein>
 <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
 <f0b60da1-ce3f-da53-9ffc-94fea233181a@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e98d690-2202-4183-5b49-942f29b0a955@redhat.com>
Date:   Tue, 7 Jul 2020 11:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f0b60da1-ce3f-da53-9ffc-94fea233181a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/20 22:55, Shuah Khan wrote:
> On 6/24/20 12:21 AM, Paolo Bonzini wrote:
>> On 23/06/20 22:44, Christian Brauner wrote:
>>>>       ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>>>>       if (ret < 0) {
>>>> -        if (errno == ENOSYS)
>>>> -            ksft_exit_skip(
>>>> +        if (errno == ENOSYS) {
>>>> +            ksft_test_result_skip(
>>>>                   "%s test: pidfd_send_signal() syscall not
>>>> supported\n",
>>>>                   test_name);
>>> If pidfd_send_signal() is not supported, you're falling through and then
>>> you're reporting:
>>>
>>> ok 5 # SKIP pidfd_send_signal check for support test:
>>> pidfd_send_signal() syscall not supported
>>> ok 6 pidfd_send_signal check for support test: pidfd_send_signal()
>>> syscall is supported. Tests can be executed
>>
>> You're right, this needs a "return".
>>
> 
> Hi Paulo,
> 
> I am applying the rest of the patches in this series except this one.
> Please send v3 for this.

Thanks, I was actually going to send everything but you're making it
even simpler.  I'll send v3 of this patch only.

Paolo

