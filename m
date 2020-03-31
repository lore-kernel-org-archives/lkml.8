Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE6C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E0206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1K+aBTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgCaKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:33:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729955AbgCaKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585650812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJdyJmHlbCZZThjXBqpe8IJpm68daaGiHI8h/gWVt6A=;
        b=D1K+aBTdBbYGgjVBZDH3XxKBat2rwzvjCnfwAG6axKU3Ols0qx11lQA/E3eKN4QPLi0j9p
        KpZKnzTBlCttXTbC6vXRPY1QnyEJvgkEpqBngChjx7gTYrnD3OG5SD3+z3NEWKbBVGQbZp
        BZc31N29Im461SRvdD0u2KLjE5PLkkY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-pZNgcDgCOqqNuj0y-Wwv8A-1; Tue, 31 Mar 2020 06:33:28 -0400
X-MC-Unique: pZNgcDgCOqqNuj0y-Wwv8A-1
Received: by mail-wm1-f69.google.com with SMTP id u6so535631wmm.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 03:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MJdyJmHlbCZZThjXBqpe8IJpm68daaGiHI8h/gWVt6A=;
        b=cvrJZJl9tIiOsr2hM0YyKgnv3vNWjOoEpCscHnqmNgg9lDLF2ZqdMPl8mas8f4wmsJ
         5S4prQz5/mhA9i11CmrGLtQraARQu/2r06A9mBIwB7RYWY5qA99UZ3HWccXVjC0y+GXJ
         J0LJTkXNG9/k4uDeCVfulkmhyiPGIQEXTZnSbPwg1IgBdi+SCxpmmxquLDerEK9ppwXN
         6JMHQ02av7ds5fcd2fC7f+1HDKKTYNcdB3YHLq2MFA1mVbOHJguwwAxPmuHEjhzQBL2u
         oox4KQMRUnIC+ZaGkk/U5Exs9E1mgroaOxnVJtJfy9TIoDCZbSO54Ubj/VQSIp5wAVf/
         Dlbg==
X-Gm-Message-State: ANhLgQ2NdOUB4yRqXwrzp27Th9PnsypMm63ETUeI626zZuzGnPtbo1MO
        xw21dkpePQucEFHuV+6PFv+ffMhBKT2XYa55ZjoDDZYOdYCpnw3djfUqXAGi6Wzs35AbKVlxt5/
        j9uw+SyoMuaKBy81gVumRV0kN
X-Received: by 2002:a5d:464a:: with SMTP id j10mr19529896wrs.3.1585650807775;
        Tue, 31 Mar 2020 03:33:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuGDenkotV0E4MljO6odBu9a/SuA+iY8rESIFQiotSoUzHd7WaDBOTrgjAOfKcqt355r2SW4g==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr19529882wrs.3.1585650807537;
        Tue, 31 Mar 2020 03:33:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z1sm14381769wrp.90.2020.03.31.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:33:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH 1/3] KVM: x86: introduce kvm_mmu_invalidate_gva
In-Reply-To: <20200330184726.GJ24988@linux.intel.com>
References: <20200326093516.24215-1-pbonzini@redhat.com> <20200326093516.24215-2-pbonzini@redhat.com> <20200328182631.GQ8104@linux.intel.com> <2a1f9477-c289-592e-25ff-f22a37044457@redhat.com> <20200330184726.GJ24988@linux.intel.com>
Date:   Tue, 31 Mar 2020 12:33:25 +0200
Message-ID: <87v9mk24qy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Mar 30, 2020 at 12:45:34PM +0200, Paolo Bonzini wrote:
>> On 28/03/20 19:26, Sean Christopherson wrote:
>> >> +	if (mmu != &vcpu->arch.guest_mmu) {
>> > Doesn't need to be addressed here, but this is not the first time in this
>> > series (the large TLB flushing series) that I've struggled to parse
>> > "guest_mmu".  Would it make sense to rename it something like nested_tdp_mmu
>> > or l2_tdp_mmu?
>> > 
>> > A bit ugly, but it'd be nice to avoid the mental challenge of remembering
>> > that guest_mmu is in play if and only if nested TDP is enabled.
>> 
>> No, it's not ugly at all.  My vote would be for shadow_tdp_mmu.
>
> Works for me.  My vote is for anything other than guest_mmu :-)
>

Oh come on guys, nobody protested when I called it this way :-)

Peronally, I don't quite like 'shadow_tdp_mmu' because it doesn't have
any particular reference to the fact that it is a nested/L2 related
thing (maybe it's just a shadow MMU?) Also, we already have a thing
called 'nested_mmu'... Maybe let's be bold and rename all three things,
like

root_mmu -> l1_mmu
guest_mmu -> l1_nested_mmu
nested_mmu -> l2_mmu (l2_walk_mmu)

or something like that?

-- 
Vitaly

