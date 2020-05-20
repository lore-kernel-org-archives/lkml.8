Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DC2206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrJEYxiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgETQga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:36:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgETQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589992589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqYJ7uIrOlC74lzjdNx8dKV0aihb2Jm3KW9U6dMtg04=;
        b=QrJEYxiXfjgDy95MJrPxXiB5Hn6PK75wIsEcvv1Qz7vudLtlCyg6llrfLB4MaZZ5oqL2pB
        FksiyIiK8P/QKYF15kxDINJtz/BG0oE0Fi73eQ2+CEyrfsKEJ6T7YtALhOEby1SjvQ3vtD
        +9Pn0d/uoCX84Kl094TQdPplIb5PT9o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-TdL_d9euPTuNCGMkQtToGg-1; Wed, 20 May 2020 12:36:27 -0400
X-MC-Unique: TdL_d9euPTuNCGMkQtToGg-1
Received: by mail-ej1-f69.google.com with SMTP id u24so1578204ejg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XqYJ7uIrOlC74lzjdNx8dKV0aihb2Jm3KW9U6dMtg04=;
        b=et0VB3OfqZ/wE1+EL7h9GO5zIfGCfLFmfKNhDn1UyZnXk6qNIVVGdbQmSCUJOoQD1y
         S5fbcJ5bJA6AlXmIG2jf2VTkOEDHprtek5Qa8jCm4b4vNOxL7GxdEQOeVDWjpvzkzQsK
         aZLe2FMip8zqOfxa10pC77ybSMfA5R7Vli+0Zsyj8VVbpTZdZv0OpZqQjSWGhvv6SXNe
         yQ//q3HXoPvo2gwtwZJJ9gIViUt2riWinZvBXYXA6Uj2d/rg/dthOJz7kFZRE92m45O9
         A3jztcPum+4oc8rmEx5tRVZwsAg+JGwQOcwRGvECTqgjlYXkdvW3onoHJwqIjjnYNFT+
         70uQ==
X-Gm-Message-State: AOAM530tgzMjnG5FHEUomChjKfHd2S97rZeNzAuWUd/QoJIODBlnh9Iv
        V+Z6pqdtGAescYAdhR9PDIGikPaKHUH3EoNI8wOf4CszH2PHwV5rMQPWkjSrwqRYAlI3Oz2yMrK
        omPG8OPdpGHP1l44IYGlH3+ao
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr4351605edb.274.1589992586282;
        Wed, 20 May 2020 09:36:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzTlJNPnR4mbBk6k3pUd+KxeZ1wVjVSLPLcjUKURZtkun7XyhyGpaFHeuQWElBl88fdngySQ==
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr4351587edb.274.1589992586118;
        Wed, 20 May 2020 09:36:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u20sm2215506edy.80.2020.05.20.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:36:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     oupton@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: allow KVM_STATE_NESTED_MTF_PENDING in kvm_state flags
In-Reply-To: <20200519180743.89974-1-pbonzini@redhat.com>
References: <20200519180743.89974-1-pbonzini@redhat.com>
Date:   Wed, 20 May 2020 18:36:24 +0200
Message-ID: <871rnetvg7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> The migration functionality was left incomplete in commit 5ef8acbdd687
> ("KVM: nVMX: Emulate MTF when performing instruction emulation", 2020-02-23),
> fix it.
>
> Fixes: 5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4f55a44951c3..0001b2addc66 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4626,7 +4626,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  
>  		if (kvm_state.flags &
>  		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE
> -		      | KVM_STATE_NESTED_EVMCS))
> +		      | KVM_STATE_NESTED_EVMCS | KVM_STATE_NESTED_MTF_PENDING))
>  			break;
>  
>  		/* nested_run_pending implies guest_mode.  */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

