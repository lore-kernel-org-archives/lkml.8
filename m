Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B4920705
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+Ff2q81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEEBW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 21:22:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbgEEBW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588641745;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1p9ndXKjEh3O8AypxiKc03ZcWYSLmsMh08HNKt1IvOE=;
        b=W+Ff2q816wWYm6QNIlni2Ewcg1O88uqlEC/bXwSP8cnO8bhssskGxAozp5Df6xFVff1PX0
        KrxR9ix27nX4xkef9+4NSNj6f3O19a1s6Y5iIzNbMpKFT/RaWyLjSfYXi8mc1KFIhTR7iq
        +mNBLlNq98CAPrYB2DPc7heZYucIZOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-AEZaM03SPbiRS5zxTKTw9w-1; Mon, 04 May 2020 21:22:22 -0400
X-MC-Unique: AEZaM03SPbiRS5zxTKTw9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72600107ACCA;
        Tue,  5 May 2020 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-132.bne.redhat.com [10.64.54.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6F02DE77;
        Tue,  5 May 2020 01:22:16 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFC 1/6] Revert "KVM: async_pf: Fix #DF due to inject
 "Page not Present" and "Page Ready" exceptions simultaneously"
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-2-vkuznets@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <22192687-072e-978b-ac13-fa2fd8d40c59@redhat.com>
Date:   Tue, 5 May 2020 11:22:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200429093634.1514902-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 7:36 PM, Vitaly Kuznetsov wrote:
> Commit 9a6e7c39810e (""KVM: async_pf: Fix #DF due to inject "Page not
> Present" and "Page Ready" exceptions simultaneously") added a protection
> against 'page ready' notification coming before 'page not ready' is
> delivered. This situation seems to be impossible since commit 2a266f23550b
> ("KVM MMU: check pending exception before injecting APF) which added
> 'vcpu->arch.exception.pending' check to kvm_can_do_async_pf.
> 
> On x86, kvm_arch_async_page_present() has only one call site:
> kvm_check_async_pf_completion() loop and we only enter the loop when
> kvm_arch_can_inject_async_page_present(vcpu) which when async pf msr
> is enabled, translates into kvm_can_do_async_pf().
> 
> There is also one problem with the cancellation mechanism. We don't seem
> to check that the 'page not ready' notification we're cancelling matches
> the 'page ready' notification so in theory, we may erroneously drop two
> valid events.
> 
> Revert the commit. apf_get_user() stays as we will need it for the new
> 'page ready notifications via interrupt' mechanism.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/x86.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

