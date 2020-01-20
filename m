Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93438C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CEA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIIncSWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgATPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:41:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgATPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579534888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfFFq+70X6qMf8r4MuhAIxjiC5PLXTTi4WgHQp9hBEw=;
        b=VIIncSWaXCSFCAzCDHRvM7Svzpxmm56oFCWZpexN1XuWEof1KLAsbJsqW8mgMCkDY0LgKQ
        +zxsVmZw1Hfcx2iE1QGBtKbI/QqUwfA3065xwytYBigJptR2hxKJsjtqd2wqplRtXrfuzO
        hBQee3nKDMXc825vVKNUu195UnDEPmY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-BXJpP6TdNk-8ENCuo2gZZQ-1; Mon, 20 Jan 2020 10:41:26 -0500
X-MC-Unique: BXJpP6TdNk-8ENCuo2gZZQ-1
Received: by mail-wm1-f69.google.com with SMTP id h130so3816848wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfFFq+70X6qMf8r4MuhAIxjiC5PLXTTi4WgHQp9hBEw=;
        b=AFZH+vcjIWB6c4FG7mHLVmLsPl/kqqQe2xohucK8qa98xMlhOyqwiBFWkpIql+7BZs
         p43JrIAv3tStXzygpBbhaijuLekhdkCYN/tQwKkhCILHiXuuAU8BTDDMuofDOLa3bTcp
         x2dtsHeWe07u1wwXUJfup1Ax14tMAUTCya6a+p+PwVbIkzF4dSoA2UYPcwm2zklOYP5m
         nNFKENzw/oZzw0RsQSgK3OMP501oyt2zyfL+wuvwPM0XaTpanc8zzyZJ1MSjz177uFSa
         NbLgZ0esIM/454kzbuF1XLorY/Ip/s3Lg7w+bX4wffyVQfE8qRfmINHqrv0+ETa/a3pw
         JoNg==
X-Gm-Message-State: APjAAAWnHsBnEh/LJkJdD1/eod7bcdXrySvZSZRM7/qUIeV+Vo35pbwq
        aPCGW/bgkVZtbG2ONb5fyO8lmQLBviNrsnJH6CkgmWyQ0W+J58yvof/f0QhyNsC8ElX0mmCtInn
        qwgbMQ9khZemce4pi+eH8pdrh
X-Received: by 2002:adf:f091:: with SMTP id n17mr68437wro.387.1579534885718;
        Mon, 20 Jan 2020 07:41:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxeN1H9XOiFOvdvahLayiiufSFu8dp6MB099coHjd9OyFt/De8dDdWWcXre82VFxJtVqeW/4A==
X-Received: by 2002:adf:f091:: with SMTP id n17mr68392wro.387.1579534885056;
        Mon, 20 Jan 2020 07:41:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id s65sm4968546wmf.48.2020.01.20.07.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 07:41:24 -0800 (PST)
Subject: Re: [RFC] Revert "kvm: nVMX: Restrict VMX capability MSR changes"
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>
References: <20200120151141.227254-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30525d58-10de-abb4-8dad-228da766ff82@redhat.com>
Date:   Mon, 20 Jan 2020 16:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200120151141.227254-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/20 16:11, Vitaly Kuznetsov wrote:
> 
> RFC. I think the check for vmx->nested.vmxon is legitimate for everything
> but restore so removing it (what I do with the revert) is likely a no-go.
> I'd like to gather opinions on the proper fix: should we somehow check
> that the vCPU is in 'restore' start (has never being run) and make
> KVM_SET_MSRS pass or should we actually mandate that KVM_SET_NESTED_STATE
> is run after KVM_SET_MSRS by userspace?
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I think this should be fixed in QEMU, by doing KVM_SET_MSRS for feature
MSRs way earlier.  I'll do it since I'm currently working on a patch to
add a KVM_SET_MSR for the microcode revision.

Thanks,

Paolo

