Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1972020758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f48qGWWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgERUNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:13:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgERUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589832817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FuqqfaCRxkXrkU1XoQZ3g0hbXKUiq+yLL3TVWqu58Q=;
        b=f48qGWWxLuD97QvcgSgPGZBCd0+//O74YGsHA/4BEgG/qyJDn+xm4mCx/QDJs0nwJF6GiF
        295PkirWZQFnITJKvJd9dEdn0V32MeKHRoA0gNT6/UrLLFIteikb9rqfhX9vX2mwlZAotr
        v0unftTLBt5G7sFhI/8uTFyEbgGWUyA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-luE8sTc0OTehOItDnvy-qw-1; Mon, 18 May 2020 16:13:33 -0400
X-MC-Unique: luE8sTc0OTehOItDnvy-qw-1
Received: by mail-wm1-f69.google.com with SMTP id 23so310081wma.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FuqqfaCRxkXrkU1XoQZ3g0hbXKUiq+yLL3TVWqu58Q=;
        b=KW/5kXTQmY298hlxf2X3MJWMgylAbSAbmzkM0axChKSZM4K3DW8oHfKvHaDmnLO6qq
         evCiPzNpeo1FJbjQEj+fFld2Y/BT/2wbalTp/prNW0oa064XHZsy56mFHHpc5M5vxBmN
         ja4A9VZnoGvESyFMsfGl3OGm8lP5BcFOLjctK9ozZlgY5pfHIB8pfs9/a+BsLd0fIC5n
         vH5xkDe4Sb9O2qiJHNIlqJU6Ggib3ZjprSVvyxzikqfx8zs4HpNol/0PaQxCiSKPSCFt
         a/NA3CjDGrbNaEZ1GKIzGoxUJXh3d0IxrhM/GmsOZHyKiv/l2YHAFrDlnrVrurmUbCN0
         zMQA==
X-Gm-Message-State: AOAM533WIgbioyEEwCja66beycJ4UYU0RoX8WOXuDLaLBsQiymjx8fX7
        wV6fMNlV2TRW+8ZZ4iOTLfbcCLmSlJHhRklZx/eWz8YgQUyDji643fUqzHjVmxeNPAanOdguL1z
        R6yndWM7nHbKuWkSouerttxE2
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr1108148wmb.123.1589832812305;
        Mon, 18 May 2020 13:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUyDuJ6hpGGEfbOxOxaYcBTBkFm+hP/HaXtAGSHA1Y+klLKmw+76JaCIxqRMzLPb3V5yiySg==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr1108115wmb.123.1589832812024;
        Mon, 18 May 2020 13:13:32 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id w82sm810750wmg.28.2020.05.18.13.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 13:13:31 -0700 (PDT)
Subject: Re: [PATCH 0/7] KVM: SVM: baby steps towards nested state migration
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cathy Avery <cavery@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
References: <20200515174144.1727-1-pbonzini@redhat.com>
 <27c7526c-4d02-c9ba-7d3b-7416dbe4cdbb@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff8ca8ca-bc2c-5188-7024-7d4a18b02759@redhat.com>
Date:   Mon, 18 May 2020 22:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <27c7526c-4d02-c9ba-7d3b-7416dbe4cdbb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/20 22:07, Krish Sadhukhan wrote:
>>
>>
>> Paolo Bonzini (7):
>>    KVM: SVM: move map argument out of enter_svm_guest_mode
>>    KVM: SVM: extract load_nested_vmcb_control
>>    KVM: SVM: extract preparation of VMCB for nested run
>>    KVM: SVM: save all control fields in svm->nested
>>    KVM: nSVM: remove HF_VINTR_MASK
>>    KVM: nSVM: do not reload pause filter fields from VMCB
>>    KVM: SVM: introduce data structures for nested virt state
>>
>>   arch/x86/include/asm/kvm_host.h |   1 -
>>   arch/x86/include/uapi/asm/kvm.h |  26 +++++++-
>>   arch/x86/kvm/svm/nested.c       | 115 +++++++++++++++++---------------
>>   arch/x86/kvm/svm/svm.c          |  11 ++-
>>   arch/x86/kvm/svm/svm.h          |  28 +++++---
>>   5 files changed, 116 insertions(+), 65 deletions(-)
>>
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

Thanks!  Note that (while these patches should be okay) they are not
really ready to be committed because more cleanups and refactorings will
become evident through the rest of the work.

Paolo

