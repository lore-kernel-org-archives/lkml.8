Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36203206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTa1Jufg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgFDOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:47:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38470 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgFDOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591282063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVjp1+B7Ums2WwjJdbTd0FyIxmI/v180ZJI4Geq4fto=;
        b=XTa1Jufg4Cgp7lNpuy+LXBxePuCnqxGLBODsZXkf+aEXWyr2tEvACPQSmWMQ1w4PZHPGSQ
        3eND6+lRjMYO1kShrPlViH1cbuyxWuU8t3Rksulh0zhQDol+rDBvphfZcR8oV8DzjWKYLE
        XrNonORHnuni87Kgsm4xWAnNSNEWgg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Z1lGyovqPsOD2xndAaDsag-1; Thu, 04 Jun 2020 10:47:41 -0400
X-MC-Unique: Z1lGyovqPsOD2xndAaDsag-1
Received: by mail-wr1-f70.google.com with SMTP id d6so2523491wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVjp1+B7Ums2WwjJdbTd0FyIxmI/v180ZJI4Geq4fto=;
        b=czrX5NDtUTXPL9BiGYOZsH1DI8WqvviO0j61oxs4jVesTizDRfSvBtKjJF0fD+E/3O
         PRsjnGB/cii9ZYfdgM6p91F82Y4EUHxo1+KVWkNMojfwjJGTK82X/yD5+b9Be6sBHv3G
         F1n5Dj4ifHiwaNtrBtLEfHhQPZKw1DgbVTDNScMNfL/IP7IPmhi1lLHc5tXXG64y6Qdo
         TuUdBtnhm+l5fp9KZfkJCoJ3G12f0J0IOa9eryg18l48+BHbjWb8p+/X+k6ztF0qLP6I
         mq8IfLMeE/kbqsZ4cgTSbudcXqaXWfbLa/LtBa1PSElKVVqQpVyFzmK1LOyc+dnFFKlv
         RrRA==
X-Gm-Message-State: AOAM531C3nySa2otY9pro6xRfUBZWoNWjj5Z1qp/z4F10i58H2oqu6oG
        AHzh1LfA3tTY4Uu6JX5g6Qh6q1Mb5zqKFdbQ72zDcYqII0cpQ5pxw/DRGPeErxml0zmbp6tdYOo
        EUQIqWxIYZKXYeeYQ5soYhaH3
X-Received: by 2002:a1c:a943:: with SMTP id s64mr4303616wme.103.1591282060089;
        Thu, 04 Jun 2020 07:47:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/oZ/llxbCOXe7Yhr5uisg7entzGeV6RiIoiIueRD3ktLznBItFpSZ9w8E80IqMv2pWELv5Q==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr4303606wme.103.1591282059855;
        Thu, 04 Jun 2020 07:47:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id s8sm8772371wrg.50.2020.06.04.07.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 07:47:39 -0700 (PDT)
Subject: Re: [PATCH 30/30] KVM: nSVM: implement KVM_GET_NESTED_STATE and
 KVM_SET_NESTED_STATE
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-31-pbonzini@redhat.com>
 <eabf694a-68e4-3877-2ad7-3d37f54fd3d4@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0abde9d2-4257-666d-aa2e-6fbb684a5c21@redhat.com>
Date:   Thu, 4 Jun 2020 16:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eabf694a-68e4-3877-2ad7-3d37f54fd3d4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I missed this.

On 02/06/20 02:11, Krish Sadhukhan wrote:
>>
>> +
>> +    /* SMM temporarily disables SVM, so we cannot be in guest mode.  */
>> +    if (is_smm(vcpu) && (kvm_state->flags &
>> KVM_STATE_NESTED_GUEST_MODE))
>> +        return -EINVAL;
>> +
>> +    if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE)) {
> 
> 
> Should this be done up at the beginning of the function ? If this flag
> isn't set, we probably don't want to come this far.

So far we have only done consistency checks.  These have to be done no
matter what (for example checking that GIF=1 if SVME=0).

>> +        svm_leave_nested(svm);
>> +        goto out_set_gif;
>> +    }
>> +
>> +    if (!page_address_valid(vcpu, kvm_state->hdr.svm.vmcb_pa))
>> +        return -EINVAL;
>> +    if (kvm_state->size < sizeof(*kvm_state) +
>> KVM_STATE_NESTED_SVM_VMCB_SIZE)
>> +        return -EINVAL;
>> +    if (copy_from_user(&ctl, &user_vmcb->control, sizeof(ctl)))
>> +        return -EFAULT;
>> +    if (copy_from_user(&save, &user_vmcb->save, sizeof(save)))
>> +        return -EFAULT;
>> +
>> +    if (!nested_vmcb_check_controls(&ctl))
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * Processor state contains L2 state.  Check that it is
>> +     * valid for guest mode (see nested_vmcb_checks).
>> +     */
>> +    cr0 = kvm_read_cr0(vcpu);
>> +        if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
>> +                return -EINVAL;
> 
> 
> Does it make sense to create a wrapper for the CR0 checks ? We have
> these checks in nested_vmcb_check_controls() also.

Not in nested_vmcb_check_controls (rather nested_vmcb_checks as
mentioned in the comments).

If there are more checks it certainly makes sense to have them.  Right
now however there are only two checks in svm_set_nested_state, and they
come from two different functions so I chose to duplicate them.

Paolo

