Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52591C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262242146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heEiyx/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCBQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:05:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52192 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727392AbgCBQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583165107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzjWFgUV0o3WEpqZfCi50NLB5vc0uNlHzWOpvHJh3Xc=;
        b=heEiyx/4nejfVs06diKYidxpoJV+KcBIuwdm5XI4p4sP36MbBg6pSsy1JUZjmuUxQBF0Y3
        EWmg5tCX83yHnNTNmLbkQYYAPwkE3p1KtHSmw+jXoN0VaS1kCuzT7cM9GLUj0uaOrUOaXw
        Vyr+Ch0FvsBJUN9l+Jbf2adeSR1Vm9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-nJL9qjENPvaPVGGS40Nz-g-1; Mon, 02 Mar 2020 11:05:05 -0500
X-MC-Unique: nJL9qjENPvaPVGGS40Nz-g-1
Received: by mail-wm1-f72.google.com with SMTP id g26so2053651wmk.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TzjWFgUV0o3WEpqZfCi50NLB5vc0uNlHzWOpvHJh3Xc=;
        b=eAvnuQaA7L2ex8cc2vHDpAtXvw5ltJ4rXvwV8Xxmg3FqmuWu5P5lHohSvxs7qW4uTP
         ZRuyAKxF8KnIx2Qu1iTbsH3DpkhRg0s0viSgI+jvldqpJLQTuIvJNghOa5RnRTiJLIks
         QV6/kNweAzkL04IHmTOJmC9MILlAfjekW2jbOjd4EC7ocMSVx8yDE5fiUfqDoiFxLMDv
         PHF4+6pVdIgs3HuBgBqQOxd2sMFXo3jy7Euwk74mdkfHYRWH4uvZD1nB5Mvy//PKxr1g
         fCAQUlH7NoYsYMEvMHC8pd9TkGBtBmNRoBcf8sfMZCn8QAwC2ybxkuQ0TCXmr28i1Hnq
         zbmA==
X-Gm-Message-State: ANhLgQ0HHM5HJcHzjW1sWVLmUxzdMtaT4XxdogWn45ulINMniwWm+Jbr
        YB/I8aMZ3lxfOv6m7z6MjtIT1S4mROLBi9f4gq3hxT1lkm50lLK3XbYiw23eBJVwOqTd5JHSm7Q
        T6yHUi0zccWbgvG9OKGNmmxVt
X-Received: by 2002:adf:a304:: with SMTP id c4mr303061wrb.186.1583165104345;
        Mon, 02 Mar 2020 08:05:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtLyS9ziQmq5CsqnaVCSE9YqCiD2HQdZUHo0h02SGMzzZ+cx57J7O9ZVp26aGR7xFTPnsIEeA==
X-Received: by 2002:adf:a304:: with SMTP id c4mr303047wrb.186.1583165104112;
        Mon, 02 Mar 2020 08:05:04 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id u8sm16865895wmm.15.2020.03.02.08.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 08:05:03 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: Fix svm the vmexit error_code of WRMSR
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     hpa@zytor.com, bp@alien8.de, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>, jmattson@google.com,
        wanpengli@tencent.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, x86@kernel.org
References: <CAB5KdOZwZUvgmHX5C53SBU0WttEF4wBFpgqiGahD2OkojQJZ-Q@mail.gmail.com>
 <87o8tehq88.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30830ba4-d8d3-df58-f039-57e750ae90a7@redhat.com>
Date:   Mon, 2 Mar 2020 17:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o8tehq88.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 13:54, Vitaly Kuznetsov wrote:
>>          enum exit_fastpath_completion *exit_fastpath)
>>   {
>>          if (!is_guest_mode(vcpu) &&
>> -               to_svm(vcpu)->vmcb->control.exit_code ==
>> EXIT_REASON_MSR_WRITE)
> There is an extra newline here (in case it's not just me).

Yes, the whole patch has broken newlines.  I fixed it up and applied.

>> +               (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR) &&
>> +               (to_svm(vcpu)->vmcb->control.exit_info_1 & 1))
>
> Could we add defines for '1' and '0', like
> SVM_EXITINFO_MSR_WRITE/SVM_EXITINFO_MSR_READ maybe?

We can eliminate "& 1" completely since that's what msr_interception does.

Paolo

