Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834C8C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB82070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaZeYggw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgAYJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:37:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgAYJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579945064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WE2fbQswzs+SJz5n1omfDubg+SoDSvUx44H2FyK3h4=;
        b=eaZeYggwS/8bHHwpjf8nMVpMyfyzEpj637FO7QYtBgMyYcXpRpET31enMVexkqoy3itMw3
        LWhEVMNDgjJxbAzLaJ4AtApvcqnTPAJbyNqKHf91xyTiOz3GgwStXT49vXsvRZMAYHHNAk
        8n6V1Add49aU8QsQa60wNywZgtMkD2c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-qvSXo_EyOB2rbprq75Qocw-1; Sat, 25 Jan 2020 04:37:40 -0500
X-MC-Unique: qvSXo_EyOB2rbprq75Qocw-1
Received: by mail-wr1-f70.google.com with SMTP id b13so2722038wrx.22
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 01:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WE2fbQswzs+SJz5n1omfDubg+SoDSvUx44H2FyK3h4=;
        b=F5DAtfjpFrpCtsb4lDFrYS2hxN4LZZETmVeDMV+iniNEFs0orfdC7SsTZun4NpUcw4
         HX6t/DJ9XhTyRuX9YoFA0I+spi3RcbF0l0O84HQ2oL1Stp00AttaSrFjCKiJBhgeTB2u
         C44+lf0zOi2IcRo5uE5FQvPJRbr7tbOs0g0BCafQw1/CF8FRE8/Rb0Jrr6GggH/vYMa3
         bFPOfH03BdZI2/PV6iYx2sryWIXaKzNhRdm9ZyCgvZye1rxR6XEbdf2gRn1dchI+82uu
         bhGOydxQBGIxWv8baVRqbrFptQ5IV+iqp47JQhyYWSQi6rUtwO93L/ZKmbuqs/RKkNUc
         eVNg==
X-Gm-Message-State: APjAAAUUBBKprM6sEmdcvXNqBxAzRBnSJ+BN9P04yM28ZOB5Zwajbyss
        JaQwvo8MqJZ5dAbe5M41mWaF9IDMltTtU8MJY/T4TVXm3ZKNORxG2su9/5x/H8xdM5JRUOs64Ae
        fGkoR0M41Cmi59KfvnhNTxkDE
X-Received: by 2002:adf:fc03:: with SMTP id i3mr9643030wrr.306.1579945059518;
        Sat, 25 Jan 2020 01:37:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzADoueJweyRIZiSjc1N6dPo0jQ7I4gMZv5B4n3ZCIMUKiG1FLlWJFwmcqNLCFzWRZfPX0SfA==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr9643007wrr.306.1579945059285;
        Sat, 25 Jan 2020 01:37:39 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o1sm10988700wrn.84.2020.01.25.01.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:37:38 -0800 (PST)
Subject: Re: [PATCH v4 09/10] KVM: selftests: Stop memslot creation in KVM
 internal memslot region
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-10-bgardon@google.com>
 <92042648-e43a-d996-dc38-aded106b976b@redhat.com>
 <CANgfPd8jpUykwrOnToXx+zhJOJvnWvxhZPSKhAwST=wwYdtA3A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6812a36c-7de6-c0c9-a2f3-5f9e02db6621@redhat.com>
Date:   Sat, 25 Jan 2020 10:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd8jpUykwrOnToXx+zhJOJvnWvxhZPSKhAwST=wwYdtA3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/20 19:41, Ben Gardon wrote:
> On Fri, Jan 24, 2020 at 12:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 23/01/20 19:04, Ben Gardon wrote:
>>> KVM creates internal memslots covering the region between 3G and 4G in
>>> the guest physical address space, when the first vCPU is created.
>>> Mapping this region before creation of the first vCPU causes vCPU
>>> creation to fail. Prohibit tests from creating such a memslot and fail
>>> with a helpful warning when they try to.
>>>
>>> Signed-off-by: Ben Gardon <bgardon@google.com>
>>> ---
>>
>> The internal memslots are much higher than this (0xfffbc000 and
>> 0xfee00000).  I'm changing the patch to block 0xfe0000000 and above,
>> otherwise it breaks vmx_dirty_log_test.
> 
> Perhaps we're working in different units, but I believe paddrs
> 0xfffbc000 and 0xfee00000 are between 3GiB and 4GiB.
> "Proof by Python":

I invoke the "not a native speaker" card.  Rephrasing: there is a large
part at the beginning of the area between 3GiB and 4GiB that isn't used
by internal memslot (but is used by vmx_dirty_log_test).

Though I have no excuse for the extra zero, the range to block is
0xfe000000 to 0x100000000.

Paolo

>>>> B=1
>>>> KB=1024*B
>>>> MB=1024*KB
>>>> GB=1024*MB
>>>> hex(3*GB)
> '0xc0000000'
>>>> hex(4*GB)
> '0x100000000'
>>>> 3*GB == 3<<30
> True
>>>> 0xfffbc000 > 3*GB
> True
>>>> 0xfffbc000 < 4*GB
> True
>>>> 0xfee00000 > 3*GB
> True
>>>> 0xfee00000 < 4*GB
> True
> 
> Am I missing something?
> 
> I don't think blocking 0xfe0000000 and above is useful, as there's
> nothing mapped in that region and AFAIK it's perfectly valid to create
> memslots there.
> 
> 
>>
>> Paolo
>>
> 

