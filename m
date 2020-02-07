Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E67C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0812082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+o5SDvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBGJFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:05:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgBGJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581066336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TFD9rG7vA4FDrUIR6pMmUw/PlKpoAIbTdMQNf1sIX4=;
        b=g+o5SDvyv3ILn6cZTY725p+e61VeqbF8jv9RPRrCzJk/9p+T1FHlsFgYqOUr5zKFbGR8qj
        eiNx2gX5QJjGWQ6ezuDukt6uXs8Gntt3OeRMD1svz/cE3HWyD+Ig3V2aVeGynv4tdoaWfn
        WaLjvz5BSn3YLi4MlZcUUQOlj2mr6kQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-1xg5UQkxMlO5Hw9BzLzuMg-1; Fri, 07 Feb 2020 04:05:35 -0500
X-MC-Unique: 1xg5UQkxMlO5Hw9BzLzuMg-1
Received: by mail-wm1-f69.google.com with SMTP id l11so1396065wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2TFD9rG7vA4FDrUIR6pMmUw/PlKpoAIbTdMQNf1sIX4=;
        b=ThaIQvcbrEUgj6e/T79iZ+UueVlif52/H2WPKjIJbc7VACL7h/XIqHlKzjmN55pKWb
         kHLCI0390NdLWR5l7Q1H9j2vsF0wZdu3RNJAOCQZZndDoTiSv3Zv25VX008xKLaV3/H6
         FD11IDKGJQVGMZpq8LCj0l7oCUE7JDpRS5rhak51zeMukkA7ZLlIvscaKVcWL0g8c0Ay
         cK2hxqxhDCR8ZZ5Mn7NMxnzt4iAbqfrCg9ozN/xauqX8xZ0RrdXVLpwFY6C4O8cHejok
         EpdDPFuTgO3HhGG+y0AjPuW0aEerr/OnYgdmfq/hf65H2UvkUTafkyVWbpvg/hrMxYaT
         XC6Q==
X-Gm-Message-State: APjAAAV6mxk3E4QxvP+9jMqiCIfVtL+0Ehrbz2ulKw235A7z7sFnVvbH
        eg9y+pTWHRrdphP0iqs0CWGCYc8UUjW6qzox2ZtetPmD93Snsf6SYVSUnLmQ20VPIBI0ReezNSO
        ipc0ZwCkxPkKOkquf2pCDoLUh
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr3721277wrx.153.1581066334140;
        Fri, 07 Feb 2020 01:05:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6O3wbeZZQCUtS6dsN5hRsa9i0lefOI3eygicXS4BIRznUA5cVKuqZiLR+ei7uBb07X4RFTQ==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr3721243wrx.153.1581066333856;
        Fri, 07 Feb 2020 01:05:33 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y7sm2571820wrr.56.2020.02.07.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:05:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: x86: remove duplicated KVM_REQ_EVENT request
In-Reply-To: <a95c89cdcdca4749a1ca4d779ebd4a0a@huawei.com>
References: <a95c89cdcdca4749a1ca4d779ebd4a0a@huawei.com>
Date:   Fri, 07 Feb 2020 10:05:32 +0100
Message-ID: <87h802g42r.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> Hi：
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> linmiaohe <linmiaohe@huawei.com> writes:
>>> From: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> The KVM_REQ_EVENT request is already made in kvm_set_rflags(). We 
>>> should not make it again.
>>>  	kvm_rip_write(vcpu, ctxt->eip);
>>>  	kvm_set_rflags(vcpu, ctxt->eflags);
>>> -	kvm_make_request(KVM_REQ_EVENT, vcpu);
>>
>> I would've actually done it the other way around and removed
>> kvm_make_request() from kvm_set_rflags() as it is not an obvious behavior (e.g. why kvm_rip_write() doens't do that and kvm_set_rflags() does ?) adding kvm_make_request() to all call sites.
>>
>>In case this looks like too big of a change with no particular gain I'd suggest you at least leave a comment above kvm_set_rflags(), something like
>>
>>"kvm_make_request() also requests KVM_REQ_EVENT"
>
> I think adding kvm_make_request() to all call sites is too big without particular gain. And also leave a comment above
> kvm_set_rflags() maybe isn't needed as rflags updates is an site that can trigger event injection. Please see commit
> (3842d135ff24 KVM: Check for pending events before attempting injection) for detail.
>
> What do you think?

I don't have a strong opinion on this and your change is correct so feel
free to throw my

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>


-- 
Vitaly

