Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4946206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHZ1uM6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgFRLKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:10:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729168AbgFRLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592478531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1NwggmtPlp9uQFfGPrVl4ulrDOEZX3SrXMA/mcsYFo=;
        b=BHZ1uM6+UpZCAbFlgI75K7hNNJCk8PddLWijPBym6dNLJR0FgMgDbGhiGwnveShv3ojOM8
        DG4Z6WSsU+GyrQLqDfd64KwlNeslvkEPWhPD0sqARHWdEsoa1No2mZVI9lGzH6p+syF6yU
        2p7RU5jdRsX6uQT9AK7emV8kKVazATg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-HBANn_1NMzmPGjChqilvig-1; Thu, 18 Jun 2020 07:08:50 -0400
X-MC-Unique: HBANn_1NMzmPGjChqilvig-1
Received: by mail-ej1-f69.google.com with SMTP id b24so2407788ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J1NwggmtPlp9uQFfGPrVl4ulrDOEZX3SrXMA/mcsYFo=;
        b=R5FI0GbtIQOI2PWDtk4We8VBXAnuegOFX/eZaWVBh3zcX7CKYODfiJg8Tfapy5lg3A
         J+kcmnbC9tDzz9wXxeIBC7nk2ufJWkxmBdNHfSatviSDe4YZqUDx9aywi+ha9ogRJ5ih
         XgrbqCuRC9bB2/f/DfVTMImUFnmR2VKJ4uHR2NrFgBQeg9FMapt8DvhC8YXUtquQb/7Z
         E0JMdtk/FL7EMZSDVY1y34Jj3BTsGpcDugB2ghh/K0h302y2J8SvNqjrYcoL/Wt6UGlh
         +VvkpTSkYAjsZx4MrOByjTFprHSBn4EKsh/UKSKxGbWZwBuX8Aj8ZJPZFG4jXET/TPyv
         Zr6Q==
X-Gm-Message-State: AOAM531ilVCMDUlwlzLwhGCDA0ra1hV76mg1zgzbQX9cICXTT4sYwJmE
        LI4AFGHc/nL1GO+xtWfORmFGtOWvIS3aFzP1wlSjO1y8GOJgcBCKEKyozkdWQGF/Obw9lLtPyVN
        ircyGOY11BK/wlgSJ++0bT06O
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr3616390ejc.249.1592478528896;
        Thu, 18 Jun 2020 04:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAB/LLMky0F0neyQ9UeNJROmlJCPgomnAgnL34Rt8rpIkHiStd0Bd+cZYMJXhj0HIX7IVdfQ==
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr3616372ejc.249.1592478528676;
        Thu, 18 Jun 2020 04:08:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bs1sm1878005edb.43.2020.06.18.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 04:08:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
In-Reply-To: <36ebc576-52c0-4164-1c83-e31146806b6b@redhat.com>
References: <20200616161427.375651-1-vkuznets@redhat.com> <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com> <87366vhscx.fsf@vitty.brq.redhat.com> <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com> <87wo45hqhy.fsf@vitty.brq.redhat.com> <36ebc576-52c0-4164-1c83-e31146806b6b@redhat.com>
Date:   Thu, 18 Jun 2020 13:08:46 +0200
Message-ID: <87imfohbr5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/06/20 13:38, Vitaly Kuznetsov wrote:
>> 
>> For KVM_GET_MSR_INDEX_LIST, the promise is "guest msrs that are
>> supported" and I'm not exactly sure what this means. Personally, I see
>> no point in returning MSRs which can't be read with KVM_GET_MSRS (as
>> this also means the guest can't read them) and KVM selftests seem to
>> rely on that (vcpu_save_state()) but this is not a documented feature.
>
> Yes, this is intended.  KVM_GET_MSR_INDEX_LIST is not the full list of
> supported MSRs or KVM_GET_MSRS (especially PMU MSRs are missing) but it
> certainly should be a sufficient condition for KVM_GET_MSRS support.
>
> In this case your patch is sort-of correct because AMD machines won't
> have X86_FEATURE_PDCM.  However, even in that case there are two things
> we can do that are better:
>
> 1) force-set X86_FEATURE_PDCM in vmx_set_cpu_caps instead of having it
> in kvm_set_cpu_caps.  The latter is incorrect because if AMD for
> whatever reason added it we'd lack the support.  This would be basically
> a refined version of your patch.
>
> 2) emulate the MSR on AMD too (returning zero) if somebody for whatever
> reason enables PDCM in there too: this would include returning it in
> KVM_GET_FEATURE_MSR_INDEX_LIST, and using kvm_get_msr_feature to set a
> default value in kvm_pmu_refresh.  The feature bit then would be
> force-set in kvm_set_cpu_caps.  This would be nicer since we have the
> value in vcpu->arch already instead of struct vcpu_vmx.

Let's try the hard way :-) I'll send v2 implementing 2) (hope I got the
idea right), thanks!

-- 
Vitaly

