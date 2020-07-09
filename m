Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE963C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A438C2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3i/GC0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGISW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:22:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30502 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbgGISW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594318945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPXiyCrH7oXeBX9QLi0so8nbm8S4tmPS8K/PlqOIwFU=;
        b=i3i/GC0FddMzUEOol9uWfQJ64H9CEGBs1NWR308YhbaMChJ5yfJBh7IO62UcVIP1Mkv/P+
        vbhgmEjuh+cshR33I1eu9NK3ROyk00KUrt1zwA6+T2WSen+H9REOc7aL9BqX2PyWVqz18j
        pOpy9b/H1giPyazgsKwNyWF7KsI8GKY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-gKDWHFzVNLOiFUGFamhIww-1; Thu, 09 Jul 2020 14:22:23 -0400
X-MC-Unique: gKDWHFzVNLOiFUGFamhIww-1
Received: by mail-qk1-f198.google.com with SMTP id g12so2424838qko.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPXiyCrH7oXeBX9QLi0so8nbm8S4tmPS8K/PlqOIwFU=;
        b=k0XXvVb9C0ngcvdJu9MzXi+qSazXUX83NtnIfHq0W8rImyD7/tMGQyG2u9Y82+mlfb
         TTGYTmsolfUc3YMyki1ISexiFZIHl+LokHhfjvj2iQD0Vzv5nunqjLsypG4RZC/ZqhHX
         SX54gARXPwj+nkVXnz/84vAHA9E3kzSfdZo6vHOg+Pq4x6nxbvrYIHJFGHRo/4AGC/OS
         sTWQC3r9M8EON/O2ONV++q8593zzX9SAp8ua/h9U1VjGa6PLzRv3UatMv950XkKw2E9N
         bcW9TbO8JErhmO/4mSIt9mOn/qJJQmE59RuVfa3pDrZuP34q1eURhUqMekJ1hJjOtv3t
         tM7A==
X-Gm-Message-State: AOAM5336CAm4/+kQnfwdR252KpZXS9W4QxYj2kG19lWuE2QYGS1kCNyM
        Dm4w2T+Ubb1nKedQPhkX2GnmapUqanfrxb7FLCwKdFq3HbYHVbVxEpZVduQeSwVw/kq6h9H5juy
        XghkVWy1B8jf0ZaPd0pIGR8h6
X-Received: by 2002:aed:2a36:: with SMTP id c51mr39636232qtd.264.1594318943270;
        Thu, 09 Jul 2020 11:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqsYywhmXTQRogPqAPHeaEeyc9RZJ23AF7MNu+3uBKa8vxZOosdZtq4sQ4TcPk5Z1Polevwg==
X-Received: by 2002:aed:2a36:: with SMTP id c51mr39636203qtd.264.1594318942990;
        Thu, 09 Jul 2020 11:22:22 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id y40sm4756253qtc.29.2020.07.09.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:22:22 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:22:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
Message-ID: <20200709182220.GG199122@xz-x1>
References: <20200622220442.21998-1-peterx@redhat.com>
 <20200622220442.21998-2-peterx@redhat.com>
 <20200625061544.GC2141@linux.intel.com>
 <1cebc562-89e9-3806-bb3c-771946fc64f3@redhat.com>
 <20200625162540.GC3437@linux.intel.com>
 <20200626180732.GB175520@xz-x1>
 <20200626181820.GG6583@linux.intel.com>
 <47b90b77-cf03-6087-b25f-fcd2fd313165@redhat.com>
 <20200630154726.GD7733@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630154726.GD7733@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 08:47:26AM -0700, Sean Christopherson wrote:
> On Sat, Jun 27, 2020 at 04:24:34PM +0200, Paolo Bonzini wrote:
> > On 26/06/20 20:18, Sean Christopherson wrote:
> > >> Btw, would it be more staightforward to check "vcpu->arch.arch_capabilities &
> > >> ARCH_CAP_TSX_CTRL_MSR" rather than "*ebx | (F(RTM) | F(HLE))" even if we want
> > >> to have such a fix?
> > > Not really, That ends up duplicating the check in vmx_get_msr().  From an
> > > emulation perspective, this really is a "guest" access to the MSR, in the
> > > sense that it the virtual CPU is in the guest domain, i.e. not a god-like
> > > entity that gets to break the rules of emulation.
> > 
> > But if you wrote a guest that wants to read MSR_IA32_TSX_CTRL, there are
> > two choices:
> > 
> > 1) check ARCH_CAPABILITIES first
> > 
> > 2) blindly access it and default to 0.
> > 
> > Both are fine, because we know MSR_IA32_TSX_CTRL has no
> > reserved/must-be-one bits.  Calling __kvm_get_msr and checking for an
> > invalid MSR through the return value is not breaking the rules of
> > emulation, it is "faking" a #GP handler.
> 
> "guest" was the wrong choice of word.  My point was that, IMO, emulation
> should never set host_initiated=true.
> 
> To me, accessing MSRs with host_initiated is the equivalent of loading a
> ucode patch, i.e. it's super duper special stuff that deliberately turns
> off all safeguards and can change the fundamental behavior of the (virtual)
> CPU.

This seems to be an orthogonal change against what this series tried to do.  We
use host_initiated=true in current code, and this series won't change that fact
either.  As I mentioned in the other thread, at least the rdmsr warning is
ambiguous when it's not initiated from the guest if without this patchset, and
this series could address that.

> 
> > So I think Peter's patch is fine, but (possibly on top as a third patch)
> > __must_check should be added to MSR getters and setters.  Also one
> > possibility is to return -EINVAL for invalid MSRs.

Yeah I can add another patch for that.  Also if to repost, I tend to also
introduce KVM_MSR_RET_[OK|ERROR] too, which seems to be cleaner when we had
KVM_MSR_RET_INVALID.

Any objections before I repost?

-- 
Peter Xu

