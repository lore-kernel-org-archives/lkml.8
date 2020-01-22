Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C34C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD669217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnr+c9Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAVOZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:25:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579703120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFgGoOBhlbp8G8qaVhgWYbMLMOHhw7MLLAMMLlLXNk8=;
        b=Xnr+c9KdCM6EEfSgCJeU2Htgmt93wmNQmALNv62MDmDuGdkE5B+Yd0Z0Q7ykDUVa8uFT48
        iEIx94B4Bu4Ky1vaqqAOVGOIUDdfmAKF6KEkyeouGy/DB+ZHbV3WlN1Sy9UjRUwz3G9G7C
        pqQWahjH9XAiZPf06dDQdlGIn3Gtsik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-dkhbqQhGNTqQlTlFEpJ37g-1; Wed, 22 Jan 2020 09:25:17 -0500
X-MC-Unique: dkhbqQhGNTqQlTlFEpJ37g-1
Received: by mail-wr1-f72.google.com with SMTP id f17so3126202wrt.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFgGoOBhlbp8G8qaVhgWYbMLMOHhw7MLLAMMLlLXNk8=;
        b=dt3B8n0RyL5G4onbvJNImclt/Krn32MIF+1MARCJ0WmJ9abofyg7lWjG9Ah1xihCR8
         RwtrA1IUbIbvfReMy0DHXtyVgC+8gx3yO9sM4tMpZFwBNIL02tZFYM6v3Z4+gmGPAaJ4
         iRk0TlA1BMw6YJKhWDbx8G9mlZVSG765Ha5oXB0/wjAJmCaYFQO62ZA9NZ+K0KjNETNX
         idRNLJ4V85+nryFXDUL4pizYJni2vrL+5UJsQ4r/fQDaOuArqRCnpCgg/bLUhfOU/jeD
         wJbfvMgM9CCN1S8beBOqgukJ/VJx/iG8MoSD/vBUFVOGp6yg54abySDmaD7tqnZjLejv
         1ckA==
X-Gm-Message-State: APjAAAXTkhGMd2XTvuB2i94RLi3jxiCXTwnlr7kn4bPWoM8QXYcAegxY
        v4ET+9jOZhrL22Qiy2KlpQbu+T23m7bHf+PUWtxPJZr+ishYqXdDYfZbZPCV7VDL4uyF6L2iVm8
        pEqtsrXkaXLbb3qsKXKiEMacL
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr11682172wrs.106.1579703116114;
        Wed, 22 Jan 2020 06:25:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP2XsJnDsSThV8rarChN47R6UPyNGJ5Ur+DUzXB/tIVsKHJn5tBp7pP6PRF5kIpqccVYYx4w==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr11682150wrs.106.1579703115876;
        Wed, 22 Jan 2020 06:25:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id s65sm4350127wmf.48.2020.01.22.06.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 06:25:15 -0800 (PST)
Subject: Re: [PATCH 02/01] KVM: x86: Use a typedef for fastop functions
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
References: <1579663304-14524-1-git-send-email-linmiaohe@huawei.com>
 <20200122044339.4888-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c8606db-a2fa-d3b8-58c3-7630bc52195f@redhat.com>
Date:   Wed, 22 Jan 2020 15:25:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200122044339.4888-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/20 05:43, Sean Christopherson wrote:
> Add a typedef to for the fastop function prototype to make the code more
> readable.
> 
> No functional change intended.
> 
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Applies on top of Miaohe's patch.  Feel free to squash this.
> 
>  arch/x86/kvm/emulate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 0accce94f660..ddbc61984227 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -311,7 +311,9 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
>  #define ON64(x)
>  #endif
>  
> -static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
> +typedef void (*fastop_t)(struct fastop *);
> +
> +static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  
>  #define __FOP_FUNC(name) \
>  	".align " __stringify(FASTOP_SIZE) " \n\t" \
> @@ -5502,7 +5504,7 @@ static void fetch_possible_mmx_operand(struct operand *op)
>  		read_mmx_reg(&op->mm_val, op->addr.mm);
>  }
>  
> -static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *))
> +static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
>  {
>  	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
>  
> @@ -5680,12 +5682,10 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
>  		ctxt->eflags &= ~X86_EFLAGS_RF;
>  
>  	if (ctxt->execute) {
> -		if (ctxt->d & Fastop) {
> -			void (*fop)(struct fastop *) = (void *)ctxt->execute;
> -			rc = fastop(ctxt, fop);
> -		} else {
> +		if (ctxt->d & Fastop)
> +			rc = fastop(ctxt, (fastop_t)ctxt->execute);
> +		else
>  			rc = ctxt->execute(ctxt);
> -		}
>  		if (rc != X86EMUL_CONTINUE)
>  			goto done;
>  		goto writeback;
> 

Queued, thanks.

Paolo

