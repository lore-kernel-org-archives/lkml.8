Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270BC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6DD20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB3tNJVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCXLH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:07:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57495 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgCXLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585048075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zG8RK9BOQ+DeO4IAkLRYrCB5fJrkacKNwyoRhJalGZg=;
        b=JB3tNJVlDSdYjf40mpAFJdnoOQHJ8tJhz2ySTPc8q9B/ZC11uwxh85T1vrRdjn89/aCyMK
        ETlI588xVaQlH0dvdMPzwyAVZxxiYji7RCyRDZgHp+0qutaoBd3estPi9I797r+sH0WZjf
        kgc3O4VNofa4Nzs2unuE/YEufTmE7/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-N7T2JRWNPLGwHQPvmm0tHA-1; Tue, 24 Mar 2020 07:07:53 -0400
X-MC-Unique: N7T2JRWNPLGwHQPvmm0tHA-1
Received: by mail-wm1-f72.google.com with SMTP id f185so1124535wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zG8RK9BOQ+DeO4IAkLRYrCB5fJrkacKNwyoRhJalGZg=;
        b=D/oGco5F41zk1QLKr8eWw4F/JG8pTTJeNV7aSnfx6l8Zf4O66znE4AI1uZ6rx7aJjI
         Gz06MyKxVIBpy006uLFhEfANekzNi9iIs94yATlREHyg6qpXXruZ+JETfqjC0jrmI0sp
         QJkIzuCLkpV7jmV3jiu28qIslvbyJVmJcSWrSk1RugEtGHhH5UKuOheHQJ1tsA+Mm/t7
         1If7fP0mckVtdFhgIp+7IuqKIrR+9LD/DW527tMBFi3N6d4FQM8+nU88xRe+Efeg8Kg3
         JSOEyZuVKgastXqTYZ8haUeUIYrcZ5/ZQ6HmuBjK9gSVnOKzvXGiaG7gebl8axBtEU7d
         2S0w==
X-Gm-Message-State: ANhLgQ2QB/Zp7brKusixHYl3znQKTJLshPRL0eMF6bCd2VI1bcd84+uR
        Z7mAsZn7ZE3wdPNhQtmXG32xrSvhoTxBZpDQenyStCj6TPy2X4+Ii0vGitunL71zUeo5tx2q7LT
        GJiA4awXpJwo9u8XIe27vgUpS
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr29634745wrw.262.1585048072740;
        Tue, 24 Mar 2020 04:07:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu/UT8MN6YxcWR3YXGd/k11KtMYJrljPCwBesOx54uQRTbpk4R6hZP/ktXslgwbAdbPtItyQg==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr29634705wrw.262.1585048072432;
        Tue, 24 Mar 2020 04:07:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id u5sm21502309wrp.81.2020.03.24.04.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:07:51 -0700 (PDT)
Subject: Re: [PATCH v3 31/37] KVM: x86/mmu: Add separate override for MMU sync
 during fast CR3 switch
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
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-32-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1227ad9e-0b91-f9a7-10b0-b02203ba52ca@redhat.com>
Date:   Tue, 24 Mar 2020 12:07:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320212833.3507-32-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 22:28, Sean Christopherson wrote:
> Add a separate "skip" override for MMU sync, a future change to avoid
> TLB flushes on nested VMX transitions may need to sync the MMU even if
> the TLB flush is unnecessary.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

I added a WARN_ON(skip_tlb_flush && !skip_mmu_sync); which could help
catching misordered parameters.

Paolo

