Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0EFC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811421927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn4MDNjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBFQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:26:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbgBFQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581006405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H3nLSU6aNBKxxlwzEldmN2l97fU6AU4NrctqbL5/r9Q=;
        b=gn4MDNjTmTpfeJjdxoddze1SdOSY1oYCyvksA+OiIHFL+DUb5toFOXhTyBShhGAej2fba1
        e5V1DHJI/gzfarbvX9ImQgl0wQKO4+xqhPjwynhMuwCvjFjM1tpy3vc+d7a5UrWi41fjMW
        7lk1IxTLtUFZPsXhaZQPQPyNyH9RQVc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-9bJH2s3FPvOt6ZKnY7cvqg-1; Thu, 06 Feb 2020 11:26:44 -0500
X-MC-Unique: 9bJH2s3FPvOt6ZKnY7cvqg-1
Received: by mail-qk1-f200.google.com with SMTP id q2so3923474qkq.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H3nLSU6aNBKxxlwzEldmN2l97fU6AU4NrctqbL5/r9Q=;
        b=Exx/QWMjZSPrtN9dLm1WbsfXnQ5J6CfFI8NKOReNbMwz0+14hHI5vl7CRCaheIFZtl
         pVUfw493fdaVPbxsYLEsZ3+3FA61vmLe3K62n/crNtpdCdp7R18JT2Wo3lLS5Xv80XPp
         iphj1d9owndXQupfEevMXI/noSceYTOtFUh9UmqEfdCULT/HSdd5SivFwQhC7AFWmC68
         wRJEsBqA/EPoAk70BM/rkjfLd5wapYEKN4Hlth3r7FGh1zE+leZt6CxusF6m+BcIYyWN
         OerhAjSGtqTbAbjjapoCndFPsEb9e+CZzCUpFVfj5sWFruKPWm9HyVj9gOPCWONh1XWX
         yzLw==
X-Gm-Message-State: APjAAAUYrrIvhvijAu9mNs7Is/1YVVymdRngNMk9905tCZ57Q2cNNn/Q
        oa6d2DVozrUHdHRC1z1d4mUbRrlBvGJtONQwjmB2Z3ubrxSajki7Ir2VznYjGmhv4A7djJYwE0D
        NphwRA4qLUyNMkRrQwbygYlm4
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr3297385qtl.175.1581006403786;
        Thu, 06 Feb 2020 08:26:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQlIJcJ9283T0k3SJBUCagGgD/4X0S4VFGYxAKtPxVCA909nX5ytULcXgwNYLmQcG3Ogy1yQ==
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr3297351qtl.175.1581006403586;
        Thu, 06 Feb 2020 08:26:43 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id q7sm1618375qkc.43.2020.02.06.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:26:42 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:26:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 10/19] KVM: Drop "const" attribute from old memslot in
 commit_memory_region()
Message-ID: <20200206162639.GC695333@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-11-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:48PM -0800, Sean Christopherson wrote:
> Drop the "const" attribute from @old in kvm_arch_commit_memory_region()
> to allow arch specific code to free arch specific resources in the old
> memslot without having to cast away the attribute.  Freeing resources in
> kvm_arch_commit_memory_region() paves the way for simplifying
> kvm_free_memslot() by eliminating the last usage of its @dont param.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

