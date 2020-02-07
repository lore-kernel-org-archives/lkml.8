Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6567C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAAB21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1GbGbpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGPIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:08:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727138AbgBGPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581088088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5g8c3Dt5YGFnyjeCvdVnSkJ8OoAq7ZLBS2fAhe/Z94c=;
        b=a1GbGbpAJCwwKigIbSSzxXx5F7ONbI20czAjQ+CyhwSY1IdOUpG+l3fkTV9o+9zkMonUfX
        byqkS6+8azRVPLIo8KqMPAOwZ5iJbhj06TXtN+n1w8poUlLVLFVycsO99FZmvQdP8DC9Dv
        2hemKD8a+RRMPInGzyUA3cY+58YrTZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-o1aMWy3gPNKEUyZyJg_gJw-1; Fri, 07 Feb 2020 10:08:02 -0500
X-MC-Unique: o1aMWy3gPNKEUyZyJg_gJw-1
Received: by mail-wm1-f72.google.com with SMTP id y125so1744920wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5g8c3Dt5YGFnyjeCvdVnSkJ8OoAq7ZLBS2fAhe/Z94c=;
        b=hXSc1Ms0nA1w+ur1HJdiOi+J896o786lA3+t5ZdYTCnp8fdMBUN3tep/CG/EB+Ee1k
         p2HTuLDDRomL/CSso2blFelvrj5p6mXpWOyuj0pDEa1Tazyys6vl69FiR5eNR/muAUVa
         rkQlA5oX/9AmzjpXLUNUENwj647cZt6DAxn1syfNgWCOOYI8hHPAlxDC3Ux1pVkwqRhB
         bHd1S0g9kfxbkx9N+QDzuvJZPOgppUsI7Mo41CRiTR5s5NVockO2Apwnsh6Fqu0Ooiph
         JfJCYhZxWfKV9+gtLioKjlQLxSP1/wn/FjgsB4eWSeTd6OXRukXeF9LP3EyGapCKrKyE
         hpNg==
X-Gm-Message-State: APjAAAXJ/TOjnU28jI2sffV7R6VjocM5ZQkqTpU3OJAUMUrrOrfDVtVP
        eetP9eUhmJJCSKFV8UbT/ArrsECYOmCa28qFvv7muwz/Jlh9zgSKkSodPVc4rS9tECU5vv+bqvC
        YCB/uheZRP/OEWeYB8rgua8jN
X-Received: by 2002:adf:f28c:: with SMTP id k12mr5384287wro.360.1581088077958;
        Fri, 07 Feb 2020 07:07:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqygyybBx8aip4PiQSeNZI4d9+MbdXWU5727okvl0YyzWFNc854rtOn5bfI+PF71Bdg58IOdxQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr5384273wro.360.1581088077787;
        Fri, 07 Feb 2020 07:07:57 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm3662109wrs.73.2020.02.07.07.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:07:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        krish.sadhukhan@oracle.com, eric.auger.pro@gmail.com,
        eric.auger@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH v5 2/4] selftests: KVM: Remove unused x86_register enum
In-Reply-To: <20200207142715.6166-3-eric.auger@redhat.com>
References: <20200207142715.6166-1-eric.auger@redhat.com> <20200207142715.6166-3-eric.auger@redhat.com>
Date:   Fri, 07 Feb 2020 16:07:56 +0100
Message-ID: <87mu9uqvub.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Auger <eric.auger@redhat.com> writes:

> x86_register enum is not used. Its presence incites us
> to enumerate GPRs in the same order in other looming
> structs. So let's remove it.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  | 20 -------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 6f7fffaea2e8..e48dac5c29e8 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -36,26 +36,6 @@
>  #define X86_CR4_SMAP		(1ul << 21)
>  #define X86_CR4_PKE		(1ul << 22)
>  
> -/* The enum values match the intruction encoding of each register */
> -enum x86_register {
> -	RAX = 0,
> -	RCX,
> -	RDX,
> -	RBX,
> -	RSP,
> -	RBP,
> -	RSI,
> -	RDI,
> -	R8,
> -	R9,
> -	R10,
> -	R11,
> -	R12,
> -	R13,
> -	R14,
> -	R15,
> -};
> -
>  struct desc64 {
>  	uint16_t limit0;
>  	uint16_t base0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

