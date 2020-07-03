Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85189C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6C020B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bs8UUSDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgGCRR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:17:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbgGCRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593796647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/DSLHDlC0xBmwzi7MVtunbOyv24TPlCbFazyTFY/v4=;
        b=bs8UUSDYU1KuWmXeiUxMBnURTweH+Q+qISNFWX0HH3AAHs8M+nyNa6krm4/JBk0EkjiGht
        JQ6zddAk/NtWKbEUNjxQNji72LEwRc82i1xymynzWMXc6iCBLfw1ggN46EkBaAz2ND/qSH
        zIJL9MdbuUtTUbOhSNdHK3ppqtXewkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-gni1M5HENf-VqxpxKWoerQ-1; Fri, 03 Jul 2020 13:17:26 -0400
X-MC-Unique: gni1M5HENf-VqxpxKWoerQ-1
Received: by mail-wm1-f72.google.com with SMTP id g187so35755410wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/DSLHDlC0xBmwzi7MVtunbOyv24TPlCbFazyTFY/v4=;
        b=cQMKYOJI+Ckuj80zXcxrcBGIwBFWL070jkC57lWYYYXNQuB+gEdTr1tKztpF954KDK
         jmiZhvVaj6yIF69jN8WJlZRja8UtLmIeLbcv5cVjkWb7z/77EwDE5BkilcdXe7cl9EPU
         WmrVQcX46wyT9WSSQC6apsHROYWSFykgNWKzwsgDZjtinfU4XU8c+WYjsYdSEqvTOhZ/
         KVUdXJabGZo4s9ucUbL5FsXH1JmJNkPWbxxurQWd7suLhn8C5dMFwEXQLFtvsD6NakiO
         AIeabQWgCzfGMZozvJz6kAaQl38UaxaTRgavqLzuRIzbxoKhqlm80yaxv+mSamWZAfjK
         oOHw==
X-Gm-Message-State: AOAM530gPJbQbtRQDtzAWP64y1v2wvziFLyNvoEc2Jtwxdjn60z/WUe9
        UEi2Q3MC2cclRiUYpk9TXshDaa7Bdg+5jq9VDkQdVQgmgpU9+NDXJ6Oq0XzZHomDgYKBbC3AG2S
        fqFYV7jgSDzU5myBeKY7nF955
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr26793167wrx.235.1593796644904;
        Fri, 03 Jul 2020 10:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDlvTnY9QVK/gWukbPZBkYBlSyQACwuEDTYux+eC9el9JhN/4lUqd65pH2NTh/iNNAZNsfOg==
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr26793152wrx.235.1593796644645;
        Fri, 03 Jul 2020 10:17:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc? ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
        by smtp.gmail.com with ESMTPSA id q188sm14195363wma.46.2020.07.03.10.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 10:17:24 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Optimizations for kvm_get_mmu_page()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        Jon Cargille <jcargill@google.com>
References: <20200623194027.23135-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a602e91-91ef-fed6-3d5f-bad46c8d7554@redhat.com>
Date:   Fri, 3 Jul 2020 19:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623194027.23135-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 21:40, Sean Christopherson wrote:
> Avoid multiple hash lookups in kvm_get_mmu_page(), and tweak the cache
> loop to optimize it for TDP.
> 
> Sean Christopherson (2):
>   KVM: x86/mmu: Avoid multiple hash lookups in kvm_get_mmu_page()
>   KVM: x86/mmu: Optimize MMU page cache lookup for fully direct MMUs
> 
>  arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 

Queued, thanks.

Paolo

