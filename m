Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94686C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8FA20836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIGxxnen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgCCRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:21:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51376 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729148AbgCCRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583256075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaOtamWYiIuWCFawzzm58ZC3ME+A1/wF1UexKFuk2I8=;
        b=SIGxxnenfeC+fID2nD0gwYMUqvRL6SFwXd49T8mHVdNaL6ZVjUODS867/DRgRoWcsrGKzy
        shi7vGRsfw/DQ53+zBQw7dBj/gNnahSEwpt2CGZykGf9mohqSMi04ZO692wAsuB1k9d1qR
        phscyDJKrtaYBAlg1EkLRb9+bKJdZ7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-g1HAjTieOjWxgwPKmqx7vA-1; Tue, 03 Mar 2020 12:21:13 -0500
X-MC-Unique: g1HAjTieOjWxgwPKmqx7vA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1510189wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaOtamWYiIuWCFawzzm58ZC3ME+A1/wF1UexKFuk2I8=;
        b=pCPaiWPqOBJgIiJGc1iCT921Jl9SJDYPt4dM80XvyfO9OHmQiO1jyI919FCjC1TAvW
         aApWYrJ4jOtiOdJrCcgNn6UR1P5JVkcvB1aQrK9vDM7z+y/nAWun9f6CE5I/4Dx0XtL8
         cYxcEZ2rHBItES9OkLWclBPDWWZJ+MzEXykC/X/oVSrFDyZVcO/cxDOMNKGuVu3DBomS
         DtMKSW1e+bbXbDgLX7ZtnqbFC+fexyLxA4Qb42mC683bDJfWCHrng2tsVRhFlUL1wRPd
         Uy8Fj3tLnbOGYJ692awDi+U1ZbLCYvBbtxTWzmx2Uz+83pFuhkOoyh5giEjrRyEtv/mb
         rYHQ==
X-Gm-Message-State: ANhLgQ0+XQdunuVAuuyk2oh+61YAKaTFzIfzNKVt5itnEfIyD0v/n7yz
        ygn94XL6p2yo8/ZTCd/i5P33AFB+EDhn9HCu9DYyAsbPbxlxdLcWBGreyAWaO5A2QRcq7Sz/l3t
        OArpFPKyXHkMtHsIhTogvqPCe
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2354703wma.164.1583256072710;
        Tue, 03 Mar 2020 09:21:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsthN0yjaliTomJLbLDve2Pd5f9/FT246y79qVZv8d+l722UQN2hFL5YW5TJVgnnYSW5Kqgyg==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2354680wma.164.1583256072516;
        Tue, 03 Mar 2020 09:21:12 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id j16sm34379932wru.68.2020.03.03.09.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 09:21:12 -0800 (PST)
Subject: Re: [PATCH 3/6] KVM: x86: Add dedicated emulator helper for grabbing
 CPUID.maxphyaddr
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302195736.24777-1-sean.j.christopherson@intel.com>
 <20200302195736.24777-4-sean.j.christopherson@intel.com>
 <de2ed4e9-409a-6cb1-e295-ea946be11e82@redhat.com>
 <20200303162808.GJ1439@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1b18b18-0bf5-7e7d-ffd9-be1a29609296@redhat.com>
Date:   Tue, 3 Mar 2020 18:21:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303162808.GJ1439@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 17:28, Sean Christopherson wrote:
>> I don't think this is a particularly useful change.  Yes, it's not
>> intuitive but is it more than a matter of documentation (and possibly
>> moving the check_cr_write snippet into a separate function)?
> 
> I really don't like duplicating the maxphyaddr logic.  I'm paranoid
> something will come along and change the "effective" maxphyaddr and we'll
> forget all about the emulator, e.g. SEV, TME and paravirt XO all dance
> around maxphyaddr.

Well, I'm paranoid about breaking everything else... :)

Adding a separate emulator_get_maxphyaddr function would at least
simplify grepping, since searching for 0x80000008 isn't exactly intuitive.

Paolo

