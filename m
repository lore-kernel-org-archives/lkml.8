Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E64C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D00F214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4mC+8Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgCCK01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:26:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728473AbgCCK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583231185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qg05cq73WzBGGAry/Xv5FvYaaU5AB/YsxHlJBvC5Ieo=;
        b=R4mC+8WdA6xZZ2GA6XRpNACKlT+38xyl2SCvELbCRVvDSafSve27Izc8BN/07QsfJP53AQ
        p7HAHt8q8H4jeCL+BXkl7kiKqIRP79CUzM0rs3Be7YoCD6F5McIM47ThS9WH7ZaYeIb/2/
        nKroAj8mZIQXLIRE13eFGiM9BGtTP/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-PPBmZvihN1ed1oEJUM2P9Q-1; Tue, 03 Mar 2020 05:26:23 -0500
X-MC-Unique: PPBmZvihN1ed1oEJUM2P9Q-1
Received: by mail-wr1-f72.google.com with SMTP id m18so995187wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qg05cq73WzBGGAry/Xv5FvYaaU5AB/YsxHlJBvC5Ieo=;
        b=fTYp63N2bveU1ecm3VBw3JcQ4uZ5212WZKO6iT/LVPUtn6aGKOWR5kLyhw6c6x7p+/
         cZD+3tT83pR9kHiK4I+FUOBVxdgndyR0W4QDCaLYXC4gKRL5uNtK7yO1PdXIY1JJHCrX
         L5WnqZpWItBis3iAGVQQXnHnEAZEgnWndDEBQBnQwy0Mm6fmWoV+NSNSR1NKNKK8Jb94
         IoGZ0bhsUzsUkrR3nWKpnDXM++qzqvsJVKDb5d/FnuvwgLCCb119RPqFv8flMr5GyMtP
         0NFUWMkcf0NLwvwvHmJ4n94XO5YJg3hTJPxSnrwyGrJBi89hB0Tn8ja7D5KCP4Hkot3s
         mIqg==
X-Gm-Message-State: ANhLgQ10I7ut75ALg2wXZ7tM0hGgkxUL8IaPtqZ7DQ/borUfLTjt7NCr
        Rap1lQbj44nx13G4BY3edc6g6bZ3K9BpXCVF08FtM8pU/ZpLOVNtjNN/PMIGiR+265pXjsyvgIc
        3+we4tFDedafIy7r+fPJMsINw
X-Received: by 2002:a7b:c010:: with SMTP id c16mr3653511wmb.148.1583231182069;
        Tue, 03 Mar 2020 02:26:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vttGcMcE2BIxjss8IG6DykhJvTycSZ+bjh9Lev0XveVbRwLE+LNmMMY2pIjdVyXsWaMa0kqxA==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr3653482wmb.148.1583231181802;
        Tue, 03 Mar 2020 02:26:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id l17sm32608641wro.77.2020.03.03.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:26:21 -0800 (PST)
Subject: Re: [PATCH v2 08/13] KVM: x86: Dynamically allocate per-vCPU
 emulation context
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
 <20200218232953.5724-9-sean.j.christopherson@intel.com>
 <87wo89i7e3.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83bd7c0c-ac3c-8ab5-091f-598324156d27@redhat.com>
Date:   Tue, 3 Mar 2020 11:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87wo89i7e3.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/20 18:29, Vitaly Kuznetsov wrote:
>>  struct x86_emulate_ctxt {
>> +	void *vcpu;
> Why 'void *'? I changed this to 'struct kvm_vcpu *' and it seems to
> compile just fine...
> 

I guess because it's really just an opaque pointer; using void* ensures
that the emulator doesn't break the emulator ops abstraction.

Paolo

