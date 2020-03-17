Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE3C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD76020735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blm5Wi8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgCQRAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:00:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49110 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584464414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pD4ldY6FsMj0oyAEHqGiJztZej2hvg/ILeuMFN/cWHc=;
        b=blm5Wi8E7sLjrGaG32fz/gMuL1RnXDlf7RJwuH6+6OcefClWYc5JBeh57Nt9RbqTxCjfUw
        NAtjmJGpQhP8UhblodkeYp9uSoR9wXG9Rpx/EMktu59O5s7/BI5qa62I0d2KLPQ/t8iRuv
        bZ2SeB1bsgTZ2HYAXr0Ou5hUYfk9X0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-b5V8QoO6NoSDZughQzqdfg-1; Tue, 17 Mar 2020 13:00:12 -0400
X-MC-Unique: b5V8QoO6NoSDZughQzqdfg-1
Received: by mail-wm1-f72.google.com with SMTP id a11so4335wmm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pD4ldY6FsMj0oyAEHqGiJztZej2hvg/ILeuMFN/cWHc=;
        b=BJ3SO2bVVbNTFdDUVkdeHRdLzWsDf5O0xQB1/flX1cxZ2yXQQtIWPS68WJzfDW2rIS
         /xvuruDupoFDthRKu16BoFlvTXiSUhAz2/OaNZNOnIDBRnPhr+S2JAHqAvTxFn0U6pZS
         mhbDlAaZICulhz0a9577JN98YWvrLgdal7RWs8+i265lznQyScny7+9B8xS++TTa4OXo
         RlzT6jS/BQvJhnVo+YxUZES/fc6LcrB2saPmoO4iMkPAhTKwuTIZXqS2z66xdSsl7LAa
         pUWFOVuxXgA+Z8HtvyJqRewylZXD2STUBS3LUOjgO/Xzpk0bvNQx4cqA9euX3s73vRkr
         MI+Q==
X-Gm-Message-State: ANhLgQ3XnIsGKEZSVYTsWUT/MVbh+0JT/UfVrjRIpEkymU+tkr0kRSlC
        l8p8jRJ/Fji5HCRAYbEcRHKKY+U/bRkRmxoO45F784z3o77m/DQfCwtXOfE3M2AeuSscxboqQyg
        ftLmGJvw3KOWB1PBr+fzwN+e0
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr6993035wrn.400.1584464411315;
        Tue, 17 Mar 2020 10:00:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuiBti4n3b+I45Dd6Af5CiLPyuCQjyIHtzEMxtdl62LafVztX3/PskWwlTeWTOv4/AIOdpE5A==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr6993015wrn.400.1584464411054;
        Tue, 17 Mar 2020 10:00:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j39sm5737571wre.11.2020.03.17.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:00:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 01/10] KVM: nVMX: Move reflection check into nested_vmx_reflect_vmexit()
In-Reply-To: <20200317161631.GD12526@linux.intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-2-sean.j.christopherson@intel.com> <87k13opi6m.fsf@vitty.brq.redhat.com> <20200317053327.GR24267@linux.intel.com> <20200317161631.GD12526@linux.intel.com>
Date:   Tue, 17 Mar 2020 18:00:07 +0100
Message-ID: <874kum533c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Mar 16, 2020 at 10:33:27PM -0700, Sean Christopherson wrote:
>> On Fri, Mar 13, 2020 at 01:12:33PM +0100, Vitaly Kuznetsov wrote:
>> > Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> > 
>> > > -static inline int nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>> > > -					    u32 exit_reason)
>> > > +static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>> > > +					     u32 exit_reason)
>> > >  {
>> > > -	u32 exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>> > > +	u32 exit_intr_info;
>> > > +
>> > > +	if (!nested_vmx_exit_reflected(vcpu, exit_reason))
>> > > +		return false;
>> > 
>> > (unrelated to your patch)
>> > 
>> > It's probably just me but 'nested_vmx_exit_reflected()' name always
>> > makes me thinkg 'the vmexit WAS [already] reflected' and not 'the vmexit
>> > NEEDS to be reflected'. 'nested_vmx_exit_needs_reflecting()' maybe?
>> 
>> Not just you.  It'd be nice if the name some how reflected (ha) that the
>> logic is mostly based on whether or not L1 expects the exit, with a few
>> exceptions.  E.g. something like
>> 
>> 	if (!l1_expects_vmexit(...) && !is_system_vmexit(...))
>> 		return false;
>
> Doh, the system VM-Exit logic is backwards, it should be
>
> 	if (!l1_expects_vmexit(...) || is_system_vmexit(...))
> 		return false;
>> 
>> The downside of that is the logic is split, which is probably a net loss?
>

Yea,

(just thinking out loud below)

the problem with the split is that we'll have to handle the same exit
reason twice, e.g. EXIT_REASON_EXCEPTION_NMI (is_nmi() check goes to
is_system_vmexit() and vmcs12->exception_bitmap check goes to
l1_expects_vmexit()). Also, we have two 'special' cases: vmx->fail and
nested_run_pending. While the former belongs to to l1_expects_vmexit(),
the later doesn't belong to either (but we can move it to
nested_vmx_reflect_vmexit() I believe).

On the other hand, I'm a great fan of splitting checkers ('pure'
functions) from actors (functions with 'side-effects') and
nested_vmx_exit_reflected() while looking like a checker does a lot of
'acting': nested_mark_vmcs12_pages_dirty(), trace printk.

-- 
Vitaly

