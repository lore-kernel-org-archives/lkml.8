Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7769206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty2m+DFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDGWEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:04:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgDGWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586297086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrH2lLfAiq23v5Jxv+IpDhUxu2udMFmlhuyHKnLXEqg=;
        b=Ty2m+DFz7lUNx5rs1/BO9KlFnCh2z6B1VSRHYD2XqW8e2O2sPdH7CiJZHYG82HCqa/zjW4
        bd12/5JtpE0g83uxR/SZqxq1fu9/XKX/PnWUuVs+RUaUUATN2P+VbceFQATk4Y0IfoblaX
        zem0GB1E2vCxa0XZptRKCxj+yGJZwNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-0rcv3KQEPJKbYta6kQ9xFA-1; Tue, 07 Apr 2020 18:04:43 -0400
X-MC-Unique: 0rcv3KQEPJKbYta6kQ9xFA-1
Received: by mail-wm1-f71.google.com with SMTP id a4so1718655wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrH2lLfAiq23v5Jxv+IpDhUxu2udMFmlhuyHKnLXEqg=;
        b=JxDyx5+aw1R729s4wqnBMBpTp4++Ry5LnQahOmD5eom0WeLuHtX+JapC3b2rY6lSU+
         5vUx5CSGDgjQ4AgaSjYv5/ax1MZOgDJ29/pzu5aKpWPWroeaQG4Rtytd4aor0mmF+nYq
         rO68WUT94juSo8i6dQopbIkXkH1Y2W4nt31VkyWpjBFr/zMp/QEBvckG0JKVKCX8P+xc
         FPIYCzoJikrLPlitn5rsgQ6PVlla9hZG0HAmMNhloRbEB1pu48t0D8Kv3zHffqUA7XRZ
         9PxPe2bYRFmAon13C7dT6DiBLJ8TSG9mVI8TPcd50z7+G+6EyTzPMxvAGmU/OIwBD6E+
         yoHA==
X-Gm-Message-State: AGi0PuZ5Gfz5+YXpq6QPcwcQxYSJvq3DZMHR1y7Hm/rIsdzjXMe2evaP
        70krvTdLGVGWiYulZPdgLRDwTmoNdpYlk3zDK4pjtrWzAIsgphTNw1l12uzo+gX7iSQGUr16zaL
        kx8UTHzdvHhqb91aVIDp79bxA
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr4563553wra.98.1586297082518;
        Tue, 07 Apr 2020 15:04:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGbUTjfdz6MpZ4qxUe2T9cFiSjdOrwlcJVFzepk8Hol5dhGGIbKBsCKOQCM8Zck3xQ0lCQsQ==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr4563476wra.98.1586297081368;
        Tue, 07 Apr 2020 15:04:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id t17sm28293907wrv.53.2020.04.07.15.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:04:40 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
Date:   Wed, 8 Apr 2020 00:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87eeszjbe6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/20 22:20, Thomas Gleixner wrote:
>>> Havind said that, I thought disabling interrupts does not mask exceptions.
>>> So page fault exception should have been delivered even with interrupts
>>> disabled. Is that correct? May be there was no vm exit/entry during
>>> those 10 seconds and that's why.
> No. Async PF is not a real exception. It has interrupt semantics and it
> can only be injected when the guest has interrupts enabled. It's bad
> design.

Page-ready async PF has interrupt semantics.

Page-not-present async PF however does not have interrupt semantics, it
has to be injected immediately or not at all (falling back to host page
fault in the latter case).  So page-not-present async PF definitely
needs to be an exception, this is independent of whether it can be
injected when IF=0.

Hypervisors do not have any reserved exception vector, and must use
vectors up to 31, which is why I believe #PF was used in the first place
(though that predates my involvement in KVM by a few years).  These
days, #VE would be a much better exception to use instead (and it also
has a defined mechanism to avoid reentrancy).

Paolo

