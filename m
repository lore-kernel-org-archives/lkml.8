Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DBC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978452072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Huno5fMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgCSRoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:44:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52513 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgCSRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584639872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEJ/BlKieSWG5w9g4ZAooVBvmg0v+6w1VOLQ6ao4BaI=;
        b=Huno5fMh+DeJ3CXA/JCN264dYymJwZyGSi2z9Fztm++DFHhpsi3LuKnhAOWsBsURPDyxlN
        jfFtVfH2QlPeRTzax0BG00TuI+d2vZN8VkVN4Bn9SYHCc1MZ63CMP8vTdhZbGkEiJZl19H
        dNesjRzauaz6si0y3zdUSC4AN3dRERU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-5zzJl_7AMI2JXLUlnsrpaQ-1; Thu, 19 Mar 2020 13:44:30 -0400
X-MC-Unique: 5zzJl_7AMI2JXLUlnsrpaQ-1
Received: by mail-wm1-f70.google.com with SMTP id z16so1308798wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nEJ/BlKieSWG5w9g4ZAooVBvmg0v+6w1VOLQ6ao4BaI=;
        b=Fhg6AioSV+FQ9t7kmtdVSdxaQhdN98GsRFx8pprGtbwHICKc8USdw3x04mnxkjPnKu
         q2Zn6SJ2jdhAmz1GOWjDC4XvWI8rQkcgeSKSbrGWrR3Jy3WbObRQXS41Qo7bFXmFQbwS
         vMl9kMJq9l5IceSdlBWhQT8qyIdPCkyRwb4nq/sKK9opLVeMtu6DFlZq0y55DRR2Aoah
         vV4+L5b3C0Qxs3orIt7gq9OLSG7ClXGA/n0l9XF0NUg4fztKgMAdx39qwiJw0ZKXl+kt
         ZvoOkn5s60fdE9pV2zhzFmBH7s0O0qOPqHIL4V8yNyXoKE87pWsN4ParL3M3PbnfyBeW
         Vycg==
X-Gm-Message-State: ANhLgQ0NF2pF4V8MvVJ4/qJohQVlH4mSwCtpTR4znkdJpQbk04wsHHZh
        xmLR1WdO8ciFthTN3Nsbn44UtW9M83ez1gKNOrwkh1yucgQ7SWW9iXH+ev29QOqlGx2SwiPALCa
        INpDqsfYxDv0w1CqJKmJSjR4j
X-Received: by 2002:adf:bb06:: with SMTP id r6mr5766081wrg.324.1584639869829;
        Thu, 19 Mar 2020 10:44:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvfLnSZwvyZi0DTLzdUGLabMXyW1faCjMXt0UNAVL0JLf4pVGRQsNCLqsXOTxe3p+rOH+Qizw==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr5766051wrg.324.1584639869593;
        Thu, 19 Mar 2020 10:44:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id h26sm1623923wmb.19.2020.03.19.10.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:44:28 -0700 (PDT)
Subject: Re: WARNING in vcpu_enter_guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     syzbot <syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <000000000000f965b8059877e5e6@google.com>
 <00000000000081861f05a132b9cd@google.com>
 <20200319144952.GB11305@linux.intel.com>
 <20be9560-fce7-1495-3a83-e2b56dbc2389@redhat.com>
 <20200319173549.GC11305@linux.intel.com>
 <20200319173927.GD11305@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd32ee6d-f30d-b221-8126-cf995ffca52e@redhat.com>
Date:   Thu, 19 Mar 2020 18:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319173927.GD11305@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/20 18:39, Sean Christopherson wrote:
>> Yep.  I worked through logic/math, mostly to gain a wee bit of knowledge
>> about the clock stuff, and it's sound.  The KVM_SET_CLOCK from syzkaller
>> is simply making time go backwards.
> Actually, would it make sense to return -EINVAL for KVM_SET_CLOCK if the
> user tries to make kvmclock_offset go backwards?

No, it is possible to do that depending on the clock setup on the live
migration source.  You could cause the warning anyway by setting the
clock to a very high (signed) value so that kernel_ns + kvmclock_offset
overflows.

Paolo

