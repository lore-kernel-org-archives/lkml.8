Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A82F20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et4ooAbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgICSDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgICSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599156212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIYywuI+5zo+5SpQBzc44V+N7rc22duk7DoIeCwwY34=;
        b=et4ooAbPr5cg9tQacWsbPmRB0NFLUz3rYf3WB4rmuieE4BNDSXzkUh+w4ZEZEcLF0saB+B
        RKJhqieqdvZNMh0U2oJ1H2DVUiqYvpnirEgS/vWVJgc5qFIdxhQtGe0SNf7FKuoV0ykt1t
        K+9hgT9DkVVs4WG02m0QdOtcNDkQ3GQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-9aeL0gecNOuJafzUkRXZqA-1; Thu, 03 Sep 2020 14:03:30 -0400
X-MC-Unique: 9aeL0gecNOuJafzUkRXZqA-1
Received: by mail-wm1-f70.google.com with SMTP id 23so1202889wmk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIYywuI+5zo+5SpQBzc44V+N7rc22duk7DoIeCwwY34=;
        b=bLw0z9oKyxiCmPT32sBGfs8h+zBpieJ+htnBArp3YgWIGtJO11BUL4FmZqUdfS9FhV
         yIjFlhnXZ454u38tkXtuf6zQdI7w+sd1Ftod/f/rjoj+sYmf2US3ilp/gQamQo1nAxgI
         5yGvpThmxLsaMNx2NslmjgoNc6uGDNLJgUuweZygEr3Er0iqaU6Mi2kO67eaN/zP66Tl
         KnK0886c7E0eSCB3XebGe6IOWUuE8grZEA1G/fhkqskXI3WQWxSnwReL8c6COZ5v0WhV
         3ZIMXmeL4rP1NpaHkk2PziQkcrMJGiUUYo+4B/HnqSIf5RFwiq7SqrZTfxKy7b9h6pgy
         KiiQ==
X-Gm-Message-State: AOAM5326EKNKvBl433bpOgDx4Va0GZoYXenCzJTSemGS2m2XMvUX+GWw
        2qmkOmWzHECjFaAd6fa1ASTJlLGoExOoX5eHuThxwv66+Ag4AuFLVioN/WtKlF8eaFT3x5bh7b0
        worvb+XAFp431SPksBbdXWqtT
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr3614741wrt.84.1599156209609;
        Thu, 03 Sep 2020 11:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywzVzvNoipx7UCAuCRf8BdHygTvcKAX8HtMdA2pAN3MK/J16WybvdgXkklbxMMCzuSooHB+Q==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr3614713wrt.84.1599156209243;
        Thu, 03 Sep 2020 11:03:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2? ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
        by smtp.gmail.com with ESMTPSA id o2sm6331216wrh.70.2020.09.03.11.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 11:03:28 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Jim Mattson <jmattson@google.com>,
        Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200903141122.72908-1-mgamal@redhat.com>
 <CALMp9eTrc8_z3pKBtLVmbnMvC+KtzXMYbYTXZPPz5F0UWW8oNQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00b0f9eb-286b-72e8-40b5-02f9576f2ce3@redhat.com>
Date:   Thu, 3 Sep 2020 20:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eTrc8_z3pKBtLVmbnMvC+KtzXMYbYTXZPPz5F0UWW8oNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 19:57, Jim Mattson wrote:
> On Thu, Sep 3, 2020 at 7:12 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>> This patch exposes allow_smaller_maxphyaddr to the user as a module parameter.
>>
>> Since smaller physical address spaces are only supported on VMX, the parameter
>> is only exposed in the kvm_intel module.
>> Modifications to VMX page fault and EPT violation handling will depend on whether
>> that parameter is enabled.
>>
>> Also disable support by default, and let the user decide if they want to enable
>> it.
>
> I think a smaller guest physical address width *should* be allowed.
> However, perhaps the pedantic adherence to the architectural
> specification could be turned on or off per-VM? And, if we're going to
> be pedantic, I think we should go all the way and get MOV-to-CR3
> correct.

That would be way too slow.  Even the current trapping of present #PF
can introduce some slowdown depending on the workload.

> Does the typical guest care about whether or not setting any of the
> bits 51:46 in a PFN results in a fault?

At least KVM with shadow pages does, which is a bit niche but it shows
that you cannot really rely on no one doing it.  As you guessed, the
main usage of the feature is for machines with 5-level page tables where
there are no reserved bits; emulating smaller MAXPHYADDR allows
migrating VMs from 4-level page-table hosts.

Enabling per-VM would not be particularly useful IMO because if you want
to disable this code you can just set host MAXPHYADDR = guest
MAXPHYADDR, which should be the common case unless you want to do that
kind of Skylake to Icelake (or similar) migration.

Paolo

