Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7A9206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It7x1aur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFELQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:16:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726465AbgFELP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591355757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8a2f7F+3vcKM6ztM/s5dArCF02jWdgvQcQyvf03Ew0=;
        b=It7x1aurSz7sqSBEFlTeOvv4g6OA/D+B1Oz5hIOro/lTp+uwYOCDZ4UeKJOUZ2EzEHLP+x
        ZunuzfhzXqwVsR0SJva1SnmqNc+KTVIOUgxjhMGVT9+V9PFuihmVAu4tiwR435AcVayW+5
        nhFYVp0J+NDYM+k2tWAE/dJa554WxMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-TD5crfOYM5Sor3dcPbqebw-1; Fri, 05 Jun 2020 07:15:55 -0400
X-MC-Unique: TD5crfOYM5Sor3dcPbqebw-1
Received: by mail-wm1-f71.google.com with SMTP id p24so2900093wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 04:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8a2f7F+3vcKM6ztM/s5dArCF02jWdgvQcQyvf03Ew0=;
        b=bgGH5O3UnT2Y1RbS2rv7i5t/1h2W7SqPOJnFnwub2F6HehdcbjzneXqXrwdbO2AiDY
         0XjuBKluXFFGH5ZPQTDM2vOzNuJ3ZLWvoA7GliKm3zAhTVXrpgX7fV2NxldNExNz4Q6i
         hXbXu9/KMGDmNr3CqkbfcdQA/sOqS0/bR/bS0JbR8rHgK+g38RwCWsgbamQYqbo3Taw0
         DQCUf+uybrveoXYkXX6McLTDxJKO5mPcZ3lYyVCT/w6jRB+nrQC8+1cuWKcLU+RpARM9
         N+UWvuwcw6dg0xiqoKjipJGenCgyKhfZvv9QRtbDBg61NKweNqGmh9Q1HX8eKTbkphT6
         RF7A==
X-Gm-Message-State: AOAM533SYyjHiAztOK8F1PuJ6nGYKxBeP18Z+sdlVBJJ3aN0tj8yiiGl
        7sJMGVrAcuvsqNOfJxf+0gGMRxxaFCmngCY3uOKy5hTMi9xgT1d+exFev0bGBYPSSEcQw/KwlCx
        M4yBKvLgCeqXfiRc5XpkTJYbD
X-Received: by 2002:a7b:c951:: with SMTP id i17mr2133195wml.44.1591355754775;
        Fri, 05 Jun 2020 04:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVGG6rFBv8a0ZRPRpzrY2u/qF8bg879nEI6FUkBwSoWqVtIk43Mjl/J9pn3/3MezPpMKQYiA==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr2133161wml.44.1591355754512;
        Fri, 05 Jun 2020 04:15:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id q1sm10556883wmc.12.2020.06.05.04.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 04:15:53 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdW3Y2XSBLVk06IFg4Njog?=
 =?UTF-8?Q?support_APERF/MPERF_registers?=
To:     "Li,Rongqing" <lirongqing@baidu.com>,
        Like Xu <like.xu@linux.intel.com>,
        "like.xu@intel.com" <like.xu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jmattson@google.com" <jmattson@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
        "wei.huang2@amd.com" <wei.huang2@amd.com>
References: <1591321466-2046-1-git-send-email-lirongqing@baidu.com>
 <be39b88c-bfb7-0634-c53b-f00d8fde643c@intel.com>
 <c21c6ffa19b6483ea57feab3f98f279c@baidu.com>
 <3a88bd63-ff51-ad70-d92e-893660c63bca@linux.intel.com>
 <c67d15322f9942aa92b6cf57011c0abe@baidu.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4edabf8-b8c6-e60b-1a78-6aaa9bb7b5e1@redhat.com>
Date:   Fri, 5 Jun 2020 13:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c67d15322f9942aa92b6cf57011c0abe@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 11:41, Li,Rongqing wrote:
>>
>> As you said, "Pass-though: it is only suitable for KVM_HINTS_REALTIME", which
>> means, KVM needs to make sure the kvm->arch.aperfmperf_mode value could
>> "only" be set to KVM_APERFMPERF_PT when the check
>> kvm_para_has_hint(KVM_HINTS_REALTIME) is passed.
>>
> pining vcpu can ensure that guest get correct mperf/aperf, but a user
> has the choice to not pin, at that condition, do not think it is bug, this wants to say

Also, userspace can also pin without exposing KVM_HINTS_REALTIME.  So
it's better not to check.

Paolo

