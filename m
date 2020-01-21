Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCFC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844122253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjKozO3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgAUOBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:01:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729152AbgAUOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579615312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObeXmqek/4gMe0mE2cafb7CORKdf30UezDwWR6GNf18=;
        b=TjKozO3jJpVThNALgMcBEMkMycO7K7GGHv+35w3Pg3s2S/Nc+Jk4AM9z+EMT0ojgfDG5cZ
        jKCPT1d4dgHrZuiEXqR6KiWE0xhVGkd4McqKc3qSJEWAAjqzHrWf484qPCBoM/z1kNB/+q
        VwP1eRhWLuMdgUUehYZAAfKy3LikpKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-nrtQ8pZ0NaW-juxdHj2u2w-1; Tue, 21 Jan 2020 09:01:51 -0500
X-MC-Unique: nrtQ8pZ0NaW-juxdHj2u2w-1
Received: by mail-wr1-f69.google.com with SMTP id r2so1346337wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ObeXmqek/4gMe0mE2cafb7CORKdf30UezDwWR6GNf18=;
        b=TSmGw9fA58w9hJgiswdghyvcKJyxVvO91iqwVdSqhajWLUARuN2erbLnu9/Cu8JFGa
         uGHj7hplbfxkLDgl2NqmFGIbZVFL82svfZHIs9PI1UjkshTkpwRufr1UeG2BkB3FeFu3
         jUa1dSMYirYKA6BnEmUTc17d5PNoY6OU5J7zBPz1Bir3UQ20pwupPlRyHHuNEpg8fPbS
         KJ6Cb0EWV/eoUzC0XAHAA2mCRhKqhnDkbaLzenB6oNNV402LMkP2O0G/r4R9oJz5o7S/
         FWtak/jfA3+ioEUtOVLn/thMKvGaT6d3shNZmMHMrkEs/VT8Npb0tUtmtZroZrRnTI1c
         Yj5A==
X-Gm-Message-State: APjAAAXZZ/CeS/J64AwPyTzyBDSntXm5gzcKiOUJa0TH86No+4J9lG1x
        BhDj3mpogw/ugE3bIyIY1jMux2nqpP/SMmPQA3wiLOpIO341Wii4GHOo58s7J6pEBN/p9vvAq/M
        HWa50ViJEDXXsaMzIgr2wmYfZ
X-Received: by 2002:a5d:5091:: with SMTP id a17mr5379863wrt.362.1579615309943;
        Tue, 21 Jan 2020 06:01:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzfFj1xWSvzPORiOR/mf0Fi+pdgBIZMpJKph7cqo+XOocycXWbBw3t6BRfxNV4UAbABwCvtA==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr5379826wrt.362.1579615309620;
        Tue, 21 Jan 2020 06:01:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id q68sm4632988wme.14.2020.01.21.06.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:01:49 -0800 (PST)
Subject: Re: [RESEND PATCH v10 06/10] vmx: spp: Set up SPP paging table at
 vmentry/vmexit
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, yu.c.zhang@linux.intel.com,
        alazar@bitdefender.com, edwin.zhai@intel.com
References: <20200102061319.10077-1-weijiang.yang@intel.com>
 <20200102061319.10077-7-weijiang.yang@intel.com>
 <20200110175537.GF21485@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80977d05-405e-826a-3d13-1757427f246b@redhat.com>
Date:   Tue, 21 Jan 2020 15:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110175537.GF21485@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/20 18:55, Sean Christopherson wrote:
> Unless there is a *very* good reason for these shenanigans, spp.c needs
> to built via the Makefile like any other source.  If this is justified
> for whatever reason, then that justification needs to be very clearly
> stated in the changelog.

Well, this #include is the reason why I moved mmu.c to mmu/spp.c.  It
shouldn't be hard to create a mmu_internal.h header for things that have
to be shared between mmu.c and spp.c, but I'm okay with having the
#include "spp.c" for now and cleaning it up later.  The spp.c file,
albeit ugly, provides hints as to what to put in that header; without it
it's a pointless exercise.

Note that there isn't anything really VMX specific even in the few vmx_*
functions of spp.c.  My suggestion is just to rename them to kvm_mmu_*.

Paolo

