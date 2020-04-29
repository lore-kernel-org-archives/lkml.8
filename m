Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5448C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB715206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSYiyNNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD2Q6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:58:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbgD2Q6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588179529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DZj+UypIq11W/7o5dpVittTTONbPwIV/7sCOfZvPFS0=;
        b=hSYiyNNzMWy9mMq1ejSZFDLevc61Q8pgVxC3kOtPnaZGIc2LojYO9NktwTufJ45RCCgVGm
        vo+y9Iip2wPSiluLlJlahBvsMnFn6Fs+OsJz3Gu0hNXXcms/+VxA5LOEy9SW0pdHURwDvT
        2pePlaO0+ZNOLmd/71EN7/7VJEekQjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-coRN61a5MzCWBh6aP5sB7A-1; Wed, 29 Apr 2020 12:58:48 -0400
X-MC-Unique: coRN61a5MzCWBh6aP5sB7A-1
Received: by mail-wr1-f72.google.com with SMTP id i10so2048992wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZj+UypIq11W/7o5dpVittTTONbPwIV/7sCOfZvPFS0=;
        b=o+ZWr2vpwIKe4WMgj8LmCzRv3RUVtyYQ+IxVkDaiY8hAe0fswuAzK/8VnJPj6R82JT
         Jb0gI988PF+9h4OyS6g0Eiqo404bik6kl8oP6jgSonr5lj/7gTwgmRuQwqIMb+g+p0GG
         l1mJzMr19pUgDAvhw7vWSutwaYGW7P/QUXhhRPjkecEonbI+t3YgCIHWGdk2b1u9wXmt
         yWzqo3INd9fwQKghKERsfmxA/6hvdAKARPNMP5PLtaFvIoQU3HQmGGcBfqLZULNjeGCp
         FNciqB4o2rgc/6uO7JcpECTmwMrqs7V1D+/ZSuljr3W2Vy/5L9GSsvqqTyC2+NBIyNfJ
         KcrA==
X-Gm-Message-State: AGi0PuazZ4V4kx08KGBiAm7aEwZ7c0SYJhvM7Dv3NZ4/wi7Rk7vM3NRW
        GtzQ1s9g2rt0uvqdnqdlSN/0GO+NbEqCID3JWqwggO9vuSst5XcXCqnHWidCa+MtRyFIpI3I32C
        qTItM0tXKzCrigEVzPPGFjIRi
X-Received: by 2002:a5d:6504:: with SMTP id x4mr43034843wru.164.1588179527021;
        Wed, 29 Apr 2020 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNgX/vxwRcj0In+qKlYwCYcXKBrwuybWbL6MJwjPCNHgZ4umK2HzpOL2puRlq6jK7/5EAJjQ==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr43034816wru.164.1588179526729;
        Wed, 29 Apr 2020 09:58:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id h1sm9392173wme.42.2020.04.29.09.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:58:46 -0700 (PDT)
Subject: Re: [PATCH 12/13] KVM: x86: Replace late check_nested_events() hack
 with more precise fix
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
 <20200423022550.15113-13-sean.j.christopherson@intel.com>
 <CALMp9eTiGdYPpejAOLNz7zzqP1wPXb_zSL02F27VMHeHGzANJg@mail.gmail.com>
 <20200428222010.GN12735@linux.intel.com>
 <6b35ec9b-9565-ea6c-3de5-0957a9f76257@redhat.com>
 <20200429164547.GF15992@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <286738de-c268-f0b6-f589-6d9d9ad3dc4a@redhat.com>
Date:   Wed, 29 Apr 2020 18:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429164547.GF15992@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 18:45, Sean Christopherson wrote:
> 
> Can you just drop 9/13, "Prioritize SMI over nested IRQ/NMI" from kvm/queue?
> It's probably best to deal with this in a new series rather than trying to
> squeeze it in.

With AMD we just have IRQ/NMI/SMI, and it's important to handle SMI in
check_nested_events because you can turn SMIs into vmexit without stuff
such as dual-monitor treatment.  On the other hand there is no MTF and
we're not handling exceptions yet.  So, since SMIs should be pretty rare
anyway, I'd rather just add a comment detailing the correct order and
why we're not following it.  The minimal fix would be to move SMI above
the preemption timer, right?

Paolo

