Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44069C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172472077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1fOzmGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCYNtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:49:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20511 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbgCYNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585144156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XKqpnolU/KR2I/RWhEGaIN7Kx+pdRatBZCvszDiNWM=;
        b=T1fOzmGZagxtSut9jnHG2MORHhkrqffLGqUrhHn83x54PjCyQXy5HFLey9JAJUhDLYwLIm
        uDK3ome9lHIMFAj0ZSaf/pg5V35uVybYfx5SV0iPI+IVvxQZn/2qWY1B/1CQCPvNEbIRvx
        4eXUPPXjbmW+z8xt5P3qMV7QNW5IbZc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Q2nmjGNqP-mkh_vC_gm8cw-1; Wed, 25 Mar 2020 09:49:15 -0400
X-MC-Unique: Q2nmjGNqP-mkh_vC_gm8cw-1
Received: by mail-wm1-f70.google.com with SMTP id m4so908386wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XKqpnolU/KR2I/RWhEGaIN7Kx+pdRatBZCvszDiNWM=;
        b=do4R1eOZIf4kGLEcNulSmRDLOUP44pkmZrSFDrrVdvYMaJmBvnah2Rn+k6xbD4kV3I
         cAjcnB6aGBvgUxTjj4h84jus2l7ptSj1Kjzfor06dVE7IeLI7vVSDo0P1nE64T/VkCI8
         dPi+bM4XsEEOY6l1kdnJMFRQksKaFjoiQK0S4tXC1FJgeLpLNCEnW/TVvT5Cf+Y0o8Nt
         5zmB/w8ox5S+ncfVXQ50QNc7uBJsEX6DI2plST+UI7bnsG44F4FAL/9Z+pDDMQk0xFGS
         9wuSZUmvd18vNpMCARpSuyKT1rwd0rzCEOPVUJxXNOwN26j8jcf+I/ZjVGhnPf+b+HR6
         AI4A==
X-Gm-Message-State: ANhLgQ2ZJ0GhEbFFhRVNUQ+NWgB7zdyTlizFtZ/qxrsLkYdjb0ylfent
        Qoubuxk/oTr/Vzb1od8h/ncSZN5htcaeeGNlkfPs/vudbVnR096osxQKVkKWfeb1vgMtAM9E7wR
        DpeP2c2qMmZkrocnzAmeElerq
X-Received: by 2002:adf:8164:: with SMTP id 91mr3460117wrm.422.1585144153347;
        Wed, 25 Mar 2020 06:49:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsQq/lfd8vaywx8tmefsAzvzmuafH1vh5G2EJD2YvUKpOXtVzioBqPoAkz7VNtBoxGEKOqk1w==
X-Received: by 2002:adf:8164:: with SMTP id 91mr3460088wrm.422.1585144153125;
        Wed, 25 Mar 2020 06:49:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id f10sm33855014wrw.96.2020.03.25.06.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 06:49:12 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: SVM: Move and split up svm.c
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200324094154.32352-1-joro@8bytes.org>
 <20200324183007.GA7798@linux.intel.com>
 <CALMp9eRYNH+=Ra=1KSJdT5Ej5kTfdV8J7Rf6JcS9NGbPOYPj8A@mail.gmail.com>
 <20200324185545.GB7798@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4599cea7-8be6-f172-976d-4155ff449b35@redhat.com>
Date:   Wed, 25 Mar 2020 14:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324185545.GB7798@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/20 19:55, Sean Christopherson wrote:
>> here is a patch-set agains kvm/queue which moves svm.c into its own
>> subdirectory arch/x86/kvm/svm/ and splits moves parts of it into
>> separate source files:
> What are people's thoughts on using "arch/x86/kvm/{amd,intel}" instead of
> "arch/x86/kvm/{svm,vmx}"?  Maybe this won't be an issue for AMD/SVM, but on
> the Intel/VMX side, there is stuff in the pipeline that makes using "vmx"
> for the sub-directory quite awkward.  I wasn't planning on proposing the
> rename (from vmx->intel) until I could justify _why_, but perhaps it makes
> sense to bundle all the pain of a reorganizing code into a single kernel
> version?

For now I would keep it svm and vmx.  I would expect that other Intel
three-letter acronyms would still use most of the vmx concepts (e.g.
VMCS) not unlike Hyper-V's eVMCS, so the existing directory name makes
sense (possibly with vmx.c split further to something like vmx-common.c
or intel-common.c).

Paolo

