Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B8D21775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQHBlnME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCBQbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:31:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727085AbgCBQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583166693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1x0ZM1xTpaIkqmKsVKdQPlGDF0qsj8hnKJSTjUcj/Aw=;
        b=fQHBlnMEnRTtk57rFCbGRNAJeb95rlHRUmHhVDb2JnxLPROTFI86Wy5Xqm+kasmIIU+fFd
        D8aCD1SzRF8ygVgZbiDyBFo99EooI91l5ZC7HOFO6FVUMBlIHx3sVQOORYyM1M2bHS4ddd
        BjT0gU7IF4lkZ4F8YxOoKduimAtRqys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-YN0MDv7TNfKWpEwlP2DjoA-1; Mon, 02 Mar 2020 11:31:32 -0500
X-MC-Unique: YN0MDv7TNfKWpEwlP2DjoA-1
Received: by mail-wr1-f69.google.com with SMTP id d9so6016688wrv.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1x0ZM1xTpaIkqmKsVKdQPlGDF0qsj8hnKJSTjUcj/Aw=;
        b=iLs3x2hgOZGineuX6CQMVEpLn8nK6RxImFuvKdzRGXfh9AbrbVH4ktK3+Ys478+SJ3
         mqy6/GuEDvQDU11PWkut1Lff2AcEIEM/JnZP8atPQOlIGUxB+UFaGO5u08o6O/Im4/mo
         pT3SipNvw4ItHQw6nMbFo2BquSH1nXNoKbWJKzL9nb/y4GgFOLrfOThUIByoj4WdXVP7
         rN4vtDp7e9utkQJCslCBIyrYILtD080m+7xWwjy9MIk9sjdeQn9YW5fKyMvwCSwgIyTL
         2I5OTwIGF0fwK6CuAAe4hOtri2wtFg4/m9USICePbeb7y+mziqpf70LVxSrfYPXTdYGj
         X6iA==
X-Gm-Message-State: ANhLgQ1IKmEmd99SEfy15+K93kOlCxcv3WGAMtW+pGdOl0G55OIaBEd5
        TqQXi4LDMzhdYeC4KBg1sm2sC7SVFqicrZ2awIarnyDQoq9S7zcs0w2qNSfWfKDJIpC68ocfYZN
        mEJ1zlOCSnzJXqcb6p/HiKmye
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr397865wrx.330.1583166690988;
        Mon, 02 Mar 2020 08:31:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuDxQ+If1BB45iLB/FVzoEXWJKceXWuH/ax1Em/rcRFrXJ3iyu6XLdz3lh8x4VPNI6aPabRng==
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr397846wrx.330.1583166690776;
        Mon, 02 Mar 2020 08:31:30 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id s22sm15544619wmc.16.2020.03.02.08.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 08:31:30 -0800 (PST)
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
 <87ftewi7of.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c78b2c8-98b2-a517-4426-511505ff9018@redhat.com>
Date:   Mon, 2 Mar 2020 17:31:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87ftewi7of.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 12:36, Vitaly Kuznetsov wrote:
>> -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
>> -			goto out;
>> -		r = 0;
>> +		r = -EINVAL;
>>  		break;
>>  	}
> Braces are not really needed not but all other cases in the switch have
> it so let's leave them here too.
> 

We can remove the case altogether.

Paolo

