Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62670C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A15020753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsxynK5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:17:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgDJPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586531849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxA/tgR1C4hkGx3HZZll51D+Ssqd304gHaE+7JqW5D4=;
        b=OsxynK5+O7SY32nyI/7DxlvxMtamLtDtfkTbs30DShDGGwE/TFvvbeKD5C46HB7o9uG9Q4
        mp61gA5PbkO9E/Zha3VRlOWb7ZtlMKYmRu7RdtTMzXo4TsNGxC6QG4OwI5NBDld6LFnxea
        3eq8Ai13/IFbL7t6oI0qy5a5oqyj6EY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-qsJhzea0PCGa-aXpZhAUuQ-1; Fri, 10 Apr 2020 11:17:25 -0400
X-MC-Unique: qsJhzea0PCGa-aXpZhAUuQ-1
Received: by mail-wr1-f70.google.com with SMTP id h14so1340431wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lxA/tgR1C4hkGx3HZZll51D+Ssqd304gHaE+7JqW5D4=;
        b=sARNrRis533o5hBEo2sFzeGt8qsF/Sta2D0ZnP7wsd6wH505yU+iiuB0mFvJGCv5Jn
         51jQ3dLsRUCJMpN5wM/poj7N7Nro3vDl0aEwmhbu3Riy/jGC0iVNr+jaS9K8R1b3Niw5
         AQaoGir4W0XxufeMwX16XibofAWwG3eKGPQ7brkzdPF1m4uX7eN0vgBd0E29xccNWP1X
         MNVsC9943jfGXIhOlP0obV1mDevs4d2FJdaWtKQWyFnnEwB9pvStNqlE1ERGqq8MaAR1
         P6bQoqPf/AyJ342U0RgcJuGtOVjfkVVZHBDDfp13Sbsp1XlBYnw2OjoBbxn8ypl2VgPd
         PsNA==
X-Gm-Message-State: AGi0Puadt1J+dcN9eFSrwF9qXj5Rrf/wWWodXiIzc5vVye+zotd7wayA
        D0Rh4k08tMcdRxlgpYrRNFUm2411T7E8dtte+dLlE3frb565pqf3ICR46t+b3L3nUDjwzX+v8h8
        U2tvotpOtDkc3g1FhJVA9wxii
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr5656672wmg.117.1586531844663;
        Fri, 10 Apr 2020 08:17:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJWNqZ9O7KLUo6jbp8USvz8XGxE5RktlTZ/tBRjyLf56EOrhOkXcv6t2w0OjupApH3JE2eFYA==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr5656648wmg.117.1586531844436;
        Fri, 10 Apr 2020 08:17:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b7:b34c:3ace:efb6? ([2001:b07:6468:f312:f4b7:b34c:3ace:efb6])
        by smtp.gmail.com with ESMTPSA id c4sm3266515wmb.5.2020.04.10.08.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:17:23 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: X86: Ultra fast single target IPI fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1586480607-5408-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e639e0f6-9393-7a32-9e2d-13725d7d96f8@redhat.com>
Date:   Fri, 10 Apr 2020 17:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586480607-5408-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 03:03, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> IPI and Timer cause the main MSRs write vmexits in cloud environment 
> observation, let's optimize virtual IPI latency more aggressively to 
> inject target IPI as soon as possible.
> 
> Running kvm-unit-tests/vmexit.flat IPI testing on SKX server, disable 
> adaptive advance lapic timer and adaptive halt-polling to avoid the 
> interference, this patch can give another 7% improvement.
> 
> w/o fastpath -> fastpath            4238 -> 3543  16.4%
> fastpath     -> ultra fastpath      3543 -> 3293     7%
> w/o fastpath -> ultra fastpath      4238 -> 3293  22.3% 
> 
> This also revises the performance data in commit 1e9e2622a1 (KVM: VMX: 
> FIXED+PHYSICAL mode single target IPI fastpath), that testing adds
> --overcommit cpu-pm=on to kvm-unit-tests guest which is unnecessary.
> 
> Tested-by: Haiwei Li <lihaiwei@tencent.com>
> Cc: Haiwei Li <lihaiwei@tencent.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * rebase on latest kvm/queue
>  * update patch description
> 
>  arch/x86/include/asm/kvm_host.h |  6 +++---
>  arch/x86/kvm/svm/svm.c          | 21 ++++++++++++++-------
>  arch/x86/kvm/vmx/vmx.c          | 19 +++++++++++++------
>  arch/x86/kvm/x86.c              |  4 ++--
>  4 files changed, 32 insertions(+), 18 deletions(-)

That's less ugly than I expected. :D  I'll queue it in the next week or
so.  But even though the commit subject is cool, I'll change it to "KVM:
x86: move IPI fastpath inside kvm_x86_ops.run".

Thanks,

Paolo

