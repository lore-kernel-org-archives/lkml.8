Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EACC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4AE206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHcq/PiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgEERMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:12:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729857AbgEERMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588698764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWi1/ExgoalyHAzreZR6yoN0Ak47l5IuTf5AyOZQ3ik=;
        b=QHcq/PiD+PDu+gBWxIDjjIskQrsyMTZFjfbw7HDXMxW3Ykgq01cZLwJtPfsP+ymgwsMEt2
        f45JtdK4eQqd1ZZzsb3Tub+1Pm6ioj4KtpGt28J0Gi5vd6JDUDliJwnx34n5dkDhwgxDQs
        LPNUXrOmseRFmYhemYs+bLZBf1PfVuA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-OSCpGgu2OZiPz74f_76vsA-1; Tue, 05 May 2020 13:12:40 -0400
X-MC-Unique: OSCpGgu2OZiPz74f_76vsA-1
Received: by mail-wr1-f69.google.com with SMTP id p8so1544093wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWi1/ExgoalyHAzreZR6yoN0Ak47l5IuTf5AyOZQ3ik=;
        b=G6T8ZFfJak59rAPKL4trpZAidMBPAgV0g2IGAFcWJZHV33vv9YTWI6H/7UrrtS6MoY
         RfhWqg/mH0w0GJdjNSsUG6UoNHznZdDG74JR/Rb56EpNJAbmaRrERZmYmPBPBlmjPde8
         gglZpi6aYyRITuaQAyh4byzGfo+1l0quqaz4lFrPFoUDfjtgdak5WfaC3fj+JD9OLUTM
         R6RpAfzQx2cohmoFZcPTcRSljrSDXHrGBqiTJTMXvZCpcBLK7kZgr3SNehUTB1d3rMvd
         1NbqzgvZZIjEXksi43N9Oko4ffk47JEA+RhVaF49UdTtxsU8NXq07mY2lozWfxLHXKUX
         wJFA==
X-Gm-Message-State: AGi0PubVulhFMUnIKY3kH1MQgnGl+Hce4UfJ5h42fCcdDhxK1kIx119O
        Oa5hED518rVpqw9vNrDkd8Zr/FdvotOu6NKrSN4pOFTi0tLAEKAoK8ncS4T1EX4Gbgbcm1yMuEX
        13wdfXII41QZ2YdJuXRGd8ghL
X-Received: by 2002:adf:a297:: with SMTP id s23mr4902255wra.54.1588698759216;
        Tue, 05 May 2020 10:12:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+wioukX6WMwi3IK6WjkRtFHM+jyaRgxTXMYD/QERUdMXHggoBt0hb8YQ1Vh2W9SGOmrpABw==
X-Received: by 2002:adf:a297:: with SMTP id s23mr4902243wra.54.1588698759017;
        Tue, 05 May 2020 10:12:39 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id 5sm1798016wmz.16.2020.05.05.10.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:12:38 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200505154750.126300-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <127c6e28-2dea-8f28-7200-2185d0d49505@redhat.com>
Date:   Tue, 5 May 2020 19:12:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505154750.126300-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 17:47, Peter Xu wrote:
> KVM_CAP_SET_GUEST_DEBUG should be supported for x86 however it's not declared
> as supported.  My wild guess is that userspaces like QEMU are using "#ifdef
> KVM_CAP_SET_GUEST_DEBUG" to check for the capability instead, but that could be
> wrong because the compilation host may not be the runtime host.
> 
> The userspace might still want to keep the old "#ifdef" though to not break the
> guest debug on old kernels.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> I also think both ppc and s390 may need similar thing, but I didn't touch them
> yet because of not confident enough to cover all cases.

Indeed, I'll squash this:

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index e15166b0a16d..ad2f172c26a6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_PPC_GUEST_DEBUG_SSTEP:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5dcf9ff12828..d05bb040fd42 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -545,6 +545,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
 	case KVM_CAP_S390_VCPU_RESETS:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_S390_HPAGE_1M:

