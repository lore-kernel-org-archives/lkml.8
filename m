Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BD72064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3aZvon1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgFJIdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:33:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726424AbgFJIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591777980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/CzDQqYRGgoycRXVjpGii7I26mAUdaOWbacFoesUyuU=;
        b=R3aZvon1E294tGk8eeqTC+pM9y2GzzTwdGpgLNxyneB7jWhNJOpEdLBbRCgHxdZ+T00evt
        AIzT3qXwptekTYx9zWHx3KoL7PmMae4qTTISecX3rwHWTYh8WTDBINo92pqZ/2bHxgu0+S
        tVu71RztIYpVk96MNWMqPrMF85oWnL8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-qMVCMpD7P622PGNWiwWB9Q-1; Wed, 10 Jun 2020 04:32:58 -0400
X-MC-Unique: qMVCMpD7P622PGNWiwWB9Q-1
Received: by mail-ej1-f70.google.com with SMTP id bo19so767977ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/CzDQqYRGgoycRXVjpGii7I26mAUdaOWbacFoesUyuU=;
        b=V58Rbek0SItS8Vs97s/kpAWcLWHQDOSTK+D0XcW0ok5ZgLOTAvOOZ7l61nS2E5oE1Z
         DQ0BxSXKRECuWGiqKeU9ry3w85DANFerI7lWCw5kCVkEhMfno9PfC3eWEQ8U+KRuEUHp
         Ji5bY9OxgYAojXAL3QOiZLF2M3+J0s7c8Tmcja/ZEtHlV15+S/2EA0w8O5E2qwGiBc7m
         6hAwnQDsHzFMmC3sHiV/yqq2SsaLj2hnXpBkNyaSmouStuaB9B4KJYhVxREUPlnLs8Pz
         L32itLca51WQC49rMKMn78eXbu1T3uoQm3F0gwT9+Qezvj7PaFonmmq3dpj8B6dVf2dB
         qzJw==
X-Gm-Message-State: AOAM532HVpWC/jyO/9MElGSxzx0S9WI3AakdT9HempX3MguXYF6IX0zu
        d8vlIn6r1TU0/14hBF9k4ZCit4eIhNkse4r5E9dOpEfzzARwakAVI1Yk0a8lqR7P7RgY5ThYFq9
        Jk9ZH1xhyWWxvK+FfUiwibKbN
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr1548535edr.271.1591777977419;
        Wed, 10 Jun 2020 01:32:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRDXVgnf8jf3KQtAoZpcPajfcKWk4OSBUiV1BVsb+L5Lx8Bk89ta016RNTLmlCPlXXZtcimg==
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr1548507edr.271.1591777977145;
        Wed, 10 Jun 2020 01:32:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ok21sm14043099ejb.82.2020.06.10.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:32:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: i8254: remove redundant assignment to pointer s
In-Reply-To: <20200609233121.1118683-1-colin.king@canonical.com>
References: <20200609233121.1118683-1-colin.king@canonical.com>
Date:   Wed, 10 Jun 2020 10:32:55 +0200
Message-ID: <875zbzb9s8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer s is being assigned a value that is never read, the
> assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

It seems it wasn't used since the very beginning,

Fixes: 7837699fa6d7 ("KVM: In kernel PIT model")

QEMU code (from where KVM's implementation originates), however, 
does make use of 's' here as it open codes pit_latch_status().

> ---
>  arch/x86/kvm/i8254.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index febca334c320..a6e218c6140d 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -462,7 +462,6 @@ static int pit_ioport_write(struct kvm_vcpu *vcpu,
>  		if (channel == 3) {
>  			/* Read-Back Command. */
>  			for (channel = 0; channel < 3; channel++) {
> -				s = &pit_state->channels[channel];
>  				if (val & (2 << channel)) {
>  					if (!(val & 0x20))
>  						pit_latch_count(pit, channel);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

