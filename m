Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F51CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497F82075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfGomoAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEDN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:26:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727781AbgEDN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588598764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4pzL4umPonPhC4u7wWwTYbUYUN1KN4vROxppSrw3+E=;
        b=GfGomoAEzmJai5pcW33Kg6Eui8ItxkGKGLR0phL4rdc4i01HZ+8byUR4Z8n1IGPG3pr8qd
        Vxl0Br0DLGaTUFB6yXItrgRii1rbnBUEHQMgRiM1hNduWpHa4fcS/PsL0D3DKmAee1qgrT
        D2wuuTPwi80jo0w+c0nhg0uQcPC2tm4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-1F7IX3bIMz2-ICSq2I8sZw-1; Mon, 04 May 2020 09:26:01 -0400
X-MC-Unique: 1F7IX3bIMz2-ICSq2I8sZw-1
Received: by mail-wm1-f70.google.com with SMTP id q5so4857487wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i4pzL4umPonPhC4u7wWwTYbUYUN1KN4vROxppSrw3+E=;
        b=VLnB4ZfxmZn13yskW21vI9pcxZZ9Au40DcyfdCbkU17l13fLGGvLdN1pSRvaq7+d/q
         FQ98BdGdYQh3P/GLDSJaefa3zuZRUXg587o/RJB7H2hUnxxl94NHU2lJD/nyqnb1ZcRI
         +91QrD8fw3QfFcXXXCGPp++6QxUmA9fpgT18iOgWRxQ33zr6xI3rRH7irGdlkUXgsdEw
         2oDKyEaEtV18LU8Jq2gvM4XzfSTHX1ziMV8Ty335nZssl0A6fPENWiYUBE3/5CWNxApZ
         cytxTqteii81bcmiAWKqFOuD++DR4tTQkIGR9p/3cd2QrqvRiWtl/TO9FGppRiiOjaFi
         Cx9A==
X-Gm-Message-State: AGi0PuY6sQhgIzNCzX2S1piWgxOw9uBFytYV/TBt/lEZbqqWlxgyO2wA
        F6OV1jTDMcELlcMFzCAwYoQYvGNjLQSRDf4rEAenssuvfU9VkcXEiAbJH+Oz42UwWoyjOot2xmm
        cC2YpAgwrDjJRpSAfzNV37fj0
X-Received: by 2002:adf:b246:: with SMTP id y6mr19634359wra.205.1588598759722;
        Mon, 04 May 2020 06:25:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDk5TIWUOHalS5JGIMZEe9cIgedoGf1dImAxSG/0eN+CuQo328XZeIltJiaklS1Cr1myn0gg==
X-Received: by 2002:adf:b246:: with SMTP id y6mr19634338wra.205.1588598759507;
        Mon, 04 May 2020 06:25:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id l16sm18526002wrp.91.2020.05.04.06.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:25:59 -0700 (PDT)
Subject: Re: [PATCH 00/10] KVM: x86: Misc anti-retpoline optimizations
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200502043234.12481-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <76c2fc30-58e3-4d90-4b66-85b6fb4741b5@redhat.com>
Date:   Mon, 4 May 2020 15:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200502043234.12481-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 06:32, Sean Christopherson wrote:
> A smattering of optimizations geared toward avoiding retpolines, though
> IMO most of the patches are worthwhile changes irrespective of retpolines.
> I can split this up into separate patches if desired, outside of the
> obvious combos there are no dependencies.

Most of them are good stuff anyway, I agree.

Since I like to believe that static calls _are_ close, I queued these:

      KVM: x86: Save L1 TSC offset in 'struct kvm_vcpu_arch'
      KVM: nVMX: Unconditionally validate CR3 during nested transitions
      KVM: VMX: Add proper cache tracking for CR4
      KVM: VMX: Add proper cache tracking for CR0
      KVM: VMX: Move nested EPT out of kvm_x86_ops.get_tdp_level() hook
      KVM: x86/mmu: Capture TDP level when updating CPUID

and I don't disagree with the DR6 one though it can be even improved a
bit so I'll send a patch myself.

Paolo

