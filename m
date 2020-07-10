Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C802C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A76D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT7uRDc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJMan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:30:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbgGJMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594384240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7diSbXLJJHy0Tup2Rvf98KHdW3L1g6SHguepxmHC4I=;
        b=XT7uRDc5/d862r3oymmTPze5cyMLvLQK+ie47JCR8eKHAWqzXjXnfNTe4qncVHSWKZeslT
        LiHhEQkglnOb7g2m6NwO0yogaEYBLnukKfVevCPoDEgYk97m3QkpALhgByvU50vTn7rkFo
        4G6epEU531zYfnVkYMhCKR2hkJXGDwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-mo9AzhD0Mpm_kQJ-6c06_w-1; Fri, 10 Jul 2020 08:30:39 -0400
X-MC-Unique: mo9AzhD0Mpm_kQJ-6c06_w-1
Received: by mail-wm1-f69.google.com with SMTP id 65so6544130wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e7diSbXLJJHy0Tup2Rvf98KHdW3L1g6SHguepxmHC4I=;
        b=p5LVQ3TEnTRYNmPKpnadQdZFsKHYPWkIY2dFEkDyF8WF49xK3oofEA7XhC6V2HptOl
         Ni9+4YxOHfZb9R4LrfHI4pDMDD0zi6xO8k3sBRkr/Y19IdWvp4dNEo5xvmTUa4KV5VGz
         GtK4aoXmz1T2RNTWY5b9Pfruw4JBXgKHdEC2LHHf3G9dWEzzj6yJT5+RCjOXSPhvX2hg
         75eHT/6Kg4CuhejIRx3BDVHpi/gHfkG1c+CQtx2BxkVxo4BvwUHp1mLHt2309gbBQz5G
         lxghux/bzwc5LPytImN5pBobLcET75fQp41iJn7+Pp0o/mv/kr1tthQlR2LJuFEtuHX0
         7FRA==
X-Gm-Message-State: AOAM530RRmztwlcw7fzadhSA774O9+mGBSEX4gpRc6mrMU43tIv8Nn61
        nIiRSA87yebDaQAHHihqrNofldB5Ra3Lm3KoxbujSoUXUOf2c+vX5dc7fzWty9+xsQiC4pM/j3N
        uQ4gS6cxPXF2GV+5GoSiIUI42
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr4790646wmc.76.1594384237877;
        Fri, 10 Jul 2020 05:30:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzbNAnnXH6Tgdh9fAHl3+mTp67fjfOO5gAZkjLUY9kIFZ1vDWW+jdm5mVm2TFELCOgrq+BQA==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr4790626wmc.76.1594384237666;
        Fri, 10 Jul 2020 05:30:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w16sm11968365wrg.95.2020.07.10.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 05:30:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] KVM: nSVM: implement nested_svm_load_cr3() and use it for host->guest switch
In-Reply-To: <353dc97c-9754-68f9-6fb7-13671995e0a2@redhat.com>
References: <20200709145358.1560330-1-vkuznets@redhat.com> <20200709145358.1560330-8-vkuznets@redhat.com> <4d3f5b01-72d9-c2c5-08e8-c2b1e0046e5e@redhat.com> <c7c65e0e-0c8f-106b-6249-ac706e702259@redhat.com> <87blknvbre.fsf@vitty.brq.redhat.com> <353dc97c-9754-68f9-6fb7-13671995e0a2@redhat.com>
Date:   Fri, 10 Jul 2020 14:30:36 +0200
Message-ID: <878sfrv9g3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/07/20 13:40, Vitaly Kuznetsov wrote:
>> Hm, it seems I missed svm_set_nested_state() path
>> completely. Surprisingly, state_test didn't fail)
>> 
>> I'm struggling a bit to understand why we don't have kvm_set_cr3() on
>> svm_set_nested_state() path: enter_svm_guest_mode() does it through
>> nested_prepare_vmcb_save() but it is skipped in svm_set_nested_state().
>> Don't we need it at least for !npt_enabled case?
>
> In svm_set_nested_state you'll have CR3 already set to the right value.
>  On the source, KVM_GET_SREGS returns the vmcb12's CR3 and it is already
> restored with KVM_SET_SREGS on the destination before set_nested_state.
>
> So, only the nested_cr3 has to be set.
>

Ah, thanks, so it seems there is no need to merge nested_svm_load_cr3()
(former kvm_set_cr3()) with nested_svm_init_mmu_context() in a new
nested_svm_init_mmu() as we'll only need the latter on
svm_set_nested_state(). We can just move nested_svm_load_cr3() out of
nested_prepare_vmcb_save() to enter_svm_guest_mode(). 

-- 
Vitaly

