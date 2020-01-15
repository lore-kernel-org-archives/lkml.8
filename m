Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9159C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2aJ78p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAOSRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:17:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728904AbgAOSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579112252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTOIMdw+nQ/QCfAVH0L+SryIoSP15eSfsBn1/tpu/8g=;
        b=b2aJ78p/NxBfAHL2PMA33kWQGhYelx90fWos+qtXVBqKlEO7MIuMqki2GuE4KTf87uwHVd
        XhtyB+Y0qQcbHDZ8rZclirgWlqFdlRe/7wB+XLRuuZBEodHlzLkY6kUcdjqsU3Km4eFv+q
        ZGr4F8+GX0nXzUG4Ku62XN/L4quwb7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-Vj6tv-SVNbiG5JBOXdsqzQ-1; Wed, 15 Jan 2020 13:17:31 -0500
X-MC-Unique: Vj6tv-SVNbiG5JBOXdsqzQ-1
Received: by mail-wr1-f72.google.com with SMTP id k18so8327316wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTOIMdw+nQ/QCfAVH0L+SryIoSP15eSfsBn1/tpu/8g=;
        b=bPnEQeeID9d2RMPXw8LZLqxjNCbO3g133h9LsP3cAtRyvdqu5gq7tjjnDEslmlDHEN
         pNJw4pjuI5WUPEVhcggLxSNywYciwYC1jE4ospqRhpZDjeLp3Gxpgc0wHpJXuyh0eGOo
         5MzBwki2R2fqUyYrnLr6cg2X0f5WzWtpX24uaBIxtbbf6YK99g3f6Y3sacu7+Ij5/Mml
         EIfXmm5Hi+JyUu9swsx0DReESCjVWhyyXCAIbOWKPgoYJAPYb//Wzg6tlMPqZX9yfxu4
         shUZXjoLbIbzDVT1bNu+yS+6Gid7LgXMVoYihF/3beEXoxPiZccKflKRHpQHp9ZHuoDI
         hkcQ==
X-Gm-Message-State: APjAAAXT5M9oPpWzCof5h5WM2UwrC4RK5HmvE08Xw250SxU62th1EZiw
        IpYGMiNyVOhGYgSWDdKPUyuYsGhUpWRALxo1pgE3mZ0pZ132uC3BrinTnrqB3B0kBGn6HidKgGT
        yC1vgm/Jttlp1RkQD3JSgy1ZL
X-Received: by 2002:a05:600c:2c08:: with SMTP id q8mr1231107wmg.45.1579112249941;
        Wed, 15 Jan 2020 10:17:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzztdIBb2gpjavGfEL7Yhh3wdfSdVaRcFOFyEfxNfeJzsz4JhL1QN6fYW1ZxvEuy8od6HLJqA==
X-Received: by 2002:a05:600c:2c08:: with SMTP id q8mr1231084wmg.45.1579112249757;
        Wed, 15 Jan 2020 10:17:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id j12sm25880146wrt.55.2020.01.15.10.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:17:29 -0800 (PST)
Subject: Re: [PATCH v2 2/2] KVM: x86/mmu: Micro-optimize nEPT's bad
 memptype/XWR checks
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20200109230640.29927-1-sean.j.christopherson@intel.com>
 <20200109230640.29927-3-sean.j.christopherson@intel.com>
 <878smfr18i.fsf@vitty.brq.redhat.com>
 <20200110160453.GA21485@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f23a2801-d33d-4c2d-290e-60b0fa142cb5@redhat.com>
Date:   Wed, 15 Jan 2020 19:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110160453.GA21485@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/20 17:04, Sean Christopherson wrote:
> Ya, I don't love the code, but it was the least awful of the options I
> tried, in that it's the most readable without being too obnoxious.
> 
> 
> Similar to your suggestion, but it avoids evaluating __is_bad_mt_xwr() if
> reserved bits are set, which is admittedly rare.
> 
> 	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level)
> #if PTTYPE == PTTYPE_EPT
> 	       || __is_bad_mt_xwr(&mmu->guest_rsvd_check, gpte)
> #endif
> 	       ;
> 
> Or macrofying the call to keep the call site clean, but IMO this obfuscates
> things too much.
> 
> 	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level) ||
> 	       IS_BAD_MT_XWR(&mmu->guest_rsvd_check, gpte);

I think what you posted is the best (David's comes second).

Queued, thanks.

Paolo

