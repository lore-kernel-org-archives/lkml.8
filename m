Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C76C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0E5208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ5SGdlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgCCNHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:07:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54586 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728565AbgCCNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583240825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tl1DdVHIR0INqv1Lc6Z+ydsIpF+tIS1d2YorStHVEYY=;
        b=FJ5SGdlBlYEoa+SYT4XjDmg2xcKJu1ltRTiCtiLTF2tpDgzUOyBd70WTPcBWXeQ89RTIjk
        qrU7Fd966CPcXJR8RtwvfTfacIBpJwBuzSfLqr5LjQOQeM6G6ioP+E1CNOGrvOzASe/rLq
        WFdxWDM0HL6+QUr/wsy81rBOqglCtok=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-nPDHn7eqNAmtHXfpeZyfjA-1; Tue, 03 Mar 2020 08:07:04 -0500
X-MC-Unique: nPDHn7eqNAmtHXfpeZyfjA-1
Received: by mail-wr1-f71.google.com with SMTP id z16so1188324wrm.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tl1DdVHIR0INqv1Lc6Z+ydsIpF+tIS1d2YorStHVEYY=;
        b=XPSaFRoS5uhaD+2k/kQK4NbqY97ddJrfSdYYtdkaxB71qKc+cbw5+zkUKzGccHPElw
         VhGsM8MKSJi15du3u3f0k93juCS1DX4daXqSasqY/rrQaJy9zN/RmAf/eAw1dM/pOey2
         OEFnsDJzh86L3CIsgekK+9a62ctr3ltQNiFMd7DMx8XwTsuYMIMJqqy5VH1rCvabQbQc
         tYt46GJyRndYvlEMGZcIrwmAiyJvdmc0pcGqmYPz5IUNx2zfiiDAGQvDUg2eSvpybOyh
         AHRSj/xIphyqS6EB/hNSZb/Q178IUStmFRsxDTZU2FDgosboFqtPeqiM1WxLgSVOJX/N
         7Y/Q==
X-Gm-Message-State: ANhLgQ30JL9KPFZWoG8N8Mh7fy2lMZM4KYq7oRvCQrv/UeZFBo+I2TOz
        /ApklOjW8E+S9Gr8QL1Frym5v+RUHbeQSodSRAP0/eAKtse8K8u/QLyuf+FU/jyJtaxEG/aM7e8
        KWBXu39CphdLDgY3Q3QXOc+Qf
X-Received: by 2002:adf:ead0:: with SMTP id o16mr5553464wrn.239.1583240822803;
        Tue, 03 Mar 2020 05:07:02 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvFs9exZ1u3AtWywZibzYcaabPn0O0rGCmokmbu9tlh8xMRqE0sD77JYX5tNmKGqzWToOmDKQ==
X-Received: by 2002:adf:ead0:: with SMTP id o16mr5553444wrn.239.1583240822570;
        Tue, 03 Mar 2020 05:07:02 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id f17sm13075895wrm.3.2020.03.03.05.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 05:07:01 -0800 (PST)
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Oliver Upton <oupton@google.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
 <87zhcyfvmk.fsf@vitty.brq.redhat.com>
 <8fbeb3c2-9627-bf41-d798-bafba22073e3@redhat.com>
 <87tv35fv5t.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bb75cdc-961e-0d83-0546-342298517496@redhat.com>
Date:   Tue, 3 Mar 2020 14:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv35fv5t.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 14:02, Vitaly Kuznetsov wrote:
> Right you are,
> 
> a big hammer like
> 
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
> index 2a8f2bd..52c9bce 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -324,14 +324,6 @@ struct x86_emulate_ctxt {
>          */
>  
>         /* current opcode length in bytes */
> -       u8 opcode_len;
> -       u8 b;
> -       u8 intercept;
> -       u8 op_bytes;
> -       u8 ad_bytes;
> -       struct operand src;
> -       struct operand src2;
> -       struct operand dst;
>         union {
>                 int (*execute)(struct x86_emulate_ctxt *ctxt);
>                 fastop_t fop;
> @@ -343,6 +335,14 @@ struct x86_emulate_ctxt {
>          * or elsewhere
>          */
>         bool rip_relative;
> +       u8 opcode_len;
> +       u8 b;
> +       u8 intercept;
> +       u8 op_bytes;
> +       u8 ad_bytes;
> +       struct operand src;
> +       struct operand src2;
> +       struct operand dst;
>         u8 rex_prefix;
>         u8 lock_prefix;
>         u8 rep_prefix;
> 
> seems to make the issue go away. (For those wondering why fielf
> shuffling makes a difference: init_decode_cache() clears
> [rip_relative, modrm) range) How did this even work before...
> (I'm still looking at the code, stay tuned...)

On AMD, probably because all these instructions were normally trapped by L1.

Of these, however, most need not be zeroed again. op_bytes, ad_bytes,
opcode_len and b are initialized by x86_decode_insn, and dst/src/src2
also by decode_operand.  So only intercept is affected, adding
"ctxt->intercept = x86_intercept_none" should be enough.

Paolo

