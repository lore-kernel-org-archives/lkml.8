Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9576C20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvQpnI9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgE0Q4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:56:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35022 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731059AbgE0Q4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590598567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soqL+aLJQ94mC33SIvSHCVdyIZoJ3dhQDwVCjjCxaQQ=;
        b=SvQpnI9tpwQ0tlRMgNaMn4WDuvMDDDoCbG//9qrBn+w2SflkJFa0yxzJR1jdVDmYx4FExc
        dZqd8GzJOiKKjsgAaGvbHkIPKYguJKtf1h74woHckMPaKzS+m/e0+XfpVCNRgPzq0Mjn30
        4U672neBbjgqlMLqnGIwIoZcdsNcGBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-tLFKjfxQO8yFzCxE_Yb0UQ-1; Wed, 27 May 2020 12:56:05 -0400
X-MC-Unique: tLFKjfxQO8yFzCxE_Yb0UQ-1
Received: by mail-wr1-f72.google.com with SMTP id n6so3706511wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=soqL+aLJQ94mC33SIvSHCVdyIZoJ3dhQDwVCjjCxaQQ=;
        b=DXV7WL3K5GOmfYyK0b72Ok2FYla/YH/ZvqRH+/9x48y0a4Y85s2/Zx2unCiKmrZUcK
         6ARXfG2f3aodbSJdL2QQCznCleG3c8ozd5qQTVKnE4lWcFGbLrLg/7Tz4MtWLS1eZah7
         pFVx4CtwBRPLaMENedjPj/56T8c4eJ5cIeo9L2UMLxVT8yFBRNDeA6VWeBimBjgzl8HG
         bCcl+2bZpMBIqqOfpT/JdvddK3hfVYW0hKgNnurfOTS8LChRfuM6nHtJBsO0taBYFCRh
         qScoDX52recJqXPuJFeHkmLTzU89+z16asemLb3C0qJIxqvXxhjMZcBjwdoxSNEbS3Op
         ngZg==
X-Gm-Message-State: AOAM5304X9M9EGl1koXTZ7IV3oG/rqYXbbBYnsS3NSAfLTBWyVNYoJLm
        SZ6BWH8xCTGFH20eRwY4WaKxJYIfgiByVwE3uxjPWJHQdBkcDouEluGXuad7RDjXkmnYrKh6MZg
        khtrIncyko9QdkPT1Iyn7NR4T
X-Received: by 2002:adf:82d0:: with SMTP id 74mr23661151wrc.138.1590598564716;
        Wed, 27 May 2020 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN1ltZI5oKhQFxqvF5DXCav71j97g6FqnxePCMKk31xs5VPQBfCIzOpFoJ7nuCJZDpjSSiNQ==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr23661135wrc.138.1590598564454;
        Wed, 27 May 2020 09:56:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id d5sm3351651wrb.14.2020.05.27.09.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:56:03 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
References: <20200527085400.23759-1-sean.j.christopherson@intel.com>
 <875zch66fy.fsf@vitty.brq.redhat.com>
 <c444fbcc-8ac3-2431-4cdb-2a37b93b1fa2@redhat.com>
 <20200527162318.GD24461@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2b9d767-df19-2974-8457-737b925749d3@redhat.com>
Date:   Wed, 27 May 2020 18:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527162318.GD24461@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 18:23, Sean Christopherson wrote:
> Hmm, one option would be to make .get_tdp_level() pure function by passing
> in vcpu->arch.maxphyaddr.  That should make the comment redundant.  I don't
> love bleeding VMX's implementation into the prototype, but that ship has
> kinda already sailed.

Well, it's not bleeding the implementation that much, guest MAXPHYADDR
is pretty much the only reason why it's a function and not a constant.

Another possibility BTW is to make the callback get_max_tdp_level and
make get_tdp_level a function in mmu.c.

Paolo

