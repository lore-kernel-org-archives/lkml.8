Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15512C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71C3208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfKExKuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGCRSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:18:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbgGCRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593796733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57ADnzVAbVVoV5vDvCiR8mlqpzPRDbDePMMdottcLdM=;
        b=hfKExKuRkw53+IwGTwgYgkAZlKm9k9XTejzMNt7xwgmxu6uIFcDGpEJabWUOof2ACvZYFW
        P45nH9ZVvQkF8EzPzQA3rNPBoZvmEsxBeVYVma+v1Bgr36/Wdb0KRFZLuY8YhQoHTLOf4t
        ARzlp5NAs9CzTJqAejBg6Us30KjWIuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-_B84wZ2TMD-LvggRgsEGdQ-1; Fri, 03 Jul 2020 13:18:52 -0400
X-MC-Unique: _B84wZ2TMD-LvggRgsEGdQ-1
Received: by mail-wr1-f69.google.com with SMTP id y18so12700878wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57ADnzVAbVVoV5vDvCiR8mlqpzPRDbDePMMdottcLdM=;
        b=NejcIoBUf+1iZJSWRy5kQLBrtFIhojy23Z/BXLzGHzTi3FOGdUIkH5XN0gPMVl8FLq
         xwZ2knalxKuGjLMvTMV9Apsp51s58/HlssP1r9IW2NrZcx93qsT8UDM+xa63WEIks9OA
         XbVp1bPows075PDbUNULmMBrQzm12zZArhRWFTHrpmNWNXErBO4ilA8wZgELWnhlN1+D
         jZriqclMyR6mE+DGIZYNeLA3qZA/SrMVIV/EkSbyGBNUGr+sJr7uskPHujLNZeFmURVq
         eE92O1EyDqqcM7lQEO7gSfQxo4X/nWzSwnd+mqLj/l0OJZWq7jRDt6LuRFIC3kiVjMdL
         oo1g==
X-Gm-Message-State: AOAM531FC+VAfijQBdVuLN0d+202kLFU1CPR2DqbNfmewncoleca5bAs
        GMS6ow34YYsWeq/YFoesugISdeqL7eBOzgSz44k6X8U+a1AD4W5B6HNpRPSnEEKZX03o0qxnVrL
        GF1q3Q7j/ERRSZ+DWJpShP8Tw
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr35347159wmi.99.1593796730862;
        Fri, 03 Jul 2020 10:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhCKjk/eB11x9WII67hiKoo0a0P0k+xr0qSCy3xWH1aodP1M6TmycDnTtBzvwNbLNMmblgGw==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr35347140wmi.99.1593796730670;
        Fri, 03 Jul 2020 10:18:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc? ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
        by smtp.gmail.com with ESMTPSA id l8sm14606024wrq.15.2020.07.03.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 10:18:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: Zapping and recycling cleanups
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623193542.7554-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59e690be-b0a6-4beb-fd7c-633186b96ece@redhat.com>
Date:   Fri, 3 Jul 2020 19:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623193542.7554-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 21:35, Sean Christopherson wrote:
> Semi-random, but related, changes that deal with the handling of active
> root shadow pages during zapping and the zapping of arbitary/old pages.
> 
> Patch 1 changes the low level handling to keep zapped active roots off the
> active page list.  KVM already relies on the vCPU to explicitly free the
> root, putting invalid root pages back on the list is just a quirk of the
> implementation.
> 
> Patches 2 reworks the MMU page recycling to batch zap pages instead of
> zapping them one at a time.  This provides better handling for active root
> pages and also avoids multiple remote TLB flushes.
> 
> Patch 3 applies the batch zapping to the .shrink_scan() path.  This is a
> significant change in behavior, i.e. is the scariest of the changes, but
> unless I'm missing something it provides the intended functionality that
> has been lacking since shrinker support was first added.
> 
> Patch 4 changes the page fault handlers to return an error to userspace
> instead of restarting the guest if there are no MMU pages available.  This
> is dependent on patch 2 as theoretically the old recycling flow could
> prematurely bail if it encountered an active root.
> 
> v2:
>   - Add a comment for the list shenanigans in patch 1. [Paolo]
>   - Add patches 2-4.
>   - Rebased to kvm/queue, commit a037ff353ba6 ("Merge branch ...")
> 
> Sean Christopherson (4):
>   KVM: x86/mmu: Don't put invalid SPs back on the list of active pages
>   KVM: x86/mmu: Batch zap MMU pages when recycling oldest pages
>   KVM: x86/mmu: Batch zap MMU pages when shrinking the slab
>   KVM: x86/mmu: Exit to userspace on make_mmu_pages_available() error
> 
>  arch/x86/kvm/mmu/mmu.c         | 94 +++++++++++++++++++++-------------
>  arch/x86/kvm/mmu/paging_tmpl.h |  3 +-
>  2 files changed, 61 insertions(+), 36 deletions(-)
> 

Queued, thanks.

Paolo

