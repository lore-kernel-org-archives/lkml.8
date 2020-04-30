Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9005C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901202076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLiAg5x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgD3N2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:28:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbgD3N2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588253291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VAxtXeE7jABzTDpf7SPMl48rHqhFXJS9keWJIiG3Vjk=;
        b=SLiAg5x6zLzSI03Q5HaZEdnZTNFklIAEnOZIHyWeDpSVXMmBmfd66hsTmeH3kOHIE6WZIr
        4tMq0g8gXX3hdzbBgLfKvLxBnGIig+Oqgeeile1sLGZuB5wSu5hJUzFqIQ09tLsp3C8wJj
        NA79besaqkrSg44gP5Ovuyq/iSqV7y0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-PBa_XjHKPHKKMlvkPtHqAw-1; Thu, 30 Apr 2020 09:28:09 -0400
X-MC-Unique: PBa_XjHKPHKKMlvkPtHqAw-1
Received: by mail-qk1-f200.google.com with SMTP id 30so6386479qkp.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAxtXeE7jABzTDpf7SPMl48rHqhFXJS9keWJIiG3Vjk=;
        b=D56PdBFnq9gHNC712bCCnExSGf9a/33Xie5a9Sy3fhHBdh4hc3u8CqeUyzEBi8sTjn
         LA818UK0axiarg+liWV5/i9fXncbrZqyYozCErMv+a1nEBSQt1aN4a4Pt0a0ObsH8+DA
         DuEv7elufYstMxGCG6jkU7poUYIsKtEjXrt2Enl2a21BrCnThWqYFTOBTctN5LxxL4lZ
         JRDpyoG3H/WwsbbJnausL1KbmEwoRbkM1d96zQ3WyzxG/vGnChqVNB+I9qJPuNWXJkLO
         KsGzncQVbLlvOnCGv/L8FLsIqEgxCEf/IBM9/MCF9b+rxeW+5aZVBrBCZ80UzzDkCYhB
         r0WQ==
X-Gm-Message-State: AGi0PuZd6RRh+Z6bUVgttzhOVQOmv10HgTvVOZDKmCcTpisPiVp4QznY
        cYUyYCye2NHWNuVp4qT/y8qMq7WQQH8pzJpsX7iZmnElRHO/xnx9WzucdBWLt/icZ/5/aEvXzbw
        9h/nuxW62v7z7cFNBUwTMx0U/
X-Received: by 2002:a37:b141:: with SMTP id a62mr3469473qkf.135.1588253288515;
        Thu, 30 Apr 2020 06:28:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfQeoTAzFa9+FkrkC/xFo4/XpcSAU+KiLE0SM26HDG/2LCq0fmh2kYaCiKeF3HdOmVYFBpdQ==
X-Received: by 2002:a37:b141:: with SMTP id a62mr3469441qkf.135.1588253288132;
        Thu, 30 Apr 2020 06:28:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b42sm2186346qta.29.2020.04.30.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:28:07 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:28:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 3/6] KVM: x86: interrupt based APF page-ready event
 delivery
Message-ID: <20200430132805.GB40678@xz-x1>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-4-vkuznets@redhat.com>
 <20200429212708.GA40678@xz-x1>
 <87v9lhfk7v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9lhfk7v.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:31:32AM +0200, Vitaly Kuznetsov wrote:
> as we need to write to two MSRs to configure the new mechanism ordering
> becomes important. If the guest writes to ASYNC_PF_EN first to establish
> the shared memory stucture the interrupt in ASYNC_PF2 is not yet set
> (and AFAIR '0' is a valid interrupt!) so if an async pf happens
> immediately after that we'll be forced to inject INT0 in the guest and
> it'll get confused and linkely miss the event.
> 
> We can probably mandate the reverse sequence: guest has to set up
> interrupt in ASYNC_PF2 first and then write to ASYNC_PF_EN (with both
> bit 0 and bit 3). In that case the additional 'enable' bit in ASYNC_PF2
> seems redundant. This protocol doesn't look too complex for guests to
> follow.

Yep looks good.  We should also update the document too about the fact.

Thanks,

-- 
Peter Xu

