Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E17C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ED52070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF3O1dS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCXLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:30:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53135 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbgCXLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585049444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUoI3izHtkIzFR5QtYPD1Igvkj0MnI7ELPqcHmKkEcc=;
        b=YF3O1dS3DWY2Ci+o5+uKmAisijF+lxRc7BVlipwKeEmEQbSxOLlhR2BLyUY6Xsj2yoOV8t
        JDp87xgQGTKqXasgFDu0vBq5BPlvGWD6v5lyTqjl41x34m6VCYDJTZxRz1PgBCsTaZrLon
        0IrwIlE5qKRihKaUk3fboY/frxtFQwA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-HeG86xQLN8aCNQkFWopfug-1; Tue, 24 Mar 2020 07:30:42 -0400
X-MC-Unique: HeG86xQLN8aCNQkFWopfug-1
Received: by mail-wr1-f71.google.com with SMTP id f8so1422760wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HUoI3izHtkIzFR5QtYPD1Igvkj0MnI7ELPqcHmKkEcc=;
        b=lRbxlawd6WVeXnoqQ25+gvhf8IJpmm+ryr3u8ov6X/Io+/im3H42jK4bs+ehs5oY9r
         QjFxPGJ94mkNi6PzVGTh6oAqq0s8BckBZFTLaVmEQwsogJ/ra9e7sehP9R7n2/6YqeYN
         eYZcC+l0HrRAnYWGka/me6cv5P2mBURDzSC5PMT0Ua7ZKmu3VOpgiukgFbd6N16eDTM0
         SyaGDZRiz4I19IyRnL/3h1kj/VivwY8enZifgX/mal5aeqq19nmwMnR9av36zqd21+zJ
         IH3WjOw4MOxEJV9fZy7X4ql2rGmPGYI/IPG8OyPy6mFFxaZh44vHdCkbvc41j6hnDSKa
         0PJQ==
X-Gm-Message-State: ANhLgQ3sDrik3UXU/XhK0GNe6Z919DZ7s/gWo8MpFZgLeo7Ljy9v2/m+
        FiJ6U0ytYhemhAZgahzTxvZ6217vpjOq31RbYDN/dcpcYDAD8TtcEmR83Bc26axbQaMGnCg1NJQ
        ALqZZS6ZljbxvUqWmsWWHcOGA
X-Received: by 2002:adf:ab12:: with SMTP id q18mr37220831wrc.148.1585049441332;
        Tue, 24 Mar 2020 04:30:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUjSBUhhUbkbFZ5FgkCOpcr55gKEKWk7dXYHSUq5RRMQjE2NU1Uym3jModjIYPajJh5t5cXA==
X-Received: by 2002:adf:ab12:: with SMTP id q18mr37220804wrc.148.1585049440995;
        Tue, 24 Mar 2020 04:30:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id o67sm3965202wmo.5.2020.03.24.04.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:30:40 -0700 (PDT)
Subject: Re: [PATCH 0/7] KVM: Fix memslot use-after-free bug
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Peter Xu <peterx@redhat.com>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa19166a-a4bd-28c2-88a0-ab5b18e8f473@redhat.com>
Date:   Tue, 24 Mar 2020 12:30:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320205546.2396-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 21:55, Sean Christopherson wrote:
> Fix a bug introduced by dynamic memslot allocation where the LRU slot can
> become invalid and lead to a out-of-bounds/use-after-free scenario.
> 
> The patch is different that what Qian has already tested, but I was able
> to reproduce the bad behavior by enhancing the set memory region selftest,
> i.e. I'm relatively confident the bug is fixed.
> 
> Patches 2-6 are a variety of selftest cleanup, with the aforementioned
> set memory region enhancement coming in patch 7.
> 
> Note, I couldn't get the selftest to fail outright or with KASAN, but was
> able to hit a WARN_ON an invalid slot 100% of the time (without the fix,
> obviously).
> 
> Regarding s390, I played around a bit with merging gfn_to_memslot_approx()
> into search_memslots().  Code wise it's trivial since they're basically
> identical, but doing so increases the code footprint of search_memslots()
> on x86 by 30 bytes, so I ended up abandoning the effort.
> 
> Sean Christopherson (7):
>   KVM: Fix out of range accesses to memslots
>   KVM: selftests: Fix cosmetic copy-paste error in vm_mem_region_move()
>   KVM: selftests: Take vcpu pointer instead of id in vm_vcpu_rm()
>   KVM: selftests: Add helpers to consolidate open coded list operations
>   KVM: selftests: Add util to delete memory region
>   KVM: selftests: Expose the primary memslot number to tests
>   KVM: selftests: Add "delete" testcase to set_memory_region_test
> 
>  arch/s390/kvm/kvm-s390.c                      |   3 +
>  include/linux/kvm_host.h                      |   3 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 139 ++++++++++--------
>  .../kvm/x86_64/set_memory_region_test.c       | 122 +++++++++++++--
>  virt/kvm/kvm_main.c                           |   3 +
>  6 files changed, 201 insertions(+), 72 deletions(-)
> 

Queued patches 1-3, thanks.

Paolo

