Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E141C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5C22071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvXbUDKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCRRLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:11:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31697 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584551494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzqv9I5Sh/5ugsjV1X2H8uxVVaA/U2JrzTHi1Jlr7RM=;
        b=XvXbUDKc51v2LavXQLKC5ekDS5+QKhwvgzY6vxxUrZLKXhY5y1pcG8+VHwGqfON02S3WBn
        LDhaO7GE7l0iEn4UDFDD5ga8XrkJr1vATvIlOAbSU0sY/JuDOW+rm1d4h9PCeLDaKr0SDT
        Z+Fjp2LORzd++JUuUVMgQ+SxfztiYn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-DY50MLRHN1qzGW8jSI0S0w-1; Wed, 18 Mar 2020 13:11:33 -0400
X-MC-Unique: DY50MLRHN1qzGW8jSI0S0w-1
Received: by mail-wm1-f72.google.com with SMTP id f9so1324193wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vzqv9I5Sh/5ugsjV1X2H8uxVVaA/U2JrzTHi1Jlr7RM=;
        b=ren7SXlC1Fm2w8xCwMXbpQcmu71ekRXjLj7n2n3FtmB0CI8Ec2plY1Hyvbux+8Vct4
         mf0KGPwROuVHtbBU6tCbxRIJkqg3CmiROpVIw9l+4ILrD/OEum6MdeFH4H5UcjM1Ov8O
         BnSU1i0BLyJXs10oOZfpk57o4pfKk4xeOXYzkRXvfBSn7cPtsqjkEr7dr2VDGhh9bXGD
         FvTcH4wiINbqzJ2cAguT3vE5LZTaOdEmVAQPSr+doBlKKEBiBhK9hjF+72Wh9Z7jrpxP
         Suv0mmIrg0Dmvj8889jDhDpBcbpeKxNgEFkF5MLk6aGCl11LxdB7SJIW0aUJvkQgwEKI
         MGJQ==
X-Gm-Message-State: ANhLgQ1Caoux58Y7iCsvcTtaLESzhbEzym0fDXhNWPfXGEEYflAIEZma
        vPlAZDM3X+OBWi9rKh7SBb/lyMxUtw+gH9XP5PGGHAe4sxhrP/Dj1bqbtQ6LHIvQbmWMPTsAPpP
        D7EEtW3ts4pCpPYoTXbu6I1A0
X-Received: by 2002:adf:a54a:: with SMTP id j10mr6885892wrb.188.1584551492179;
        Wed, 18 Mar 2020 10:11:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt9u608gYRp7tO/knBR6K2ZgiFKLlyGeKIepNlMrVma8HthryXIRHihp1d398V+IzLI8vt48w==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr6885860wrb.188.1584551491921;
        Wed, 18 Mar 2020 10:11:31 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id l18sm10187921wrr.17.2020.03.18.10.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 10:11:31 -0700 (PDT)
Subject: Re: [PATCH v2 31/32] KVM: nVMX: Don't flush TLB on nested VM
 transition with EPT enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200317045238.30434-1-sean.j.christopherson@intel.com>
 <20200317045238.30434-32-sean.j.christopherson@intel.com>
 <97f91b27-65ac-9187-6b60-184e1562d228@redhat.com>
 <20200317182251.GD12959@linux.intel.com>
 <218d4dbd-20f1-5bf8-ca44-c53dd9345dab@redhat.com>
 <20200318170241.GJ24357@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c3a4d9b-b213-dfc0-2857-a975e9c20770@redhat.com>
Date:   Wed, 18 Mar 2020 18:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318170241.GJ24357@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/20 18:02, Sean Christopherson wrote:
> So something like this?
> 
> 	if (!nested_ept)
> 		kvm_mmu_new_cr3(vcpu, cr3, enable_ept ||
> 					   nested_cpu_has_vpid(vmcs12));

... which is exactly nested_has_guest_tlb_tag(vcpu).  Well, not exactly
but it's a bug in your code above. :)

It completely makes sense to use that as the third argument, and while a
comment is still needed it will be much smaller.

Paolo

