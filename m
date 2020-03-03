Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2144C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D32073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbu2AaDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgCCQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:18:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730263AbgCCQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583252292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ux1LbKEH1m8oXcQEuc/U7Ti4AulME3jbfobJPAiWr6U=;
        b=Nbu2AaDLW1bbAk/SUyzTcpyfRzUgmnogY0ndlL0DopJonAnTWRcTnIwp4zyjJtUGKLYaBx
        brcrLR9TW+raziIAy2l1K0noYhf0Rv6h2d06SRl8r7WrUfd6mj6EtyN+oJ3nEcjEZw7mp+
        /6GoHZGPDv+nRgurw8Rq3+c52+qtVCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-UyVdazlFOky2JSlXWHcivw-1; Tue, 03 Mar 2020 11:18:10 -0500
X-MC-Unique: UyVdazlFOky2JSlXWHcivw-1
Received: by mail-wm1-f69.google.com with SMTP id g78so851331wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ux1LbKEH1m8oXcQEuc/U7Ti4AulME3jbfobJPAiWr6U=;
        b=k3mzUIu4nblz1nFHHzSAtCpRcig+8xesPl96xVW1IlJlVUChMc09/F0RrSxlD7sFMN
         fZDd2frwllrSRw2idOItVyN70C1qHYEQPCrwnuPS5f6et99lBsr9xqozUMgH5qWXLNyR
         p8+aecjY+nc42cS6JoRe1NugU/PqAMQT6irGPb/DGJjHiOBN+2FEhUC0G2oyx9gx2Wka
         mksV0QcFGetR1fwdEZBnBB5yLgm6KlCiL2QJCOjFY4vpOwtMke4Xley6LntIXscjpdhg
         60usRzb8nI8bvFXlJT0W+QXtuQ1RnOrysQOas7j7Fy08E8PxM9lqeRGuZTwp+1YaRjKF
         eKMQ==
X-Gm-Message-State: ANhLgQ3BSin662PNPLyW6Wo8xwE80GApNfM9RhmM3ojvPMdzw49JELaO
        HZwvueyOaLs2d0i0GGE9Xh0n4/mahCf/yn7opLZEA9JIeKRJzg4lE6HzEb3F6l4312YNTf1dhAC
        wJYyQHmm1aS6mp2xPZKxxGKEs
X-Received: by 2002:adf:f491:: with SMTP id l17mr6715440wro.149.1583252289252;
        Tue, 03 Mar 2020 08:18:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtwoSxwVgqZLc0Y9OACaZM95EIDRl4nCEMRKLI2B2zsM4WldStnyj0BJz2YJF13qOqzBE61vQ==
X-Received: by 2002:adf:f491:: with SMTP id l17mr6715424wro.149.1583252289089;
        Tue, 03 Mar 2020 08:18:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 16sm4551998wmi.0.2020.03.03.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:18:08 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] KVM: x86: Dynamically allocate per-vCPU emulation context
In-Reply-To: <20200303145746.GA1439@linux.intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-9-sean.j.christopherson@intel.com> <87wo89i7e3.fsf@vitty.brq.redhat.com> <83bd7c0c-ac3c-8ab5-091f-598324156d27@redhat.com> <20200303145746.GA1439@linux.intel.com>
Date:   Tue, 03 Mar 2020 17:18:07 +0100
Message-ID: <8736apfm4g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Mar 03, 2020 at 11:26:21AM +0100, Paolo Bonzini wrote:
>> On 26/02/20 18:29, Vitaly Kuznetsov wrote:
>> >>  struct x86_emulate_ctxt {
>> >> +	void *vcpu;
>> > Why 'void *'? I changed this to 'struct kvm_vcpu *' and it seems to
>> > compile just fine...
>> > 
>> 
>> I guess because it's really just an opaque pointer; using void* ensures
>> that the emulator doesn't break the emulator ops abstraction.
>
> Ya, it prevents the emulator from directly deferencing the vcpu.
>

Makes sense, a comment like /* Should never be dereferenced by the
emulater */ would've helped)

-- 
Vitaly

