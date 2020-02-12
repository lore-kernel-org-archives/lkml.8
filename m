Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61647C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CEB206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWoX+K1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBLHo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:44:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728294AbgBLHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581493465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g67JW6PCjzPFY0JeUKVhTRxxURvlw/u8govktNjV/gc=;
        b=cWoX+K1G7pEnkhLIg0ZwMo8/IRQN/XBVWlI2aLNQ65VWQUgjfUnPyUhIn/eOeVG6213OOV
        X7AoNaVkkRTV0uxCHRN7r2HrtI3cvLrkuvFD/4fn6sKTGo5w3C4goZpA3oI581h/ukLyAi
        2BiL1YxlCSpY0PMnMzQ2QW9O2eTmYyA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-nsW27BvuNVOmyyrGdKdybQ-1; Wed, 12 Feb 2020 02:44:23 -0500
X-MC-Unique: nsW27BvuNVOmyyrGdKdybQ-1
Received: by mail-wr1-f69.google.com with SMTP id 90so473025wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g67JW6PCjzPFY0JeUKVhTRxxURvlw/u8govktNjV/gc=;
        b=BX44wS/Qy3nXOubV6Kv/CW/Ww0C6KnaentRHC1S2TGxmRGj/H5WLA69jqUch3mNdni
         OFLaM/j/YigwAjhLlNZ/BHYUlxyFiFopFe5kmqgajilIbhWnLtuCy+xh+xRptWW2bby3
         5bGXSq8IQhmutKFPGPlqnHMakaLK7EgUgcN201rXAMGKoF9QXi+5MF0qcA1780MZ5sao
         CeV87mWmKoQYf+kmZbngllcIOxIlE0s7DSYiHLC5ueUseCd5NH+tz+S6K+oR3jPl7QuU
         q+AXMBRGRK8bkYIvwj52Q3BdDKGfBvsC6PYdK+bvBRPRBIWLolnnrYBTn5ll9nwwTSQh
         j2YQ==
X-Gm-Message-State: APjAAAXSsvxm1bENtDgh30W9IxcPH0TFY9cjKFWnaaxolB6KrmVq2xOJ
        xjGPtVcvsjwkNAdR+QGNHUAqLFN8dhfg3qt1ULWlj/XxurdkV1TPbN2qtzQZhtqme1cAaB5vMtN
        jCjHwYlPjgLNh4ivh6I15Yx8/
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr10562974wmh.12.1581493462598;
        Tue, 11 Feb 2020 23:44:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRHiPRH64HlUiSRMYtcJAOFfNmBT5P+vp6Nwrf0t8K92gPacb6XCWJ/IyVdUV+r6f8oytxyg==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr10562225wmh.12.1581493454694;
        Tue, 11 Feb 2020 23:44:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id r3sm8820670wrn.34.2020.02.11.23.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 23:44:14 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: do not reset microcode version on INIT or RESET
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1581444279-10033-1-git-send-email-pbonzini@redhat.com>
 <20200211223837.GC21526@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <988c9422-52d2-f544-c703-b3ec6274e2be@redhat.com>
Date:   Wed, 12 Feb 2020 08:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200211223837.GC21526@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/20 23:38, Sean Christopherson wrote:
> On Tue, Feb 11, 2020 at 07:04:39PM +0100, Paolo Bonzini wrote:
>> The microcode version should be set just once, since it is essentially
>> a CPU feature; so do it on vCPU creation rather than reset.
> I wouldn't call it a CPU feature, CPU features generally can't be
> arbitrarily changed while running.

That was true of CPUID bits too until microcode started adding and
removing them, but I see your point. :)  What I was trying to convey as
"CPU feature" is that KVM will not change it arbitrarily when running;
it can only change as a result of userspace actions, KVM_SET_MSRS in
this case.  But yes, I will improve the text based on your version:

---
Do not initialize the microcode version at RESET or INIT, only on vCPU
creation.   Microcode updates are not lost during INIT, and exact
behavior across a warm RESET is not specified by the architecture.

Since we do not support a microcode update directly from the hypervisor,
but only as a result of userspace setting the microcode version MSR,
it's simpler for userspace if we do nothing in KVM and let userspace
emulate behavior for RESET as it sees fit.
---

Thanks,

Paolo

> I'd prefer to have a changelog that
> at least somewhat ties the change to hardware behavior. 
> 
>   Do not initialize the microcode version at RESET or INIT.   Microcode
>   updates are not lost during INIT, and exact behavior across a warm RESET
>   is microarchitectural, i.e. defer to userspace to emulate behavior for
>   RESET as it sees fit.
> 
> For the code:

