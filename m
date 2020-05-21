Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD9220829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7TJ36+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEUSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:38:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728240AbgEUSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590086317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6xn++Cf4HTyCSbGYh8HNPobkxrKx2sAl2lxN9hs9ouI=;
        b=c7TJ36+NLFWSfBQjkAw6Oh77SIWV4iG2khbeCR5NCcQd/maU9A0ZAqNZcsTfjFPmg5YCtN
        PfUTFmNma6FRnW/UN5yvosyUVwERmP2tvs2NtJIX2f1XcpEQshIzaG4o/prgRcQ1D01sb3
        E/665ZhC8ve4SDo/x0tgYFHMivoEME8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-5bnbrclkMYKsSWfsdSTzWw-1; Thu, 21 May 2020 14:38:35 -0400
X-MC-Unique: 5bnbrclkMYKsSWfsdSTzWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF6E6EC1B2;
        Thu, 21 May 2020 18:38:32 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-233.rdu2.redhat.com [10.10.116.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96E7212A4D;
        Thu, 21 May 2020 18:38:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0D80322036E; Thu, 21 May 2020 14:38:32 -0400 (EDT)
Date:   Thu, 21 May 2020 14:38:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
Message-ID: <20200521183832.GB46035@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511164752.2158645-3-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 06:47:46PM +0200, Vitaly Kuznetsov wrote:
> Currently, APF mechanism relies on the #PF abuse where the token is being
> passed through CR2. If we switch to using interrupts to deliver page-ready
> notifications we need a different way to pass the data. Extent the existing
> 'struct kvm_vcpu_pv_apf_data' with token information for page-ready
> notifications.
> 
> The newly introduced apf_put_user_ready() temporary puts both reason
> and token information, this will be changed to put token only when we
> switch to interrupt based notifications.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
>  arch/x86/kvm/x86.c                   | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 2a8e0b6b9805..e3602a1de136 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -113,7 +113,8 @@ struct kvm_mmu_op_release_pt {
>  
>  struct kvm_vcpu_pv_apf_data {
>  	__u32 reason;

Hi Vitaly,

Given we are redoing it, can we convert "reason" into a flag instead
and use bit 0 for signalling "page not present" Then rest of the 31
bits can be used for other purposes. I potentially want to use one bit to
signal error (if it is known at the time of injecting #PF).

> -	__u8 pad[60];
> +	__u32 pageready_token;
> +	__u8 pad[56];

Given token is 32 bit, for returning error in "page ready" type messages,
I will probably use padding bytes and create pagready_flag and use one
of the bits to signal error.

Thanks
Vivek

