Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09A024653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8Vf3vjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgAUOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:40:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729275AbgAUOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579617649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSSit0Wm+RQr1Jgst7x5naV4XKUyLXD3AhAyDv7TiYs=;
        b=X8Vf3vjCA3YtJBkZkSUNtCpTyRDiA+Fjs1kniCHWWWO0N22Lx0snkoE0zs2t5PcS4yqAPK
        M1Pp2aO5DeZjXsDOtsDZEK6CwfTq2yK7hU96FHqc2jxWey9MbmN8xv2U2qiamZoH7k+7dJ
        NGogPIPHs0nQ5cYjXi2g78L8Rw9EawU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-kARLWSK8PtqZVT-nfxWL9Q-1; Tue, 21 Jan 2020 09:40:46 -0500
X-MC-Unique: kARLWSK8PtqZVT-nfxWL9Q-1
Received: by mail-wr1-f71.google.com with SMTP id z10so1382794wrt.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JSSit0Wm+RQr1Jgst7x5naV4XKUyLXD3AhAyDv7TiYs=;
        b=CD/I1SwkE4f4rkRV5mtNUZp7FtSPcneZK/sf7kDkYeghOg3Wj9DOsykOjDdV3YYtj7
         Ft2pRfks1/6dKXIDHnlSB3Q4EfIlULtN4Jfen5mSatDILKrPHzhNRD2AVxmRMNRR4Ns3
         88dnBCfoSekkcv3QqGHZfsq57rqb7OQ9zQEdTxCiRxDbL8Hx4DqRbZx/unFU+9dJBVjr
         J5KlSt0yVW6q13Tqz2a/6gMtdrP2JFEez3mshk4+ta3ly4EsdY+boPucgv3aasIvA2Du
         1xS6CPQd4Y99qtrL7SAY+0rgdUm1GgSUnJFEuyA/JAYZg2AaJe2Ucsz5Gu9h/xdVL4aj
         ACiA==
X-Gm-Message-State: APjAAAXXaLiQh5i/vnpGTEBlstN5CUASkzgXlYgNychTIsPiV9+L+DOS
        6e/eyPQB8W+mOY30YpEqe0Ha0LA69ql6aX2nQPSS6ACEuczZKyEgaPL+a8Wl0MZIC8Eixty4zHN
        rPHAdi6xMPZ5jMcRZaOwj4kcc
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4596881wml.71.1579617645321;
        Tue, 21 Jan 2020 06:40:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUkg5d8MSonCO4Ge0L397jZ+4TsON4lVJzpAggAw2WjkJCWhAHkQt1Jw0IPvgT93BvWQD3aw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4596848wml.71.1579617645022;
        Tue, 21 Jan 2020 06:40:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id b67sm4417502wmc.38.2020.01.21.06.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:40:44 -0800 (PST)
Subject: Re: [PATCH 07/14] KVM: x86/mmu: Walk host page tables to find THP
 mappings
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Barret Rhoden <brho@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Zeng <jason.zeng@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-8-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e9987a2-c34f-362d-a123-7dc4849811d1@redhat.com>
Date:   Tue, 21 Jan 2020 15:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-8-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 21:24, Sean Christopherson wrote:
> +
> +	/*
> +	 * Manually do the equivalent of kvm_vcpu_gfn_to_hva() to avoid the
> +	 * "writable" check in __gfn_to_hva_many(), which will always fail on
> +	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
> +	 * page fault steps have already verified the guest isn't writing a
> +	 * read-only memslot.
> +	 */
> +	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	if (!memslot_valid_for_gpte(slot, true))
> +		return PT_PAGE_TABLE_LEVEL;
> +
> +	hva = __gfn_to_hva_memslot(slot, gfn);
> +

Using gfn_to_memslot_dirty_bitmap is also a good excuse to avoid
kvm_vcpu_gfn_to_hva.

+	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, true);
+	if (!slot)
+		return PT_PAGE_TABLE_LEVEL;
+
+	hva = __gfn_to_hva_memslot(slot, gfn);

(I am planning to remove gfn_to_hva_memslot so that __gfn_to_hva_memslot
can lose the annoying underscores).

Paolo

