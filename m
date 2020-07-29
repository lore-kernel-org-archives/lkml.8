Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86859C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F87E20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABtJD8Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgG2XIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:08:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbgG2XIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596064095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIiXcFyvXpes1TnL1+wTHGXIVVbSubmFJ3ChguRJtb0=;
        b=ABtJD8JkbZVy4x3JZjxi8OnUTzaX0utRtEDySgXDKNox3v+EwPzcDJ6Ogvv3/6hJOrzg/x
        vTI/z8hi7cbcGWBLaJOSozgKNv3kuMNfpwLHYw2oh+sM9T0Pn7xqKjHnZNr1fQbgiusi5Z
        MLLMzdf/MmpdOzRcdSnCq6qpgzO3p18=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-zGkBufeTNrmfjezBQAaELA-1; Wed, 29 Jul 2020 19:08:13 -0400
X-MC-Unique: zGkBufeTNrmfjezBQAaELA-1
Received: by mail-wr1-f70.google.com with SMTP id 5so7117531wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cIiXcFyvXpes1TnL1+wTHGXIVVbSubmFJ3ChguRJtb0=;
        b=l+lLk9bYq5Hv7TYzikiitjjmUAZafKUuVUJpijJPW1QnUMMddKDM/Q41BzYzbQBZNR
         ahzkuM/PC4b85fqFt758JuCZMw0euIP5+X7Wb9tYgVThEGyUJlfmyLeVRimvKsr1xqVn
         f10erecN8K8uB9iEMbRmCebndFuWD0eQIntX8J6Lv3g7+vSgUnzG94JEYFXks2K5IOFF
         BDnnHTp+HqWjWIja6yXzj5EgJxMpci3lYyLzfDQQbhIH2zQAJA+Eau9Ah8gR6355vmpe
         e9dIIMdND5PqExort2Ejn6XpEyFUoEvle4lySNQSYiY8J8mlby4TOW+0RnJjezSw4EBJ
         YefA==
X-Gm-Message-State: AOAM530QHtSCf3LSZuPeqtJCl5hXLnY4tKWYe/LLRuZEvKXHWj28tUYj
        i0mAhB44RdnLSIp6FGWmiWY8TzRnsz0ui1hZ/MIxvcj8Ij1y0r5G9eWCkeqC56xLP4W5qCiRcsx
        /89+4RsO7JuaKuDhGI/khG4G3
X-Received: by 2002:adf:bb14:: with SMTP id r20mr17780wrg.366.1596064092190;
        Wed, 29 Jul 2020 16:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz23ETCraz9nu5BZ3LgJYRp/3yYB2g1A0+QLPdg/44/6iAl4RguA3HO5UuXK/5dOCTgtIIlCA==
X-Received: by 2002:adf:bb14:: with SMTP id r20mr17756wrg.366.1596064091926;
        Wed, 29 Jul 2020 16:08:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c? ([2001:b07:6468:f312:101f:6e7:e073:454c])
        by smtp.gmail.com with ESMTPSA id b63sm6682694wme.41.2020.07.29.16.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:08:11 -0700 (PDT)
Subject: Re: [PATCH v3 02/11] KVM: SVM: Change intercept_cr to generic
 intercepts
To:     Babu Moger <babu.moger@amd.com>, Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
 <159597948045.12744.16141020747986494741.stgit@bmoger-ubuntu>
 <CALMp9eTDKX7L0ntOo-hsirk2dET1ZG4tofgvQ4SX9kdwEQoPtw@mail.gmail.com>
 <d11694cd-7c75-9dbb-0ccd-9b1927fa2da1@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67dad5ee-1c70-b892-918a-8e7126aa4a5f@redhat.com>
Date:   Thu, 30 Jul 2020 01:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d11694cd-7c75-9dbb-0ccd-9b1927fa2da1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/20 18:08, Babu Moger wrote:
>>>
>>>         if (g->int_ctl & V_INTR_MASKING_MASK) {
>>>                 /* We only want the cr8 intercept bits of L1 */
>>> -               c->intercept_cr &= ~(1U << INTERCEPT_CR8_READ);
>>> -               c->intercept_cr &= ~(1U << INTERCEPT_CR8_WRITE);
>>> +               __clr_intercept(&c->intercepts, INTERCEPT_CR8_READ);
>>> +               __clr_intercept(&c->intercepts, INTERCEPT_CR8_WRITE);
>> Why the direct calls to the __clr_intercept worker function? Can't these be calls
>> to clr_cr_intercept()?
>> Likewise throughout.
> This code uses the address to clear the bits.  So called __clr_intercept
> directly. The call clr_cr_intercept() passes the structure vcpu_svm and
> then uses get_host_vmcb to get the address.

Yes, this is correct.

Paolo

