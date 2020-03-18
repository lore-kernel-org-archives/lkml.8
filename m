Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE784C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236320776
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FklvOzYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRRjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:39:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36056 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgCRRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584553143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ltahyOOW3gyw5hu5HKZgwII4enLzMRUQpOYTS+Rs5s=;
        b=FklvOzYNTibxE2f3qRFgl6lzhNdmIMG1/6tXEXjOVfcImOTElNrwxi/xaPxeoCqcg9AmWW
        i65SramMglYPHbUetvxm5SqE7NCNBglgd7xR5l4uBJGH2cfT22Ip3WuGBeXVzheqXZPdwk
        4TyoKobv8qZyAk+UNpbEmr76pwEKhwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-7Yh2A9MDPK-8RXclp1KZ-A-1; Wed, 18 Mar 2020 13:39:01 -0400
X-MC-Unique: 7Yh2A9MDPK-8RXclp1KZ-A-1
Received: by mail-wr1-f69.google.com with SMTP id i18so1619566wrx.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ltahyOOW3gyw5hu5HKZgwII4enLzMRUQpOYTS+Rs5s=;
        b=Hfeb+GmZg6GzmfsrCRaoc5H8Ti0pDI67qohVbYuz92bkLTqdfAoChiFOaWUEJgpRoe
         ZCmtDwWqRQaCEb9jQV4bu6lN9lLVm15DjM9nPmdNiM1nzBMuYmBL87Zt+9Yd0JJWpe8B
         qcyCdQiUPMnZ382W/xlfym37CoWn8KV3SGjCSjtHOCiW0/sOOZXTdQbnCIleL/WvLoGc
         BGYuZAS5OjsxAq1zCVdRklBK+9U4uS+3kIJ58IL02NKRJGqInTcAe1Mmh/fY9fI2gUEU
         cur0Mzo98dekwO3JNfJeV0HdiuzW1fjKDmeIuRKNg7t4gEg0lGSXFGJGTe1Ze7XJ6Pri
         YorQ==
X-Gm-Message-State: ANhLgQ3KqhVViQnSP+DsLGKx+zaaEwEP8sGA4LubDQmKYsUc3s3HUCgK
        S3iKM0hzG6xnIgh4fbJ9qVvGU7i483G4bJ/G6PNL1BaRyV+bw39fhyW5NVamq7q/icx+c7oyCEL
        Ao0myC3g4Q8QeJp6MTcKwJqGs
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr6260263wmj.119.1584553140438;
        Wed, 18 Mar 2020 10:39:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuYkHCYYMA4Xp4XlBoTwsVoafCfvFQAPbXylg2R+kbEgu+F7kEaGahXtLtVFBCfm2S5tlQlBQ==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr6260237wmj.119.1584553140189;
        Wed, 18 Mar 2020 10:39:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id r3sm3775498wrm.35.2020.03.18.10.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 10:38:59 -0700 (PDT)
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
 <3c3a4d9b-b213-dfc0-2857-a975e9c20770@redhat.com>
 <20200318172614.GK24357@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7661081d-6276-6176-dbbb-700aeec656b8@redhat.com>
Date:   Wed, 18 Mar 2020 18:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318172614.GK24357@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/20 18:26, Sean Christopherson wrote:
>>>
>>> 	if (!nested_ept)
>>> 		kvm_mmu_new_cr3(vcpu, cr3, enable_ept ||
>>> 					   nested_cpu_has_vpid(vmcs12));
>>
>> ... which is exactly nested_has_guest_tlb_tag(vcpu).  Well, not exactly
>> but it's a bug in your code above. :)
>
> I don't think it's a bug, it's intentionally different.  When enable_ept=0,
> nested_has_guest_tlb_tag() returns true if and only if L1 has enabled VPID
> for L2 *and* L2 has been assigned a unique VPID by L0.
> 
> For sync purposes, whether or not L2 has been assigned a unique VPID is
> irrelevant.  L0 needs to invalidate TLB entries to prevent resuing L1's
> entries (assuming L1 has been assigned a VPID), but L0 doesn't need to sync
> SPTEs because L2 doesn't expect them to be refreshed.
                ^^
                L1

Yes you're right.  So I would say keep your code, but we can simplify
the comment.  Something like:

/*
 * We can skip the TLB flush if we have EPT enabled (because...)  and
 * also if L1 is using VPID, because then it doesn't expect SPTEs for L2
 * to be refreshed.
 *
 * This is almost the same as nested_has_guest_tlb_tag(vcpu), but here
 * we don't care if L2 has been assigned a unique VPID; L1 doesn't know,
 * and will nevertheless do INVVPID to avoid reuse of stale page
 * table entries.
 */

Nevertheless it's scary in that this is a potential attack vector for
reusing stale L0 SPTEs, so we should make sure it's all properly commented.

Thanks,

Paolo

>> It completely makes sense to use that as the third argument, and while a
>> comment is still needed it will be much smaller.
> Ya, agreed.
> 

