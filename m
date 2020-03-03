Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53266C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A4E214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkY/QvyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgCCKOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:14:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728531AbgCCKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/0qud24Lc83ZsK+kraVeDJxpPhKrBM9LgPi+wDoazM=;
        b=bkY/QvyH11ds6QOk3Zjca9IjpiigOKj27bAxICYb+0PyqKmWMbGDiupMOQSz+Z/6Nt/GFX
        4xZJjyM9CKkM96xLN9jRkF4aWsRBWqrazSiHegDGKnk5RNxbjSIA4P8njwTUsWI4ul4Kyb
        wNrrrdgAPoU5ouhvvFUrXa8otfvjs0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-7fyuCQ2SPka4rtgFKKkcJw-1; Tue, 03 Mar 2020 05:14:37 -0500
X-MC-Unique: 7fyuCQ2SPka4rtgFKKkcJw-1
Received: by mail-wm1-f69.google.com with SMTP id o24so469090wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w/0qud24Lc83ZsK+kraVeDJxpPhKrBM9LgPi+wDoazM=;
        b=BpHQ+9Ij+AtxfpQ9fatbe9zSMhVdW3gcaged2AUNScKL+Iv9KLS191DN4xjFpSE+iH
         93gfHwatYanpYJIMykokbrgDq0Lln5ZGBn6bvFd1xevvf4oLoQgo2CQGL6V2LOrnNi3h
         uPnLuChKI+HBYVZrG9W1/+k2Orj7nUEjNa5Dnhp0NUZ5T7y1VIX6XD8rQLaQQaC/DQqW
         RI+nyfjJbzVA0DrKuuuFKSbS8kf2SQJLHZCpdfrqjlgR7k6Khrx45BOC88QFlssQVu4U
         Umpfd64e2kLhyPnRPxB9ervm7xcPtc9vXlziIivvuMp+olFYf9LXK0cN9O6DXiwVEXeh
         B8Rw==
X-Gm-Message-State: ANhLgQ1b41GI3vNxhnz6c/qHaulUnjF87gjmfNf1ZCezqW/ji04hc5IV
        TvgV2VES78ck/hJlmnC3LOCe0V8y3lHTDjhnHyHeisbOSNiieCN5XXcu2WKaHCjGeQ5CQ4//Lln
        KVdMDKDGi5Lv/7huoC40KY01P
X-Received: by 2002:adf:b60f:: with SMTP id f15mr5029157wre.372.1583230476242;
        Tue, 03 Mar 2020 02:14:36 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuLxMYQILq06MORiKyONazb9g5WpGvFOg06QFQY+MMaKouSE6HlNhP78dp7DMPohLvHcz6D9A==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr5029137wre.372.1583230476016;
        Tue, 03 Mar 2020 02:14:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id 61sm33196852wrf.65.2020.03.03.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:14:35 -0800 (PST)
Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
To:     "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "peterx@redhat.com" <peterx@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxin (U)" <wangxinxin.wang@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Liujinsong (Paul)" <liu.jinsong@huawei.com>
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
 <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
 <B2D15215269B544CADD246097EACE7474BB4E091@DGGEMM528-MBX.china.huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8c4cc9f-6c9e-6d02-9eb3-32824dcc0c4c@redhat.com>
Date:   Tue, 3 Mar 2020 11:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BB4E091@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 11:00, Zhoujian (jay) wrote:
> 
> 
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Tuesday, March 3, 2020 4:54 PM
>> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; kvm@vger.kernel.org
>> Cc: peterx@redhat.com; shuah@kernel.org; linux-kselftest@vger.kernel.org;
>> linux-kernel@vger.kernel.org; wangxin (U) <wangxinxin.wang@huawei.com>;
>> Huangweidong (C) <weidong.huang@huawei.com>; Liujinsong (Paul)
>> <liu.jinsong@huawei.com>
>> Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
>>
>> On 03/03/20 09:07, Jay Zhou wrote:
>>>  #ifdef USE_CLEAR_DIRTY_LOG
>>> -	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
>>> -		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping
>> tests\n");
>>> +	dirty_log_manual_caps =
>>> +		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
>>> +	if (!dirty_log_manual_caps) {
>>> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
>>> +				"skipping tests\n");
>>> +		exit(KSFT_SKIP);
>>> +	}
>>> +	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
>>> +		dirty_log_manual_caps !=
>> KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
>>> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
>>> +				"%"PRIu64", skipping tests\n",
>>> +				dirty_log_manual_caps);
>>>  		exit(KSFT_SKIP);
>>>  	}
>>>  #endif
>>>
>>
>> Thanks, instead of this final "if" it should be enough to do
>>
>> 	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE
>> |
>> 				  KVM_DIRTY_LOG_INITIALLY_SET);
>>
>>
>> Otherwise looks good, I'll test it and eventually apply both patches.
> 
> Do I need to resubmit this patch with this modification?

No, thanks.

Paolo

