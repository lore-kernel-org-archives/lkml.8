Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13640207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HknO05dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHUKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:07:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728004AbgHUKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598004443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1P7azXYfV0jqkCDnkRHD/0D9waQRA2iINzYrxU+tRY=;
        b=HknO05dSLdQldRj6tFofgE7jPI1EB5a8jZd88hiAgsrR4EKYfjf0qHRrBubwM3/akniIiN
        Ppedl/iM1raRyZiqxtYgVgFRfgKR0LFZD9JklWRtemeyO9ZgiOXJRZmD/Hr13Iy2MR5i+T
        4gaBGqIzsR8sZReAN3R5Skdgc/1Wz8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-9WlxZuNfNAW5qLWXEkBuog-1; Fri, 21 Aug 2020 06:07:22 -0400
X-MC-Unique: 9WlxZuNfNAW5qLWXEkBuog-1
Received: by mail-wm1-f71.google.com with SMTP id q23so361078wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1P7azXYfV0jqkCDnkRHD/0D9waQRA2iINzYrxU+tRY=;
        b=G1jaHI14AU1whoOJR0bpJSL0j4/DUF2cZRYAxnbXLNRycmSERG2IqIqwqh+VjOWqf+
         1LmaNmFpiVChwdeVlFCDVdIJz4laEOsn38V6OP1EsewLjR/4oFB0fHgb7jtvLqkqWaVc
         +LGqfCZV22CTeXj23SJs0GHnI450gZiD/rnAHfP7JvpVCweogKKSzGei/Wkn4KU/A9UN
         KIUrRYciD9dwgaDMs2Jwbp7Z/sLmFovBZFyLOEG2X2FnrUazyJhZxfrDRHcYmqQjlWBj
         c8k/QS2O5hPVfgc2Bcn1VZletjuVxxFru6HH8ss2DJF051owXwR1m2Z4SxSWqEXmITPT
         3NSg==
X-Gm-Message-State: AOAM5302hyBgd35J2vaQjGJ9pS8rDpX511kp4pbVjDtj3sUGrPcU6oxP
        e1i1z9X0cZyZ7K/1MN3O+S6eH/B4hO5U1XtXhR8E0VABganmyfK4xX3wolvlb+nQ6onU1sy6aIg
        ghfLj/Sf4f2LuPHhIpudQived
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr2014124wrv.197.1598004441007;
        Fri, 21 Aug 2020 03:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA7I+I679TgdT0CtRYE0nBissWAZ9ibzm/ankI+puja2IVFWbi9ACrxHMTwGvzeT2GN8gU3A==
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr2014105wrv.197.1598004440766;
        Fri, 21 Aug 2020 03:07:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id f9sm3174815wrm.62.2020.08.21.03.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 03:07:20 -0700 (PDT)
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic>
 <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
 <20200821092237.GF12181@zn.tnic>
 <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
 <20200821094802.GG12181@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81985f69-190d-eea6-f1ff-206a43b06851@redhat.com>
Date:   Fri, 21 Aug 2020 12:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821094802.GG12181@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 11:48, Borislav Petkov wrote:
>> It's not like we grab MSRs every day.  The user-return notifier restores
>> 6 MSRs (7 on very old processors).  The last two that were added were
>> MSR_TSC_AUX itself in 2009 (!) and MSR_IA32_TSX_CTRL last year.
> What about "If it is a shared resource, there better be an agreement
> about sharing it." is not clear?
> 
> It doesn't matter how many or which resources - there needs to be a
> contract for shared use so that shared use is possible. It is that
> simple.

Sure, and I'll make sure to have that discussion the next time we add a
shared MSR in 2029.

In the meanwhile:

* for the syscall MSRs, patches to share them were reviewed by hpa and
peterz so I guess there's no problem.

* for MSR_TSC_AUX, which is the one that is causing problems, everybody
seems to agree with just using LSL (in the lack specific numbers on
performance improvements from RDPID).

* for MSR_IA32_TSX_CTRL.RTM_DISABLE, which is the only one that was
added in the last 10 years, I'm pretty sure there are no plans for using
the Trusty Sidechannel eXtension in the kernel.  So that should be fine
too.  (The CPUID_CLEAR bit of the MSR is not shared).

Thanks,

Paolo

