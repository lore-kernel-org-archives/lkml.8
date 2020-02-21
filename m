Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83707C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AEC20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1VJsO2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBURON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:14:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727469AbgBUROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43kfDTCiVzkWMTtQLFuPZFiW+eHoPSitQf9eB3dJ7to=;
        b=X1VJsO2tnv/tUAxmR7UH4U27r5TIOgSTGmPN7qW8R3b9d1avEQTJAEIKkpK9jOUGvwoONv
        Fjff3lHQaPY3wTMtp5nWo1ZkWBLt4tG7ctw6eJu4iSRLq1T43x5LHOLyFoWff1CZbrQFcg
        qKQGldg4RJVkCL8NlrEHuOPmK5apPhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-j592UB-IMZS5-npAwwfjaQ-1; Fri, 21 Feb 2020 12:14:08 -0500
X-MC-Unique: j592UB-IMZS5-npAwwfjaQ-1
Received: by mail-wm1-f72.google.com with SMTP id y7so837285wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43kfDTCiVzkWMTtQLFuPZFiW+eHoPSitQf9eB3dJ7to=;
        b=DOc9TmXxnEfPfpCk/FLm13uorrUVtWLFywUkPJKeRbA2vTJimM0rt3tsmE4RvvL2dd
         DSsNsgfSF9hegPm01PmT9976gBQWA+GeEhVc2OlwNVlE44n7wks1aVwFzhpumgi6GsBH
         jAipzsEeWoIZkv7XDDzMrBPsiiL0STKQXmQVkK0XlttWTGVk33tL/AQamuNnwuo0ToqF
         Cv7Ems3mKOXhRW6WiN/sD2kKskbDwV9SKrkRN80GkuD9x7ks41Yc2UAhQU1CQNvEJSyC
         Nz+pSyUeB4erOmrqxMmhm4Irjunvj3QzP8k2cj+1QI0kZGieQXON6y7oHtd014f69K7F
         ELpg==
X-Gm-Message-State: APjAAAVsKIhsHRwTVr/FwtXgr76yEubNJV83kLwDXyY+24XyKVka6+y4
        FsogyiytqtQtLxwjsKl+pSc6NPJ8DPjuW5GEh1fROtv91nt3AN+4AYMvJsuzVYPf7iCEpDAePVz
        D/MCIqPON1FNZjEEPvzgpSVOz
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr5050279wmj.72.1582305246965;
        Fri, 21 Feb 2020 09:14:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqrTrGHNJy+4GBDeTRch/681B16eH9c4fXOpHFasnECSyy6jW57hTfGuNbgVq4rg8sjDeKQw==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr5050254wmj.72.1582305246694;
        Fri, 21 Feb 2020 09:14:06 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id x6sm4423401wmi.44.2020.02.21.09.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:14:06 -0800 (PST)
Subject: Re: [PATCH v2 3/3] KVM: x86: Move #PF retry tracking variables into
 emulation context
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218230310.29410-1-sean.j.christopherson@intel.com>
 <20200218230310.29410-4-sean.j.christopherson@intel.com>
 <40c8d560-1a5d-d592-5682-720980ca3dd9@redhat.com>
 <20200219151644.GB15888@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5626891-82f6-0a0c-401c-89a901a8455d@redhat.com>
Date:   Fri, 21 Feb 2020 18:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219151644.GB15888@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 16:16, Sean Christopherson wrote:
> The easy solution to that is to move retry_instruction() into emulate.c.
> That would also allow making x86_page_table_writing_insn() static.  All
> other functions invoked from retry_instruction() are exposed via kvm_host.h.

emulate.c is supposed to invoke no (or almost no) function outside the
ctxt->ops struct.  In particular, retry_instruction() invokes
kvm_mmu_gva_to_gpa_write and kvm_mmu_unprotect_page.

Paolo

