Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C4F20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W609tspm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGJLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:40:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726828AbgGJLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594381243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHkgHsP2LMXiJzMuU12W+yp4KrE8aOeFbQ7+oDie8jo=;
        b=W609tspmoBhQH/GF4adhR6CgFSdsszfhlwdQ7nmuZg9pPkiypI0SNqxiTVotkqRWVHqpUx
        b6dsXHJ0DBl8raJRLKpY6EPiqGhg9HGtK7nE5CCpyw3vEme6B5GGt2O6fFMsj2uJeZwnzt
        TnwQWGN33f/qYDEBWpC8JCzIOiv2KIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-lIGhmCLUPTu3-7EZKhzlpQ-1; Fri, 10 Jul 2020 07:40:41 -0400
X-MC-Unique: lIGhmCLUPTu3-7EZKhzlpQ-1
Received: by mail-wm1-f71.google.com with SMTP id g6so6519642wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VHkgHsP2LMXiJzMuU12W+yp4KrE8aOeFbQ7+oDie8jo=;
        b=drGYnDbYgH/iycScSO5eqHbwZMXY2RrqEXnLNyt0xx4+PiWz2G+jgsjEdkw5TVZF8d
         7E+MFDD16oHSTROaA0mEh3gVGvXRZfESWIuPN3meb46N+HDD+HssG5bxWXgV+32rotVl
         T4Oeekg/xPJzqCTAZ88fVKX5wvWUl2+nnDZTGufaS5jarh6LyK7+6nxRrJACzEtknQZX
         bVQBLMGOo+mMxOJB/RYpXVSHG10D7Y6K2SbIn4UxCn27S76Ky+sWWzMF1sTcTKKHRjBP
         ewZIKM3sbO1DzxhXOf2wHFFtoJu3G/EPZqY/NoXgoOMpZwom1fcXtc1S4423u1nvxzob
         aBGA==
X-Gm-Message-State: AOAM530wBOflVN96fGfLkLpusy6hWWj39NXEQkBIUdo47X580Z87VHux
        /vzPdPSYYAqtwzoJV+u1Vo7voGqDUB+fpntpD63+yGGdOyMTQvfZhrvXRK9Wz5cRmuR/H329NNN
        /PTZMHt1L5x1sle+Ar8MjLRSg
X-Received: by 2002:a1c:4846:: with SMTP id v67mr5008224wma.175.1594381239905;
        Fri, 10 Jul 2020 04:40:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzexHDpMo1ULLtIMbhLiWf3L2m1aZ1l+TwAjQ9GHUa2QztMKPPmHnEuaReNPKxs3BoWz2+j/w==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr5008197wma.175.1594381239727;
        Fri, 10 Jul 2020 04:40:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t2sm9040491wma.43.2020.07.10.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:40:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] KVM: nSVM: implement nested_svm_load_cr3() and use it for host->guest switch
In-Reply-To: <c7c65e0e-0c8f-106b-6249-ac706e702259@redhat.com>
References: <20200709145358.1560330-1-vkuznets@redhat.com> <20200709145358.1560330-8-vkuznets@redhat.com> <4d3f5b01-72d9-c2c5-08e8-c2b1e0046e5e@redhat.com> <c7c65e0e-0c8f-106b-6249-ac706e702259@redhat.com>
Date:   Fri, 10 Jul 2020 13:40:37 +0200
Message-ID: <87blknvbre.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/07/20 19:57, Paolo Bonzini wrote:
>> On 09/07/20 16:53, Vitaly Kuznetsov wrote:
>>> +	if (nested_npt_enabled(svm))
>>> +		nested_svm_init_mmu_context(&svm->vcpu);
>>> +
>>>  	ret = nested_svm_load_cr3(&svm->vcpu, nested_vmcb->save.cr3,
>>>  				  nested_npt_enabled(svm));
>> 
>> This needs to be done in svm_set_nested_state, so my suggestion is that
>> the previous patch includes a call to nested_svm_load_cr3 in
>> svm_set_nested_state, and this one adds the "if" inside
>> nested_svm_load_cr3 itself.
>
> Actually no, that doesn't work after the next patch.  So the best option
> is probably to extract nested_svm_init_mmu as a separate step in
> enter_svm_guest_mode.  This also leaves nested_prepare_vmcb_save as a
> void function.
>

Hm, it seems I missed svm_set_nested_state() path
completely. Surprisingly, state_test didn't fail)

I'm struggling a bit to understand why we don't have kvm_set_cr3() on
svm_set_nested_state() path: enter_svm_guest_mode() does it through
nested_prepare_vmcb_save() but it is skipped in svm_set_nested_state().
Don't we need it at least for !npt_enabled case? We'll have to extract
nested_cr3 from nested_vmcb then.

-- 
Vitaly

