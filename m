Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099FAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD63C2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QesSCW9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAUQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:14:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728904AbgAUQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579623248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqGKWE4vljjAcPx0vpPhn72zDnBvqdvK17Xs6yePlDY=;
        b=QesSCW9LAOUG9wOBSlOL30XGeFCwGoX2yrhb9l6eS+HzrbU2phsRRKANeDwyvzapLUmSR6
        fq6BXjA019FgGiXrR3VWp7gL3VaUPCsr+coyNrYzS1liPyrSLijqMUb7AZX7HlD1g4S9cg
        4FMSMd9j1an558A+sdhi7W2mliLmx+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-uPVloHShM7ORF9CbFbrLBw-1; Tue, 21 Jan 2020 11:14:05 -0500
X-MC-Unique: uPVloHShM7ORF9CbFbrLBw-1
Received: by mail-wr1-f70.google.com with SMTP id r2so1519363wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IqGKWE4vljjAcPx0vpPhn72zDnBvqdvK17Xs6yePlDY=;
        b=JoEEGTVp/ZiVyBZNfoVyzBMULGYa3OLU9+dSnrEMCPZuuyKIrR2/6G2MnJzc+t2SGm
         zAdQrXZvZrL0/ZF3ias7M7CTm62pAugmd3eWmnQg2TJVuIUZh9pfT9NyWHx9btLgRI98
         E2CZ6QAK7QtLyYE49TBndGrPdXzJIjQyJJ2z0Sx1RocS/nHs7mGIQ3DmbrDWgqmLLUWk
         TB+GhYBIwEkJNP1HV5wfxK05ZOEYDTNOqosGHeZ89XrM+JdzEE9YDV94jrDdbDkDUcRE
         l1TF4295KEUFMyBbF6L6tRYmd5RSMwO5/PFex0Rxr8bFrfgiTKs41Y//P4qj+7OkaGgN
         fZgA==
X-Gm-Message-State: APjAAAXm5rlogO32ux6wYlNCAzIa63aevsuQRoLVJ08fK7d7fyEAi1BV
        qn+zHzRL7r9zPdfQWlwY3eUm5/aZYYf2YUhtgw61Bt6BlnA6eycUdwYJnN7R4ujuEq+0suiH8jq
        v/ad2J2Bn1wDpBI/y1hF6+eB1
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr4971796wmm.24.1579623244197;
        Tue, 21 Jan 2020 08:14:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLcl/lYmcft/LqZTO4NiEq6Lyk5s/oCPqY3EBAJJlr/q/iZw7reeRokvq1TEUD+WfWoLmTWA==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr4971768wmm.24.1579623243901;
        Tue, 21 Jan 2020 08:14:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id t8sm53079354wrp.69.2020.01.21.08.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:14:03 -0800 (PST)
Subject: Re: [PATCH v3 09/21] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-10-peterx@redhat.com>
 <20200121155657.GA7923@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2f556fa-8562-f2d3-37a0-220af33732cd@redhat.com>
Date:   Tue, 21 Jan 2020 17:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200121155657.GA7923@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 16:56, Sean Christopherson wrote:
> This code also needs to be tested by doing unrestricted_guest=0 when
> loading kvm_intel, because it's obviously broken.

... as I had just found out after starting tests on kvm/queue.  Unqueued
this patch.

Paolo

> __x86_set_memory_region()
> takes an "unsigned long *", interpreted as a "pointer to a usersepace
> address", i.e. a "void __user **".  But the callers are treating the param
> as a "unsigned long in userpace", e.g. init_rmode_identity_map() declares
> uaddr as an "unsigned long *", when really it should be declaring a
> straight "unsigned long" and passing "&uaddr".  The only thing that saves
> KVM from dereferencing a bad pointer in __x86_set_memory_region() is that
> uaddr is initialized to NULL 

