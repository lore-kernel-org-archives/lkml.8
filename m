Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A20D20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPKOutk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEFKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:04:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728624AbgEFKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588759448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiIEZVwe7SG+6Nxq2tgonbDJOE30ulty5p7C5cusMJU=;
        b=hPKOutk4JMgHoZ9O6QIU0O2dYxmhqzAeqgLAN0UU6/tUO0wm2JPdyd1eLBCW/4ounLYN9v
        SpEbRE+EOa3XyHBVoUL10X4I+AQY9aFWX+0ngaDjXNlmfKi5bo7OyyduQgM8TQJdq7P54n
        sdTxVBENa2045dNv1Bn++vbhOA/sAGs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-GNSxqRPuNuyx7nvNHd2iaw-1; Wed, 06 May 2020 06:03:49 -0400
X-MC-Unique: GNSxqRPuNuyx7nvNHd2iaw-1
Received: by mail-wr1-f70.google.com with SMTP id f2so1054043wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QiIEZVwe7SG+6Nxq2tgonbDJOE30ulty5p7C5cusMJU=;
        b=Dht3dSUvTouRdujBTvWdW8PQecDw1xO8/shKp9yrRacSlExCK+kLAKiVuu8s142Prf
         jOdwsIu3jH5JxoEVUMvLtqBV8WILn+cVJ7c02r0UAhynWZNKVJvysmW1gdCAFC0oRtzS
         HHzQtBlHs33uuu9Zy1eRLOpMoCSsbFxLVFxy/r00Ppt95xwsFD8UVGMWp0kWap9R7x4g
         VEwsVUXicVDsuHZ9z7yU+jMUlWx3YH63XMrftrf8RaajfwoxU5mqaAGLb8LHmogKUH31
         szKP+i3HXVsyPGGq17WEvbAHVs0ZTQ4EfJ0U2kS8Wh3CociYFZDMel7qM9f48kul0UiE
         HA7g==
X-Gm-Message-State: AGi0PuY5CdcO09+xdUmy1cz6cP4QR27tzPC3QQEWE2vxcn6RCid0HbBa
        V+NJRwNJSjAl9+9SqQ/Fj5NM7qsvYDDLeyL17bH61xeEgmwI3+HOLaFOVHqx1d9puxtO14QZx9a
        vr8VcgBEu8OYmisWFxuxCUAm0
X-Received: by 2002:a1c:e284:: with SMTP id z126mr3721710wmg.32.1588759427842;
        Wed, 06 May 2020 03:03:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA2Cf0okwuIaFAnbBfYxArho8JGedgvkjxALaNhmtcMcYyVgk5oUJVs5LcIZ75gvpZF67HhA==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr3721677wmg.32.1588759427527;
        Wed, 06 May 2020 03:03:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id d27sm2027867wra.30.2020.05.06.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 03:03:46 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Explicitly clear RFLAGS.CF and RFLAGS.ZF in
 VM-Exit RSB path
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20200506035355.2242-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f906b20-4806-4de0-fa99-9e7607464eb0@redhat.com>
Date:   Wed, 6 May 2020 12:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506035355.2242-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 05:53, Sean Christopherson wrote:
> Clear CF and ZF in the VM-Exit path after doing __FILL_RETURN_BUFFER so
> that KVM doesn't interpret clobbered RFLAGS as a VM-Fail.  Filling the
> RSB has always clobbered RFLAGS, its current incarnation just happens
> clear CF and ZF in the processs.  Relying on the macro to clear CF and
> ZF is extremely fragile, e.g. commit 089dd8e53126e ("x86/speculation:
> Change FILL_RETURN_BUFFER to work with objtool") tweaks the loop such
> that the ZF flag is always set.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: f2fde6a5bcfcf ("KVM: VMX: Move RSB stuffing to before the first RET after VM-Exit")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmenter.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 87f3f24fef37b..51d1a82742fd5 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -82,6 +82,9 @@ SYM_FUNC_START(vmx_vmexit)
>  	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
>  	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
>  
> +	/* Clear RFLAGS.CF and RFLAGS.ZF to preserve VM-Exit, i.e. !VM-Fail. */
> +	or $1, %_ASM_AX
> +
>  	pop %_ASM_AX
>  .Lvmexit_skip_rsb:
>  #endif
> 

Queued, thanks (for 5.7 so that it will never be broken in Linus's tree).

Paolo

