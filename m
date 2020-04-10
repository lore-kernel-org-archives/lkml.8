Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2527C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5120B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBAJGI1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJKYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:24:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgDJKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586514239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNMtqQDhqXxgBm2d6PtXUW4lIuPYaCAoH3YfelJDW6U=;
        b=QBAJGI1re6ltGL6uHg/jevWvpY2eCAigXEVtzOPx/smHg2AASykUJ3opGOQn+uI7p2egNJ
        g5bpNq5RxswlO8EKg13I5QvLwQE98PEot0A7LBSWxaQjPfcxNx6lHqsLJJWG2iNsjH9zE7
        pHOA2Gaxci+rWlGWwTaiB7/p0JPXaz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-MtU39AY3MO69UQb7TJ_y3Q-1; Fri, 10 Apr 2020 06:23:57 -0400
X-MC-Unique: MtU39AY3MO69UQb7TJ_y3Q-1
Received: by mail-wr1-f71.google.com with SMTP id n7so924048wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 03:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNMtqQDhqXxgBm2d6PtXUW4lIuPYaCAoH3YfelJDW6U=;
        b=rv+yw5CA/tifrslx3/3vzaEVpG0yD0NqINaU7/35sCQuCY3liJYGqwh85LC4GzE4z+
         BtFs1YDXxWjBFccml80L5QMO9KPrO++6YmiE6LEWfaaglF5mY/11QkpvcYei0O0+ffJh
         EFzm6XGhoiQM744xnWKBpaaQx6QY1NXOoJV+NCZs8ZKxNipPDyMgHZ0LN7au3n6ZBbMb
         OahC0zjKdPQcL3UjnZwthAxsnkWiPvh+CaGCsN/V1tYmm8A41P4zQg0r/vG/ir3QY0Vd
         /ToyWfDgVTce1bq/jBFbmU4BCH1odieqhtioX1B6jRv3Hj5nMi3LPkAFh3bY0Rd3H3G0
         WhBw==
X-Gm-Message-State: AGi0PuY1vtrPAHDyz0aWWuOIs23eq6gTiT6Wt/19A9fX5hzmFpShPUfZ
        kNTOYgwWtlCtVV51roC/T5/Z44iLeidUAGF6OuM73HFrzpOyxcgSxLIJOUvoEnaeuQJyhc6cDeP
        l/80EHkNbQJWJwy54lMUP85i7
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr4211325wmc.146.1586514236357;
        Fri, 10 Apr 2020 03:23:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIIN+FhxOln9RGpZAOpqoKDY47mQ73YcDG4yKXz8RhDStd9eyiNr+jrcDR19FRJiAaG9lW/5w==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr4211297wmc.146.1586514236095;
        Fri, 10 Apr 2020 03:23:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995? ([2001:b07:6468:f312:e8a3:73c:c711:b995])
        by smtp.gmail.com with ESMTPSA id s14sm2303069wme.33.2020.04.10.03.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 03:23:55 -0700 (PDT)
Subject: Re: [PATCH 0/3] x86: KVM: VMX: Add basic split-lock #AC handling
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, "Kenneth R . Crudup" <kenny@panix.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200402124205.334622628@linutronix.de>
 <20200402155554.27705-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3f2a8d0-fa73-709e-8942-c1597184889f@redhat.com>
Date:   Fri, 10 Apr 2020 12:23:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402155554.27705-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/20 17:55, Sean Christopherson wrote:
> First three patches from Xiaoyao's series to add split-lock #AC support
> in KVM.
> 
> Xiaoyao Li (3):
>   KVM: x86: Emulate split-lock access as a write in emulator
>   x86/split_lock: Refactor and export handle_user_split_lock() for KVM
>   KVM: VMX: Extend VMX's #AC interceptor to handle split lock #AC in
>     guest

Sorry I was out of the loop on this (I'm working part time and it's a
mess).  Sean, can you send the patches as a top-level message?  I'll
queue them and get them to Linus over the weekend.

Paolo

